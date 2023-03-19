import 'package:equatable/equatable.dart';

class ShopDetailsEntity extends Equatable {
  final String type;
  final ShopContactEntity contact;
  final String id;
  final String ownerId;
  final String imageUrl;
  final String name;
  final String address;
  final int numberOfLikes;
  final int numberOfReviews;
  final List<OpeningHoursEntity> openingHours;
  final bool isAvailable;
  final String geoHash;
  final ShopCoordinateEntity coordinate;

  const ShopDetailsEntity({
    required this.type,
    required this.contact,
    required this.id,
    required this.ownerId,
    required this.imageUrl,
    required this.name,
    required this.address,
    required this.openingHours,
    required this.geoHash,
    required this.coordinate,
    required this.numberOfLikes,
    required this.numberOfReviews,
    required this.isAvailable,
  });

  @override
  List<Object?> get props => [
        type,
        contact,
        id,
        ownerId,
        imageUrl,
        name,
        address,
        openingHours,
        geoHash,
        coordinate,
        numberOfLikes,
        numberOfReviews,
        isAvailable,
      ];
}

class OpeningHoursEntity extends Equatable {
  final String day;
  final String openTime;
  final String closeTime;

  const OpeningHoursEntity({
    required this.day,
    required this.openTime,
    required this.closeTime,
  });

  @override
  List<Object?> get props => [day, openTime, closeTime];
}

class ShopContactEntity extends Equatable {
  final String email;
  final String phoneNumber;

  const ShopContactEntity({required this.email, required this.phoneNumber});

  @override
  List<Object?> get props => [email, phoneNumber];
}

class ShopCoordinateEntity extends Equatable {
  final double latitude;
  final double longitude;

  const ShopCoordinateEntity({required this.latitude, required this.longitude});

  @override
  List<Object?> get props => [latitude, longitude];
}
