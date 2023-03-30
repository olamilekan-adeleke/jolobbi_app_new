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

  @override
  List<Object?> get props => [region, address, addressDescription];
  
}
