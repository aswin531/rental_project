// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:rentit/features/returncar/data/model/car_return_model.dart';

// abstract class ReturnCarDatasource {
//   Future<void> carReturnInitiate(String returnId);
//   Future<void> carReturnConfirm(String returnId, CarReturnModel carReturnModel);
// }

// class ReturnCarDataSourceImpl implements ReturnCarDatasource {
//   final FirebaseFirestore firebaseFirestore;

//   ReturnCarDataSourceImpl(this.firebaseFirestore);


//   @override
//   Future<void> carReturnInitiate(String returnId) async{
//     await firebaseFirestore.collection("rental_requests").doc().update(data)
//   }

//     @override
//   Future<void> carReturnConfirm(
//       String returnId, CarReturnModel carReturnModel) {
        
//   }
// }
