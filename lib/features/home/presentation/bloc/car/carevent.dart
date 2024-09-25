import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class CarEvent extends Equatable {
  const CarEvent();
  @override
  List<Object> get props => [];
}

class FetchCars extends CarEvent {}

class RefreshCars extends CarEvent {}

class SearchCars extends CarEvent {
  final String searchTerm;
  const SearchCars({required this.searchTerm});
}

class FilterCars extends CarEvent {
  final String? make;
  final String? model;
  final RangeValues? priceRange;
  final int? year;

  const FilterCars({this.make, this.model, this.priceRange, this.year});
}