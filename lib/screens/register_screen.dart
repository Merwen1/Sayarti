import 'package:coil/models/cmodels.dart';
import 'package:coil/screens/cars_menu_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:coil/components/constants.dart';

var confirmpass;
final _formKey = GlobalKey<FormState>();

class RegisterScreen extends StatelessWidget {
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
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Sign Up',
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
                  Icons.account_circle,
                  color: Colors.blueGrey,
                  size: 90,
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blueGrey, width: 4),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        )),
                    hintText: "Enter Your Email",
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
                        borderSide:
                            BorderSide(color: Colors.blueGrey, width: 2)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  onChanged: (value) {
                    password = value;
                  },
                  validator: (value) {
                    confirmpass = value;
                    if (value!.isEmpty) {
                      return "please enter new password";
                    } else if (value.length < 8) {
                      return "Password must be at least 8 characters";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    hintText: "Password",
                    prefixIcon: Icon(
                      Icons.key,
                      color: Colors.blueGrey,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey, width: 4),
                    ),
                    border: UnderlineInputBorder(borderSide: BorderSide.none),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey, width: 2),
                    ),
                  ),
                  obscureText: true,
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Re-Enter New Password";
                    } else if (value.length < 8) {
                      return "Password must be at least 8 characters";
                    } else if (value != confirmpass) {
                      return "Password must be same as above";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    hintText: "Confirm Password",
                    prefixIcon: Icon(
                      Icons.key,
                      color: Colors.blueGrey,
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blueGrey, width: 4),
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
                        borderSide:
                            BorderSide(color: Colors.blueGrey, width: 2)),
                  ),
                  obscureText: true,
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 40,
                  width: 150,
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
                        if (_formKey.currentState!.validate()) {
                          try {
                            final newuser = await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                    email: email, password: password);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CarsMenu()));
                          } catch (e) {
                            AlertDialog(
                                title: Text("Failed Login"),
                                content: Text("Wrong Email or Password."));
                          }
                        }
                      },
                      child: Text(
                        "REGISTER",
                        style: TextStyle(
                          fontFamily: 'Righteous',
                          fontSize: 17,
                          letterSpacing: 1,
                          color: Colors.black,
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
