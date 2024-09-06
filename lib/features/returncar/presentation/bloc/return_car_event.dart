import 'package:equatable/equatable.dart';
import 'package:rentit/features/returncar/domain/entity/car_return_entity.dart';

abstract class CarReturnEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CarReturnInitiate extends CarReturnEvent {
  final String rentalId;
  CarReturnInitiate(this.rentalId);

  @override
  List<Object> get props => [rentalId];
}

class CarReturnConfirmation extends CarReturnEvent {
  final String rentalId;
  final CarReturnEntity carReturnEntity;

  CarReturnConfirmation(this.carReturnEntity, this.rentalId);
}
