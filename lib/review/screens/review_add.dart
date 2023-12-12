import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

// Kurang Impor dari modul library
// import 'package:library_module/library_module.dart';

class AddFormPage extends StatefulWidget {
  const AddFormPage({super.key});

  @override
  State<AddFormPage> createState() => _AddFormPageState();
}

class _AddFormPageState extends State<AddFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _statusOnReview = ""; // Get the value from your library module here
  double _starsRating = 0;
  String _reviewText = "";

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Handle form submission here
      print('Status on Review: $_statusOnReview');
      print('Stars Rating: $_starsRating');
      print('Review Text: $_reviewText');
    }
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Form Tambah Review',
          ),
        ),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RatingBar.builder(
                initialRating: _starsRating,
                minRating: 0,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 32.0,
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    _starsRating = rating;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                initialValue: _statusOnReview,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: "Status on Review",
                  labelText: "UNTRACKED",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    _reviewText = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: "Review Text",
                  labelText: "Review Text",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                maxLines: 3, // Adjust the number of lines as needed
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.indigo),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Review successfuly created!'),
                            content: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Stars Rating: $_starsRating '),
                                  Text('Status on Review: $_statusOnReview'),
                                  Text('Review: $_reviewText'),

                                  // TODO: Munculkan value-value lainnya
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                child: const Text('OK'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        },
                      );
                      _formKey.currentState!.reset();
                    }
                  },
                  child: const Text(
                    "Save",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
