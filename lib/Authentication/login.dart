import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Admin/adminLogin.dart';
import 'package:e_shop/Widgets/customTextField.dart';
import 'package:e_shop/DialogBox/errorDialog.dart';
import 'package:e_shop/DialogBox/loadingDialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Store/storehome.dart';
import 'package:e_shop/Config/config.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width,
        screenHight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                "images/login.png",
                height: 240,
                width: 240,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                "Login To Your Account",
                style: TextStyle(color: Colors.white),
              ),
            ),
            Form(
              key: formkey,
              child: Column(
                children: [
                  CustomTextField(
                    controller: emailController,
                    data: Icons.email,
                    hintText: "Email",
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
                      emailController.text.isNotEmpty &&
                              passwordController.text.isNotEmpty
                          ? loginUser()
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
                    height: 10.0,
                  ),
                  ElevatedButton.icon(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AdminSignInPage())),
                      icon: Icon(Icons.nature_people_sharp),
                      label: Text(
                        "I'm Admin",
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.pink,
                            fontFamily: "Signatra"),
                      )),
                  SizedBox(
                    height: 30.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  FirebaseAuth auth = FirebaseAuth.instance;
  loginUser() async {
    showDialog(
        context: context,
        builder: (BuildContext) {
          return LoadingAlertDialog(
            message: "Authenticating! Please wait...",
          );
        });
    try {
      final UserCredential firebaseUser = await auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      await readDara(firebaseUser);
      Navigator.pop(context);
      Route route = MaterialPageRoute(builder: (BuildContext) => StoreHome());
      Navigator.pushReplacement(context, route);
    } on FirebaseException catch (e) {
      showDialog(
          context: context,
          builder: (BuildContext) {
            return ErrorAlertDialog(
              message: e.message,
            );
          });
    }
  }

  readDara(UserCredential firebaseUser) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // final DocumentSnapshot snapshot =
    await firestore
        .collection("users")
        .doc(firebaseUser.user.uid)
        .get()
        .then((dataSnapshot) async {
      final Map<String, dynamic> data = dataSnapshot.data();
      await EcommerceApp.sharedPreferences
          .setString(EcommerceApp.userUID, data["uid"]);
      await EcommerceApp.sharedPreferences
          .setString(EcommerceApp.userEmail, data["email"]);
      await EcommerceApp.sharedPreferences
          .setString(EcommerceApp.userName, data["name"]);
      await EcommerceApp.sharedPreferences
          .setString(EcommerceApp.userAvatarUrl, data["picURL"]);
      List<String> cartlist = data["userCart"].cast<String>();
      await EcommerceApp.sharedPreferences
          .setStringList(EcommerceApp.userCartList, cartlist);
    });
  }
}
