part of 'add_address_bloc.dart';

class AddAddressEvent extends Equatable {
  final AddressModel address;
  const AddAddressEvent(this.address);

  @override
  List<Object> get props => [address];
}
