import 'package:cloud_firestore/cloud_firestore.dart';

class Review {
  final String id;
  final String userId;
  final String carId;
  final double rating;
  final String reviewText;
  final List<String> imageUrls;
  final DateTime createdAt;

  Review({
    required this.id,
    required this.userId,
    required this.carId,
    required this.rating,
    required this.reviewText,
    required this.imageUrls,
    required this.createdAt,
  });

  factory Review.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Review(
      id: doc.id,
      userId: data['userId'] ?? '',
      carId: data['carId'] ?? '',
      rating: (data['rating'] ?? 0).toDouble(),
      reviewText: data['reviewText'] ?? '',
      imageUrls: List<String>.from(data['imageUrls'] ?? []),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'carId': carId,
      'rating': rating,
      'reviewText': reviewText,
      'imageUrls': imageUrls,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}