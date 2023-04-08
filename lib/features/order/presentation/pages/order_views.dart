import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/locator.dart';
import '../../../../cores/components/components.dart';
import '../../../../cores/utils/utils.dart';
import '../../domain/entities/order_entity.dart';
import '../bloc/get_all_orders/get_all_orders_bloc.dart';
import '../widgets/order_item_widget.dart';

class OrderView extends StatefulWidget {
  static const String routeName = '/order';

  const OrderView({super.key});

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  final GetAllOrdersBloc _bloc = SetUpLocators.getIt<GetAllOrdersBloc>();
  late final ScrollController _scrollController;

  @override
  void initState() {
    _bloc.add(const GetAllOrdersEvent());
    _scrollController = ScrollController();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _bloc.add(const GetAllOrdersEvent(false));
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => _bloc.add(const GetAllOrdersEvent()),
      child: ScaffoldWidget(
        controller: _scrollController,
        scrollPhysics: const AlwaysScrollableScrollPhysics(),
        body: Column(
          children: <Widget>[
            verticalSpace(20),
            const AppBarWidget("Orders"),
            verticalSpace(),
            BlocBuilder<GetAllOrdersBloc, GetAllOrdersState>(
              bloc: _bloc,
              builder: (context, state) {
                if (state is GetAllOrdersLoading) {
                  return const Center(child: LoadingIndicatorWidget());
                } else if (state is GetAllOrdersError) {
                  return SizedBox(
                    height: sh(40),
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
                    borderRadius: BorderRadius.circular(sr(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 2,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListView.separated(
                        separatorBuilder: (context, index) => const Divider(),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _bloc.orders.length,
                        itemBuilder: (context, index) {
                          final OrderEntity order = _bloc.orders[index];
                          return OrderItemWidget(order);
                        },
                      ),
                      BlocBuilder<GetAllOrdersBloc, GetAllOrdersState>(
                        bloc: _bloc,
                        builder: (context, state) {
                          if (state is GetAllOrdersLoadingMore) {
                            return Container(
                              padding: EdgeInsets.symmetric(horizontal: sp(10)),
                              child: const LoadingIndicatorWidget(),
                            );
                          }
                          return Container();
                        },
                      )
                    ],
                  ),
                );
              },
            ),
            verticalSpace(25),
          ],
        ),
      ),
    );
  }
}
