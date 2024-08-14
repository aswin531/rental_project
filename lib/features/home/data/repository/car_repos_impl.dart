import 'package:flutter/material.dart';
import 'package:rentit/features/home/data/datasource/car_datasource.dart';
import 'package:rentit/features/home/data/model/carvehicle_model.dart';
import 'package:rentit/features/home/domain/entity/brand_entity.dart';
import 'package:rentit/features/home/domain/entity/car_entity.dart';
import 'package:rentit/features/home/domain/repository/car_rental_repo.dart';

class CarReposImpl implements CarRepository {
  final CarRemoteDataSource remoteDataSource;

  CarReposImpl({required this.remoteDataSource});

  @override
  Stream<List<CarVehicleEntity>> getCars() {
    try {
      return remoteDataSource.getCars().map((carModels) {
        return carModels.map((model) {
          return CarVehicleEntity(
            carId: model.carId,
            make: model.make,
            engine: model.engine,
            seatCapacity: model.seatCapacity,
            model: model.model,
            body: model.body,
            year: model.year,
            color: model.color,
            rentalPriceRange: model.rentalPriceRange,
            status: model.status,
            imageUrls: model.imageUrls,
            mainImageUrl: model.mainImageUrl,
          );
        }).toList();
      }).handleError((error) {
        debugPrint('Error occurred in getCarsStream: $error');
        throw Exception('Failed to fetch car stream.');
      });
    } catch (error) {
      debugPrint('Error in getCarsStream: $error');
      return Stream.error('Failed to fetch car stream.');
    }
  }

  @override
  Future<List<BrandEntity>> getBrands() async {
    final brandModels = await remoteDataSource.getBrands();
    return brandModels.map((model) => model.toEntity()).toList();
  }
  
  @override
  Future<List<CarVehicleModel>> getCarsByBrand(String brandName) {
    throw UnimplementedError();
  }

  // @override
  // Future<List<CarVehicleModel>> getCarsByBrand(String brand) async {
  //   final cars = await remoteDataSource.getCars();
  //   return cars.where((car) => car.make == brand).toList();
  // }
}




// class GetCarsUseCase {
//   final CarRepository repository;

//   GetCarsUseCase(this.repository);

//   Future<List<Car>> execute() async {
//     try {
//       return await repository.getCars();
//     } on ServerException catch (e) {
//       // Handle the exception or rethrow it
//       print('Error fetching cars: ${e.message}');
//       rethrow;
//     }
//   }
// }