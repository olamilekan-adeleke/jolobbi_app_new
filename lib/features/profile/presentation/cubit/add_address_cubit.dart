import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cores/utils/formz_validator/required_formz_validator.dart';
import '../formz/add_address_formz.dart';

class AddAddressCubit extends Cubit<AddAddressFormz> {
  AddAddressCubit() : super(const AddAddressFormz());

  void reset() => emit(const AddAddressFormz());

  void regionChanged(String value) {
    emit(state.copyWith(region: Required.dirty(value)));
  }

  void addressChanged(String value) {
    emit(state.copyWith(address: Required.dirty(value)));
  }

  void addressDescriptionChanged(String value) {
    emit(state.copyWith(addressDescription: Required.dirty(value)));
  }
}
