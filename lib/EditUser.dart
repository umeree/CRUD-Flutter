import 'package:crud1/dbHandler.dart';
import 'package:crud1/model.dart';
import 'package:flutter/material.dart';

class EditUser extends StatefulWidget {
  const EditUser({super.key});

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  DatabaseHelper? dbHelper;
  late Future<List<UserModel>> usersList;

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
        title: Text("Edit User"),
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
                  dbHelper!.update(UserModel(
                      name: nameController.text.toString(),
                      description: descriptionController.text.toString(),
                      contact: contactController.text.toString()));
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
