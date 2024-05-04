import 'dart:async';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase{

  //// all the logic of data base
  AppDatabase._();
  ///accessing the appdb class object
  static final AppDatabase db = AppDatabase._();

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
      db.execute("create table user ( user_id integer primary key autoincrement, user_phone text, user_email text unique ,user_name text,user_pass text )");
      db.execute("create table note ( exp_id integer primary key autoincrement,user_id integer, exp_title text, exp_desc text, exp_amount text, exp_date&time text  )");


    });

  }





  void addNote({ required String ntitle, required String ndesc}) async{

    var cdb = await getDb();
    cdb.insert( "note" , {

      "exp_title": ntitle ,
      "exp_desc" : ndesc
    });

  }

  Future<List<Map<String,dynamic>>> fetchallnote() async{
    var cdb = await getDb();
    var data =   await cdb.query( "note");
    return data;

  }


  void remove(int id) async {
    var cdb = await getDb();
    cdb.delete("note", where: " exp_id = ?", whereArgs: [id]);
  }
  void updateda({ required String ntitle, required String ndesc, required id}) async{

    var cdb = await getDb();
    cdb.update("note", {

      "exp_title": ntitle ,
      "exp_desc" : ndesc,
    },where: "exp_id = ?", whereArgs: [id],);

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
   Future<bool> authuser({ required String email, required String pass}) async{

     var cdb = await getDb();
     List<Map<String, dynamic>> mData  = await cdb.query("user", where: "user_email = ? AND user_pass = ?" , whereArgs: [email,pass]);



     if(mData.isNotEmpty){
       setUID( mData);

     }

     return mData.isNotEmpty;

   }

   void getUID(){

   }
   void setUID(mData) async{

     var prefs = await SharedPreferences.getInstance();
     prefs.setInt("uId",mData[0]["user_id"] );

   }


}