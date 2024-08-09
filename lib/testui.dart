import 'package:flutter/material.dart';

class TestCarListScreen extends StatelessWidget {
  const TestCarListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: 250.0,
              backgroundColor: Colors.blue,
              flexibleSpace: FlexibleSpaceBar(
                background: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 32), // For status bar space
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Icon(Icons.location_on, color: Colors.white),
                          Text(
                            "New York, USA",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          Icon(Icons.notifications, color: Colors.white),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: const TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search",
                            icon: Icon(Icons.search, color: Colors.blue),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Brands",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text("See All"),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 100, // Height for the brand icons section
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          BrandIconWidget(brandName: "BMW"),
                          BrandIconWidget(brandName: "Toyota"),
                          BrandIconWidget(brandName: "Mercedes"),
                          BrandIconWidget(brandName: "Tesla"),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Popular Car",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text("See All"),
                        ),
                      ],
                    ),
                    PopularCarWidget(
                      imageUrl:
                          "assets/car_image.png", // Replace with your image path
                      carName: "Hyundai Verna",
                      carType: "Sedan",
                      pricePerHour: "\$25.00/hr",
                      rating: "4.9",
                    ),
                    PopularCarWidget(
                      imageUrl:
                          "assets/car_image.png", // Replace with your image path
                      carName: "Hyundai Verna",
                      carType: "Sedan",
                      pricePerHour: "\$25.00/hr",
                      rating: "4.9",
                    ),
                    PopularCarWidget(
                      imageUrl:
                          "assets/car_image.png", // Replace with your image path
                      carName: "Hyundai Verna",
                      carType: "Sedan",
                      pricePerHour: "\$25.00/hr",
                      rating: "4.9",
                    ),
                    PopularCarWidget(
                      imageUrl:
                          "assets/car_image.png", // Replace with your image path
                      carName: "Hyundai Verna",
                      carType: "Sedan",
                      pricePerHour: "\$25.00/hr",
                      rating: "4.9",
                    ),
                    // Add more PopularCarWidget if needed
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BrandIconWidget extends StatelessWidget {
  final String brandName;

  const BrandIconWidget({required this.brandName, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor:
                Colors.grey[200], // Background color for brand icon
            child: Icon(Icons.directions_car,
                size: 30, color: Colors.blue), // Placeholder for brand icon
          ),
          const SizedBox(height: 8),
          Text(brandName),
        ],
      ),
    );
  }
}

class PopularCarWidget extends StatelessWidget {
  final String imageUrl;
  final String carName;
  final String carType;
  final String pricePerHour;
  final String rating;

  const PopularCarWidget({
    required this.imageUrl,
    required this.carName,
    required this.carType,
    required this.pricePerHour,
    required this.rating,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(imageUrl), // Image of the car
            const SizedBox(height: 8),
            Text(carType, style: const TextStyle(color: Colors.grey)),
            Text(carName,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(pricePerHour,
                style: const TextStyle(color: Colors.blue, fontSize: 16)),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.star, color: Colors.yellow[700]),
                const SizedBox(width: 4),
                Text(rating),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
