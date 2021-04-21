import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class DatabaseManager {
  final CollectionReference profileList =
  Firestore.instance.collection('Student');
  
  Future<bool> UpdateTeacherCourse(String tid, List<String> list , String stream, String branch , String sem) async{
    bool val = false;
    if((stream.toLowerCase() == "btech" || stream.toLowerCase() == "mtech")
        && (branch.toLowerCase() == "cse" || branch.toLowerCase() == "ece")
        && (sem.toLowerCase() == "sem 1" || sem.toLowerCase() == "sem 2" || sem.toLowerCase() == "sem 3"
            || sem.toLowerCase() == "sem 4" || sem.toLowerCase() == "sem 5" || sem.toLowerCase() == "sem 6"
            || sem.toLowerCase() == "sem 7" || sem.toLowerCase() == "sem 8")){
      val = true;
      String a = sem[4];
      sem = "Sem "+a;
    }

    if(!val){
      return val;
    }

    try {
      CollectionReference users = Firestore.instance.collection('Student');
      await users
          .where("Teacher ID",
          isEqualTo: tid)
          .getDocuments()
          .then((value) {
        if(value.documents.isEmpty){
          val = false;
        }
        value.documents.forEach((element) async {
          try {
            print(element.documentID);
            List<String> course = [];
            List<String> required_list = [];
            if (stream.toLowerCase() == "btech" &&
                branch.toLowerCase() == "cse") {
              await Firestore.instance.collection('Course')
                  .document("Btech CSE")
                  .collection(sem)
                  .document("BTech CSE")
                  .get()
                  .then((value) {
                course = List.from(value["Course"].keys);
                required_list.clear();
                if (course.length != null) {
                  for (int i = 0; i < value["Course"].length; i++) {
                    required_list.add(value["Course"][course[i]]["Course_name"]);
                    required_list.add(value["Course"][course[i]]["Course_code"]);
                    required_list.add(
                        value["Course"][course[i]]["Course_credit"]);
                  }
                }
              });
              for (int i = 0; i < required_list.length; i += 3) {
                for (int j = 0; j < list.length; j++) {
                  if (required_list[i + 1] == list[j]) {
                    await Firestore.instance
                        .collection("Student")
                        .document(element.documentID)
                        .updateData(
                        {
                          'Course': FieldValue.arrayUnion([
                            {
                              "Course_code": required_list[i+1],
                              "Name": required_list[i],
                              "Credit":required_list[i+2],
                              "Stream":stream,
                               "Semester" : sem,
                            }
                          ]),
                        }
                    );
                  }
                }
              }
            }
            else if (stream.toLowerCase() == "btech" &&
                branch.toLowerCase() == "ece") {
              await Firestore.instance.collection('Course')
                  .document("BTech ECE")
                  .collection(sem)
                  .document("BTech ECE")
                  .get()
                  .then((value) {
                course = List.from(value["Course"].keys);
                required_list.clear();
                if (course.length != null) {
                  for (int i = 0; i < value["Course"].length; i++) {
                    required_list.add(value["Course"][course[i]]["Course_name"]);
                    required_list.add(value["Course"][course[i]]["Course_code"]);
                    required_list.add(
                        value["Course"][course[i]]["Course_credit"]);
                  }
                }
              });
              for (int i = 0; i < required_list.length; i += 3) {
                for (int j = 0; j < list.length; j++) {
                  if (required_list[i + 1] == list[j]) {
                    await Firestore.instance
                        .collection("Student")
                        .document(element.documentID)
                        .updateData(
                        {
                          'Course': FieldValue.arrayUnion([
                          {
                          "Course_code": required_list[i+1],
                          "Name": required_list[i],
                          "Credit":required_list[i+2],
                          "Stream":stream,
                          "Semester" : sem,
                          }
                          ]),
                        }
                    );
                  }
                }
              }
            }

            else if (branch.toLowerCase() == "mtech" &&
                branch.toLowerCase() == "cse") {
              await Firestore.instance.collection('Course')
                  .document("MTech CSE")
                  .collection(sem)
                  .document("MTech CSE")
                  .get()
                  .then((value) {
                course = List.from(value["Course"].keys);
                required_list.clear();
                //print(course);
                if (course.length != null) {
                  for (int i = 0; i < value["Course"].length; i++) {
                    required_list.add(value["Course"][course[i]]["Course_name"]);
                    required_list.add(value["Course"][course[i]]["Course_code"]);
                    required_list.add(
                        value["Course"][course[i]]["Course_credit"]);
                  }
                }
              });
              for (int i = 0; i < required_list.length; i += 3) {
                for (int j = 0; j < list.length; j++) {
                  if (required_list[i + 1] == list[j]) {
                    await Firestore.instance
                        .collection("Student")
                        .document(element.documentID)
                        .updateData(
                        {
                          'Course': FieldValue.arrayUnion([
                          {
                          "Course_code": required_list[i+1],
                          "Name": required_list[i],
                          "Credit":required_list[i+2],
                          "Stream":stream,
                          "Semester" : sem,
                          }
                          ]),
                        }
                    );
                  }
                }
              }
            }
            else if (stream.toLowerCase() == "mtech" &&
                branch.toLowerCase() == "ece") {
              await Firestore.instance.collection('Course')
                  .document("Mtech ECE")
                  .collection(sem)
                  .document("MTech ECE")
                  .get()
                  .then((value) {
                course = List.from(value["Course"].keys);
                required_list.clear();
                if (course.length != null) {
                  for (int i = 0; i < value["Course"].length; i++) {
                    required_list.add(value["Course"][course[i]]["Course_name"]);
                    required_list.add(value["Course"][course[i]]["Course_code"]);
                    required_list.add(
                        value["Course"][course[i]]["Course_credit"]);
                  }
                }
              });
              for (int i = 0; i < required_list.length; i += 3) {
                for (int j = 0; j < list.length; j++) {
                  if (required_list[i + 1] == list[j]) {
                    await Firestore.instance
                        .collection("Student")
                        .document(element.documentID)
                        .updateData(
                        {
                          'Course': FieldValue.arrayUnion([
                          {
                          "Course_code": required_list[i+1],
                          "Name": required_list[i],
                          "Credit":required_list[i+2],
                          "Stream":stream,
                          "Semester" : sem,
                          }
                          ]),
                        }
                    );
                  }
                }
              }
            }
            else {
            }
          } catch (e) {
            val = false;
          }
        });
      });
    }catch(e){
      return val;
    }
    return val;
  }

  Future<bool> DeleteCourse(String stream , String branch ,String sem , String Course_code ) async{

    bool val=false;

    if((stream.toLowerCase() == "btech" || stream.toLowerCase() == "mtech") && (branch.toLowerCase() == "cse" || branch.toLowerCase() == "ece") && (sem.toLowerCase()=="sem 1"|| sem.toLowerCase()=="sem 2" || sem.toLowerCase()=="sem 3" || sem.toLowerCase()=="sem 4" || sem.toLowerCase()=="sem 5" || sem.toLowerCase()=="sem 6" || sem.toLowerCase()=="sem 7" || sem.toLowerCase()=="sem 8")){
      val = true;
      String a = sem[4];
      sem = "Sem "+a;
    }

    if(!val){
      return val;
    }

    try {
      CollectionReference colref = Firestore.instance.collection('Course');
      if(stream.toLowerCase() == "btech" || branch.toLowerCase() == "cse"){
        await Firestore.instance
            .collection('Course')
            .document("Btech CSE")
            .collection(sem)
            .document("BTech CSE")
            .updateData({"Course."+Course_code: FieldValue.delete()});

      }else if(stream.toLowerCase() == "btech" || branch.toLowerCase() == "ece"){
        await Firestore.instance
            .collection('Course')
            .document("BTech ECE")
            .collection(sem)
            .document("BTech ECE")
            .updateData({"Course."+Course_code: FieldValue.delete()});

      }else if(stream.toLowerCase() == "mtech" || branch.toLowerCase() == "cse"){
        await Firestore.instance
            .collection('Course')
            .document("MTech CSE")
            .collection(sem)
            .document("MTech CSE")
            .updateData({"Course."+Course_code: FieldValue.delete()});

      }else if(stream.toLowerCase() == "mtech" || branch.toLowerCase() == "ece"){
        await Firestore.instance
            .collection('Course')
            .document("MTech ECE")
            .collection(sem)
            .document("MTech ECE")
            .updateData({"Course."+Course_code: FieldValue.delete()});

      }else{
        return false;
      }

    }catch(e){
      return val;
    }
    return val;

  }

  Future<bool> DeleteUserData(String roll_number) async{

    bool val = false;
    try {
      await profileList
          .where("Roll Number", isEqualTo: roll_number)
          .getDocuments()
          .then((value) {
            if(value.documents.isNotEmpty){
              val = true;
            }
        value.documents.forEach((element) async {
          if (element.documentID.isNotEmpty) {
            for(int i=1;i<=8;i++){
            await profileList
              .document(element.documentID)
            .collection('Sem '+i.toString())
                .document(element.documentID)
                .delete();
            }
            await profileList
                .document(element.documentID)
                .delete();
           }
        });
      });
    }catch(e){
      return val;
    }
    return val;
  }

  Future<bool> DeleteTeacher(String tid) async{

    bool val = false;
    try {
      await profileList
          .where("Teacher ID", isEqualTo: tid)
          .getDocuments()
          .then((value) {
        if(value.documents.isNotEmpty){
          val = true;
        }
        value.documents.forEach((element) async {
          if (element.documentID.isNotEmpty) {
            await profileList
                .document(element.documentID)
                .delete();
          }
        });
      });
    }catch(e){
      return val;
    }
    return val;
  }

 Future<bool> UpdateFinalResult(String roll_number,String semester,String course_code ,String grades) async{
   bool return_val = false;

   List<String> sem = ["Sem 1","Sem 2","Sem 3","Sem 4","Sem 5","Sem 6","Sem 7","Sem 8"];
   for(int i=0;i<sem.length;i++){
     if(sem[i].toLowerCase() == semester.toLowerCase()){
       return_val = true;
     }
   }
   if(!return_val){
     return false;
   }


    try {
      CollectionReference users = Firestore.instance.collection('Student');
     await users
          .where("Roll Number", isEqualTo: roll_number)
          .getDocuments()
          .then((value) {
            if(value.documents.isEmpty){
                         return_val = false;
           }

        value.documents.forEach((element) async {
          try {
            await Firestore.instance
                .collection("Student")
                .document(element.documentID)
                .collection(semester)
                .document(element.documentID)
                .updateData(
                {
                  "Result.$course_code.Course_grade": grades,
                }
            );
          }catch(e){
          }
        });
      });
    }catch(e){
      return return_val;
    }
  return return_val;
 }

 Future<bool> UpdateCourse(String roll_number , String semester , List<String> list) async{
    List<String> sem = ["Sem 1","Sem 2","Sem 3","Sem 4","Sem 5","Sem 6","Sem 7","Sem 8"];
    bool val = false;
    for(int i=0;i<sem.length;i++){
      if(sem[i].toLowerCase() == semester.toLowerCase()){
        val = true;
      }
    }

    if(!val){
      return false;
    }
   try{
    CollectionReference users = Firestore.instance.collection('Student');
    await users
      .where("Roll Number",isEqualTo: roll_number)
      .getDocuments()
      .then((value){
        if(value.documents.isEmpty){
          val = false;
        }
        value.documents.forEach((element) async {
          try{
          String Course = element.data["Course"];
          String Branch = element.data["Branch"];
          List<String> course = [];
          List<String> required_list = [];
          if (Course.toLowerCase() == "btech" &&
              Branch.toLowerCase() == "cse") {
            await Firestore.instance.collection('Course')
                .document("Btech CSE")
                .collection(semester)
                .document("BTech CSE")
                .get()
                .then((value) {
              course = List.from(value["Course"].keys);
              required_list.clear();
              //print(course);
              if (course.length != null) {
                for (int i = 0; i < value["Course"].length; i++) {
                  required_list.add(value["Course"][course[i]]["Course_name"]);
                  required_list.add(value["Course"][course[i]]["Course_code"]);
                  required_list.add(
                      value["Course"][course[i]]["Course_credit"]);
                }
              }
            });
            for (int i = 0; i < required_list.length; i += 3) {
              for (int j = 0; j < list.length; j++) {
                if (required_list[i + 1] == list[j]) {
                  await Firestore.instance
                      .collection("Student")
                      .document(element.documentID)
                      .collection(semester)
                      .document(element.documentID)
                      .updateData(
                      {
                        "Result." + required_list[i + 1]: {
                          "Course_code": required_list[i + 1],
                          "Course_name": required_list[i],
                          "Course_grade": "-",
                          "Course_credit": required_list[i + 2],
                        }
                      }
                  );
                }
              }
            }
          }
          else if (Course.toLowerCase() == "btech" &&
              Branch.toLowerCase() == "ece") {
            await Firestore.instance.collection('Course')
                .document("BTech ECE")
                .collection(semester)
                .document("BTech ECE")
                .get()
                .then((value) {
              course = List.from(value["Course"].keys);
              required_list.clear();
              if (course.length != null) {
                for (int i = 0; i < value["Course"].length; i++) {
                  required_list.add(value["Course"][course[i]]["Course_name"]);
                  required_list.add(value["Course"][course[i]]["Course_code"]);
                  required_list.add(
                      value["Course"][course[i]]["Course_credit"]);
                }
              }
            });
            for (int i = 0; i < required_list.length; i += 3) {
              for (int j = 0; j < list.length; j++) {
                if (required_list[i + 1] == list[j]) {
                  await Firestore.instance
                      .collection("Student")
                      .document(element.documentID)
                      .collection(semester)
                      .document(element.documentID)
                      .updateData(
                      {
                        "Result." + required_list[i + 1]: {
                          "Course_code": required_list[i + 1],
                          "Course_name": required_list[i],
                          "Course_grade": "-",
                          "Course_credit": required_list[i + 2],
                        }
                      }
                  );
                }
              }
            }
          }

          else if (Course.toLowerCase() == "mtech" &&
              Branch.toLowerCase() == "cse") {
            await Firestore.instance.collection('Course')
                .document("MTech CSE")
                .collection(semester)
                .document("MTech CSE")
                .get()
                .then((value) {
              course = List.from(value["Course"].keys);
              required_list.clear();
              //print(course);
              if (course.length != null) {
                for (int i = 0; i < value["Course"].length; i++) {
                  required_list.add(value["Course"][course[i]]["Course_name"]);
                  required_list.add(value["Course"][course[i]]["Course_code"]);
                  required_list.add(
                      value["Course"][course[i]]["Course_credit"]);
                }
              }
            });
            for (int i = 0; i < required_list.length; i += 3) {
              for (int j = 0; j < list.length; j++) {
                if (required_list[i + 1] == list[j]) {
                  await Firestore.instance
                      .collection("Student")
                      .document(element.documentID)
                      .collection(semester)
                      .document(element.documentID)
                      .updateData(
                      {
                        "Result." + required_list[i + 1]: {
                          "Course_code": required_list[i + 1],
                          "Course_name": required_list[i],
                          "Course_grade": "-",
                          "Course_credit": required_list[i + 2],
                        }
                      }
                  );
                }
              }
            }
          }
          else if (Course.toLowerCase() == "mtech" &&
              Branch.toLowerCase() == "ece") {
            await Firestore.instance.collection('Course')
                .document("Mtech ECE")
                .collection(semester)
                .document("MTech ECE")
                .get()
                .then((value) {
              course = List.from(value["Course"].keys);
              required_list.clear();
              if (course.length != null) {
                for (int i = 0; i < value["Course"].length; i++) {
                  required_list.add(value["Course"][course[i]]["Course_name"]);
                  required_list.add(value["Course"][course[i]]["Course_code"]);
                  required_list.add(
                      value["Course"][course[i]]["Course_credit"]);
                }
              }
            });
            for (int i = 0; i < required_list.length; i += 3) {
              for (int j = 0; j < list.length; j++) {
                if (required_list[i + 1] == list[j]) {
                  await Firestore.instance
                      .collection("Student")
                      .document(element.documentID)
                      .collection(semester)
                      .document(element.documentID)
                      .updateData(
                      {
                        "Result." + required_list[i + 1]: {
                          "Course_code": required_list[i + 1],
                          "Course_name": required_list[i],
                          "Course_grade": "-",
                          "Course_credit": required_list[i + 2],
                        }
                      }
                  );
                }
              }
            }
          }
          else {

          }
        }catch(e)
        {
            return false;
        }
        });
      });
    }catch(e){
      return val;
    }
    return val;
 }

 Future<bool> AddCourse(String stream , String branch ,String sem , String Course_code , String Course_name , String Course_credit) async{
    bool val=false;

    if((stream.toLowerCase() == "btech" || stream.toLowerCase() == "mtech") && (branch.toLowerCase() == "cse" || branch.toLowerCase() == "ece") && (sem.toLowerCase()=="sem 1"|| sem.toLowerCase()=="sem 2" || sem.toLowerCase()=="sem 3" || sem.toLowerCase()=="sem 4" || sem.toLowerCase()=="sem 5" || sem.toLowerCase()=="sem 6" || sem.toLowerCase()=="sem 7" || sem.toLowerCase()=="sem 8")){
      val = true;
      String a = sem[4];
      sem = "Sem "+a;
    }

    if(!val){
      return val;
    }

    try {
    CollectionReference colref = Firestore.instance.collection('Course');
    if(stream.toLowerCase() == "btech" || branch.toLowerCase() == "cse"){
      await Firestore.instance
          .collection('Course')
          .document("Btech CSE")
          .collection(sem)
          .document("BTech CSE")
          .updateData({
                   "Course."+Course_code:{
                     "Course_code":Course_code,
                     "Course_credit":Course_credit,
                     "Course_name":Course_name,
                   }
                }
            );
    }else if(stream.toLowerCase() == "btech" || branch.toLowerCase() == "ece"){
      await Firestore.instance
          .collection('Course')
          .document("BTech ECE")
          .collection(sem)
          .document("BTech ECE")
          .updateData({
        "Course."+Course_code:{
          "Course_code":Course_code,
          "Course_credit":Course_credit,
          "Course_name":Course_name,
        }
       }
      );
    }else if(stream.toLowerCase() == "mtech" || branch.toLowerCase() == "cse"){
      await Firestore.instance
          .collection('Course')
          .document("MTech CSE")
          .collection(sem)
          .document("MTech CSE")
          .updateData({
        "Course."+Course_code:{
          "Course_code":Course_code,
          "Course_credit":Course_credit,
          "Course_name":Course_name,
        }
      }
      );
    }else if(stream.toLowerCase() == "mtech" || branch.toLowerCase() == "ece"){
      await Firestore.instance
          .collection('Course')
          .document("MTech ECE")
          .collection(sem)
          .document("MTech ECE")
          .updateData({
        "Course."+Course_code:{
          "Course_code":Course_code,
          "Course_credit":Course_credit,
          "Course_name":Course_name,
        }
      }
      );
    }else{
         return false;
    }

  }catch(e){
    return val;
  }
  return val;
 }

 Future<bool> createNewTeacher(String name , String email , String tid , String post , String stream , String pass) async{

    bool val=false;

    if((stream.toLowerCase() == "cse" || stream.toLowerCase() == "ece" || stream.toLowerCase() == "hss") && (pass.length >= 6)){
      val = true;
    }

    if(!val){
      return val;
    }

    try{
      CollectionReference colref = Firestore.instance.collection('Student');
      await colref
          .where("Teacher ID",isEqualTo: tid)
          .getDocuments()
          .then((value) {
        if(value.documents.isNotEmpty){
          val = false;
        }
      });

      if(val) {
        AuthResult result = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
            email: email, password: pass);
        FirebaseUser user = result.user;
        await Firestore.instance.collection('Student')
            .document(user.uid).setData(
            {
              "Name": name,
              "Teacher ID":tid,
              "Email": email,
              "Role": "teacher",
              "Post": post,
              "Stream":stream.toUpperCase(),
              "Course":[],
            });
      }
    }catch(e){
     return val;
    }
    return val;
 }

  Future<bool> createNewUser(String name, String email,String branch,String course,String roll_number, String password,String batch) async {

    bool val = false;

    if((course.toLowerCase() == "btech" || course.toLowerCase() == "mtech") && (branch.toLowerCase() == "cse" || branch.toLowerCase() == "ece")){
      val = true;
    }

    if(!val){
      return val;
    }

    try {
      CollectionReference colref = Firestore.instance.collection('Student');
       await colref
      .where("Roll Number",isEqualTo: roll_number)
      .getDocuments()
      .then((value) {
          if(value.documents.isNotEmpty){
            val = false;
          }
      });

       if(val) {
         AuthResult result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      await Firestore.instance.collection('Student')
          .document(user.uid).setData(
          {
            "Name": name,
            "Roll Number": roll_number,
            "Email": email,
            "Branch": branch.toLowerCase() == "cse" ? "CSE" : "ECE",
            "Course": course.toLowerCase() == "btech" ? "BTech" : "MTech",
            "Role": "student",
            "Batch": batch,
            "Current": []
          });

      for (int i = 1; i <= 8; i++) {
        await Firestore.instance.collection('Student')
            .document(user.uid)
            .collection('Sem ' + i.toString())
            .document(user.uid)
            .setData({
          "Result": {}
        });
      }
       }
    } catch (e) {
      return val;
    }
    return val;
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