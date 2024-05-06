import 'dart:async';

import 'package:expmontety/data/model/expenssmodel.dart';
import 'package:expmontety/data/model/usermodel.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase{

  //// all the logic of data base
  AppDatabase._();
  ///accessing the appdb class object
  static final AppDatabase db = AppDatabase._();

  static const String TABLE_NAME_USER='user';
  static const String TABLE_COLUMN_UID='uId';
  static const String TABLE_COLUMN_UNAME='uname';
  static const String TABLE_COLUMN_UEMAIL='uemail';
  static const String TABLE_COLUMN_UPASS='upass';
  static const String TABLE_COLUMN_UMOBILE='umobile';

  static const String TABLE_NAME_EXPENSE='expense';
  static const String TABLE_COLUMN_EID='eId';
  static const String TABLE_COLUMN_ETITLE='etitle';
  static const String TABLE_COLUMN_EDESC='edesc';
  static const String TABLE_COLUMN_ETIME='etime';
  static const String TABLE_COLUMN_EAMOUNT='eamount';
  static const String TABLE_COLUMN_EBALANCE='ebalance';
  static const String TABLE_COLUMN_ETYPE='etype';

  static const String TABLE_NAME_CAT='category';
  static const String TABLE_COLUMN_CATID='catId';
  static const String TABLE_COLUMN_CATNAME='name';
  static const String TABLE_COLUMN_CATIMAGE='image';

// all logic of data base

  Database? MyDb;

  Future<Database>  getDb()async{
    if(MyDb!=null){
      return MyDb!;
    }else{
      MyDb= await initDb();
      return MyDb!;

    }
  }

  Future<Database> initDb() async {

    var rootpath = await getApplicationDocumentsDirectory();
    print('data baselocation :'+rootpath.path);


    var actualpath = join(rootpath.path,"noteDB.db");

    return await openDatabase(actualpath, version: 1,onCreate: (db, version){
      // table create
      db.execute("create table $TABLE_NAME_USER ( $TABLE_COLUMN_UID integer primary key autoincrement, $TABLE_COLUMN_UMOBILE text, $TABLE_COLUMN_UEMAIL text unique ,$TABLE_COLUMN_UNAME text,$TABLE_COLUMN_UPASS text )");
      db.execute("create table $TABLE_NAME_EXPENSE ( $TABLE_COLUMN_EID integer primary key autoincrement,$TABLE_COLUMN_UID integer, $TABLE_COLUMN_ETITLE text, $TABLE_COLUMN_EDESC text, $TABLE_COLUMN_EAMOUNT text, $TABLE_COLUMN_ETIME text, $TABLE_COLUMN_ETYPE text, $TABLE_COLUMN_CATID integer  )");


    });

  }





  void addNote({ required ExpenseModel newexp}) async{

    var cdb = await getDb();
    var uid =await getUID();
    newexp.uid = uid;
    cdb.insert( "$TABLE_NAME_EXPENSE" , newexp.toMap() );

  }

  Future<List<Map<String,dynamic>>> fetchallnote() async{
    var cdb = await getDb();
    var uid =await getUID();
    var data =   await cdb.query( "$TABLE_NAME_EXPENSE",where: "$TABLE_COLUMN_UID = ?", whereArgs: ['$uid']);
    return data;

  }


  void remove({ required ExpenseModel newexp}) async {
    var cdb = await getDb();
    cdb.delete("$TABLE_NAME_EXPENSE", where: "$TABLE_COLUMN_EID = ?", whereArgs: ['${newexp.id}']);
  }
  void updateda({ required ExpenseModel newexp}) async{

    var cdb = await getDb();
     cdb.update("$TABLE_NAME_EXPENSE", newexp.toMap()
         //{
    //
    //   "$TABLE_COLUMN_ETITLE": newexp.title ,
    //   "$TABLE_COLUMN_EDESC" : newexp.desc,
    // }
    ,where: "$TABLE_COLUMN_EID = ?", whereArgs: ['${newexp.id}']);

  }
  /////
  /////user signup
  Future<bool> addNewUser({required String uPhone,required String uEmail,required String uName,required String uPass }) async{
    var cdb = await getDb();
    bool haveaccount = await emailexit(uEmail);
    bool accountcreated  = false;

    if(!haveaccount){

   var rowsEffected  =  await     cdb.insert("user",{
        "user_phone": uPhone ,
        "user_email" : uEmail ,
        "user_name" : uName ,
        "user_pass" : uPass ,
      });
     accountcreated = rowsEffected>0;
    }

    return accountcreated;
  }

  Future<bool>  emailexit(String email) async{
    var cdb = await getDb();
      var mData  = await cdb.query("user", where: "user_email = ?", whereArgs: [email]);
      return mData.isNotEmpty;
  }

  /// user login
   Future<bool> login({ required UserModel newusermodel}) async{

     var cdb = await getDb();
     var mData  = await cdb.query("$TABLE_NAME_USER", where: "$TABLE_COLUMN_UEMAIL = ? AND $TABLE_COLUMN_UPASS = ?" , whereArgs: ['$newusermodel.email,$newusermodel.pass']);



     if(mData.isNotEmpty)  {
      await setUID( UserModel.fromMap(mData[0]).uid);

     }

     return mData.isNotEmpty;

   }

  Future <int> getUID() async{

    var prefs = await SharedPreferences.getInstance();
   int uid = prefs.getInt("LID")!;
   return uid?? 0;
   }
  Future <void> setUID( int uid) async{
     var prefs = await SharedPreferences.getInstance();
     prefs.setInt("LID",uid );

   }


}