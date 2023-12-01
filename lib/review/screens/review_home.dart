import 'package:flutter/material.dart';

/// ini contoh
class ReviewHome extends StatelessWidget {
  ReviewHome({Key? key}) : super(key: key);

  final List<ReviewItem> items = [
    ReviewItem("Lihat Review", Icons.checklist),
    ReviewItem("Tambah Review", Icons.add_shopping_cart),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reviews"),
      ),
      body: SingleChildScrollView(
        // Widget wrapper yang dapat discroll
        child: Padding(
          padding: const EdgeInsets.all(10.0), // Set padding dari halaman
          child: Column(
            // Widget untuk menampilkan children secara vertikal
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                // Widget Text untuk menampilkan tulisan dengan alignment center dan style yang sesuai
                child: Text(
                  'PBP Shop', // Text yang menandakan toko
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Grid layout
              GridView.count(
                // Container pada card kita.
                primary: true,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 3,
                shrinkWrap: true,
                children: items.map((ReviewItem item) {
                  // Iterasi untuk setiap item
                  return ReviewCard(item);
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReviewItem {
  final String title;
  final IconData icon;

  ReviewItem(this.title, this.icon);
}

class ReviewCard extends StatelessWidget {
  final ReviewItem item;

  const ReviewCard(this.item);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(item.title),
        leading: Icon(item.icon),
        onTap: () {
          // Handle item tap
        },
      ),
    );
  }
}
