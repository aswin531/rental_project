import 'package:rentit/features/home/domain/entities/car_entity.dart';

abstract class CarRepository {
  Future<List<CarVehicle>> getCars();
}
