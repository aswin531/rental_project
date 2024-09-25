import 'dart:io';
import 'package:equatable/equatable.dart';

class ReviewState extends Equatable {
  final String carId;
  final String carModel;
  final String carImage;
  final double rating;
  final String reviewText;
  final List<File> images;
  final bool isSubmitting;
  final bool isSuccess;
  final String? error;

  const ReviewState({
    this.carId = '',
    this.carModel = '',
    this.carImage = '',
    this.rating = 0,
    this.reviewText = "",
    this.images = const [],
    this.isSubmitting = false,
    this.isSuccess = false,
    this.error,
  });

  ReviewState copyWith({
    String? carId,
    String? carModel,
    String? carImage,
    double? rating,
    String? reviewText,
    List<File>? images,
    bool? isSubmitting,
    bool? isSuccess,
    String? error,
  }) {
    return ReviewState(
      carId: carId ?? this.carId,
      carModel: carModel ?? this.carModel,
      carImage: carImage ?? this.carImage,
      rating: rating ?? this.rating,
      reviewText: reviewText ?? this.reviewText,
      images: images ?? this.images,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        carId,
        carModel,
        carImage,
        rating,
        reviewText,
        images,
        isSubmitting,
        isSuccess,
        error
      ];
}
