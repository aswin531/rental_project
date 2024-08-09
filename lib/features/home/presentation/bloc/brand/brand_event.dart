import 'package:equatable/equatable.dart';

abstract class BrandsEvent extends Equatable {
  const BrandsEvent();
  @override
  List<Object> get props => [];
}

class FetchBrands extends BrandsEvent {
  const FetchBrands();
  @override
  List<Object> get props => [];
}
