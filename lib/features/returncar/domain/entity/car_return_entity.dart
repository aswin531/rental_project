class CarReturnEntity {
  final String returnId;
  final String carId;
  final String userId;
  final DateTime returnDate;
  final bool isDamaged;
  final double fuelLevel;
  final int mileage;
  final String? comments;
  final double lateFee;
  final double totalCost;

  CarReturnEntity(
      this.returnId,
      this.carId,
      this.userId,
      this.returnDate,
      this.isDamaged,
      this.fuelLevel,
      this.mileage,
      this.comments,
      this.lateFee,
      this.totalCost);

  double calculateTotalCost(
      double baseRentalCost, double damageFee, double lateFee) {
    return baseRentalCost + damageFee + lateFee;
  }
}
