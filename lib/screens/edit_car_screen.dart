import 'package:coil/models/cmodels.dart';
import 'package:coil/screens/cars_menu_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditCarScreen extends StatelessWidget {
  EditCarScreen({
    required String id,
    this.oldCarName = "",
    this.oldEngOilName = "",
    this.oldGearOilName = "",
    this.oldOdometerKM = "",
  });
  late String oldCarName;
  late String oldEngOilName;
  late String oldOdometerKM;
  late String oldGearOilName;

  String editCarName = "";
  String editEngOilName = "";
  String editOdometerKM = "";
  String editGearOilName = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      child: Container(
        padding: EdgeInsets.all(30.0),
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Edit",
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.blueGrey,
                  fontFamily: 'Righteous'),
            ),
            TextField(
              style: TextStyle(color: Colors.white54),
              autofocus: false,
              cursorColor: Colors.blueGrey,
              decoration: InputDecoration(
                hintText: "Car Name",
                border: UnderlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                label: Text(
                  oldCarName,
                  style: TextStyle(
                    fontFamily: 'Righteous',
                    color: Colors.blueGrey,
                  ),
                ),
              ),
              textAlign: TextAlign.center,
              onChanged: (newValue) {
                editCarName = newValue;
              },
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              style: TextStyle(color: Colors.white54),
              autofocus: false,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "car engine oil name",
                label: Text(
                  oldEngOilName,
                  style: TextStyle(
                    fontFamily: 'Righteous',
                    color: Colors.blueGrey,
                  ),
                ),
              ),
              textAlign: TextAlign.center,
              onChanged: (newValue) {
                editEngOilName = newValue;
              },
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              style: TextStyle(color: Colors.white54),
              autofocus: false,
              maxLength: 6,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "odometer reading in KM",
                label: Text(
                  oldOdometerKM,
                  style: TextStyle(
                    fontFamily: 'Righteous',
                    color: Colors.blueGrey,
                  ),
                ),
              ),
              textAlign: TextAlign.center,
              onChanged: (newValue) {
                editOdometerKM = newValue;
              },
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              style: TextStyle(color: Colors.white54),
              autofocus: false,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "car gear oil name",
                label: Text(
                  oldGearOilName,
                  style: TextStyle(
                    fontFamily: 'Righteous',
                    color: Colors.blueGrey,
                  ),
                ),
              ),
              textAlign: TextAlign.center,
              onChanged: (newValue) {
                editGearOilName = newValue;
              },
            ),
            SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () async {
                updateCar(oldCarName, editCarName, editEngOilName,
                    editGearOilName, editOdometerKM);
                Navigator.pop(context);
              },
              child: Text(
                "SAVE",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Righteous',
                ),
              ),
              style: TextButton.styleFrom(
                backgroundColor: Colors.blueGrey,
                fixedSize: Size(400, 40),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
