import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jolobbi_app_new/app/locator.dart';
import 'package:jolobbi_app_new/cores/components/components.dart';
import 'package:jolobbi_app_new/cores/utils/utils.dart';
import 'package:jolobbi_app_new/features/home/domain/entities/shop_details_entity.dart';
import 'package:jolobbi_app_new/features/home/presentation/bloc/get_all_restaurant/get_all_restaurant_bloc.dart';
import 'package:jolobbi_app_new/features/home/presentation/widgets/home_fast_food_list_widget.dart';

class AllRestaurantListView extends StatefulWidget {
  const AllRestaurantListView({super.key});

  @override
  State<AllRestaurantListView> createState() => _AllRestaurantListViewState();
}

class _AllRestaurantListViewState extends State<AllRestaurantListView> {
  late final ScrollController _scrollController = ScrollController();
  final GetAllRestaurantBloc _getAllRestaurantBloc =
      SetUpLocators.getIt<GetAllRestaurantBloc>();

  @override
  void initState() {
    _getAllRestaurantBloc.add(const GetAllRestaurantEvent());

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        LoggerHelper.log(_scrollController.position.pixels.toString());
        _getAllRestaurantBloc.add(const GetAllRestaurantEvent(false));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetAllRestaurantBloc, GetAllRestaurantState>(
      bloc: _getAllRestaurantBloc,
      builder: (context, state) {
        if (state is GetAllRestaurantLoading) {
          return const Center(child: LoadingIndicatorWidget());
        } else if (state is GetAllRestaurantError) {
          return CustomErrorWidget(
            message: state.message,
            onRetry: () => _getAllRestaurantBloc.add(
              const GetAllRestaurantEvent(),
            ),
          );
        } else {
          return ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: _scrollController,
            itemCount: _getAllRestaurantBloc.shops.length,
            itemBuilder: (context, index) {
              final ShopDetailsEntity restaurant =
                  _getAllRestaurantBloc.shops[index];

              return BuildFastFoodItem(shop: restaurant);
            },
          );
        }
      },
    );
  }
}
