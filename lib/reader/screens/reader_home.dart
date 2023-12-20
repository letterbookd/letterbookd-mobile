import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:letterbookd/core/assets/appconstants.dart' as app_data;
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:letterbookd/authenticate/screens/logout.dart';
import 'package:letterbookd/reader/screens/reader_settings.dart';
import 'package:letterbookd/reader/models/reader.dart';
import 'package:letterbookd/reader/models/reader_books.dart';
import 'package:letterbookd/reader/models/reader_reviews.dart';
import 'package:letterbookd/reader/widgets/library_grid_view.dart';
import 'package:letterbookd/reader/widgets/search_result_list.dart';

String currentUsername = "";

class ReaderHome extends StatefulWidget {
  const ReaderHome({super.key});

  @override
  ReaderHomeState createState() => ReaderHomeState();
}

class ReaderHomeState extends State<ReaderHome> {
  bool isSearchMode = false;
  bool hasSearched = false;
  List<ReaderElement> listReaders = [];
  TextEditingController searchController = TextEditingController();
  String? _username;
  bool _shareLibrary = false;
  bool _shareReview = false;

  Future<String?> _getSavedUsername() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('username');
  }

  Future<ReaderElement?> fetchReaders() async {
    String? username = await _getSavedUsername();
    if (username != null) {
      var url = Uri.parse('${app_data.baseUrl}/reader/get-reader-json/');
      var response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Username": username,
        },
      );

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(utf8.decode(response.bodyBytes));
        return ReaderElement.fromJson(jsonData);
      }
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  void _loadUsername() async {
    _username = await _getSavedUsername();
    setState(() {});
  }

  Future<List<ReaderElement>> searchReaders(String query) async {
    String? username = await _getSavedUsername();

    if (username != null) {
      var url = Uri.parse('${app_data.baseUrl}/reader/search-readers?q=$query');
      var response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Username": username,
        },
      );

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(utf8.decode(response.bodyBytes));

        if (jsonData is List && jsonData.isNotEmpty) {
          List<ReaderElement> searchResults = List<ReaderElement>.from(
            jsonData.map((e) => ReaderElement.fromJson(e)),
          );

          return searchResults;
        } else {
          debugPrint('No search results found.');
          return [];
        }
      } else {
        throw Exception('Failed to search readers');
      }
    }

    return [];
  }

  Future<List<dynamic>> fetchLibrary(String username) async {
    var url =
        Uri.parse('${app_data.baseUrl}/reader/reader-library-api/$username');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load library');
    }
  }

  Future<List<Review>> fetchReviews(String username) async {
    var url =
        Uri.parse('${app_data.baseUrl}/reader/reader-review-api/$username');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> jsonReviews = json.decode(response.body);
      return jsonReviews.map((json) => Review.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load reviews');
    }
  }

  Widget _buildBody(BuildContext context, List<ReaderElement> readers) {
    return ListView(
      children: [
        const SizedBox(height: 16),
        // Display search results or user profile
        if (isSearchMode)
          _buildSearchResults(context, readers)
        else
          FutureBuilder<ReaderElement?>(
            future: fetchReaders(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data == null) {
                return const Center(child: Text("Tidak ada data pembaca."));
              } else {
                _shareLibrary =
                    snapshot.data!.preferences.shareLibrary ?? false;
                _shareReview = snapshot.data!.preferences.shareReviews ?? false;
                final reader = snapshot.data!;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const CircleAvatar(
                      radius: 50.0,
                      backgroundImage: AssetImage('assets/images/pfp_0.jpg'),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      reader.displayName,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '@$_username',
                      style: const TextStyle(
                        fontSize: 18.0,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        reader.bio,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EditProfileScreen(),
                          ),
                        ).then((result) {
                          if (result != null && result == true) {
                            setState(() {});
                          }
                        });
                      },
                      child: const SizedBox(
                        child: Text(
                          'Edit Profile',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    // Show library reader
                    if (_shareLibrary)
                      FutureBuilder<List<dynamic>>(
                        future: _username != null
                            ? fetchLibrary(_username!)
                            : Future.value([]),
                        builder: (context, librarySnapshot) {
                          if (librarySnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (librarySnapshot.hasError) {
                            return Text('Error: ${librarySnapshot.error}');
                          } else if (librarySnapshot.hasData) {
                            List<BookDisplayInfo> books =
                                librarySnapshot.data!.map((jsonBook) {
                              return BookDisplayInfo(
                                title: jsonBook['title'],
                                thumbnail: jsonBook['thumbnail'],
                              );
                            }).toList();
                            return _buildLibraryList(books);
                          } else {
                            return const Text('No books found');
                          }
                        },
                      ),

                    const SizedBox(height: 20),

                    // Reader's review section
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text("Reviews",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                    ),

                    // Show reviews
                    if (_shareReview)
                      FutureBuilder<List<Review>>(
                        future: _username != null
                            ? fetchReviews(_username!)
                            : Future.value([]),
                        builder: (context, reviewSnapshot) {
                          if (reviewSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (reviewSnapshot.hasError) {
                            return Text('Error: ${reviewSnapshot.error}');
                          } else if (reviewSnapshot.hasData &&
                              reviewSnapshot.data!.isNotEmpty) {
                            return _buildReviewList(reviewSnapshot.data!);
                          } else {
                            return const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text('No reviews found'),
                            );
                          }
                        },
                      ),
                  ],
                );
              }
            },
          ),
      ],
    );
  }

  Widget _buildLibraryList(List<BookDisplayInfo> books) {
    return LibraryGridView(books: books);
  }

  Widget _buildReviewList(List<Review> reviews) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        childAspectRatio: 1 / 0.6,
      ),
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        return _buildReviewCard(reviews[index]);
      },
    );
  }

  Widget _buildReviewCard(Review review) {
    return Card(
      margin: const EdgeInsets.all(4),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: Text(
                review.bookTitle,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
            Text(
              review.reviewText,
              style: const TextStyle(fontSize: 14),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              '${review.starsRating} Stars',
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults(
      BuildContext context, List<ReaderElement> readers) {
    if (readers.isEmpty && hasSearched) {
      return const Center(
        child: Text('No readers found'),
      );
    }
    return SearchResultList(readers: readers);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isSearchMode ? _buildSearchAppBar() : _buildRegularAppBar(),
      body: _buildBody(context, listReaders),
    );
  }

  AppBar _buildRegularAppBar() {
    return AppBar(
      title: const Text('Reader'),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            setState(() {
              listReaders = [];
              hasSearched = false;
              searchController.text = "";
              isSearchMode = true;
            });
          },
        ),
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
            // Directly call the performLogout method
            final request = context.watch<CookieRequest>();
            Logout.performLogout(context, request);
          },
        ),
      ],
    );
  }

  AppBar _buildSearchAppBar() {
    return AppBar(
      leading: BackButton(
        onPressed: () {
          setState(() {
            isSearchMode = false;
          });
        },
      ),
      title: TextField(
        controller: searchController,
        autofocus: true,
        decoration: const InputDecoration(
          hintText: "Search...",
          border: InputBorder.none,
        ),
        onSubmitted: (value) {
          // Handle search here
          searchReaders(value).then((results) {
            setState(() {
              listReaders = results;
              hasSearched = true;
            });
          });
        },
      ),
    );
  }
}
