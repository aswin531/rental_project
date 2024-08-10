import 'package:rentit/features/home/data/model/carvehicle_model.dart';
import 'package:rentit/features/home/domain/repository/car_rental_repo.dart';

class GetCarsByBrandUsecase {
  final CarRepository carRepository;

  GetCarsByBrandUsecase({required this.carRepository});

  Future<List<CarVehicleModel>> execute(String brandName) async {
    return carRepository.getCarsByBrand(brandName);
  }
}
