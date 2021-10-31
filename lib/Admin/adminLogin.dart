import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Admin/uploadItems.dart';
import 'package:e_shop/Authentication/authenication.dart';
import 'package:e_shop/Widgets/customTextField.dart';
import 'package:e_shop/DialogBox/errorDialog.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AdminSignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: new LinearGradient(
                colors: [Colors.purple, Colors.blue],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
        ),
        title: Text(
          "Online Shopping",
          style: TextStyle(
              fontSize: 55, color: Colors.white, fontFamily: "Signatra"),
        ),
        centerTitle: true,
      ),
      body: AdminSignInScreen(),
    );
  }
}

class AdminSignInScreen extends StatefulWidget {
  @override
  _AdminSignInScreenState createState() => _AdminSignInScreenState();
}

class _AdminSignInScreenState extends State<AdminSignInScreen> {
  final TextEditingController adminIDController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width,
        screenHight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          gradient: new LinearGradient(
              colors: [Colors.purple, Colors.blue],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                "images/admin.png",
                height: 240,
                width: 240,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                "Admin",
                style: TextStyle(
                    color: Colors.white, fontSize: 50, fontFamily: "Signatra"),
              ),
            ),
            Form(
              key: formkey,
              child: Column(
                children: [
                  CustomTextField(
                    controller: adminIDController,
                    data: Icons.person,
                    hintText: "Admin Id",
                    isObsecure: false,
                  ),
                  CustomTextField(
                    controller: passwordController,
                    data: Icons.password,
                    hintText: "Password",
                    isObsecure: true,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.purple,
                      textStyle:
                          TextStyle(fontSize: 40, fontFamily: "Signatra"),
                    ),
                    onPressed: () {
                      adminIDController.text.isNotEmpty &&
                              passwordController.text.isNotEmpty
                          ? loginAdmin()
                          : showDialog(
                              context: context,
                              builder: (BuildContext) {
                                return ErrorAlertDialog(
                                  message: "Please File Above Fields",
                                );
                              });
                    },
                    child: Text("Login"),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 4.0,
                    width: screenWidth * 0.8,
                    color: Colors.pink,
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  ElevatedButton.icon(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AuthenticScreen())),
                      icon: Icon(Icons.nature_people_sharp),
                      label: Text(
                        "I'm Not an Admin",
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.pink,
                            fontFamily: "Signatra"),
                      )),
                  SizedBox(
                    height: 50.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  loginAdmin() async {
    await FirebaseFirestore.instance
        .collection("admins")
        .doc("Ek5PO2jlXeAW9SBBO5BV")
        .get()
        .then((snapshot) {
      final Map<String, dynamic> data = snapshot.data();
      print(data["id"]);
      if (data["id"] != adminIDController.text &&
          data["password"] != passwordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Admin Id or Password is Incorrect"),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Welcome Dear Admin! " + data["name"]),
          ),
        );
        Route route =
            MaterialPageRoute(builder: (BuildContext) => UploadPage());
        Navigator.pushReplacement(context, route);
        setState(() {
          adminIDController.clear();
          passwordController.clear();
        });
      }
    });
  }
}
