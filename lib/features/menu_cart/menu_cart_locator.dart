import '../../app/locator.dart';
import 'presentation/cubit/cart_items_cubit.dart';

void getUpMenuCartLocator() {
  /// cubit
  SetUpLocators.getIt.registerLazySingleton<CartItemCubit>(
    () => CartItemCubit(),
  );
}
