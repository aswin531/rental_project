import 'package:equatable/equatable.dart';
import 'package:rentit/features/home/data/model/carvehicle_model.dart';
import 'package:rentit/features/home/domain/entity/brand_entity.dart';


abstract class BrandsState extends Equatable {
  const BrandsState();

  @override
  List<Object?> get props => [];
}

class BrandsInitial extends BrandsState {}

class BrandsLoading extends BrandsState {}

class BrandsLoaded extends BrandsState {
  final List<BrandEntity> brands;

  const BrandsLoaded(this.brands);

  @override
  List<Object?> get props => [brands];
}

class BrandsError extends BrandsState {
  final String message;

  const BrandsError(this.message);

  @override
  List<Object?> get props => [message];
}

class CarsLoading extends BrandsState {}

class CarsLoadedByBrand extends BrandsState {
  final List<CarVehicleModel> cars;

  const CarsLoadedByBrand(this.cars);

  @override
  List<Object?> get props => [cars];
}

class CarsErrorByBrand extends BrandsState {
  final String message;

  const CarsErrorByBrand(this.message);

  @override
  List<Object?> get props => [message];
}
