import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/locator.dart';
import '../../../home/presentation/pages/home_view.dart';
import '../bloc/authentication_bloc.dart';
import 'pages.dart';

class AuthStateView extends StatelessWidget {
  static const String route = "/";

  const AuthStateView({super.key});

  static final AuthenticationBloc _authBloc =
      SetUpLocators.getIt<AuthenticationBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      bloc: _authBloc,
      builder: (context, state) {
        if (state is AuthenticatedState) {
          return const HomeView();
        }
        return const IntroScreen();
      },
    );
  }
}
