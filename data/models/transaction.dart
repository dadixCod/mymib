
class Transaction {
  final DateTime date;
  final int revenueAmount;
  final int expenseAmount;
  final String? revenueNote;
  final String? expenseNote;
  final String revenueCategory;
  final String expenseCategory;
  Transaction({
    required this.date,
    required this.revenueAmount,
    required this.expenseAmount,
    this.revenueNote,
    this.expenseNote,
    required this.revenueCategory,
    required this.expenseCategory,
  });
  

  Transaction copyWith({
    DateTime? date,
    int? revenueAmount,
    int? expenseAmount,
    String? revenueNote,
    String? expenseNote,
    String? revenueCategory,
    String? expenseCategory,
  }) {
    return Transaction(
      date: date ?? this.date,
      revenueAmount: revenueAmount ?? this.revenueAmount,
      expenseAmount: expenseAmount ?? this.expenseAmount,
      revenueNote: revenueNote ?? this.revenueNote,
      expenseNote: expenseNote ?? this.expenseNote,
      revenueCategory: revenueCategory ?? this.revenueCategory,
      expenseCategory: expenseCategory ?? this.expenseCategory,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'date': date.millisecondsSinceEpoch,
      'revenueAmount': revenueAmount,
      'expenseAmount': expenseAmount,
      'revenueNote': revenueNote,
      'expenseNote': expenseNote,
      'revenueCategory': revenueCategory,
      'expenseCategory': expenseCategory,
    };
  }

  factory Transaction.fromJson(Map<String, dynamic> map) {
    return Transaction(
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      revenueAmount: map['revenueAmount'] as int,
      expenseAmount: map['expenseAmount'] as int,
      revenueNote: map['revenueNote'] != null ? map['revenueNote'] as String : null,
      expenseNote: map['expenseNote'] != null ? map['expenseNote'] as String : null,
      revenueCategory: map['revenueCategory'] as String,
      expenseCategory: map['expenseCategory'] as String,
    );
  }


  @override
  String toString() {
    return 'Transaction(date: $date, revenueAmount: $revenueAmount, expenseAmount: $expenseAmount, revenueNote: $revenueNote, expenseNote: $expenseNote, revenueCategory: $revenueCategory, expenseCategory: $expenseCategory)';
  }

  @override
  bool operator ==(covariant Transaction other) {
    if (identical(this, other)) return true;
  
    return 
      other.date == date &&
      other.revenueAmount == revenueAmount &&
      other.expenseAmount == expenseAmount &&
      other.revenueNote == revenueNote &&
      other.expenseNote == expenseNote &&
      other.revenueCategory == revenueCategory &&
      other.expenseCategory == expenseCategory;
  }

  @override
  int get hashCode {
    return date.hashCode ^
      revenueAmount.hashCode ^
      expenseAmount.hashCode ^
      revenueNote.hashCode ^
      expenseNote.hashCode ^
      revenueCategory.hashCode ^
      expenseCategory.hashCode;
  }
}
