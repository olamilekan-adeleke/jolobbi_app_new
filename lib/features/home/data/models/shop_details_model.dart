import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/shop_details_entity.dart';

class ShopDetailsModel extends ShopDetailsEntity {
  const ShopDetailsModel({
    required super.type,
    required super.contact,
    required super.id,
    required super.ownerId,
    required super.imageUrl,
    required super.name,
    required super.address,
    required super.openingHours,
    required super.geoHash,
    required super.coordinate,
    required super.numberOfLikes,
    required super.numberOfReviews,
    required super.isAvailable,
  });

  factory ShopDetailsModel.fromMap(Map<String, dynamic> map) {
    final Map<String, dynamic> coordinateAsMap = {
      "latitude": map['geopoint'].latitude as double,
      "longitude": map['geopoint'].longitude as double,
    };

    return ShopDetailsModel(
      type: map['type'] as String,
      contact: ShopContactModel.fromMap(map['contact'] as Map<String, dynamic>),
      id: map['id'] as String,
      ownerId: map['ownerId'] as String,
      imageUrl: map['imageUrl'] as String,
      name: map['name'] as String,
      address: map['address'] as String,
      numberOfLikes: map['numberOfLikes'] as int,
      numberOfReviews: (map['numberOfReviews'] ?? 0) as int,
      openingHours: List<OpeningHoursModel>.from(
        (map['openingHours'] as List<dynamic>).map<OpeningHoursModel>(
          (x) => OpeningHoursModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      isAvailable: map['isAvailable'] as bool,
      geoHash: map['geohash'] as String,
      coordinate: ShopCoordinateModel.fromMap(coordinateAsMap),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type,
      'contact': (contact as ShopContactModel).toMap(),
      'id': id,
      'ownerId': ownerId,
      'imageUrl': imageUrl,
      'name': name,
      'address': address,
      'openingHours':
          openingHours.map((x) => (x as OpeningHoursModel).toMap()).toList(),
      'geohash': geoHash,
      'geopoint': GeoPoint(coordinate.latitude, coordinate.longitude),
      'numberOfLikes': numberOfLikes,
      'isAvailable': isAvailable,
    };
  }

  @override
  String toString() {
    return 'ShopDetailsModel(type: $type, contact: $contact, id: $id, ownerId: $ownerId, imageUrl: $imageUrl, name: $name, address: $address, openingHours: $openingHours, geoHash: $geoHash, coordinate: $coordinate, numberOfLikes: $numberOfLikes, isAvailable: $isAvailable)';
  }
}

class OpeningHoursModel extends OpeningHoursEntity {
  const OpeningHoursModel({
    required super.day,
    required super.openTime,
    required super.closeTime,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'day': day,
      'openTime': openTime,
      'closeTime': closeTime,
    };
  }

  factory OpeningHoursModel.fromMap(Map<String, dynamic> map) {
    return OpeningHoursModel(
      day: map['day'] as String,
      openTime: map['openTime'] as String,
      closeTime: map['closeTime'] as String,
    );
  }

  @override
  String toString() {
    return 'OpeningHoursModel(day: $day, openTime: $openTime, closeTime: $closeTime)';
  }
}

class ShopContactModel extends ShopContactEntity {
  const ShopContactModel({required super.email, required super.phoneNumber});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'phoneNumber': phoneNumber,
    };
  }

  factory ShopContactModel.fromMap(Map<String, dynamic> map) {
    return ShopContactModel(
      email: map['email'] as String,
      phoneNumber: map['phoneNumber'] as String,
    );
  }

  @override
  String toString() {
    return 'ShopContactModel(email: $email, phoneNumber: $phoneNumber)';
  }
}

class ShopCoordinateModel extends ShopCoordinateEntity {
  const ShopCoordinateModel({
    required super.latitude,
    required super.longitude,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory ShopCoordinateModel.fromMap(Map<String, dynamic> map) {
    return ShopCoordinateModel(
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
    );
  }

  Map<String, dynamic> toGeoPoint() {
    return <String, dynamic>{'geopoint': GeoPoint(latitude, longitude)};
  }

  @override
  String toString() {
    return 'ShopCoordinateModel(latitude: $latitude, longitude: $longitude)';
  }
}
