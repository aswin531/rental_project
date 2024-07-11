import 'package:equatable/equatable.dart';

abstract class HomeDisplayCarEvent extends Equatable {
  const HomeDisplayCarEvent();

  @override
  List<Object?> get props => [];
}

class FetchCars extends HomeDisplayCarEvent {}
