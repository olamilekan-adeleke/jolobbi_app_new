import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/locator.dart';
import '../../../../cores/components/components.dart';
import '../../../../cores/navigator/navigator.dart';
import '../../../../cores/utils/utils.dart';
import '../bloc/get_all_restaurant/get_all_restaurant_bloc.dart';
import '../widgets/all_restaurant/all_restaurant_list_view_widget.dart';
import 'search_restaurant_view.dart';

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
