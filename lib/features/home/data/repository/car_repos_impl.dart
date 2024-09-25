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

  @override
  Stream<List<CarVehicleModel>> getCarBySearch({
    String? searchTerm,
    String? make,
    String? model,
    // PriceRange? priceRange,
    int? year,
  }) {
    return remoteDataSource.getCarBySearch(
      searchTerm: searchTerm,
      make: make,
      model: model,
      // priceRange: priceRange,
      year: year,
    );
  }
}
