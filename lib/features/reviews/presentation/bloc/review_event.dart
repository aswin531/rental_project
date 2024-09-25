import 'dart:io';
import 'package:equatable/equatable.dart';

abstract class ReviewEvent extends Equatable {
  const ReviewEvent();

  @override
  List<Object> get props => [];
}

class InitializeReview extends ReviewEvent {
  final String carId;
  final String carModel;
  final String carImage;

  const InitializeReview(
      {required this.carId, required this.carModel, required this.carImage});

  @override
  List<Object> get props => [carId, carModel, carImage];
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

class AddImage extends ReviewEvent {
  final File image;
  const AddImage(this.image);
  @override
  List<Object> get props => [image];
}

class SubmitReview extends ReviewEvent {}


/*
   List<Object> get props => [rating]; <==>
If the user tries to add the same review twice, this setup allows your system to recognize that the events are identical, potentially preventing duplicate submissions.
 two instances of RatingChangedare considered equal if they have the same rating.
*/