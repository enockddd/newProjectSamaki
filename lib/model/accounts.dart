class Accounts {
  final int? accountId;
  final String? cardNo;
  final String? expireDate;
  final String? cvv;
  final double? balance;
  final String? cardName;

  Accounts({
    this.accountId,
    this.cardNo,
    this.expireDate,
    this.cvv,
    this.balance,
    this.cardName,
  });

  factory Accounts.fromJson(Map<String, dynamic> json) {
    return Accounts(
      accountId: json['account_id'] as int?,
      cardNo: json['card_no'] as String?,
      expireDate: json['expire_date'] as String?,
      cvv: json['cvv'] as String?,
      balance: json['balance'] != null ? (json['balance'] as num).toDouble() : null,
      cardName: json['card_name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'account_id': accountId,
      'card_no': cardNo,
      'expire_date': expireDate,
      'cvv': cvv,
      'balance': balance,
      'card_name': cardName,
    };
  }
}
