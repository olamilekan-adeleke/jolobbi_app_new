import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../app/locator.dart';
import '../../../../../cores/components/components.dart';
import '../../../../../cores/navigator/app_router.dart';
import '../../../../../cores/utils/formatter/money_formatter.dart';
import '../../../../../cores/utils/utils.dart';
import '../../../../profile/presentation/bloc/get_profile/get_profile_bloc_bloc.dart';
import '../../bloc/withdrawal/withdrawal_bloc.dart';
import '../../cubit/withdrawal_cubit.dart';

class RequestWithdrawalView extends StatefulWidget {
  static const String routeName = "/request_withdrawal";
  const RequestWithdrawalView({super.key});

  @override
  State<RequestWithdrawalView> createState() => _RequestWithdrawalViewState();
}

class _RequestWithdrawalViewState extends State<RequestWithdrawalView> {
  final WithdrawalBloc _withdrawalBloc = SetUpLocators.getIt<WithdrawalBloc>();
  final WithdrawalCubit _withdrawalCubit =
      SetUpLocators.getIt<WithdrawalCubit>();
  final GetProfileBloc _getProfileBloc = SetUpLocators.getIt<GetProfileBloc>();

  @override
  void initState() {
    _withdrawalCubit.reset();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WithdrawalBloc, WithdrawalState>(
      bloc: _withdrawalBloc,
      listener: listener,
      child: ScaffoldWidget(
        body: Column(
          children: [
            verticalSpace(),
            const AppBarWidget("Request Withdrawal"),
            verticalSpace(40),
            TextFieldWidget(
              title: 'Account Number',
              hintText: '2200000000',
              onChanged: _withdrawalCubit.accountNumberChanged,
              validator: accountNumberValidator,
              textInputType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ],
            ),
            verticalSpace(),
            TextFieldWidget(
              title: 'Bank Name',
              hintText: 'Access Bank',
              onChanged: _withdrawalCubit.bankNameChanged,
              validator: textValidator,
            ),
            verticalSpace(),
            TextFieldWidget(
              title: 'Account Name',
              hintText: 'John Doe',
              onChanged: _withdrawalCubit.accountNameChanged,
              validator: textValidator,
            ),
            verticalSpace(),
            TextFieldWidget(
              title: "Amount",
              hintText: "\u20A6 1,000",
              validator: amountValidator,
              textInputType: const TextInputType.numberWithOptions(),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                CurrencyTextInputFormatter(symbol: "\u20A6 "),
              ],
              onChanged: (p0) {
                String amount = p0
                    .replaceAll("\u20A6 ", "")
                    .replaceAll(",", "")
                    .split(".")
                    .first;

                _withdrawalCubit.amountChanged(amount);
              },
            ),
            verticalSpace(40),
            BlocBuilder<WithdrawalBloc, WithdrawalState>(
              bloc: _withdrawalBloc,
              builder: (context, state) {
                if (state is WithdrawalLoading) return const Button.loading();

                return BlocBuilder<WithdrawalCubit, WithdrawalStateFormz>(
                  bloc: _withdrawalCubit,
                  builder: (context, state) {
                    return Button(
                      active: state.isValid,
                      text: 'Request Withdrawal',
                      onTap: () => _withdrawalBloc.add(
                        WithdrawalEvent(
                          state.toMap(_getProfileBloc.userDetailsEntity!),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            verticalSpace(20),
          ],
        ),
      ),
    );
  }
}

extension on _RequestWithdrawalViewState {
  void listener(BuildContext context, WithdrawalState state) {
    if (state is WithdrawalSuccess) {
      SnackBarService.showSuccessSnackBar(
        message: state.entity.message,
        context: context,
      );

      AppRouter.instance.goBack();
    } else if (state is WithdrawalError) {
      SnackBarService.showErrorSnackBar(
        message: state.message,
        context: context,
      );
    }
  }
}
