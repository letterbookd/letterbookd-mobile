import 'package:flutter/material.dart';
import 'package:letterbookd/review/screens/review_add.dart';

class ReviewHome extends StatelessWidget {
  const ReviewHome({Key? key}) : super(key: key);

  static const List<ReviewItem> items = [
    ReviewItem("Lihat Review Saya", Icons.preview),
    ReviewItem("Tambah Review", Icons.rate_review),
  ];

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
              color: Colors.blue,
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
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: ReviewCard(items[0]),
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: ReviewCard(items[1]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Removed GridView.builder section
          ],
        ),
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

  const ReviewCard(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.purple[50],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: InkWell(
        onTap: () {
          // Handle item tap
          if (item.title == "Tambah Review") {
            // Redirect to AddFormPage
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddFormPage()),
            );
          } else {
            // Handle other item taps
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(item.icon),
              SizedBox(width: 4.0),
              Text(
                item.title,
                style: TextStyle(
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





// import 'package:flutter/material.dart';
// import 'package:percent_indicator/linear_percent_indicator.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// class ReviewHome extends StatelessWidget {
//   ReviewHome({Key? key}) : super(key: key);

//   static const List<ReviewItem> items = [
//     ReviewItem("Lihat Review Saya", Icons.preview),
//     ReviewItem("Tambah Review", Icons.rate_review),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Text("Reviews"),
//       ),
//       body: Column(
//         children: [
//           Container(
//             color: Colors.blue[50],
//             padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text.rich(
//                       TextSpan(
//                         children: [
//                           TextSpan(
//                             text: "4.5",
//                             style: TextStyle(fontSize: 48.0),
//                           ),
//                           TextSpan(
//                             text: "/5",
//                             style: TextStyle(
//                               fontSize: 24.0,
//                               color: Colors.grey,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       width: 150.0, // Set a fixed width for the RatingBar
//                       child: RatingBar.builder(
//                         initialRating: 4.5,
//                         minRating: 1,
//                         direction: Axis.horizontal,
//                         allowHalfRating: true,
//                         itemCount: 5,
//                         itemSize: 28.0,
//                         itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
//                         itemBuilder: (context, _) => Icon(
//                           Icons.star,
//                           color: Colors.orange,
//                         ),
//                         onRatingUpdate: (rating) {
//                           // Handle rating update
//                         },
//                       ),
//                     ),
//                     SizedBox(height: 16.0),
//                     Text(
//                       "10 Reviews", // Replace with the actual number of reviews
//                       style: TextStyle(
//                         fontSize: 20.0,
//                         color: Colors.grey,
//                       ),
//                     ),
//                   ],
//                 ),
//                 Container(
//                   width: 200.0,
//                   child: ListView.builder(
//                     shrinkWrap: true,
//                     reverse: true,
//                     itemCount: 5,
//                     itemBuilder: (context, index) {
//                       return Row(
//                         children: [
//                           Text(
//                             "${index + 1}",
//                             style: TextStyle(fontSize: 18.0),
//                           ),
//                           SizedBox(width: 4.0),
//                           Icon(Icons.star, color: Colors.orange),
//                           SizedBox(width: 8.0),
//                           LinearPercentIndicator(
//                             lineHeight: 6.0,
//                             width: MediaQuery.of(context).size.width / 2.8,
//                             animation: true,
//                             animationDuration: 2500,
//                             percent:
//                                 0.7, // Replace with the actual rating percentage
//                             progressColor: Colors.orange,
//                           ),
//                         ],
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: ListView.separated(
//               padding: EdgeInsets.only(bottom: 8.0, top: 8.0),
//               itemCount: items.length,
//               itemBuilder: (context, index) {
//                 return InkWell(
//                   onTap: () {
//                     // Navigate to another page when ReviewItem is tapped
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => AnotherPage(),
//                       ),
//                     );
//                   },
//                   child: ListTile(
//                     leading: Icon(items[index].icon),
//                     title: Text(items[index].title),
//                   ),
//                 );
//               },
//               separatorBuilder: (context, index) {
//                 return Divider(
//                   thickness: 2.0,
//                   color: Colors.blue[100],
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ReviewItem {
//   final String title;
//   final IconData icon;

//   const ReviewItem(this.title, this.icon);
// }

// class AnotherPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Another Page"),
//       ),
//       body: Center(
//         child: Text("This is another page"),
//       ),
//     );
//   }
// }
