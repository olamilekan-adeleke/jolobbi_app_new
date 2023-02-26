import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/locator.dart';
import '../../../../cores/components/custom_scaffold_widget.dart';
import '../../../../cores/constants/color.dart';
import '../../../../cores/navigator/navigator.dart';
import '../../../../cores/utils/utils.dart';
import '../bloc/forgot_password/forgot_password_bloc.dart';
import '../widgets/forgot_password_widget/forgot_password_form_widget.dart';

class ForgotPasswordView extends StatelessWidget {
  static const String route = '/forgot-password';

  const ForgotPasswordView({Key? key}) : super(key: key);

  static final ForgotPasswordBloc _bloc =
      SetUpLocators.getIt<ForgotPasswordBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
      bloc: _bloc,
      listener: blocListener,
      child: ScaffoldWidget(
        useSingleScroll: false,
        usePadding: false,
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(color: kcPrimaryColor),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: kcWhite,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(sp(10)),
                    topRight: Radius.circular(sp(10)),
                  ),
                ),
                child: const ForgotFormWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

extension on ForgotPasswordView {
  void blocListener(context, state) {
    if (state is ForgotPasswordError) {
      SnackBarService.showErrorSnackBar(
        context: context,
        message: state.message,
      );
    } else if (state is ForgotPasswordSuccess) {
      AppRouter.instance.goBack();

      SnackBarService.showSuccessSnackBar(
        context: context,
        message: 'Forgot Password Link Sent Successfully, '
            'Please Check Your Email',
      );
    }
  }
}
