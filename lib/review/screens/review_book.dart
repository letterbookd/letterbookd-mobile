import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:letterbookd/reader/screens/reader_home.dart';
import 'package:letterbookd/core/assets/appconstants.dart' as app_data;
import 'package:timeago/timeago.dart' as timeago;
import 'package:letterbookd/review/models/review.dart';

void showReviewsBottomSheet(BuildContext context, int bookId) {
  TextEditingController reviewController = TextEditingController();  
  double? selectedRating;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext bc) {
      return Container(
        color: Colors.black87,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Book Reviews',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView( 
                child: buildReviewList(context, bookId),
              ),
            ),
            ReviewInput(reviewController: reviewController, selectedRating: selectedRating, bookId: bookId,),
          ],
        ),
      );
    },
  );
}

Widget buildReviewList(BuildContext context, int bookId) {
  return FutureBuilder<List<Review>>(
    future: fetchReviewsByBookId(bookId),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return Center(child: Text('No reviews found for this book'));
      } else {
        return Column( // Replace ListView.builder with Column
          children: snapshot.data!
              .map<Widget>((review) => _buildReviewCard(context, review))
              .toList(),
        );
      }
    },
  );
}

Widget _buildReviewCard(BuildContext context, Review review) {
  double rating = review.fields.starsRating.toDouble();
  String timeAgoText = timeago.format(review.fields.datePosted);

  return Card(
    color: Colors.grey[850],
    child: ListTile(
      title: FutureBuilder<String>(
        future: fetchUsernameForReview(review.fields.user),
        builder: (context, snapshot) {
          String username = snapshot.data ?? 'Unknown User';
          return RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: username,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                TextSpan(
                  text: ' · $timeAgoText',
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            overflow: TextOverflow.ellipsis,
          );
        },
      ),
      subtitle: Text(
        review.fields.reviewText,
        style: TextStyle(color: Colors.white),
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min, 
        children: <Widget>[
          _buildStarRating(rating),
        ],
      ),
    ),
  );
}


Widget _buildStarRating(double rating) {
  return Row(
    mainAxisSize: MainAxisSize.min, // Constrain the row's size to its children
    children: List.generate(5, (index) {
      Icon icon;
      if (index < rating.floor()) {
        icon = Icon(Icons.star, color: Colors.amber);
      } else if (index < rating.ceil()) {
        icon = Icon(Icons.star_half, color: Colors.amber);
      } else {
        icon = Icon(Icons.star_border, color: Colors.amber);
      }
      return icon;
    }),
  );
}

Future<List<Review>> fetchReviewsByBookId(int bookId) async {
  final response = await http.get(
    Uri.parse('${app_data.baseUrl}/review/show_review_by_book_flutter/$bookId'),
    headers: {"Content-Type": "application/json"},
  );

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((review) => Review.fromJson(review)).toList();
  } else {
    throw Exception('Failed to load reviews for book ID: $bookId');
  }
}

Future<String> fetchUsernameForReview(int userId) async {
  final url = Uri.parse('${app_data.baseUrl}/review/get_username_by_id/$userId/');

  try {
    final response = await http.get(url, headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['username'];
    } else {
      print('Error: ${response.statusCode}');
      return 'Unknown User';
    }
  } catch (e) {
    print('Error fetching username: $e');
    return 'Unknown User';
  }
}

Future<bool> submitReview(int bookId, String reviewText, double rating) async {
  var url = Uri.parse('${app_data.baseUrl}/review/create_review_flutter/');
  
  var response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json', // Ganti ke application/json
    },
    body: json.encode({
      'book_id': bookId,
      'review_text': reviewText,
      'stars_rating': rating,
    }),
  );

  if (response.statusCode == 201) {
    // Berhasil membuat review baru
    return true;
  } else if (response.statusCode == 200) {
    // Review sudah ada
    return false;
  } else {
    // Terjadi error
    throw Exception('Failed to submit review');
  }
}


class ReviewInput extends StatefulWidget {
  final TextEditingController reviewController;
  final int bookId;
  double? selectedRating;

  ReviewInput({required this.reviewController, required this.bookId, this.selectedRating});

  @override
  _ReviewInputState createState() => _ReviewInputState();
}

class _ReviewInputState extends State<ReviewInput> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: InputDecorator(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
              suffixIcon: DropdownButtonHideUnderline(
                child: DropdownButton<double>(
                  value: widget.selectedRating,
                  icon: Icon(Icons.arrow_drop_up),
                  onChanged: (newValue) {
                    setState(() {
                      widget.selectedRating = newValue;
                    });
                  },
                  items: List.generate(10, (index) {
                    double ratingValue = (index + 1) * 0.5;
                    return DropdownMenuItem(
                      value: ratingValue,
                      child: Row(
                        children: List.generate(5, (starIndex) {
                          Icon icon;
                          if (starIndex < ratingValue.floor()) {
                            icon = Icon(Icons.star, color: Colors.amber);
                          } else if (starIndex < ratingValue.ceil()) {
                            icon = Icon(Icons.star_half, color: Colors.amber);
                          } else {
                            icon = Icon(Icons.star_border, color: Colors.amber);
                          }
                          return icon;
                        }),
                      ),
                    );
                  }),
                ),
              ),
            ),
            child: Text(widget.selectedRating != null ? '${widget.selectedRating} Stars' : 'Select Rating'),
          ),
        ),
        TextField(
          controller: widget.reviewController,
          decoration: InputDecoration(
            hintText: 'Add a review...',
            hintStyle: TextStyle(color: Colors.white),
            border: OutlineInputBorder(),
          ),
          style: TextStyle(color: Colors.white),
          minLines: 1,
          maxLines: 5,
        ),
        SizedBox(height: 10), // Add some spacing
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.white, // Button color
            onPrimary: Colors.black, // Text color
          ),
          onPressed: () async {
            setState(() {
              isLoading = true;
            });
            try {
              final success = await submitReview(
                widget.bookId,
                widget.reviewController.text,
                widget.selectedRating ?? 0,
              );
              print('Review added');
              widget.reviewController.clear();
              setState(() {
                widget.selectedRating = null;
              });
              Navigator.pop(context);
            
              
            } catch (e) {
              print('Error adding review: $e');
            } finally {
              setState(() {
                isLoading = false;
              });
            }
          },
          child: Text('Add Review'),
        ),
      ],
    );
  }
}
