import 'package:rentit/features/home/domain/entity/car_entity.dart';
import 'package:rentit/features/home/domain/repository/car_rental_repo.dart';

class GetCarsStreamUseCase {
  final CarRepository repository;

  GetCarsStreamUseCase({required this.repository});

  Stream<List<CarVehicleEntity>> call() {
    return repository.getCars();
  }
}



// What is the responsibility of the UseCase? The use case is responsible for 
//encapsulating the business logic for a single reusable task the system must 
//perform. 1- Business logic focuses on the WHAT the product team needs to 
//achieve when they describe to us the task.