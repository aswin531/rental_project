import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentit/core/injection_container/dependency_injection.dart';
import 'package:rentit/features/reviews/data/model/review_model.dart';
import 'package:rentit/features/reviews/domain/usecases/addreview_usecase.dart';
import 'package:rentit/features/reviews/domain/usecases/uploadimage_usecase.dart';
import 'package:rentit/features/reviews/presentation/bloc/review_event.dart';
import 'package:rentit/features/reviews/presentation/bloc/review_state.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  final AddReviewUseCase _addReviewUseCase;
  final UploadImageUseCase _uploadImageUseCase;

  ReviewBloc(this._addReviewUseCase, this._uploadImageUseCase) : super(const ReviewState()) {
    on<InitializeReview>(_onInitializeReview);
    on<RatingChanged>(_onRatingChanged);
    on<ReviewTextChanged>(_onReviewTextChanged);
    on<AddImage>(_onAddImage);
    on<SubmitReview>(_onSubmitReview);
  }

  void _onInitializeReview(InitializeReview event, Emitter<ReviewState> emit) {
    emit(state.copyWith(
      carId: event.carId,
      carModel: event.carModel,
      carImage: event.carImage,
    ));
  }

  void _onRatingChanged(RatingChanged event, Emitter<ReviewState> emit) {
    emit(state.copyWith(rating: event.rating));
  }

  void _onReviewTextChanged(ReviewTextChanged event, Emitter<ReviewState> emit) {
    emit(state.copyWith(reviewText: event.reviewText));
  }

  void _onAddImage(AddImage event, Emitter<ReviewState> emit) {
    final updatedImages = List<File>.from(state.images)..add(event.image);
    emit(state.copyWith(images: updatedImages));
  }

  Future<void> _onSubmitReview(SubmitReview event, Emitter<ReviewState> emit) async {
    emit(state.copyWith(isSubmitting: true, error: null));
    try {
      final imageUrls = await Future.wait(
        state.images.map((image) => _uploadImageUseCase(image))
      );
      
      final review = Review(
        id: '', 
        userId: firebaseAuthInstance.currentUser!.uid, 
        carId: state.carId,
        rating: state.rating,
        reviewText: state.reviewText,
        imageUrls: imageUrls,
        createdAt: DateTime.now(),
      );

      await _addReviewUseCase(review);
      emit(state.copyWith(isSubmitting: false, isSuccess: true));
    } catch (e) {
      emit(state.copyWith(isSubmitting: false, error: e.toString()));
    }
  }
}