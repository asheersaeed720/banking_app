import 'package:cloud_firestore/cloud_firestore.dart';

class BankCardModel {
  final String uid;
  final String bankName;
  final String cardImg;
  final String cardType;
  final String expiryDate;
  final Timestamp? createdAt;

  BankCardModel({
    this.uid = '',
    this.bankName = '',
    this.cardImg = '',
    this.cardType = '',
    this.expiryDate = '',
    this.createdAt,
  });

  BankCardModel.fromJson(Map<String, Object?> json)
      : this(
          uid: json['uid']! as String,
          bankName: json['bank_name']! as String,
          cardImg: json['card_img']! as String,
          cardType: json['card_type']! as String,
          expiryDate: json['expiry_date']! as String,
          createdAt: json['created_at'] as Timestamp,
        );

  Map<String, Object?> toJson() {
    return {
      'uid': uid,
      'bank_name': bankName,
      'card_img': cardImg,
      'card_type': cardType,
      'expiry_date': expiryDate,
      'created_at': createdAt,
    };
  }

  static List<BankCardModel> banksList = [
    BankCardModel(bankName: 'sads'),
    BankCardModel(bankName: 'Al Baraka Bank (Pakistan) Limited'),
    BankCardModel(bankName: 'Allied Bank Limited'),
    BankCardModel(bankName: 'Askari Bank'),
    BankCardModel(bankName: 'Bank Alfalah Limited'),
    BankCardModel(bankName: 'Bank Al-Habib Limited'),
    BankCardModel(bankName: 'BankIslami Pakistan Limited'),
    BankCardModel(bankName: 'Citi Bank'),
    BankCardModel(bankName: 'Deutsche Bank A.G'),
    BankCardModel(bankName: 'The Bank of Tokyo-Mitsubishi UFJ'),
    BankCardModel(bankName: 'Dubai Islamic Bank Pakistan Limited'),
    BankCardModel(bankName: 'Faysal Bank Limited'),
    BankCardModel(bankName: 'First Women Bank Limited'),
    BankCardModel(bankName: 'Habib Bank Limited'),
    BankCardModel(bankName: 'Standard Chartered Bank (Pakistan) Limite'),
    BankCardModel(bankName: 'Habib Metropolitan Bank Limited'),
    BankCardModel(bankName: 'Industrial and Commercial Bank of China'),
    BankCardModel(bankName: 'Industrial Development Bank of Pakistan'),
    BankCardModel(bankName: 'JS Bank Limited'),
    BankCardModel(bankName: 'MCB Bank Limited'),
    BankCardModel(bankName: 'MCB Islamic Bank Limited'),
    BankCardModel(bankName: 'Meezan Bank Limited'),
    BankCardModel(bankName: 'National Bank of Pakistan'),
  ];
}
