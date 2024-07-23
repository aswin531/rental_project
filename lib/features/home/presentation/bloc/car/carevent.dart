import 'package:equatable/equatable.dart';

abstract class CarEvent extends Equatable {
  const CarEvent();
  @override
  List<Object> get props => [];
}

class FetchCars extends CarEvent {}

class RefreshCars extends CarEvent {}

class FilterCars extends CarEvent {
  final String brand;
  const FilterCars(this.brand);
  @override
  List<Object> get props => [];
}
