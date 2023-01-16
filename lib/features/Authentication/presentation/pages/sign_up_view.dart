import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/locator.dart';
import '../../../../cores/components/custom_scaffold_widget.dart';
import '../../../../cores/constants/color.dart';
import '../../../../cores/utils/utils.dart';
import '../bloc/authentication_bloc.dart';
import '../bloc/sign_up/sign_up_bloc.dart';
import '../widgets/sign_up_widgets/sign_up_form_widget.dart';

class SignUpView extends StatelessWidget {
  static const String route = "/sign_up";

  const SignUpView({super.key});

  static final SignUpBloc _signUpBloc = SetUpLocators.getIt<SignUpBloc>();
  static final AuthenticationBloc _authBloc =
      SetUpLocators.getIt<AuthenticationBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      bloc: _signUpBloc,
      listener: listener,
      child: ScaffoldWidget(
        usePadding: false,
        useSingleScroll: false,
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
                child: const SignUpFormWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void listener(context, state) {
    if (state is SignUpError) {
      SnackBarService.showErrorSnackBar(
        context: context,
        message: state.message,
      );
    } else if (state is SignUpSuccess) {
      _authBloc.add(const ChangeAuthStateEvent(true));

      SnackBarService.showSuccessSnackBar(
        context: context,
        message: 'Account Created Successfully!',
      );
    }
  }
}
