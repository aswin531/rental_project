import 'package:equatable/equatable.dart';
import 'package:rentit/features/home/domain/entities/car_entity.dart';

abstract class HomeDisplayCarState extends Equatable {
  const HomeDisplayCarState();

  @override
  List<Object?> get props => [];
}

class HomeDisplayCarLoading extends HomeDisplayCarState {}

class HomeDisplayCarLoaded extends HomeDisplayCarState {
  final List<CarVehicle> cars;

  const HomeDisplayCarLoaded(this.cars);

  @override
  List<Object?> get props => [cars];
}

class HomeDisplayCarError extends HomeDisplayCarState {
  final String message;

  const HomeDisplayCarError({required this.message});

  @override
  List<Object?> get props => [message];
}
