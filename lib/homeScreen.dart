import 'package:crud1/AddUser.dart';
import 'package:crud1/EditUser.dart';
import 'package:crud1/dbHandler.dart';
import 'package:crud1/model.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
        title: Text(
          "C R U D",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: usersList,
                builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {},
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Card(
                                  child: ListTile(
                                    onTap: () {},
                                    title: Text(
                                        snapshot.data![index].name.toString()),
                                    subtitle: Text(snapshot
                                        .data![index].description
                                        .toString()),
                                    trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                dbHelper!.update(UserModel(
                                                    id: snapshot
                                                        .data![index].id!,
                                                    name: "Umer",
                                                    description: "This is Umer",
                                                    contact: "0987654321"));
                                                setState(() {
                                                  usersList =
                                                      dbHelper!.getUsers();
                                                });
                                              },
                                              icon: Icon(
                                                Icons.edit,
                                              )),
                                          IconButton(
                                              onPressed: () {
                                                dbHelper!.delete(
                                                    snapshot.data![index].id!);
                                                setState(() {
                                                  usersList =
                                                      dbHelper!.getUsers();
                                                });
                                              },
                                              icon: Icon(
                                                Icons.delete,
                                                color: const Color.fromARGB(
                                                    255, 198, 50, 39),
                                              ))
                                        ]),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                  );
                }),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddUser()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
