import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class DatabaseManager {
  final CollectionReference profileList =
  Firestore.instance.collection('Student');

  Future DeleteUserData(String roll_number) async{
    await profileList
        .where("Roll Number",isEqualTo: roll_number)
        .getDocuments()
        .then((value) {
               value.documents.forEach((element) async{
                     if(element.documentID.isNotEmpty){
                             return await profileList
                                 .document(element.documentID)
                                 .delete();
                     }
                     else{
                       return null;
                      }
      });
      });
    }
 Future UpdateFinalResult(String roll_number,String semester,String course_code ,String grades) async{
    try{

      CollectionReference users = Firestore.instance.collection('Student');
      await users
          .where("Roll Number",isEqualTo: roll_number)
          .getDocuments()
          .then((value){
        value.documents.forEach((element) async{
          if(element.documentID.isNotEmpty){
            await Firestore.instance
                .collection("Student")
                .document(element.documentID)
                .collection(semester)
                .document(element.documentID)
                .updateData(
                {
                  "Result.$course_code.Course_grade":grades,
                }
            );
          }
          else{
          }
        });
      });

    }catch(e){
      print(e);
    }

 }

 Future UpdateCourse(String roll_number , String semester , List<String> list) async{
    try{
      CollectionReference colref = Firestore.instance.collection('Student');
      await colref
      .where("Roll Number",isEqualTo: roll_number)
      .getDocuments()
      .then((value){
        value.documents.forEach((element) async {
          String Course = element.data["Course"];
          String Branch = element.data["Branch"];
          List<String> course = [];
          List<String> required_list = [];
          if(Course.toLowerCase() == "btech" && Branch.toLowerCase() == "cse"){
            await Firestore.instance.collection('Course')
                .document("Btech CSE")
                .collection(semester)
                .document("BTech CSE")
                .get()
                .then((value){
                  course = List.from(value["Course"].keys);
                  required_list.clear();
                  //print(course);
                  if(course.length != null) {
                    for (int i = 0; i < value["Course"].length; i++) {
                      required_list.add(value["Course"][course[i]]["Course_name"]);
                      required_list.add(value["Course"][course[i]]["Course_code"]);
                      required_list.add(value["Course"][course[i]]["Course_credit"]);
                    }
                  }
                });
            for(int i=0;i<required_list.length;i+=3){
              for(int j=0;j<list.length;j++){
                if(required_list[i+1] == list[j]){
                  await Firestore.instance
                      .collection("Student")
                      .document(element.documentID)
                      .collection(semester)
                      .document(element.documentID)
                      .updateData(
                      {
                        "Result."+required_list[i+1]:{
                          "Course_code":required_list[i+1],
                          "Course_name":required_list[i],
                          "Course_grade":"-",
                          "Course_credit":required_list[i+2],
                        }
                      }
                  );
                }
              }
            }

          }
          else if(Course.toLowerCase() == "btech" && Branch.toLowerCase() == "ece"){

            await Firestore.instance.collection('Course')
                .document("BTech ECE")
                .collection(semester)
                .document("BTech ECE")
                .get()
                .then((value){
              course = List.from(value["Course"].keys);
              required_list.clear();
              if(course.length != null) {
                for (int i = 0; i < value["Course"].length; i++) {
                  required_list.add(value["Course"][course[i]]["Course_name"]);
                  required_list.add(value["Course"][course[i]]["Course_code"]);
                  required_list.add(value["Course"][course[i]]["Course_credit"]);
                }
              }
            });
            for(int i=0;i<required_list.length;i+=3){
              for(int j=0;j<list.length;j++){
                if(required_list[i+1] == list[j]){
                  await Firestore.instance
                      .collection("Student")
                      .document(element.documentID)
                      .collection(semester)
                      .document(element.documentID)
                      .updateData(
                      {
                        "Result."+required_list[i+1]:{
                          "Course_code":required_list[i+1],
                          "Course_name":required_list[i],
                          "Course_grade":"-",
                          "Course_credit":required_list[i+2],
                        }
                      }
                  );
                }
              }
            }
          }

          else if(Course.toLowerCase() == "mtech" && Branch.toLowerCase() == "cse"){

            await Firestore.instance.collection('Course')
                .document("MTech CSE")
                .collection(semester)
                .document("MTech CSE")
                .get()
                .then((value){
              course = List.from(value["Course"].keys);
              required_list.clear();
              //print(course);
              if(course.length != null) {
                for (int i = 0; i < value["Course"].length; i++) {
                  required_list.add(value["Course"][course[i]]["Course_name"]);
                  required_list.add(value["Course"][course[i]]["Course_code"]);
                  required_list.add(value["Course"][course[i]]["Course_credit"]);
                }
              }
            });
            for(int i=0;i<required_list.length;i+=3){
              for(int j=0;j<list.length;j++){
                if(required_list[i+1] == list[j]){
                  await Firestore.instance
                      .collection("Student")
                      .document(element.documentID)
                      .collection(semester)
                      .document(element.documentID)
                      .updateData(
                      {
                        "Result."+required_list[i+1]:{
                          "Course_code":required_list[i+1],
                          "Course_name":required_list[i],
                          "Course_grade":"-",
                          "Course_credit":required_list[i+2],
                        }
                      }
                  );
                }
              }
            }
          }
          else if(Course.toLowerCase() == "mtech" && Branch.toLowerCase() == "ece"){

            await Firestore.instance.collection('Course')
                .document("Mtech ECE")
                .collection(semester)
                .document("MTech ECE")
                .get()
                .then((value){
              course = List.from(value["Course"].keys);
              required_list.clear();
              //print(course);
              if(course.length != null) {
                for (int i = 0; i < value["Course"].length; i++) {
                  required_list.add(value["Course"][course[i]]["Course_name"]);
                  required_list.add(value["Course"][course[i]]["Course_code"]);
                  required_list.add(value["Course"][course[i]]["Course_credit"]);
                }
              }
            });
            for(int i=0;i<required_list.length;i+=3){
              for(int j=0;j<list.length;j++){
                if(required_list[i+1] == list[j]){
                  await Firestore.instance
                      .collection("Student")
                      .document(element.documentID)
                      .collection(semester)
                      .document(element.documentID)
                      .updateData(
                      {
                        "Result."+required_list[i+1]:{
                          "Course_code":required_list[i+1],
                          "Course_name":required_list[i],
                          "Course_grade":"-",
                          "Course_credit":required_list[i+2],
                        }
                      }
                  );
                }
              }
            }
          }
          else{

          }
        });
      });
    }catch(e){
      print(e);
    }
 }

  Future<bool> createNewUser(String name, String email,String branch,String course,String roll_number, String password) async {
    try {
      CollectionReference colref = Firestore.instance.collection('Student');
      AuthResult result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      await colref
      .where("Roll Number",isEqualTo: roll_number)
      .getDocuments()
      .then((value){
        value.documents.forEach((element) async{
              if(element.documentID.isEmpty == true){
                await Firestore.instance.collection('Student')
                    .document(user.uid).setData(
                    {
                      "Name":name,
                      "Roll Number":roll_number,
                      "Email":email,
                      "Branch":branch,
                      "Course":course,
                      "Role":"student",
                      "Current":[]
                    });

                for(int i=1;i<=8;i++){
                  await Firestore.instance.collection('Student')
                      .document(user.uid)
                      .collection('Sem '+i.toString())
                      .document(user.uid)
                      .setData({
                    "Result": {}
                  });
                }
                return Future<bool>.value(true);
              }
              else{
                return Future<bool>.value(false);
              }
        });
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future updateUserList(String name, String gender, int score, String uid) async {
    return await profileList.document(uid).updateData({
      'name': name, 'gender': gender, 'score': score
    });
  }

  Future getUsersList() async {
    List itemsList = [];

    try {
      await profileList.getDocuments().then((querySnapshot) {
        querySnapshot.documents.forEach((element) {
          itemsList.add(element.data);
        });
      });
      return itemsList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future getCurrentUserData() async{
    List CurrentUserList = [];
    try{
      final firebaseuser = await FirebaseAuth.instance.currentUser();
      if(firebaseuser != null){
        await profileList
            .document(firebaseuser.uid)
            .get()
            .then((ds){
              CurrentUserList.add(ds);
        });
      }
      else{
        return null;
      }
      return CurrentUserList;
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }
}