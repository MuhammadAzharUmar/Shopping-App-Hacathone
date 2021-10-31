import 'dart:ffi';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Widgets/customTextField.dart';
import 'package:e_shop/DialogBox/errorDialog.dart';
import 'package:e_shop/DialogBox/loadingDialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../Store/storehome.dart';
import 'package:e_shop/Config/config.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cpasswordController = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  String userImageUrl = "";
  File imageFile;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width,
        screenHight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: 8.0,
            ),
            InkWell(
              onTap: selectAndPickImage,
              child: CircleAvatar(
                radius: screenWidth * 0.15,
                backgroundColor: Colors.white,
                backgroundImage:
                    imageFile == null ? null : FileImage(imageFile),
                child: imageFile == null
                    ? Icon(
                        Icons.add_a_photo_sharp,
                        size: screenWidth * 0.15,
                        color: Colors.grey,
                      )
                    : null,
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Form(
              key: formkey,
              child: Column(
                children: [
                  CustomTextField(
                    controller: nameController,
                    data: Icons.person,
                    hintText: "Name",
                    isObsecure: false,
                  ),
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
                  CustomTextField(
                    controller: cpasswordController,
                    data: Icons.password,
                    hintText: "Confirm Password",
                    isObsecure: true,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.purple,
                textStyle: TextStyle(fontSize: 40, fontFamily: "Signatra"),
              ),
              onPressed: () {
                uploadAndSaveData();
              },
              child: Text("Sign Up"),
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
              height: 15.0,
            )
          ],
        ),
      ),
    );
  }

  Future<void> selectAndPickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        imageFile = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> uploadAndSaveData() async {
    if (imageFile == null) {
      displayDialoge("Please Select An Image");
    } else {
      passwordController.text == cpasswordController.text
          ? emailController.text.isNotEmpty &&
                  nameController.text.isNotEmpty &&
                  passwordController.text.isNotEmpty &&
                  cpasswordController.text.isNotEmpty
              ? uploadToDatabase()
              : displayDialoge("Please Fill the COmplete FOrm.")
          : displayDialoge("Password do not match");
    }
  }

  uploadToDatabase() async {
    showDialog(
        context: context,
        builder: (BuildContext) {
          return LoadingAlertDialog(
            message: 'Registring, Please wait.....',
          );
        });
    String imageFileName = DateTime.now().microsecondsSinceEpoch.toString();
    String imaheFilePath = imageFile.path;
    firebase_storage.Reference ref =
        firebase_storage.FirebaseStorage.instance.ref(imageFileName);
    File file = File(imaheFilePath);
    await ref.putFile(file);
    String downloadURL = await ref.getDownloadURL();
    userImageUrl = downloadURL;
    registerUser();
  }

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  registerUser() async {
    String email = emailController.text;
    String password = passwordController.text;
    try {
      final UserCredential user = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await firestore.collection("users").doc(user.user.uid).set({
        "name": nameController.text,
        "uid": user.user.uid,
        "email": email,
        "picURL": userImageUrl,
        EcommerceApp.userCartList: ["garbageValue"],
      });

      await EcommerceApp.sharedPreferences
          .setString(EcommerceApp.userUID, user.user.uid);
      await EcommerceApp.sharedPreferences
          .setString(EcommerceApp.userEmail, email);
      await EcommerceApp.sharedPreferences
          .setString(EcommerceApp.userName, nameController.text);
      await EcommerceApp.sharedPreferences
          .setString(EcommerceApp.userAvatarUrl, userImageUrl);
      await EcommerceApp.sharedPreferences
          .setStringList(EcommerceApp.userCartList, ["garbageValue"]);

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

  displayDialoge(String msg) {
    showDialog(
        context: context,
        builder: (BuildContext) {
          return ErrorAlertDialog(
            message: msg,
          );
        });
  }
}
