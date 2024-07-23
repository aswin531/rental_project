import 'package:equatable/equatable.dart';

abstract class BrandState extends Equatable {
  const BrandState();

  @override
  List<Object> get props => [];
}

class BrandInitial extends BrandState {}

class BrandLoading extends BrandState {}

class BrandLoaded extends BrandState {
  final List<String> brands;
  const BrandLoaded(this.brands);

  @override
  List<Object> get props => [brands];
}

class BrandError extends BrandState {
  final String message;
  const BrandError(this.message);

  @override
  List<Object> get props => [message];
}
