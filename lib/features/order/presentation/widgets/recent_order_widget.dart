import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/locator.dart';
import '../../../../cores/components/components.dart';
import '../../../../cores/utils/utils.dart';
import '../../domain/entities/order_entity.dart';
import '../bloc/get_all_orders/get_all_orders_bloc.dart';
import 'order_item_widget.dart';

class RecentOrdersWidget extends StatefulWidget {
  const RecentOrdersWidget({super.key});

  @override
  State<RecentOrdersWidget> createState() => _RecentOrdersWidgetState();
}

class _RecentOrdersWidgetState extends State<RecentOrdersWidget> {
  final GetAllOrdersBloc _bloc = SetUpLocators.getIt<GetAllOrdersBloc>();

  @override
  void initState() {
    _bloc.add(const GetAllOrdersEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _headerWidget(),
        verticalSpace(15),
        BlocBuilder<GetAllOrdersBloc, GetAllOrdersState>(
          bloc: _bloc,
          builder: (context, state) {
            if (state is GetAllOrdersLoading) {
              return const Center(child: LoadingIndicatorWidget());
            } else if (state is GetAllOrdersError) {
              return SizedBox(
                height: sh(20),
                child: CustomErrorWidget(
                  useFlex: false,
                  message: state.message,
                  onRetry: () => _bloc.add(const GetAllOrdersEvent()),
                ),
              );
            }
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 2,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: ListView.separated(
                separatorBuilder: (context, index) => const Divider(),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _bloc.orders.length,
                itemBuilder: (context, index) {
                  final OrderEntity order = _bloc.orders[index];
                  return OrderItemWidget(order);
                },
              ),
            );
          },
        ),
        verticalSpace(25),
      ],
    );
  }

  Row _headerWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        TextWidget(
          "Recent Orders",
          fontSize: sp(20),
          textColor: Colors.grey.shade800,
          fontWeight: FontWeight.w500,
        ),
        // TextWidget(
        //   "View All",
        //   fontSize: sp(14),
        //   textColor: kcPrimaryColor,
        //   decoration: TextDecoration.underline,
        // ),
      ],
    );
  }
}
