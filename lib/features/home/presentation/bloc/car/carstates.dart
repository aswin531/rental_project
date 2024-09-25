import 'package:equatable/equatable.dart';
import 'package:rentit/features/home/data/model/carvehicle_model.dart';
import 'package:rentit/features/home/domain/entity/car_entity.dart';

abstract class CarState extends Equatable {
  const CarState();
  @override
  List<Object> get props => [];
}

class CarInitial extends CarState {}

class CarLoading extends CarState {}

class CarLoaded extends CarState {
  final List<CarVehicleEntity> cars;

  const CarLoaded(this.cars);
  @override
  List<Object> get props => [cars];
}

class CarSearchLoaded extends CarState {
  final List<CarVehicleModel> cars;

  const CarSearchLoaded(this.cars);
  @override
  List<Object> get props => [cars];
}


class CarError extends CarState {
  final String message;
  const CarError(this.message);
  @override
  List<Object> get props => [message];
}
