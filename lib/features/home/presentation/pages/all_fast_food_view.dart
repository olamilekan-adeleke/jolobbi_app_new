import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jolobbi_app_new/app/locator.dart';
import 'package:jolobbi_app_new/cores/components/components.dart';
import 'package:jolobbi_app_new/cores/navigator/navigator.dart';
import 'package:jolobbi_app_new/cores/utils/utils.dart';
import 'package:jolobbi_app_new/features/home/presentation/pages/search_restaurant_view.dart';

import 'package:jolobbi_app_new/features/home/presentation/widgets/all_restaurant/all_restaurant_list_view_widget.dart';

import '../bloc/get_all_restaurant/get_all_restaurant_bloc.dart';

class AllFastFoodView extends StatelessWidget {
  static const String route = "/all_fast_food";

  const AllFastFoodView({super.key});

  static final GetAllRestaurantBloc _getAllRestaurantBloc =
      SetUpLocators.getIt<GetAllRestaurantBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<GetAllRestaurantBloc, GetAllRestaurantState>(
      bloc: _getAllRestaurantBloc,
      listener: (context, state) {
        if (state is GetAllRestaurantErrorMore) {
          SnackBarService.showErrorSnackBar(
            context: context,
            message: state.message,
          );
        }
      },
      child: ScaffoldWidget(
        useSingleScroll: false,
        body: Column(
          children: <Widget>[
            AppBarWidget(
              "All Restaurant",
              useSpacer: true,
              trilling: GestureDetector(
                onTap: () => AppRouter.instance.navigateTo(
                  SearchRestaurantView.route,
                ),
                child: const Icon(CupertinoIcons.search),
              ),
            ),
            verticalSpace(),
            const Flexible(child: AllRestaurantListView()),
            BlocBuilder<GetAllRestaurantBloc, GetAllRestaurantState>(
              bloc: _getAllRestaurantBloc,
              builder: (context, state) {
                if (state is GetAllRestaurantLoadingMore) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: h(10)),
                    child: const Center(child: LoadingIndicatorWidget()),
                  );
                }

                return Container();
              },
            )
          ],
        ),
      ),
    );
  }
}
