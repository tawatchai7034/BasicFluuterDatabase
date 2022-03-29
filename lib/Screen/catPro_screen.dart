import 'package:basic_sqflite/DB/catPro_handler.dart';
import 'package:basic_sqflite/DB/catTime_handler.dart';
import 'package:basic_sqflite/Model/catPro.dart';
import 'package:basic_sqflite/Screen/catPro_Create.dart';
import 'package:basic_sqflite/Screen/catTime_screen.dart';
import 'package:flutter/material.dart';

class CatProScreen extends StatefulWidget {
  const CatProScreen({Key? key}) : super(key: key);

  @override
  _CatProScreenState createState() => _CatProScreenState();
}

class _CatProScreenState extends State<CatProScreen> {
  CatProHelper? dbHelper;
  CatTimeHelper? dbCatTime;
  late Future<List<CatProModel>> notesList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbHelper = new CatProHelper();
    dbCatTime = new CatTimeHelper();
    loadData();
    // NotesModel(title: "User00",age: 22,description: "Default user",email: "User@exemple.com");
  }

  loadData() async {
    notesList = dbHelper!.getCatProList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cattle SQL"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: notesList,
                builder: (context, AsyncSnapshot<List<CatProModel>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        reverse: false,
                        shrinkWrap: true,
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => CatTimeScreen(
                                      catProId: snapshot.data![index].id!)));
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
                                  // delete row in catpro table with snapshot.data![index].id!
                                  dbHelper!
                                      .deleteCatPro(snapshot.data![index].id!);
                                    
                                  // delete row in cattime table with snapshot.data![index].id!
                                  dbCatTime!.deleteCatTimeWithIdPro(snapshot.data![index].id!);
                                  notesList = dbHelper!.getCatProList();
                                  snapshot.data!.remove(snapshot.data![index]);
                                });
                              },
                              key: ValueKey<int>(snapshot.data![index].id!),
                              child: Card(
                                child: ListTile(
                                  contentPadding: EdgeInsets.all(0),
                                  title: Text(
                                      snapshot.data![index].name.toString()),
                                  subtitle: Text(
                                      "Gender: ${snapshot.data![index].gender.toString()}\nSpecies: ${snapshot.data![index].species.toString()}"),
                                  trailing: IconButton(
                                      onPressed: () {
                                        dbHelper!.updateCatPro(CatProModel(
                                          id: snapshot.data![index].id!,
                                          name: "cattle01",
                                          gender: "female",
                                          species: "barhman",
                                        ));

                                        setState(() {
                                          notesList = dbHelper!.getCatProList();
                                        });
                                      },
                                      icon: Icon(Icons.edit)),
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
             Navigator.of(context).push(MaterialPageRoute(builder: (context)=> CatProFormCreate()));
            // dbHelper!
            //     .insert(CatProModel(
            //   name: "cattle02",
            //   gender: "male",
            //   species: "angus",
            // ))
            //     .then((value) {
            //   print("Add data completed");
            //   setState(() {
            //     notesList = dbHelper!.getCatProList();
            //   });
            //   notesList = dbHelper!.getCatProList();
            // }).onError((error, stackTrace) {
            //   print("Error: " + error.toString());
            // });
          },
          child: const Icon(Icons.add)),
    );
  }
}
