part of 'fee_receipt_bloc.dart';

@immutable
abstract class FeeReceiptState {}

class FeeReceiptInitial extends FeeReceiptState {}

class ImageUploadCompletedState extends FeeReceiptState {
  final String? imageUrl;

  ImageUploadCompletedState(this.imageUrl);
}

class PDFUploadCompletedState extends FeeReceiptState {
  final String? pdfUrl;

  PDFUploadCompletedState(this.pdfUrl);
}