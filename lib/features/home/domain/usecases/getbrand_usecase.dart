import 'package:rentit/features/home/domain/entity/brand_entity.dart';
import 'package:rentit/features/home/domain/repository/car_rental_repo.dart';

class GetBrandUsecase {
  final CarRepository carRepository;

  GetBrandUsecase({required this.carRepository});

  Future<List<BrandEntity>> execute() async {
    return carRepository.getBrands();
  }
}
