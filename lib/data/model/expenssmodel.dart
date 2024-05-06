import '../../domain/local/database.dart';

class ExpenseModel {
  int id;
  int uid;
  String title;
  String desc;
  String time;
  String amount;
  String balance;
  String type;
  int catId;

  ExpenseModel(
      {required this.title,
        required this.desc,
        required this.time,
        required this.amount,
        required this.balance,
        required this.type,
        required this.id,
        required this.uid,
        required this.catId});

  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
        id: map[AppDatabase.TABLE_COLUMN_EID],
        uid: map[AppDatabase.TABLE_COLUMN_UID],
        title: map[AppDatabase.TABLE_COLUMN_ETITLE],
        desc: map[AppDatabase.TABLE_COLUMN_EDESC],
        time: map[AppDatabase.TABLE_COLUMN_ETIME],
        amount: map[AppDatabase.TABLE_COLUMN_EAMOUNT],
        balance: map[AppDatabase.TABLE_COLUMN_EBALANCE],
        type: map[AppDatabase.TABLE_COLUMN_ETYPE],
        catId: map[AppDatabase.TABLE_COLUMN_CATID]);
  }

  Map<String, dynamic> toMap() {
    return {
      AppDatabase.TABLE_COLUMN_ETITLE: title,
      AppDatabase.TABLE_COLUMN_EDESC: desc,
      AppDatabase.TABLE_COLUMN_ETIME: time,
      AppDatabase.TABLE_COLUMN_EAMOUNT: amount,
      AppDatabase.TABLE_COLUMN_EBALANCE: balance,
      AppDatabase.TABLE_COLUMN_ETYPE: type,
      AppDatabase.TABLE_COLUMN_CATID: catId,
      AppDatabase.TABLE_COLUMN_UID: uid,
    };
  }
}