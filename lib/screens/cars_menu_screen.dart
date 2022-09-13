import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coil/models/cmodels.dart';
import 'package:coil/screens/add_car_screen.dart';
import 'package:coil/screens/edit_car_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:coil/components/constants.dart';

late User loggedInUser;
late final userdata;
final _firestore = FirebaseFirestore.instance;

class CarsMenu extends StatefulWidget {
  @override
  State<CarsMenu> createState() => _CarsMenuState();
}

class _CarsMenuState extends State<CarsMenu> {
  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  Future<void> getCurrentUser() async {
    try {
      final user = await FirebaseAuth.instance.currentUser;
      // User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
        String loggedInUserUID = loggedInUser.uid;
        userdata = await FirebaseFirestore.instance
            .collection('carsData')
            .where('uid', isEqualTo: loggedInUserUID)
            .get();
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Sayarti",
          style: TextStyle(
            fontFamily: 'Righteous',
            color: Colors.blueGrey,
            fontSize: 35,
          ),
        ),
      ),
      body: Column(
        children: [
          CarsStream(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) => SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: AddCarScreen(),
                    ),
                  ));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blueGrey,
      ),
    );
  }
}

class CarsStream extends StatelessWidget {
  const CarsStream({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _firestore
            .collection('carsData')
            .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Padding(
                padding: EdgeInsets.only(top: 30),
                child: CircularProgressIndicator(
                  backgroundColor: Colors.black12,
                  color: Colors.blueGrey,
                ),
              ),
            );
          }
          final cars = snapshot.data!.docs;
          List<CarCard> carscards = [];
          for (var car in cars) {
            final carname = car['CarName'];
            final engineoilname = car['EngineOilName'];
            final gearoilname = car['GearOilName'];
            final odometerreading = car['OdometerReading'];
            final currentUser = loggedInUser.uid;
            final carcard = CarCard(
              name: carname,
              engname: engineoilname,
              gearname: gearoilname,
              odoreading: odometerreading,
              isMe: currentUser == car['uid'],
            );
            carscards.add(carcard);
          }
          return Expanded(
            child: ListView(
              reverse: false,
              children: carscards,
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
            ),
          );
        });
  }
}

class CarCard extends StatefulWidget {
  CarCard(
      {required this.name,
      required this.engname,
      required this.gearname,
      required this.odoreading,
      required this.isMe});

  final String name;
  final String engname;
  final String gearname;
  final String odoreading;
  final bool isMe;

  @override
  State<CarCard> createState() => _CarCardState();
}

class _CarCardState extends State<CarCard> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        child: Dismissible(
          key: UniqueKey(),
          direction: DismissDirection.startToEnd,
          background: Container(
            color: Colors.red,
            child: Row(
              children: [
                Icon(Icons.delete),
                Text(
                  '  Delete this car',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Righteous',
                  ),
                )
              ],
            ),
          ),
          confirmDismiss: (DismissDirection direction) async {
            return await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(
                      "Delete Confirmation",
                    ),
                    content: Text(
                      "Are you sure you want to delete this item?",
                    ),
                    actions: <Widget>[
                      TextButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: const Text(
                            "Delete",
                            style: TextStyle(color: Colors.red),
                          )),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text(
                          "Cancel",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  );
                });
          },
          onDismissed: (DismissDirection direction) async {
            if (direction == DismissDirection.startToEnd) {
              print('item deleted');
            }
            deleteCar(widget.name); //I want to get doc ID to delete it
          },
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.blueGrey,
                ),
                borderRadius: BorderRadius.circular(30)),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Car Name : ${widget.name}',
                        style: TextStyle(
                          fontFamily: 'Righteous',
                          fontSize: 20,
                          color: Colors.blueGrey,
                        ),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(
                        'Engine Oil : ${widget.engname}' +
                            '\n' +
                            'Gear Oil : ${widget.gearname}' +
                            '\n' +
                            'Odometer Reading : ${widget.odoreading}' +
                            '\n',
                        style: TextStyle(
                            fontFamily: 'Righteous',
                            fontSize: 15,
                            color: Colors.black),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 70),
                    child: IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (context) => SingleChildScrollView(
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom),
                                    child: EditCarScreen(
                                      id: 'asdfasdf',
                                      oldCarName: widget.name,
                                      oldEngOilName: widget.engname,
                                      oldGearOilName: widget.gearname,
                                      oldOdometerKM: widget.odoreading,
                                    ),
                                  ),
                                ));
                      },
                      icon: Icon(
                        Icons.edit_outlined,
                        size: 20,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
