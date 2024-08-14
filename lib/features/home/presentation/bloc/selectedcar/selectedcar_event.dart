import 'package:equatable/equatable.dart';
import 'package:rentit/features/home/domain/entity/car_entity.dart';

abstract class SelectedCarEvent extends Equatable {
  const SelectedCarEvent();

  @override
  List<Object> get props => [];
}

class SelectCar extends SelectedCarEvent {
  final CarVehicleEntity selectedCar;

  const SelectCar(this.selectedCar);

  @override
  List<Object> get props => [selectedCar];
}
