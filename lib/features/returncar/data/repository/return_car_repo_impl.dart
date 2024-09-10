import 'package:rentit/features/returncar/data/datasource/return_car_datasource.dart';
import 'package:rentit/features/returncar/data/model/car_return_model.dart';
import 'package:rentit/features/returncar/domain/entity/car_return_entity.dart';
import 'package:rentit/features/returncar/domain/repository/return_car_repository.dart';

class CarReturnRepositoryImpl implements CarReturnRepository {
  final ReturnCarDatasource returnCarDatasource;

  CarReturnRepositoryImpl(this.returnCarDatasource);

  @override
  Future<void> carReturnInitial(String rentalId) async {
    try {
      await returnCarDatasource.carReturnInitiate(rentalId);
    } catch (e) {
      throw Exception('Error initiating car return: $e');
    }
  }

  @override
  Future<void> confirmCarReturn(CarReturnEntity carReturnEntity) async {
    try {
      final carReturnModel = CarReturnModel(
        carReturnEntity.returnId,
        carReturnEntity.carId,
        carReturnEntity.userId,
        carReturnEntity.returnDate,
        carReturnEntity.isDamaged,
        carReturnEntity.fuelLevel,
        carReturnEntity.mileage,
        carReturnEntity.comments,
        carReturnEntity.lateFee,
        carReturnEntity.totalCost,
      );
      
      await returnCarDatasource.carReturnConfirm(carReturnEntity.returnId, carReturnModel);
    } catch (e) {
      // Handle or log the error appropriately
      throw Exception('Error confirming car return: $e');
    }
  }
}
