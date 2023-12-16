import 'package:crud1/dbHandler.dart';
import 'package:crud1/model.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  DatabaseHelper? dbHelper;
  late Future<List<UserModel>> usersList;
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController contactController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbHelper = DatabaseHelper();
    loadData();
  }

  loadData() async {
    usersList = dbHelper!.getUsers();
    return usersList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add User"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                  hintText: "Name",
                  labelText: "Name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(
                  hintText: "Description",
                  labelText: "Description",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: contactController,
              decoration: InputDecoration(
                  hintText: "Contact",
                  labelText: "Contact",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  dbHelper!
                      .insert(UserModel(
                          name: nameController.text.toString(),
                          description: descriptionController.text.toString(),
                          contact: contactController.text.toString()))
                      .then((value) {
                    print("Data Added");
                    setState(() {
                      usersList = dbHelper!.getUsers();
                    });
                    const SnackBar(content: Text("Data Adeed Successfully"));
                  }).onError((error, stackTrace) {
                    print(error.toString());
                  });
                  nameController.text = "";
                  descriptionController.text = "";
                  contactController.text = "";
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(100, 50),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                ),
                child: Text("Save"))
          ],
        ),
      ),
    );
  }
}


// dbHelper!
//               .insert(UserModel(
//                   name: "Ali",
//                   description: "Hello I am Umer",
//                   contact: "03069457225"))
//               .then((value) {
//             print("Data Added");
//             setState(() {
//               usersList = dbHelper!.getUsers();
//             });
//           }).onError((error, stackTrace) {
//             print(error.toString());
//           });