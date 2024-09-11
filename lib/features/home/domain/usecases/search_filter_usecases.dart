// fetch_cars_usecase.dart
import 'package:rentit/features/home/data/model/carvehicle_model.dart';
import 'package:rentit/features/home/domain/entity/car_entity.dart';
import 'package:rentit/features/home/domain/repository/car_rental_repo.dart';

class FetchCarsUsecase {
  final CarRepository carRepository;

  FetchCarsUsecase({required this.carRepository});

  Stream<List<CarVehicleEntity>> call() {
    return carRepository.getCars();
  }
}

// search_cars_usecase.dart
class SearchCarsUsecase {
  final CarRepository carRepository;

  SearchCarsUsecase({required this.carRepository});

  Stream<List<CarVehicleModel>> call(String searchTerm) {
    return carRepository.getCarBySearch(searchTerm: searchTerm);
  }
}

// filter_cars_usecase.dart
class FilterCarsUsecase {
  final CarRepository carRepository;

  FilterCarsUsecase({required this.carRepository});

  Stream<List<CarVehicleModel>> call({
    String? make,
    String? model,
   // PriceRange? priceRange,
    int? year,
  }) {
    return carRepository.getCarBySearch(
      make: make,
      model: model,
      //priceRange: priceRange,
      year: year,
    );
  }
}
