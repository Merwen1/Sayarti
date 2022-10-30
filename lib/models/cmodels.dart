import 'dart:collection';
import 'package:coil/components/constants.dart';
import 'package:coil/screens/cars_menu_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



List<Map> cars = <Map>[];

void addCar(
    String carName, String engName, String odometerKM, String gearName) async {
  CollectionReference carsData =
      FirebaseFirestore.instance.collection("carsData");
  final Map car = {"Car Name": carName};
  cars.add(car);

  carsData.add({
    'uid': loggedInUser.uid,
    'date': Timestamp.now(),
    'CarName': carName,
    'EngineOilName': engName,
    'OdometerReading': odometerKM,
    'GearOilName': gearName
  });
  carsData.doc(loggedInUser.uid);
}

register() async {
  await FirebaseAuth.instance
      .createUserWithEmailAndPassword(email: email, password: password);
}

signin() async {
  await FirebaseAuth.instance
      .signInWithEmailAndPassword(email: email, password: password)
      .then(
        (value) => print("dooooonnnnnnneeeeee"),
      );
}

Future deleteCar(String nameCar) async {
  String cardID = await FirebaseFirestore.instance
      .collection('carsData')
      .where('uid', isEqualTo: loggedInUser.uid)
      .where('CarName', isEqualTo: nameCar)
      .limit(1)
      .get()
      .then((value) => value.docs.first.id);
  print(cardID + '+asdfasdf');
  try {
    await FirebaseFirestore.instance
        .collection('carsData')
        .doc(cardID)
        .delete();
  } catch (e) {
    return false;
  }
}

Future updateCar(String oldNameCar, String newNameCar, String newEngOil,
    String newGearOil, String newOdometer) async {
  String cardID = await FirebaseFirestore.instance
      .collection('carsData')
      .where('uid', isEqualTo: loggedInUser.uid)
      .where('CarName', isEqualTo: oldNameCar)
      .limit(1)
      .get()
      .then((value) => value.docs.first.id);
  print(cardID + '+asdfasdf');
  try {
    if (newNameCar != "") {
      await FirebaseFirestore.instance
          .collection('carsData')
          .doc(cardID)
          .update({'CarName': newNameCar});
    }
    if (newEngOil != "") {
      await FirebaseFirestore.instance
          .collection('carsData')
          .doc(cardID)
          .update({'EngineOilName': newEngOil});
    }
    if (newGearOil != "") {
      await FirebaseFirestore.instance
          .collection('carsData')
          .doc(cardID)
          .update({'GearOilName': newGearOil});
    }
    if (newOdometer != "") {
      await FirebaseFirestore.instance
          .collection('carsData')
          .doc(cardID)
          .update({'OdometerReading': newOdometer});
    }
  } catch (e) {
    return false;
  }
}
