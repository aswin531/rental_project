import 'package:firebase_storage/firebase_storage.dart';
import 'package:rentit/core/injection_container/dependency_injection.dart';
import 'dart:io';

import 'package:rentit/features/reviews/data/model/review_model.dart';

class ReviewDataSource {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> addReview(Review review) async {
    await firebaseFirestore.collection('reviews').add(review.toFirestore());
  }

  Future<List<Review>> getReviewsForCar(String carId) async {
    final querySnapshot = await firebaseFirestore
        .collection('reviews')
        .where('carId', isEqualTo: carId)
        .get();
    return querySnapshot.docs.map((doc) => Review.fromFirestore(doc)).toList();
  }

  Future<String> uploadImage(File image) async {
    final ref = _storage.ref().child('review_images/${DateTime.now()}.png');
    await ref.putFile(image);
    return await ref.getDownloadURL();
  }
}