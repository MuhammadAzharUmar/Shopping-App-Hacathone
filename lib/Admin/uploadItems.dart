import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Admin/adminShiftOrders.dart';
import 'package:e_shop/Widgets/loadingWidget.dart';
import 'package:e_shop/main.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as ImD;

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage>
    with AutomaticKeepAliveClientMixin<UploadPage> {
  bool get wantKeepAlive => true;
  File imageFile;
  String imageFilePath;
  TextEditingController descController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController shortInfoController = TextEditingController();
  String productid = DateTime.now().microsecondsSinceEpoch.toString();
  bool uploading = false;

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return imageFile == null
        ? displayAdminHomeScreen()
        : displayAdminUploadScreen();
  }

  displayAdminHomeScreen() {
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
        leading: IconButton(
          onPressed: () {
            Route route = MaterialPageRoute(
                builder: (BuildContext) => AdminShiftOrders());
            Navigator.pushReplacement(context, route);
          },
          icon: Icon(
            Icons.border_color,
            color: Colors.lightGreenAccent,
          ),
        ),
        actions: [
          ElevatedButton(
              onPressed: () {
                Route route = MaterialPageRoute(
                    builder: (BuildContext) => SplashScreen());
                Navigator.pushReplacement(context, route);
              },
              child: Text(
                "Logout",
                style: TextStyle(
                    color: Colors.pink,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ))
        ],
      ),
      body: getHomeScreenBody(),
    );
  }

  getHomeScreenBody() {
    return Container(
      decoration: BoxDecoration(
        gradient: new LinearGradient(
            colors: [Colors.purple, Colors.blue],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shop_two,
              color: Colors.white,
              size: 200.0,
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9.0)),
                  primary: Colors.green,
                ),
                onPressed: () async {
                  await takeImage();
                },
                child: Text(
                  "Upload new Item",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  takeImage() async {
    await showDialog<bool>(
      context: context,
      builder: (BuildContext) {
        return SimpleDialog(
          title: Text(
            "Item Image",
            style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
          ),
          children: [
            SimpleDialogOption(
                child: Text(
                  "Pick From Gallery",
                  style: TextStyle(color: Colors.green),
                ),
                onPressed: () {
                  pickFromGallery();
                }),
            SimpleDialogOption(
                child: Text(
                  "Capture with Camera",
                  style: TextStyle(color: Colors.green),
                ),
                onPressed: () {
                  captureWithCamera();
                }),
            SimpleDialogOption(
              child: Text(
                "Cancel",
                style: TextStyle(color: Colors.green),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  captureWithCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        imageFile = File(pickedFile.path);
        imageFilePath = pickedFile.path;
      } else {
        print('No image selected.');
      }
    });
    Navigator.of(context).pop();
  }

  pickFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        imageFile = File(pickedFile.path);
        imageFilePath = pickedFile.path;
      } else {
        print('No image selected.');
      }
    });
    Navigator.of(context).pop();
  }

  displayAdminUploadScreen() {
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
        leading: IconButton(
          onPressed: () {
            clearFormInfo();
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
        ),
        actions: [
          ElevatedButton(
              onPressed: uploading
                  ? null
                  : () {
                      saveImageAndDataInfo();
                    },
              child: Text(
                "Add",
                style: TextStyle(
                    color: Colors.pink,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ))
        ],
      ),
      body: ListView(
        children: [
          uploading ? circularProgress() : Text(""),
          Container(
            height: 230,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Center(
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: FileImage(imageFile), fit: BoxFit.cover)),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 12),
          ),
          ListTile(
            leading: Icon(
              Icons.perm_device_information,
              color: Colors.pink,
            ),
            title: Container(
              width: 250,
              child: TextField(
                style: TextStyle(color: Colors.deepPurpleAccent),
                controller: shortInfoController,
                decoration: InputDecoration(
                  hintText: "Short Info",
                  hintStyle: TextStyle(color: Colors.deepPurpleAccent),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Divider(
            color: Colors.pink,
          ),
          ListTile(
            leading: Icon(
              Icons.perm_device_information,
              color: Colors.pink,
            ),
            title: Container(
              width: 250,
              child: TextField(
                style: TextStyle(color: Colors.deepPurpleAccent),
                controller: titleController,
                decoration: InputDecoration(
                  hintText: "Title",
                  hintStyle: TextStyle(color: Colors.deepPurpleAccent),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Divider(
            color: Colors.pink,
          ),
          ListTile(
            leading: Icon(
              Icons.perm_device_information,
              color: Colors.pink,
            ),
            title: Container(
              width: 250,
              child: TextField(
                style: TextStyle(color: Colors.deepPurpleAccent),
                controller: descController,
                decoration: InputDecoration(
                  hintText: "Description",
                  hintStyle: TextStyle(color: Colors.deepPurpleAccent),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Divider(
            color: Colors.pink,
          ),
          ListTile(
            leading: Icon(
              Icons.perm_device_information,
              color: Colors.pink,
            ),
            title: Container(
              width: 250,
              child: TextField(
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.deepPurpleAccent),
                controller: priceController,
                decoration: InputDecoration(
                  hintText: "Price",
                  hintStyle: TextStyle(color: Colors.deepPurpleAccent),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Divider(
            color: Colors.pink,
          ),
        ],
      ),
    );
  }

  clearFormInfo() {
    setState(() {
      imageFile = null;
      descController.clear();
      titleController.clear();
      shortInfoController.clear();
      priceController.clear();
    });
  }

  saveImageAndDataInfo() async {
    setState(() {
      uploading = true;
    });
    String downloadUrl = await uploadItemImage(imageFilePath);
    saveItemInfo(downloadUrl);
  }

  Future<String> uploadItemImage(mfileImage) async {
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref("Product $productid.jpg")
        .child("Items");
    File file = File(mfileImage);
    await ref.putFile(file);
    String downloadURL = await ref.getDownloadURL();
    return downloadURL;
  }

  saveItemInfo(String downloadUrl) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore.collection("Items").doc(productid).set({
      "title": titleController.text,
      "shortInfo": shortInfoController.text,
      "publishedDate": DateTime.now(),
      "thumbnailUrl": downloadUrl,
      "longDescription": descController.text,
      "status": "Available",
      "price": int.parse(priceController.text),
    });
    setState(() {
      uploading = false;
      imageFile = null;
      productid = DateTime.now().microsecondsSinceEpoch.toString();
      titleController.clear();
      descController.clear();
      shortInfoController.clear();
      priceController.clear();
    });
  }
}
