part of 'fee_receipt_bloc.dart';

@immutable
abstract class FeeReceiptEvent {}

class UploadImageEvent extends FeeReceiptEvent {
  final String folderName;

  UploadImageEvent(this.folderName);
}

class UploadPDFEvent extends FeeReceiptEvent {
  final String folderName;

  UploadPDFEvent(this.folderName);
}