abstract class LocationEvent {}

class GetCurrentLocationEvent extends LocationEvent {}

class SearchLocationEvent extends LocationEvent {
  final String query;

  SearchLocationEvent({required this.query});
}
