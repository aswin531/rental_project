import 'dart:io';
import 'package:rentit/features/reviews/domain/repository/review_repository.dart';

class UploadImageUseCase {
  final ReviewRepository _repository;

  UploadImageUseCase(this._repository);

  Future<String> call(File image) async {
    return await _repository.uploadImage(image);
  }
}
