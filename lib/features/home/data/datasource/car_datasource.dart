import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rentit/features/home/data/model/brand_model.dart';
import 'package:rentit/features/home/data/model/carvehicle_model.dart';

abstract class CarRemoteDataSource {
  Stream<List<CarVehicleModel>> getCars();
  Future<List<BrandModel>> getBrands();
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
}
