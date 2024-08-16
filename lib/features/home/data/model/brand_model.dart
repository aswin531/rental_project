import 'package:flutter/foundation.dart';
import 'package:rentit/features/home/domain/entity/brand_entity.dart';

class BrandModel {
  final String? id;
  String logoUrl;
  String brandName;

  BrandModel( {required this.brandName, required this.logoUrl,this.id,});

  factory BrandModel.fromFirestoreDocument(
      Map<String, dynamic> map, String id) {
   // debugPrint('===BRANDLOGO ==Document Data: $map, $id  ===End==');
    return BrandModel(brandName: map['name'] ?? 'Brand Name', logoUrl: map['logoUrl'] ?? 'BrandLogo URL');
  }

    BrandEntity toEntity() {
    return BrandEntity(
      id: id ?? 'ID',
      brandName: brandName,
      logoUrl: logoUrl,
    );
  }

}
