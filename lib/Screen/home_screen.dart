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
  late Future<List<NotesModel>> notesList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbHelper = new DBHelper();
    loadData();
    // NotesModel(title: "User00",age: 22,description: "Default user",email: "User@exemple.com");
  }

  loadData() async {
    notesList = dbHelper!.getCartListWithUserId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes SQL"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: notesList,
                builder: (context, AsyncSnapshot<List<NotesModel>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        reverse: false,
                        shrinkWrap: true,
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: (){
                              dbHelper!.updateQuantity(
                                NotesModel(
                                  id: snapshot.data![index].id!,
                                  title: "User03_Update",
                                  age: 29,
                                  description: "Update Data",
                                  email: "userUpdate@example.com")
                              );

                              setState(() {
                                notesList = dbHelper!.getCartListWithUserId();
                              });
                            },
                            child: Dismissible(
                              direction: DismissDirection.endToStart,
                              background: Container(
                                  color: Colors.red,
                                  alignment: Alignment.centerRight,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Icon(Icons.delete_forever)),
                              onDismissed: (DismissDirection direction) {
                                setState(() {
                                  dbHelper!
                                      .deleteProduct(snapshot.data![index].id!);
                                  notesList = dbHelper!.getCartListWithUserId();
                                  snapshot.data!
                                      .remove(snapshot.data![index]);
                                });
                              },
                              key: ValueKey<int>(snapshot.data![index].id!),
                              child: Card(
                                child: ListTile(
                                  contentPadding: EdgeInsets.all(0),
                                  title: Text(
                                      snapshot.data![index].title.toString()),
                                  subtitle: Text(snapshot.data![index].description
                                      .toString()),
                                  trailing:
                                      Text(snapshot.data![index].age.toString()),
                                ),
                              ),
                            ),
                          );
                        });
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            dbHelper!
                .insert(NotesModel(
                    title: "User02",
                    age: 23,
                    description: "first user",
                    email: "user@example.com"))
                .then((value) {
              print("Add data completed");
              setState(() {
                notesList = dbHelper!.getCartListWithUserId();
              });
              notesList = dbHelper!.getCartListWithUserId();
            }).onError((error, stackTrace) {
              print("Error: " + error.toString());
            });
          },
          child: const Icon(Icons.add)),
    );
  }
}
