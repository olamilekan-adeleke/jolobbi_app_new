import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/transaction_entity.dart';
import '../../../domain/usecases/get_transactions_usecase.dart';

part 'get_transaction_event.dart';
part 'get_transaction_state.dart';

class GetTransactionBloc
    extends Bloc<GetTransactionEvent, GetTransactionState> {
  final GetTransactionUsecase getTransactionUsecase;

  String? lastDoc;
  bool isBusy = false;
  List<TransactionEntity> transactions = [];

  GetTransactionBloc({
    required this.getTransactionUsecase,
  }) : super(GetTransactionInitial()) {
    on<GetTransactionEvent>((event, emit) async {
      if (isBusy) return;

      if (event.getFreshData == true) {
        transactions = [];
        lastDoc = null;
      }

      if (lastDoc == null) {
        emit(GetTransactionLoading());
      } else {
        emit(GetTransactionLoadingMore());
      }

      final result = await getTransactionUsecase(lastDoc);

      result.fold(
        (failure) {
          if (lastDoc == null) {
            emit(GetTransactionError(failure.message));
          } else {
            emit(GetTransactionErrorMore(failure.message));
          }
        },
        (transactions) {
          this.transactions.addAll(transactions);
          if (transactions.isNotEmpty) lastDoc = transactions.last.id;

          emit(GetTransactionSuccess(this.transactions));
        },
      );
    });
  }
}
