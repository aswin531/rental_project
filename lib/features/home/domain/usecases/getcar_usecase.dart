import 'package:flutter/foundation.dart';
import 'package:rentit/core/errors/server_exception.dart';
import 'package:rentit/features/home/domain/entity/car_entity.dart';
import 'package:rentit/features/home/domain/repository/car_rental_repo.dart';

class GetcarUsecase {
  final CarRepository repository;

  GetcarUsecase({required this.repository});

  Future<List<CarVehicleEntity>> execute() async {
    try {
      return await repository.getCars();
    } on ServerException catch (e) {
      // Handle the exception or rethrow it
      debugPrint('Error fetching cars: ${e.message}');
      rethrow;
    }
  }
}



// What is the responsibility of the UseCase? The use case is responsible for encapsulating the business logic for a single reusable task the system must perform. 1- Business logic focuses on the WHAT the product team needs to achieve when they describe to us the task.