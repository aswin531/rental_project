import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentit/features/reviews/presentation/bloc/review_event.dart';
import 'package:rentit/features/reviews/presentation/bloc/review_state.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  ReviewBloc() : super(const ReviewState()) {
    on<RatingChanged>((event, emit) {
      emit(state.copyWith(rating: event.rating));
    });

    on<ReviewTextChanged>((event, emit) {
      emit(state.copyWith(reviewText: event.reviewText));
    });
  }
}
