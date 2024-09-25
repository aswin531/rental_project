import 'package:rentit/features/reviews/data/model/review_model.dart';
import 'package:rentit/features/reviews/domain/repository/review_repository.dart';

class AddReviewUseCase {
  final ReviewRepository _repository;

  AddReviewUseCase(this._repository);

  Future<void> call(Review review) async {
    await _repository.addReview(review);
  }
}