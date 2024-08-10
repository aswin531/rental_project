import 'package:equatable/equatable.dart';

abstract class BrandsEvent extends Equatable {
  const BrandsEvent();

  @override
  List<Object?> get props => [];
}

class FetchBrands extends BrandsEvent {
  const FetchBrands();
}

class FetchCarsByBrand extends BrandsEvent {
  final String brandName;

  const FetchCarsByBrand(this.brandName);

  @override
  List<Object?> get props => [brandName];
}
