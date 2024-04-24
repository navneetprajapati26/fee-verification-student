import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'fee_receipt_event.dart';
part 'fee_receipt_state.dart';

class FeeReceiptBloc extends Bloc<FeeReceiptEvent, FeeReceiptState> {
  FeeReceiptBloc() : super(FeeReceiptInitial()) {
    on<FeeReceiptEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
