import 'package:basic_sqflite/DB/catTime_handler.dart';
import 'package:basic_sqflite/Model/catTime.dart';
import 'package:basic_sqflite/Screen/catImage_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CatTimeScreen extends StatefulWidget {
  final int catProId;
  const CatTimeScreen({Key? key, required this.catProId}) : super(key: key);

  @override
  _CatTimeScreenState createState() => _CatTimeScreenState();
}

class _CatTimeScreenState extends State<CatTimeScreen> {
  CatTimeHelper? dbHelper;
  late Future<List<CatTimeModel>> notesList;
  final formatDay = DateFormat('dd/MM/yyyy hh:mm a');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbHelper = new CatTimeHelper();
    loadData();
    // NotesModel(title: "User00",age: 22,description: "Default user",email: "User@exemple.com");
  }

  loadData() async {
    notesList = dbHelper!.getCatTimeListWithCatProID(widget.catProId);
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
                builder: (context, AsyncSnapshot<List<CatTimeModel>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        reverse: false,
                        shrinkWrap: true,
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => CatImageScreen(
                                      idPro: widget.catProId,
                                      idTime: snapshot.data![index].id!)));
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
                                      .deleteCatTime(snapshot.data![index].id!);
                                  notesList = dbHelper!
                                      .getCatTimeListWithCatProID(
                                          widget.catProId);
                                  snapshot.data!.remove(snapshot.data![index]);
                                });
                              },
                              key: ValueKey<int>(snapshot.data![index].id!),
                              child: Card(
                                child: ListTile(
                                  contentPadding: EdgeInsets.all(0),
                                  title: Text(formatDay.format(DateTime.parse(
                                      snapshot.data![index].date))),
                                  subtitle: Text(
                                      snapshot.data![index].note.toString()),
                                  trailing: IconButton(
                                      onPressed: () {
                                        dbHelper!.updateCatTime(CatTimeModel(
                                            id: snapshot.data![index].id!,
                                            idPro: widget.catProId,
                                            bodyLenght: 10,
                                            heartGirth: 10,
                                            hearLenghtSide: 10,
                                            hearLenghtRear: 10,
                                            hearLenghtTop: 10,
                                            pixelReference: 10,
                                            distanceReference: 10,
                                            imageSide: 10,
                                            imageRear: 10,
                                            imageTop: 10,
                                            date: DateTime.now()
                                                .toIso8601String(),
                                            note: "New update"));

                                        setState(() {
                                          notesList = dbHelper!
                                              .getCatTimeListWithCatProID(
                                                  widget.catProId);
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
            dbHelper!
                .insert(CatTimeModel(
                    idPro: widget.catProId,
                    bodyLenght: 0,
                    heartGirth: 0,
                    hearLenghtSide: 0,
                    hearLenghtRear: 0,
                    hearLenghtTop: 0,
                    pixelReference: 0,
                    distanceReference: 0,
                    imageSide: 0,
                    imageRear: 0,
                    imageTop: 0,
                    date: DateTime.now().toIso8601String(),
                    note: "New create"))
                .then((value) {
              print("Add data completed");
              setState(() {
                notesList =
                    dbHelper!.getCatTimeListWithCatProID(widget.catProId);
              });
              notesList = dbHelper!.getCatTimeListWithCatProID(widget.catProId);
            }).onError((error, stackTrace) {
              print("Error: " + error.toString());
            });
          },
          child: const Icon(Icons.add)),
    );
  }
}
