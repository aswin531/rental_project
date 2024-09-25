import 'dart:io';

import 'package:rentit/features/reviews/data/model/review_model.dart';

abstract class ReviewRepository {
  Future<void> addReview(Review review);
  Future<List<Review>> getReviewsForCar(String carId);
  Future<String> uploadImage(File image);
}