import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Config/config.dart';
import 'package:e_shop/Address/address.dart';
import 'package:e_shop/Store/product_page.dart';
import 'package:e_shop/Widgets/customAppBar.dart';
import 'package:e_shop/Widgets/loadingWidget.dart';
import 'package:e_shop/Models/item.dart';
import 'package:e_shop/Counters/cartitemcounter.dart';
import 'package:e_shop/Counters/totalMoney.dart';
import 'package:e_shop/Widgets/myDrawer.dart';
import 'package:e_shop/Widgets/searchBox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:e_shop/Store/storehome.dart';
import 'package:provider/provider.dart';
import '../main.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List asz =
      EcommerceApp.sharedPreferences.getStringList(EcommerceApp.userCartList);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      drawer: MyDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: SearchBoxDelegate(),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("Items")
                .orderBy("publishedDate", descending: true)
                .snapshots(),
            builder: (context, dataSnapshot) {
              // allResult = dataSnapshot.data.docs;
              // print(allResult.length);
              return !dataSnapshot.hasData
                  ? SliverToBoxAdapter(
                      child: Center(
                      child: circularProgress(),
                    ))
                  : SliverStaggeredGrid.countBuilder(
                      crossAxisCount: 1,
                      staggeredTileBuilder: (context) => StaggeredTile.fit(1),
                      itemBuilder: (context, index) {
                        ItemModel model = ItemModel.fromJson(
                            dataSnapshot.data.docs[index].data());

                        return itemView(model, context);
                      },
                      itemCount: dataSnapshot.data.docs.length,
                    );
            },
          ),
        ],
      ),
    );
  }

  Widget itemView(ItemModel model, BuildContext context,
      {Color background, removeCartFunction}) {
    for (var i = 0; i < asz.length; i++) {
      if (asz[i] == model.shortInfo) {
        return sourceInfo(
          model,
          context,
        );
      }
    }
    return Text("");
  }

  Widget sourceInfo(ItemModel model, BuildContext context,
      {Color background, removeCartFunction}) {
    return InkWell(
      onTap: () {
        Route route = MaterialPageRoute(
            builder: (BuildContext) => ProductPage(itemModel: model));
        Navigator.pushReplacement(context, route);
      },
      splashColor: Colors.pink,
      child: Padding(
        padding: EdgeInsets.all(6),
        child: Container(
          height: 190,
          width: width,
          child: Row(
            children: [
              Image.network(
                model.thumbnailUrl,
                width: 140,
                height: 140,
              ),
              SizedBox(
                width: 4,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Text(
                              model.title,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Text(
                              model.shortInfo,
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle, color: Colors.pink),
                          alignment: Alignment.topLeft,
                          width: 40,
                          height: 43,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "50%",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white),
                                ),
                                Text(
                                  "OFF",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 0.0),
                              child: Row(
                                children: [
                                  Text(
                                    "Original Price ₨./- ",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                        decoration: TextDecoration.lineThrough),
                                  ),
                                  Text(
                                    (model.price + model.price).toString(),
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey,
                                        decoration: TextDecoration.lineThrough),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 0.0),
                              child: Row(
                                children: [
                                  Text(
                                    "New Price ",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.black),
                                  ),
                                  Text(
                                    "₨./- ",
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 14),
                                  ),
                                  Text(
                                    (model.price).toString(),
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black),
                                  )
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Flexible(child: Container()),
                    Align(
                      alignment: Alignment.centerRight,
                      child: removeCartFunction != null
                          ? IconButton(
                              onPressed: () {
                                // checkItemInCart(model.shortInfo, context);
                              },
                              icon: Icon(
                                Icons.add_shopping_cart,
                                color: Colors.pinkAccent,
                              ),
                            )
                          : IconButton(
                              onPressed: () async {
                                await removeeCartFunction(
                                    model.shortInfo, context);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            this.widget));
                              },
                              icon: Icon(
                                Icons.remove_shopping_cart,
                                color: Colors.pinkAccent,
                              ),
                            ),
                    ),
                    Divider(
                      height: 5,
                      color: Colors.black,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  removeeCartFunction(String shortInfoID, BuildContext context) async {
    List tempCartList =
        EcommerceApp.sharedPreferences.getStringList(EcommerceApp.userCartList);
    await tempCartList.remove(shortInfoID);
    await EcommerceApp.firestore
        .collection(EcommerceApp.collectionUser)
        .doc(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
        .update({
      await EcommerceApp.userCartList: tempCartList,
    }).then((v) {
      Fluttertoast.showToast(msg: "Item Removed From The Cart Successfully");
      EcommerceApp.sharedPreferences
          .setStringList(EcommerceApp.userCartList, tempCartList);
      Provider.of<CartItemCounter>(context, listen: false).displayResult();
    });
  }
}
