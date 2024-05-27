
enum FeeReceiptStatus { pending, approved, rejected }


class FeeReceiptModel {
  String? id;
  String? studentId;

  String? receiptName;
  String? receiptYear;
  String? receiptAmount;
  String? receiptUrl;
  FeeReceiptStatus? receiptStatus;

FeeReceiptModel({
    this.id,
    this.studentId,
    this.receiptName,
    this.receiptYear,
    this.receiptAmount,
    this.receiptUrl,
    this.receiptStatus,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'studentId': this.studentId,
      'receiptName': this.receiptName,
      'receiptYear': this.receiptYear,
      'receiptAmount': this.receiptAmount,
      'receiptUrl': this.receiptUrl,
      'receiptStatus': this.receiptStatus,
    };
  }

  factory FeeReceiptModel.fromMap(Map<String, dynamic> map) {
    return FeeReceiptModel(
      id: map['id'] as String,
      studentId: map['studentId'] as String,
      receiptName: map['receiptName'] as String,
      receiptYear: map['receiptYear'] as String,
      receiptAmount: map['receiptAmount'] as String,
      receiptUrl: map['receiptUrl'] ?? "",
      receiptStatus: (map['receiptStatus'] as FeeReceiptStatus?) ?? FeeReceiptStatus.pending, // default to pending if null
    );
  }


  @override
  String toString() {
    return 'FeeReceiptModel{id: $id, studentId: $studentId, receiptName: $receiptName, receiptYear: $receiptYear, receiptAmount: $receiptAmount, receiptUrl: $receiptUrl, receiptStatus: $receiptStatus}';
  }

  FeeReceiptModel copyWith({
    String? id,
    String? studentId,
    String? receiptName,
    String? receiptYear,
    String? receiptAmount,
    String? receiptUrl,
    FeeReceiptStatus? receiptStatus,
  }) {
    return FeeReceiptModel(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      receiptName: receiptName ?? this.receiptName,
      receiptYear: receiptYear ?? this.receiptYear,
      receiptAmount: receiptAmount ?? this.receiptAmount,
      receiptUrl: receiptUrl ?? this.receiptUrl,
      receiptStatus: receiptStatus ?? this.receiptStatus,
    );
  }

}
