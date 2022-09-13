import 'package:coil/models/cmodels.dart';
import 'package:coil/screens/cars_menu_screen.dart';
import 'package:coil/screens/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:coil/components/constants.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Sayarti",
          style: TextStyle(
            color: Colors.blueGrey,
            fontFamily: 'Righteous',
            fontSize: 35,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'User Login',
              style: TextStyle(
                fontFamily: 'Righteous',
                color: Colors.blueGrey,
                fontSize: 28,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Icon(
              Icons.login,
              color: Colors.blueGrey,
              size: 70,
            ),
            TextField(
              onChanged: (value) {
                email = value;
              },
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey, width: 4),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    )),
                hintText: "Email",
                prefixIcon: Icon(
                  Icons.email_outlined,
                  color: Colors.blueGrey,
                ),
                border: UnderlineInputBorder(borderSide: BorderSide.none),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    borderSide: BorderSide(color: Colors.blueGrey, width: 2)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              onChanged: (value) {
                password = value;
              },
              decoration: InputDecoration(
                hintText: "Password",
                prefixIcon: Icon(
                  Icons.key,
                  color: Colors.blueGrey,
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey, width: 4),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    )),
                border: UnderlineInputBorder(borderSide: BorderSide.none),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    borderSide: BorderSide(color: Colors.blueGrey, width: 2)),
              ),
              obscureText: true,
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 150,
              height: 40,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                  elevation: 30,
                  side: BorderSide(
                    color: Colors.black,
                    width: 1,
                  ),
                  shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                ),
                onPressed: () async {
                  try {
                    final user = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: email, password: password);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CarsMenu()));
                  } catch (e) {
                    Alert(
                            context: context,
                            title: "Failed Login",
                            desc: "Incorrect Email Or Password.")
                        .show();
                    // AlertDialog(
                    //   title: Text("Failed Login"),
                    //   content: Text("Wrong Email or Password."),
                    // );
                  }
                },
                child: Text(
                  "LOGIN",
                  style: TextStyle(
                    fontFamily: 'Righteous',
                    fontSize: 17,
                    letterSpacing: 1,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              child: Text("dont have account ?"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
