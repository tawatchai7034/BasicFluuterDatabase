import 'package:basic_sqflite/DB/db_handler.dart';
import 'package:basic_sqflite/Model/User.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DBHelper? dbHelper;
  late Future<List<NotesModel>> userList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbHelper = new DBHelper();
    // loadData();
    // NotesModel(title: "User00",age: 22,description: "Default user",email: "User@exemple.com");
  }

  // loadData() async {
  //   userList = dbHelper!.getNotesModelList();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes SQL"),
        centerTitle: true,
      ),
      body: Column(children: [],),
      // FutureBuilder(
      //         future: userList,
      //         builder: (context, AsyncSnapshot<List<User>> snapshot) {
      //           return ListView.builder(
      //               itemCount: snapshot.data?.length,
      //               itemBuilder: (context, index) {
      //                 return Card(
      //                   child: ListTile(
      //                     contentPadding: EdgeInsets.all(0),
      //                     title: Text(snapshot.data![index].name.toString()),
      //                     subtitle: Text(
      //                         snapshot.data![index].description.toString()),
      //                     trailing: Text(snapshot.data![index].age.toString()),
      //                   ),
      //                 );
      //               });
      //         }),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            dbHelper!
                .insert(NotesModel(
                    title: "User01",
                    age: 23,
                    description: "first user",
                    email: "user@example.com"))
                .then((value) {
              print("Add data completed");
            }).onError((error, stackTrace) {
              print("Error: " + error.toString());
            });
          },
          child:const Icon(Icons.add)),
    );
  }
}
