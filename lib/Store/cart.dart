import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Config/config.dart';
import 'package:e_shop/Address/address.dart';
import 'package:e_shop/Widgets/customAppBar.dart';
import 'package:e_shop/Widgets/loadingWidget.dart';
import 'package:e_shop/Models/item.dart';
import 'package:e_shop/Counters/cartitemcounter.dart';
import 'package:e_shop/Counters/totalMoney.dart';
import 'package:e_shop/Widgets/myDrawer.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:e_shop/Store/storehome.dart';
import 'package:provider/provider.dart';
import '../main.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    EcommerceApp.userCartList.length;
    return Scaffold(
      appBar: MyAppBar(),
      drawer: MyDrawer(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                leading: Image.network(
                  "https://i.gadgets360cdn.com/products/large/micromax-in-2b-1-414x800-1627626668.jpg?downsize=240:*&output-quality=80&output-format=webp",
                  height: 140,
                  width: 140,
                ),
                title: Row(
                  children: [
                    Text(
                      "Phone",
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Text(
                      "Rs:/-  15000",
                      style: TextStyle(fontSize: 12, color: Colors.red),
                    ),
                  ],
                ),
                subtitle: Text(
                  "Brand New Phone",
                  style: TextStyle(fontSize: 12),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                color: Colors.pink,
                thickness: 1,
              ),
              ListTile(
                leading: Image.network(
                  "https://i.gadgets360cdn.com/products/large/micromax-in-2b-1-414x800-1627626668.jpg?downsize=240:*&output-quality=80&output-format=webp",
                  height: 140,
                  width: 140,
                ),
                title: Row(
                  children: [
                    Text(
                      "Phone",
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Text(
                      "Rs:/-  15000",
                      style: TextStyle(fontSize: 12, color: Colors.red),
                    ),
                  ],
                ),
                subtitle: Text(
                  "Brand New Phone",
                  style: TextStyle(fontSize: 12),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                color: Colors.pink,
                thickness: 1,
              ),
              ListTile(
                leading: Image.network(
                  "https://i.gadgets360cdn.com/products/large/micromax-in-2b-1-414x800-1627626668.jpg?downsize=240:*&output-quality=80&output-format=webp",
                  height: 140,
                  width: 140,
                ),
                title: Row(
                  children: [
                    Text(
                      "Phone",
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Text(
                      "Rs:/-  15000",
                      style: TextStyle(fontSize: 12, color: Colors.red),
                    ),
                  ],
                ),
                subtitle: Text(
                  "Brand New Phone",
                  style: TextStyle(fontSize: 12),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                color: Colors.pink,
                thickness: 1,
              ),
              ListTile(
                leading: Image.network(
                  "https://i.gadgets360cdn.com/products/large/micromax-in-2b-1-414x800-1627626668.jpg?downsize=240:*&output-quality=80&output-format=webp",
                  height: 140,
                  width: 140,
                ),
                title: Row(
                  children: [
                    Text(
                      "Phone",
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Text(
                      "Rs:/-  15000",
                      style: TextStyle(fontSize: 12, color: Colors.red),
                    ),
                  ],
                ),
                subtitle: Text(
                  "Brand New Phone",
                  style: TextStyle(fontSize: 12),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                color: Colors.pink,
                thickness: 1,
              ),
              ListTile(
                leading: Image.network(
                  "https://i.gadgets360cdn.com/products/large/micromax-in-2b-1-414x800-1627626668.jpg?downsize=240:*&output-quality=80&output-format=webp",
                  height: 140,
                  width: 140,
                ),
                title: Row(
                  children: [
                    Text(
                      "Phone",
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Text(
                      "Rs:/-  15000",
                      style: TextStyle(fontSize: 12, color: Colors.red),
                    ),
                  ],
                ),
                subtitle: Text(
                  "Brand New Phone",
                  style: TextStyle(fontSize: 12),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                color: Colors.pink,
                thickness: 1,
              ),
              ListTile(
                leading: Image.network(
                  "https://i.gadgets360cdn.com/products/large/micromax-in-2b-1-414x800-1627626668.jpg?downsize=240:*&output-quality=80&output-format=webp",
                  height: 140,
                  width: 140,
                ),
                title: Row(
                  children: [
                    Text(
                      "Phone",
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Text(
                      "Rs:/-  15000",
                      style: TextStyle(fontSize: 12, color: Colors.red),
                    ),
                  ],
                ),
                subtitle: Text(
                  "Brand New Phone",
                  style: TextStyle(fontSize: 12),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                color: Colors.pink,
                thickness: 1,
              ),
              ListTile(
                leading: Image.network(
                  "https://i.gadgets360cdn.com/products/large/micromax-in-2b-1-414x800-1627626668.jpg?downsize=240:*&output-quality=80&output-format=webp",
                  height: 140,
                  width: 140,
                ),
                title: Row(
                  children: [
                    Text(
                      "Phone",
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Text(
                      "Rs:/-  15000",
                      style: TextStyle(fontSize: 12, color: Colors.red),
                    ),
                  ],
                ),
                subtitle: Text(
                  "Brand New Phone",
                  style: TextStyle(fontSize: 12),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                color: Colors.pink,
                thickness: 1,
              ),
              ListTile(
                leading: Image.network(
                  "https://i.gadgets360cdn.com/products/large/micromax-in-2b-1-414x800-1627626668.jpg?downsize=240:*&output-quality=80&output-format=webp",
                  height: 140,
                  width: 140,
                ),
                title: Row(
                  children: [
                    Text(
                      "Phone",
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Text(
                      "Rs:/-  15000",
                      style: TextStyle(fontSize: 12, color: Colors.red),
                    ),
                  ],
                ),
                subtitle: Text(
                  "Brand New Phone",
                  style: TextStyle(fontSize: 12),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                color: Colors.pink,
                thickness: 1,
              ),
              ListTile(
                leading: Image.network(
                  "https://i.gadgets360cdn.com/products/large/micromax-in-2b-1-414x800-1627626668.jpg?downsize=240:*&output-quality=80&output-format=webp",
                  height: 140,
                  width: 140,
                ),
                title: Row(
                  children: [
                    Text(
                      "Phone",
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Text(
                      "Rs:/-  15000",
                      style: TextStyle(fontSize: 12, color: Colors.red),
                    ),
                  ],
                ),
                subtitle: Text(
                  "Brand New Phone",
                  style: TextStyle(fontSize: 12),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                color: Colors.pink,
                thickness: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
