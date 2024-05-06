part of 'fee_receipt_bloc.dart';

enum FeeReceiptPostStatus {
  initial,
  loading,
  imageLoaded,
  pdfLoaded,
  error,
}

enum FeeReceiptGetStatus {
  initial,
  loading,
  loaded,
  error,
}


class FeeReceiptState extends Equatable {
  final FeeReceiptPostStatus postStatus;
  final FeeReceiptGetStatus getStatus;
  final String? errorMessage;
  final FeeReceiptModel? feeReceiptModel;
  final List<FeeReceiptModel>? feeReceiptModelList;


  const FeeReceiptState({
    required this.postStatus,
    required this.getStatus,
    this.errorMessage,
    this.feeReceiptModel,
    this.feeReceiptModelList,
  });

  factory FeeReceiptState.initial() {
    return FeeReceiptState(
      postStatus: FeeReceiptPostStatus.initial,
      getStatus: FeeReceiptGetStatus.initial,
      errorMessage: "",
      feeReceiptModel: null,
      feeReceiptModelList: [],
    );
  }



  @override
  List<Object?> get props => [postStatus,getStatus, errorMessage, feeReceiptModel, feeReceiptModelList];

  FeeReceiptState copyWith({
    FeeReceiptPostStatus? postStatus,
    FeeReceiptGetStatus? getStatus,
    String? errorMessage,
    FeeReceiptModel? feeReceiptModel,
    List<FeeReceiptModel>? feeReceiptModelList,
  }) {
    return FeeReceiptState(
      postStatus: postStatus ?? this.postStatus,
      getStatus: getStatus ?? this.getStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      feeReceiptModel: feeReceiptModel ?? this.feeReceiptModel,
      feeReceiptModelList: feeReceiptModelList ?? this.feeReceiptModelList,
    );
  }
}