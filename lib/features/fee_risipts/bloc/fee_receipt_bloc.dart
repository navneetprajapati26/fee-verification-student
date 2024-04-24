import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../utils/storage_utils.dart';

part 'fee_receipt_event.dart';
part 'fee_receipt_state.dart';

class FeeReceiptBloc extends Bloc<FeeReceiptEvent, FeeReceiptState> {
  final StorageUtils _storageUtils = StorageUtils();

  FeeReceiptBloc() : super(FeeReceiptInitial()) {
    on<UploadImageEvent>((event, emit) async {
      try {
        String? imageUrl = await _storageUtils.uploadImage(event.folderName);
        emit(ImageUploadCompletedState(imageUrl));
      } catch (e) {
        // Handle error here
      }
    });
    on<UploadPDFEvent>((event, emit) async {
      try {
        String? pdfUrl = await _storageUtils.uploadPDF(event.folderName);
        emit(PDFUploadCompletedState(pdfUrl));
      } catch (e) {
        // Handle error here
      }
    });
  }
}
