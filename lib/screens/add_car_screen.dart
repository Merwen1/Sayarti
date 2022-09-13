import 'package:coil/models/cmodels.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddCarScreen extends StatelessWidget {
  late String newCarName;
  late String engOilName;
  late String odometerKM;
  late String gearOilName;

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
              "Add Car",
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
                  "Car Name",
                  style: TextStyle(
                    fontFamily: 'Righteous',
                    color: Colors.blueGrey,
                  ),
                ),
              ),
              textAlign: TextAlign.center,
              onChanged: (newValue) {
                newCarName = newValue;
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
                  "Engine Oil",
                  style: TextStyle(
                    fontFamily: 'Righteous',
                    color: Colors.blueGrey,
                  ),
                ),
              ),
              textAlign: TextAlign.center,
              onChanged: (newValue) {
                engOilName = newValue;
              },
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              style: TextStyle(color: Colors.white54),
              autofocus: false,
              keyboardType: TextInputType.number,
              maxLength: 6,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "odometer reading in KM",
                label: Text(
                  "Odometer Reading",
                  style: TextStyle(
                    fontFamily: 'Righteous',
                    color: Colors.blueGrey,
                  ),
                ),
              ),
              textAlign: TextAlign.center,
              onChanged: (newValue) {
                odometerKM = newValue;
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
                  "Gear Oil",
                  style: TextStyle(
                    fontFamily: 'Righteous',
                    color: Colors.blueGrey,
                  ),
                ),
              ),
              textAlign: TextAlign.center,
              onChanged: (newValue) {
                gearOilName = newValue;
              },
            ),
            SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () async {
                addCar(newCarName, engOilName, odometerKM, gearOilName);
                Navigator.pop(context);
              },
              child: Text(
                "ADD",
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
