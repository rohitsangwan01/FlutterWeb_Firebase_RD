import 'package:firebase/firebase.dart' as fb;
import 'package:firebase/firebase.dart';


//Replace These Values With Yours
class FirebaseHelper  {
  static fb.Database initDatabase() {
    try {
      if (fb.apps.isEmpty) {
        fb.initializeApp(
            apiKey: "AIzaSyAyP3_FN7CoSoucTmcl30oc6KiiULev8So",
            authDomain: "flutterweb-2463a.firebaseapp.com",
            databaseURL: "https://flutterweb-2463a-default-rtdb.firebaseio.com",
            projectId: "flutterweb-2463a",
            storageBucket: "flutterweb-2463a.appspot.com",
            messagingSenderId: "660278896286",
            appId: "1:660278896286:web:9c6340926fff2e9f773d8f"
        );
      }
    } on fb.FirebaseJsNotLoadedException catch (e) {
      print(e);
    }
    return fb.database();
  }
}

class fire{
  static fb.Database database = FirebaseHelper.initDatabase();
}


Future<String> getOnce(fb.DatabaseReference AdsRef) async {
  String a;
  await AdsRef.once('value').then((value) => {a = value.snapshot.val()});
  return a;
}

Future<List> getList(fb.DatabaseReference AdsRef) async {
  List list = [""];
  await AdsRef.once('value').then((value) => {
    list = result(value.snapshot, list)
  });
  return list;
}

List result(DataSnapshot dp,List list){
  list.clear();
  dp.forEach((v) {
    list.add(v);
  });
  return list;
}

