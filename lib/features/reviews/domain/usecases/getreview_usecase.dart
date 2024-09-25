import 'package:rentit/features/reviews/data/model/review_model.dart';
import 'package:rentit/features/reviews/domain/repository/review_repository.dart';

class GetReviewsForCarUseCase {
  final ReviewRepository _repository;

  GetReviewsForCarUseCase(this._repository);

  Future<List<Review>> call(String carId) async {
    return await _repository.getReviewsForCar(carId);
  }
}