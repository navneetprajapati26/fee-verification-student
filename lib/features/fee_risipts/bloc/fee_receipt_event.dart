part of 'fee_receipt_bloc.dart';

@immutable
abstract class FeeReceiptEvent {}

class UploadImageEvent extends FeeReceiptEvent {
  String folderName;
  String receiptName;
  String receiptYear;
  String receiptAmount;

  UploadImageEvent({
    required this.folderName,
    required this.receiptName,
    required this.receiptYear,
    required this.receiptAmount,
  });
}

class UploadPDFEvent extends FeeReceiptEvent {
  String folderName;
  String receiptName;
  String receiptYear;
  String receiptAmount;

  UploadPDFEvent({
    required this.folderName,
    required this.receiptName,
    required this.receiptYear,
    required this.receiptAmount,
  });
}

class GetFeeReceiptsByListOfIdEvent extends FeeReceiptEvent {
  //final List<String> studentIdList;

  GetFeeReceiptsByListOfIdEvent();
}