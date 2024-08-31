import 'package:equatable/equatable.dart';

abstract class ReviewEvent extends Equatable {
  const ReviewEvent();

  @override
  List<Object> get props =>
      []; //return a list of properties that should be used to determine equality between instances of ReviewEvent
}

class RatingChanged extends ReviewEvent {
  final double rating;
  const RatingChanged(this.rating);
  @override
  List<Object> get props => [rating];
}

class ReviewTextChanged extends ReviewEvent {
  final String reviewText;
  const ReviewTextChanged(this.reviewText);
  @override
  List<Object> get props => [reviewText];
}



/*
   List<Object> get props => [rating]; <==>
If the user tries to add the same review twice, this setup allows your system to recognize that the events are identical, potentially preventing duplicate submissions.
 two instances of RatingChangedare considered equal if they have the same rating.
*/