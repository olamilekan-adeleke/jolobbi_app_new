import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../app/locator.dart';
import '../../../../../cores/components/components.dart';
import '../../../../../cores/navigator/navigator.dart';
import '../../../../../cores/utils/utils.dart';
import '../../../data/models/address_model.dart';
import '../../bloc/add_address/add_address_bloc.dart';
import '../../bloc/get_address_bloc/get_address_bloc_bloc.dart';
import '../../cubit/add_address_cubit.dart';
import '../../formz/add_address_formz.dart';

class AddAddressView extends StatelessWidget {
  static const String route = '/AddAddressView';

  const AddAddressView({super.key});

  static final AddAddressCubit addAddressCubit =
      SetUpLocators.getIt<AddAddressCubit>();
  static final AddAddressBloc addAddressBloc =
      SetUpLocators.getIt<AddAddressBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddAddressBloc, AddAddressState>(
      bloc: addAddressBloc,
      listener: listener,
      child: ScaffoldWidget(
        useSingleScroll: false,
        body: Column(
          children: <Widget>[
            const AppBarWidget("Add Address", useSpacer: true),
            verticalSpace(20),
            DropDownWidget(
              title: "Region",
              hintText: "Select Region",
              items: const ["Malete"],
              onTap: addAddressCubit.regionChanged,
            ),
            verticalSpace(15),
            TextFieldWidget(
              title: "Address",
              hintText: "Enter Address",
              onChanged: addAddressCubit.addressChanged,
            ),
            verticalSpace(15),
            TextFieldWidget(
              title: "Address Description",
              hintText: "Enter Address Description",
              onChanged: addAddressCubit.addressDescriptionChanged,
            ),
            verticalSpace(15),
            const Spacer(),
            BlocBuilder<AddAddressBloc, AddAddressState>(
              bloc: addAddressBloc,
              builder: (context, state) {
                if (state is AddAddressLoading) return const Button.loading();

                return buttonWIdget();
              },
            ),
            verticalSpace(15),
          ],
        ),
      ),
    );
  }

  BlocBuilder<AddAddressCubit, AddAddressFormz> buttonWIdget() {
    return BlocBuilder<AddAddressCubit, AddAddressFormz>(
      bloc: addAddressCubit,
      builder: (context, state) {
        return Button(
          active: state.isValid,
          text: "Save",
          onTap: () {
            addAddressBloc.add(
              AddAddressEvent(
                AddressModel(
                  region: addAddressCubit.state.region.value,
                  address: addAddressCubit.state.address.value,
                  addressDescription:
                      addAddressCubit.state.addressDescription.value,
                ),
              ),
            );
          },
        );
      },
    );
  }
}

extension on AddAddressView {
  void listener(BuildContext context, AddAddressState state) {
    final GetAddressBlocBloc getAddressBlocBloc =
        SetUpLocators.getIt<GetAddressBlocBloc>();

    if (state is AddAddressSuccess) {
      getAddressBlocBloc.add(const GetAddressBlocEvent());
      AppRouter.instance.goBack();
    } else if (state is AddAddressError) {
      SnackBarService.showErrorSnackBar(
        context: context,
        message: state.message,
      );
    }
  }
}
