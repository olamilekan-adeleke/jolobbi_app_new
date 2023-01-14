import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/locator.dart';
import '../../../../cores/components/components.dart';
import '../../../../cores/constants/constants.dart';
import '../../../../cores/utils/utils.dart';
import '../bloc/login/login_bloc.dart';
import '../widgets/login_widgets/login_form_widget.dart';

class LoginView extends StatelessWidget {
  static const String route = "/login";

  const LoginView({super.key});

  static final LoginBloc _bloc = SetUpLocators.getIt<LoginBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      bloc: _bloc,
      listener: listener,
      child: ScaffoldWidget(
        usePadding: false,
        useSingleScroll: false,
        body: Stack(
          children: <Widget>[
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
                child: const LoginFormWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void listener(context, state) {
    if (state is LoginError) {
      SnackBarService.showErrorSnackBar(
        context: context,
        message: state.message,
      );
    } else if (state is LoginSuccess) {
      SnackBarService.showSuccessSnackBar(
        context: context,
        message: 'Login success',
      );
    }
  }
}
