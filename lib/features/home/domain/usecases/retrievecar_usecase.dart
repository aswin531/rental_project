import 'package:rentit/features/home/domain/entities/car_entity.dart';
import 'package:rentit/features/home/domain/repository/carrepo_interface.dart';

class RetrieveCars {
  final CarRepository repository;

  RetrieveCars(this.repository);

  Future<List<CarVehicle>> call() async {
    return await repository.getCars();
  }
}
