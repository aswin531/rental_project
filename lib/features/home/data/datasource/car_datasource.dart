import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rentit/features/home/data/model/brand_model.dart';
import 'package:rentit/features/home/data/model/carvehicle_model.dart';

abstract class CarRemoteDataSource {
  Stream<List<CarVehicleModel>> getCars();
  Future<List<BrandModel>> getBrands();
  Stream<List<CarVehicleModel>> getCarBySearch({
    String? searchTerm,
    String? make,
    String? model,
    //PriceRange? priceRange,
    int? year,
  });
}

class CarRemoteDataSourceImpl implements CarRemoteDataSource {
  final FirebaseFirestore _firebaseFirestore;

  CarRemoteDataSourceImpl(this._firebaseFirestore);

  @override
  Stream<List<CarVehicleModel>> getCars()  {
  return _firebaseFirestore.collection('cars').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => CarVehicleModel.fromFirestoreDcument(doc.data(), doc.id))
          .toList();
    });
  }

  @override
  Future<List<BrandModel>> getBrands() async {
    final snapshot = await _firebaseFirestore.collection('brands').get();
    return snapshot.docs
        .map((doc) => BrandModel.fromFirestoreDocument(doc.data(), doc.id))
        .toList();
  }


  @override
  Stream<List<CarVehicleModel>> getCarBySearch({
    String? searchTerm,
    String? make,
    String? model,
   // PriceRange? priceRange,
    int? year,
  }) {
    try {
      CollectionReference carsCollection = _firebaseFirestore.collection('cars');
      Query query = carsCollection;

      if (searchTerm != null && searchTerm.isNotEmpty) {
        query = query.where('searchKeywords', arrayContains: searchTerm.toLowerCase());
      }

      if (make != null && make.isNotEmpty) {
        query = query.where('make', isEqualTo: make);
      }

      if (model != null && model.isNotEmpty) {
        query = query.where('model', isEqualTo: model);
      }

      // if (priceRange != null) {
      //   query = query
      //       .where('rentalPrice', isGreaterThanOrEqualTo: priceRange.min)
      //       .where('rentalPrice', isLessThanOrEqualTo: priceRange.max);
      // }

      if (year != null) {
        query = query.where('year', isEqualTo: year);
      }

      return query.snapshots().map((snapshot) {
        return snapshot.docs.map((doc) {
          return CarVehicleModel.fromFirestoreDcument(doc.data() as Map<String, dynamic>, doc.id);
        }).toList();
      });
    } catch (e) {
      // Handle exceptions appropriately
      throw Exception('Failed to load cars: $e');
    }
  }
}
