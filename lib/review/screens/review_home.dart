import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:letterbookd/core/assets/appconstants.dart' as app_data;
import 'package:letterbookd/reader/screens/reader_home.dart';
import 'package:letterbookd/review/screens/review_book.dart';
import 'package:letterbookd/review/screens/review_edit.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:letterbookd/review/models/review.dart';

class ReviewHome extends StatefulWidget {
  const ReviewHome({super.key});

  @override
  State<ReviewHome> createState() => _ReviewHomeState();
}

class _ReviewHomeState extends State<ReviewHome> {
  late Future<List<Review>> userReviewsFuture;
  late Future<List<Review>> allReviewsFuture;

  @override
  void initState() {
    super.initState();
    userReviewsFuture = _fetchReviewsbyUser();
    allReviewsFuture = _fetchAllReviews();
  }

  Future<List<Review>> _fetchReviewsbyUser() async {
    var url =
        Uri.parse('${app_data.baseUrl}/review/show_review_flutter_by_user/');
    var response =
        await http.get(url, headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      List<dynamic> reviewsJson = jsonDecode(response.body);
      return reviewsJson.map((json) => Review.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load reviews');
    }
  }

  Future<List<Review>> _fetchAllReviews() async {
    var url = Uri.parse('${app_data.baseUrl}/review/show_review_flutter/');
    var response =
        await http.get(url, headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      List<dynamic> reviewsJson = jsonDecode(response.body);
      return reviewsJson.map((json) => Review.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load all reviews');
    }
  }

  Future<String> fetchBookTitleById(int bookId) async {
    final url =
        Uri.parse('${app_data.baseUrl}/review/get_book_title_by_id/$bookId/');
    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['title'];
    } else {
      throw Exception('Failed to load book title for ID: $bookId');
    }
  }

  Future<bool> deleteReview(int idReview, int idBuku) async {
    var url = Uri.parse('${app_data.baseUrl}/review/delete_review_flutter/');

    try {
      var response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'book_id': idBuku,
          'review_id': idReview,
        }),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reviews"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.black87,
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  const Text(
                    'Review Page',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  ReviewCard(
                    title: "Lihat Review Saya",
                    icon: Icons.preview,
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (BuildContext bc) {
                          return Container(
                            color: Colors.black87,
                            padding: const EdgeInsets.all(16.0),
                            child: FutureBuilder<List<Review>>(
                              future: userReviewsFuture,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else if (snapshot.hasError) {
                                  return Center(
                                      child: Text('Error: ${snapshot.error}'));
                                } else if (!snapshot.hasData ||
                                    snapshot.data!.isEmpty) {
                                  return const Center(
                                      child: Text('No reviews found'));
                                } else {
                                  return ListView(
                                    children: snapshot.data!
                                        .map((review) =>
                                            _buildReviewCard(context, review))
                                        .toList(),
                                  );
                                }
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
                  // Section for displaying all reviews
                  FutureBuilder<List<Review>>(
                    future: allReviewsFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('No reviews found'));
                      } else {
                        return Column(
                          children: snapshot.data!
                              .map(
                                  (review) => _buildReviewCard(context, review))
                              .toList(),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewCard(BuildContext context, Review review) {
    double rating = review.fields.starsRating.toDouble();
    String timeAgoText = timeago.format(review.fields.datePosted);

    return Card(
      color: Colors.grey[850],
      child: Column(
        children: [
          FutureBuilder<String>(
            future: fetchUsernameForReview(review.fields.user),
            builder: (context, snapshotUser) {
              if (!snapshotUser.hasData) {
                return const CircularProgressIndicator();
              }
              String username = snapshotUser.data ?? 'Unknown User';
              // Fetch the book title
              return FutureBuilder<String>(
                future: fetchBookTitleById(review.fields.book),
                builder: (context, snapshotBook) {
                  String bookTitle = snapshotBook.data ?? 'Unknown Book';
                  return ListTile(
                    title: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: username,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          TextSpan(
                            text: ' · $timeAgoText',
                            style: const TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Judul Buku: $bookTitle", // Display the book title here
                          style: const TextStyle(fontSize: 14),
                        ),
                        Text(
                          review.fields.reviewText,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    trailing: _buildStarRating(rating),
                  );
                },
              );
            },
          ),
          // Edit and delete buttons would be here if user review
          _buildReviewActions(context, review),
        ],
      ),
    );
  }

  Widget _buildEditAndDeleteButtons(BuildContext context, Review review) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          icon:
              Icon(Icons.edit, color: Theme.of(context).colorScheme.secondary),
          onPressed: () {
            showEditReviewBottomSheet(context, review, () {
              setState(() {
                // Refresh data setelah review diperbarui
                userReviewsFuture = _fetchReviewsbyUser();
                allReviewsFuture = _fetchAllReviews();
              });
            });
          },
        ),
        IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () async {
            bool shouldDelete = await _showDeleteConfirmationDialog(context);
            if (shouldDelete) {
              var success = await deleteReview(review.pk, review.fields.book);

              if (!context.mounted) return;
              if (success) {
                setState(() {
                  userReviewsFuture = _fetchReviewsbyUser();
                  allReviewsFuture = _fetchAllReviews();
                });
                Navigator.of(context).pop(true);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Failed to delete review')),
                );
              }
            }
          },
        ),
      ],
    );
  }

  Widget _buildReviewActions(BuildContext context, Review review) {
    return FutureBuilder<String>(
      future: fetchUsernameForReview(review.fields.user),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox.shrink();
        bool isUserReview = currentUsername == snapshot.data;
        return isUserReview
            ? _buildEditAndDeleteButtons(context, review)
            : const SizedBox.shrink();
      },
    );
  }

  Widget _buildStarRating(double rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        Icon icon;
        if (index < rating.floor()) {
          icon = const Icon(Icons.star, color: Colors.amber);
        } else if (index < rating.ceil()) {
          icon = const Icon(Icons.star_half, color: Colors.amber);
        } else {
          icon = const Icon(Icons.star_border, color: Colors.amber);
        }
        return icon;
      }),
    );
  }
}

class ReviewCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const ReviewCard(
      {super.key,
      required this.title,
      required this.icon,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.purple[50],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(icon),
              const SizedBox(width: 4.0),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<bool> _showDeleteConfirmationDialog(BuildContext context) async {
  return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.black87,
            title: const Text('Delete Review'),
            content: const Text(
              'Do you want to delete this review?',
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context)
                      .pop(false); // User chooses not to delete the review
                },
              ),
              TextButton(
                child:
                    const Text('Delete', style: TextStyle(color: Colors.red)),
                onPressed: () {
                  Navigator.of(context)
                      .pop(true); // User confirms to delete the review
                },
              ),
            ],
          );
        },
      ) ??
      false; // Returning false if dialog is dismissed
}
