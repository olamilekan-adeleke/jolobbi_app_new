import 'package:equatable/equatable.dart';

class AddressEntity extends Equatable {
  final String region;
  final String address;
  final String addressDescription;

  const AddressEntity({
    required this.region,
    required this.address,
    required this.addressDescription,
  });

  String get fullAddress => "$region, $address, $addressDescription";

  Map<String, dynamic> toMap() {
    return {
      'region': region,
      'address': address,
      'addressDescription': addressDescription,
    };
  }

  @override
  List<Object?> get props => [region, address, addressDescription];
}
