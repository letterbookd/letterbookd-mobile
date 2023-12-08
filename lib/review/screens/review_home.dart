import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewHome extends StatelessWidget {
  const ReviewHome({Key? key}) : super(key: key);

  static const List<ReviewItem> items = [
    ReviewItem("Lihat Review Saya", Icons.preview),
    ReviewItem("Tambah Review", Icons.rate_review),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text("Reviews"),
      ),
      body: Column(
        children: [
          Container(
            color: Theme.of(context).colorScheme.primaryContainer,
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(
                            text: "4.5",
                            style: TextStyle(fontSize: 48.0),
                          ),
                          TextSpan(
                            text: "/5",
                            style: TextStyle(
                              fontSize: 24.0,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    RatingBar.builder(
                      initialRating: 4.5,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 28.0,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.orange,
                      ),
                      onRatingUpdate: (rating) {
                        // Handle rating update
                      },
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      "10 Reviews", // Replace with the actual number of reviews
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 200.0,
                  child: ListView.builder(
                    shrinkWrap: true,
                    reverse: true,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Text(
                            "${index + 1}",
                            style: const TextStyle(fontSize: 18.0),
                          ),
                          const SizedBox(width: 4.0),
                          const Icon(Icons.star, color: Colors.orange),
                          const SizedBox(width: 8.0),
                          LinearPercentIndicator(
                            lineHeight: 6.0,
                            width: MediaQuery.of(context).size.width / 2.8,
                            animation: true,
                            animationDuration: 2500,
                            percent:
                                0.7, // Replace with the actual rating percentage
                            progressColor: Colors.orange,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(8.0),
              itemCount: 10, // Replace with the actual number of reviews
              itemBuilder: (context, index) {
                return ReviewCard(ReviewItem("User $index", Icons.person));
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 8.0);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ReviewItem {
  final String title;
  final IconData icon;

  const ReviewItem(this.title, this.icon);
}

class ReviewCard extends StatelessWidget {
  final ReviewItem item;

  const ReviewCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: InkWell(
        onTap: () {
          // Handle item tap
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(item.icon),
              const SizedBox(width: 4.0),
              Text(item.title),
            ],
          ),
        ),
      ),
    );
  }
}
