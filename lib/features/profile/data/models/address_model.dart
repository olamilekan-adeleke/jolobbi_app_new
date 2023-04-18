import '../../domain/entities/address_entity.dart';

class AddressModel extends AddressEntity {
  const AddressModel({
    required super.region,
    required super.address,
    required super.addressDescription,
  });

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      region: map['region'] as String,
      address: map['address'] as String,
      addressDescription: map['addressDescription'] as String,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'region': region,
      'address': address,
      'addressDescription': addressDescription,
    };
  }
}
