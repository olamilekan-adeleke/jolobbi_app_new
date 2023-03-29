import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../app/locator.dart';
import '../../../../../cores/components/box_shadow.dart';
import '../../../../../cores/components/components.dart';
import '../../../../../cores/constants/constants.dart';
import '../../../../../cores/navigator/navigator.dart';
import '../../../../../cores/utils/sizer_utils.dart';
import '../../../domain/entities/address_entity.dart';
import '../../bloc/get_address_bloc/get_address_bloc_bloc.dart';
import 'add_address_view.dart';

class UserAddressView extends StatefulWidget {
  static const String route = '/userAddressView';

  const UserAddressView({super.key});

  @override
  State<UserAddressView> createState() => _UserAddressViewState();
}

class _UserAddressViewState extends State<UserAddressView> {
  final GetAddressBlocBloc getAddressBlocBloc =
      SetUpLocators.getIt<GetAddressBlocBloc>();

  @override
  void initState() {
    getAddressBlocBloc.add(const GetAddressBlocEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      useSingleScroll: false,
      body: Column(
        children: <Widget>[
          const AppBarWidget("User Address", useSpacer: true),
          verticalSpace(),
          BlocBuilder<GetAddressBlocBloc, GetAddressBlocState>(
            bloc: getAddressBlocBloc,
            builder: (context, state) {
              if (state is GetAddressBlocLoading) {
                return const Center(child: LoadingIndicatorWidget());
              } else if (state is GetAddressBlocError) {
                return CustomErrorWidget(
                  message: state.message,
                  onRetry: () => getAddressBlocBloc.add(
                    const GetAddressBlocEvent(),
                  ),
                );
              } else if (state is GetAddressBlocSuccess) {
                return buildListView(state.addresses);
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => AppRouter.instance.navigateTo(AddAddressView.route),
        backgroundColor: kcPrimaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }

  ListView buildListView(List<AddressEntity> addresses) {
    return ListView.separated(
      separatorBuilder: (_, __) => verticalSpace(),
      itemCount: addresses.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final AddressEntity address = addresses[index];

        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: sp(20),
            vertical: sp(10),
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: boxShadowHelper,
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: sp(15),
                          color: kcSoftTextColor.withOpacity(0.5),
                        ),
                        horizontalSpace(5),
                        TextWidget(
                          address.region,
                          fontWeight: FontWeight.w500,
                          fontSize: sp(16),
                        ),
                      ],
                    ),
                    verticalSpace(5),
                    TextWidget(
                      "${address.address}, ${address.addressDescription}",
                      textColor: kcSoftTextColor.withOpacity(0.8),
                      fontSize: sp(14),
                      fontWeight: FontWeight.w300,
                    ),
                  ],
                ),
              ),
              verticalSpace(),
              Icon(
                CupertinoIcons.delete,
                size: sp(20),
                color: kcSoftTextColor.withOpacity(0.5),
              ),
            ],
          ),
        );
      },
    );
  }
}
