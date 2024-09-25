import 'dart:io';
import 'package:rentit/features/reviews/data/datasource/review_datasource.dart';
import 'package:rentit/features/reviews/data/model/review_model.dart';
import 'package:rentit/features/reviews/domain/repository/review_repository.dart';

class ReviewRepositoryImpl implements ReviewRepository {
  final ReviewDataSource _dataSource;

  ReviewRepositoryImpl(this._dataSource);

  @override
  Future<void> addReview(Review review) async {
    await _dataSource.addReview(review);
  }

  @override
  Future<List<Review>> getReviewsForCar(String carId) async {
    return await _dataSource.getReviewsForCar(carId);
  }

  @override
  Future<String> uploadImage(File image) async {
    return await _dataSource.uploadImage(image);
  }
}