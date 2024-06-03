import '../../../constents/constents.dart';

class FeeReceiptModel {
  String? id;
  String? studentId;
  String? receiptType;
  String? receiptNum;
  String? receiptYear;
  String? receiptAmount;
  String? receiptUrl;
  String? receiptStatus;
  String? receiptVerifiedBy;

  FeeReceiptModel({
    this.id,
    this.studentId,
    this.receiptType, this.receiptNum,
    this.receiptYear,
    this.receiptAmount,
    this.receiptUrl,
    this.receiptStatus,
    this.receiptVerifiedBy
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'studentId': this.studentId,
      'receiptType': this.receiptType,
      'receiptNum': this.receiptNum,
      'receiptYear': this.receiptYear,
      'receiptAmount': this.receiptAmount,
      'receiptUrl': this.receiptUrl,
      'receiptStatus': this.receiptStatus ?? ListConstent.feeReceiptStatus[0],
      'receiptVerifiedBy': this.receiptVerifiedBy ?? "",
    };
  }

  factory FeeReceiptModel.fromMap(Map<String, dynamic> map) {
    return FeeReceiptModel(
      id: map['id'] as String,
      studentId: map['studentId'] as String,
      receiptType: map['receiptType'] as String,
      receiptNum: map['receiptNum'] as String,
      receiptYear: map['receiptYear'] as String,
      receiptAmount: map['receiptAmount'] as String,
      receiptUrl: map['receiptUrl'] as String,
      receiptStatus: map['receiptStatus'] as String? ?? ListConstent.feeReceiptStatus[0],
      receiptVerifiedBy: map['receiptVerifiedBy'] as String? ?? "",
    );
  }



  @override
  String toString() {
    return 'FeeReceiptModel{id: $id, studentId: $studentId, receiptType: $receiptType, receiptNum: $receiptNum, receiptYear: $receiptYear, receiptAmount: $receiptAmount, receiptUrl: $receiptUrl, receiptStatus: $receiptStatus}';
  }

  FeeReceiptModel copyWith({
    String? id,
    String? studentId,
    String? receiptType,
    String? receiptNum,
    String? receiptYear,
    String? receiptAmount,
    String? receiptUrl,
    String? receiptStatus,
    String? receiptVerifiedBy,
  }) {
    return FeeReceiptModel(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      receiptType: receiptType ?? this.receiptType,
      receiptNum: receiptNum ?? this.receiptNum,
      receiptYear: receiptYear ?? this.receiptYear,
      receiptAmount: receiptAmount ?? this.receiptAmount,
      receiptUrl: receiptUrl ?? this.receiptUrl,
      receiptStatus: receiptStatus ?? this.receiptStatus,
      receiptVerifiedBy: receiptVerifiedBy ?? this.receiptVerifiedBy,
    );
  }
}
