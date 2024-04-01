class Transaction {
  final String?  id;
  final DateTime date;
  final double? revenueAmount;
  final double? expenseAmount;
  final String? revenueNote;
  final String? expenseNote;
  final String revenueCategory;
  final String expenseCategory;
  Transaction({
    this.id,
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
    double? revenueAmount,
    double? expenseAmount,
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
      'date': date.toIso8601String(),
      'revenueAmount': revenueAmount.toString(),
      'expenseAmount': expenseAmount.toString(),
      'revenueNote': revenueNote,
      'expenseNote': expenseNote,
      'revenueCategory': revenueCategory,
      'expenseCategory': expenseCategory,
    };
  }

  factory Transaction.fromJson(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'],
      date: DateTime.parse(map['date']),
      revenueAmount: double.parse(map['revenueAmount']),
      expenseAmount: double.parse( map['expenseAmount']),
      revenueNote:
          map['revenueNote'],
      expenseNote:
          map['expenseNote'],
      revenueCategory: map['revenueCategory'] ,
      expenseCategory: map['expenseCategory'] ,
    );
  }

  @override
  String toString() {
    return 'Transaction(date: $date, revenueAmount: $revenueAmount, expenseAmount: $expenseAmount, revenueNote: $revenueNote, expenseNote: $expenseNote, revenueCategory: $revenueCategory, expenseCategory: $expenseCategory)';
  }

  @override
  bool operator ==(covariant Transaction other) {
    if (identical(this, other)) return true;

    return other.date == date &&
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
