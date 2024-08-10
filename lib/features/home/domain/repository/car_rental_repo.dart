import 'package:rentit/features/home/data/model/carvehicle_model.dart';
import 'package:rentit/features/home/domain/entity/brand_entity.dart';
import 'package:rentit/features/home/domain/entity/car_entity.dart';

abstract class CarRepository {
  Future<List<CarVehicleEntity>> getCars();
   Future<List<BrandEntity>> getBrands();
   Future<List<CarVehicleModel>> getCarsByBrand(String brandName);
}