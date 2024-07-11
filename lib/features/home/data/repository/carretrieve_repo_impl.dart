import 'package:rentit/features/home/data/datasource/car_retrieval_datasource.dart';
import 'package:rentit/features/home/domain/entities/car_entity.dart';
import 'package:rentit/features/home/domain/repository/carrepo_interface.dart';

class CarRepositoryImpl implements CarRepository {
  final CarRemoteDataSource carRemoteDataSource;

  CarRepositoryImpl({required this.carRemoteDataSource});

  @override
  Future<List<CarVehicle>> getCars() async {
    return await carRemoteDataSource.getCars();
  }
}
