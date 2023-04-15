import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/locator.dart';
import '../../../../cores/components/components.dart';
import '../../../../cores/utils/utils.dart';
import '../bloc/get_profile/get_profile_bloc_bloc.dart';
import '../widgets/profile_info_details_widget.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  static final GetProfileBloc _getProfileBloc =
      SetUpLocators.getIt<GetProfileBloc>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getProfileBloc.add(const GetProfileEvent());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      useSingleScroll: false,
      body: RefreshIndicator(
        onRefresh: () async => _getProfileBloc.add(const GetProfileEvent()),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              verticalSpace(20),
              const AppBarWidget("Profile", showBackButton: false),
              verticalSpace(20),
              BlocBuilder<GetProfileBloc, GetProfileState>(
                bloc: _getProfileBloc,
                builder: (context, state) {
                  if (state is GetProfileLoading) {
                    return SizedBox(
                      height: h(300),
                      child: const Center(
                        child: CustomCircularProgressIndicator(),
                      ),
                    );
                  } else if (state is GetProfileSuccess) {
                    return ProfileInfoDetailsWidget(state.userDetailsEntity);
                  } else if (state is GetProfileError) {
                    return SizedBox(
                      height: h(300),
                      child: CustomErrorWidget(
                        message: state.message,
                        showButton: true,
                        onRetry: () => _getProfileBloc.add(
                          const GetProfileEvent(),
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
