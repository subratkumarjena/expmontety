import '../../domain/local/database.dart';

class UserModel{
  int uid;
  String email;
  String pass;
  String mobile;
  String name;
  UserModel({required this.email,required this.pass,required this.mobile,required this.uid,required this.name});

  factory UserModel.fromMap(Map<String,dynamic>map){
    return UserModel(
        name: map[AppDatabase.TABLE_COLUMN_UNAME],
        uid: map[AppDatabase.TABLE_COLUMN_UID],
        email: map[AppDatabase.TABLE_COLUMN_UEMAIL],
        pass: map[AppDatabase.TABLE_COLUMN_UPASS],
        mobile: map[AppDatabase.TABLE_COLUMN_UMOBILE]);
  }

  Map<String,dynamic>toMap(){
    return {
      AppDatabase.TABLE_COLUMN_UEMAIL: email,
      AppDatabase.TABLE_COLUMN_UNAME: name,
      AppDatabase.TABLE_COLUMN_UPASS: pass,
      AppDatabase.TABLE_COLUMN_UMOBILE: mobile,
    };
  }
}