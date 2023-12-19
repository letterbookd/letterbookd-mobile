import 'package:flutter/material.dart';
import 'package:letterbookd/review/models/review.dart';
import 'package:letterbookd/core/assets/appconstants.dart' as app_data;
import 'package:http/http.dart' as http;
import 'dart:convert';

void showEditReviewBottomSheet(BuildContext context, Review review, Function onReviewUpdated) {
  TextEditingController reviewController = TextEditingController(text: review.fields.reviewText);
  double? selectedRating = review.fields.starsRating.toDouble();
  if (![1, 1.5, 2, 2.5, 3, 3.5, 4, 4.5, 5].contains(selectedRating)) {
    selectedRating = 1; // default value if not in list
  }

  
  Future<bool> editReviewFlutter(int reviewId, String reviewText, double rating) async {
    var url = Uri.parse('${app_data.baseUrl}/review/update_review_flutter/');  
    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'review_id': reviewId,
        'review_text': reviewText,
        'stars_rating': rating,
      }),
    );

    if (response.statusCode == 200) {
      // Request berhasil dan review telah diperbarui
      return true;
    } else {
      // Terjadi kesalahan saat mengedit review
      print('Failed to edit review: ${response.body}');
      return false;
    }
  }

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext bc) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setModalState) {
          return Container(
            color: Colors.black87,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Edit Review',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: reviewController,
                  decoration: InputDecoration(
                    hintText: 'Edit your review...',
                    hintStyle: TextStyle(color: Colors.white70),
                    border: OutlineInputBorder(),
                    fillColor: Colors.white24,
                    filled: true,
                  ),
                  maxLines: 5,
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 10),
                DropdownButton<double>(
                  value: selectedRating,
                  dropdownColor: Colors.black87,
                  items: List.generate(10, (index) {
                    double ratingValue = (index + 1) * 0.5;
                    return DropdownMenuItem<double>(
                      value: ratingValue,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(5, (starIndex) {
                          if (starIndex < ratingValue.floor()) {
                            return Icon(Icons.star, color: Colors.amber);
                          } else if (starIndex + 0.5 == ratingValue) {
                            return Icon(Icons.star_half, color: Colors.amber);
                          } else {
                            return Icon(Icons.star_border, color: Colors.amber);
                          }
                        }),
                      ),
                    );
                  }),
                  onChanged: (newValue) {
                    setModalState(() {
                      selectedRating = newValue;
                    });
                  },
                  underline: Container(),
                  style: TextStyle(color: Colors.white),
                  iconEnabledColor: Colors.white,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  child: Text('Update Review'),
                  onPressed: () async {
                  if (selectedRating != null && reviewController.text.isNotEmpty) {
                    bool success = await editReviewFlutter(
                      review.pk, 
                      reviewController.text,
                      selectedRating!,
                    );

                    if (success) {
                      Navigator.of(context).pop(true);
                      Navigator.of(context).pop(true);
                      onReviewUpdated();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Review updated successfully')),
                      );
                    } else {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to update review')),
                      );
                    }
                  } else {
                    // If some fields are empty or not selected
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please fill in all fields')),
                    );
                  }
                },
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
