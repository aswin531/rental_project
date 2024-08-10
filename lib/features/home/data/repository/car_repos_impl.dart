import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rentit/core/errors/server_exception.dart';
import 'package:rentit/features/home/data/datasource/car_datasource.dart';
import 'package:rentit/features/home/data/model/carvehicle_model.dart';
import 'package:rentit/features/home/domain/entity/brand_entity.dart';
import 'package:rentit/features/home/domain/entity/car_entity.dart';
import 'package:rentit/features/home/domain/repository/car_rental_repo.dart';

class CarReposImpl implements CarRepository {
  final CarRemoteDataSource remoteDataSource;

  CarReposImpl({required this.remoteDataSource});

  @override
  Future<List<CarVehicleEntity>> getCars() async {
    try {
      final carModels = await remoteDataSource.getCars();
      return carModels
          .map((model) => CarVehicleEntity(
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
              mainImageUrl: model.mainImageUrl))
          .toList();
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Failed to Fetch Cars');
    }
  }

  @override
  Future<List<BrandEntity>> getBrands() async {
    final brandModels = await remoteDataSource.getBrands();
    return brandModels.map((model) => model.toEntity()).toList();
  }

  @override
  Future<List<CarVehicleModel>> getCarsByBrand(String brand) async {
    final cars = await remoteDataSource.getCars();
    return cars.where((car) => car.make == brand).toList();
  }
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