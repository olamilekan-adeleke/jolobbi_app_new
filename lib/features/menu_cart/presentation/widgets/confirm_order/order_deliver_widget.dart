import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../app/locator.dart';
import '../../../../../cores/components/components.dart';
import '../../../../../cores/constants/constants.dart';
import '../../../../../cores/navigator/navigator.dart';
import '../../../../../cores/utils/utils.dart';
import '../../../../profile/domain/entities/address_entity.dart';
import '../../../../profile/presentation/bloc/get_address_bloc/get_address_bloc_bloc.dart';
import '../../../../profile/presentation/pages/address/user_address_view.dart';

class OrderDeliverWidget extends StatefulWidget {
  const OrderDeliverWidget({super.key});

  @override
  State<OrderDeliverWidget> createState() => _OrderDeliverWidgetState();
}

class _OrderDeliverWidgetState extends State<OrderDeliverWidget> {
  final GetAddressBlocBloc getAddressBlocBloc =
      SetUpLocators.getIt<GetAddressBlocBloc>();

  List<AddressEntity> addresses = [];
  String addressTitle = "No Address, Tap to Add Address";

  @override
  void initState() {
    getAddressBlocBloc.add(const GetAddressBlocEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetAddressBlocBloc, GetAddressBlocState>(
      bloc: getAddressBlocBloc,
      listener: (context, state) {
        if (state is GetAddressBlocLoading) {
          addressTitle = "Loading...";
        } else if (state is GetAddressBlocSuccess) {
          addresses = state.addresses;
          addressTitle = addresses.first.address;

          // setState(() {});
        }
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(
                  "Delivery Address",
                  fontSize: sp(18),
                  fontWeight: FontWeight.w500,
                ),
                GestureDetector(
                  onTap: () => AppRouter.instance.navigateTo(
                    UserAddressView.route,
                  ),
                  child: TextWidget(
                    addresses.isNotEmpty ? "Change" : "Tap To Add Address",
                    fontSize: sp(14),
                    textColor: kcSoftTextColor.withOpacity(0.5),
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
            verticalSpace(5),
            GestureDetector(
              onTap: () async {
                if (addresses.isEmpty) {
                  AppRouter.instance.navigateTo(UserAddressView.route);
                } else {
                  AddressEntity? address = await BottomSheetHelper.show(
                    context,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        verticalSpace(20),
                        BuildListView(addresses: addresses, showIcon: false),
                        verticalSpace(20),
                      ],
                    ),
                  );

                  if (address != null) addressTitle = address.fullAddress;
                }
              },
              child: AbsorbPointer(
                child: TextFieldWidget(
                  hintText: "Select your delivery address",
                  maxLine: null,
                  textEditingController:
                      TextEditingController(text: addressTitle),
                  // suffix: Icons.arrow_forward_ios_outlined,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
