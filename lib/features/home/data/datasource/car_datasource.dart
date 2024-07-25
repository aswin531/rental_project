import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rentit/features/home/data/model/carvehicle_model.dart';

abstract class CarRemoteDataSource {
  Future<List<CarVehicleModel>> getCars();
}

class CarRemoteDataSourceImpl implements CarRemoteDataSource {
  final FirebaseFirestore _firebaseFirestore;

  CarRemoteDataSourceImpl(this._firebaseFirestore);

  @override
  Future<List<CarVehicleModel>> getCars() async {
    final snapshot = await _firebaseFirestore.collection('cars').get();
    return snapshot.docs.map((doc) => CarVehicleModel.fromFirestoreDcument(doc.data(), doc.id)).toList();
  }
}