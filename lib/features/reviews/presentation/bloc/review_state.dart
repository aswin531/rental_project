import 'package:equatable/equatable.dart';

class ReviewState extends Equatable {
  final double rating;
  final String reviewText;

  const ReviewState({this.rating = 4.5, this.reviewText=""});

    ReviewState copyWith({
    double? rating,
    String? reviewText,
  }) {
    return ReviewState(
      rating: rating ?? this.rating,
      reviewText: reviewText ?? this.reviewText,
    );
  }

  @override
  List<Object> get props => [rating, reviewText];

}
