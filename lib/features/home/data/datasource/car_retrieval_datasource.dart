import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rentit/features/home/data/model/car_model.dart';

class CarRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;
  CarRemoteDataSource({required this.firebaseFirestore});

  Future<List<CarVehicleModel>> getCars() async {
    QuerySnapshot snapshot = await firebaseFirestore.collection('cars').get();
    return snapshot.docs
        .map((doc) =>
            CarVehicleModel.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }
}
