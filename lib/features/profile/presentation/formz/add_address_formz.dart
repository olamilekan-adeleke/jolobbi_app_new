import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../../../cores/utils/formz_validator/required_formz_validator.dart';

class AddAddressFormz extends Equatable with FormzMixin {
  final Required region;
  final Required address;
  final Required addressDescription;

  const AddAddressFormz({
    this.region = const Required.pure(),
    this.address = const Required.pure(),
    this.addressDescription = const Required.pure(),
  });

  bool get isValid => status == FormzStatus.valid;

  AddAddressFormz copyWith({
    Required? region,
    Required? address,
    Required? addressDescription,
  }) {
    return AddAddressFormz(
      region: region ?? this.region,
      address: address ?? this.address,
      addressDescription: addressDescription ?? this.addressDescription,
    );
  }

  @override
  List<FormzInput> get inputs => [region, address, addressDescription];

  @override
  List<Object?> get props => [region, address, addressDescription];
}
