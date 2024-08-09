import 'package:equatable/equatable.dart';

abstract class BrandsState extends Equatable {
  const BrandsState();
  @override
  List<Object> get props => [];
}

class BrandsInitial extends BrandsState {}

class BrandsLoading extends BrandsState {}

class BrandsLoaded extends BrandsState {
  final List<String> brands;
  const BrandsLoaded(this.brands);
  @override
  List<Object> get props => [brands];
}

class BrandsError extends BrandsState {
  final String message;
  const BrandsError(this.message);
  @override
  List<Object> get props => [message];
}
