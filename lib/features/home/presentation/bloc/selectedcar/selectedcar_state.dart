import 'package:equatable/equatable.dart';
import 'package:rentit/features/home/domain/entity/car_entity.dart';

abstract class SelectedCarState extends Equatable {
  const SelectedCarState();

  @override
  List<Object> get props => [];
}

class SelectedCarInitial extends SelectedCarState {}

class CarSelected extends SelectedCarState {
  final CarVehicleEntity car;

  const CarSelected(this.car);
  @override
  List<Object> get props => [car];
}
