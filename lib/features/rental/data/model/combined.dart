import 'package:rentit/features/rental/data/model/car_req.dart';
import 'package:rentit/features/rental/data/model/request_form_model.dart';

class RentalRequestWithCarDetails {
  final RentalRequestModel rentalRequest;
  final CarModel car;

  RentalRequestWithCarDetails({
    required this.rentalRequest,
    required this.car,
  });
}
