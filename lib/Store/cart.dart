import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Config/config.dart';
import 'package:e_shop/Address/address.dart';
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
        return sourceInfo(model, context);
      }
    }
    return Text("");
  }
}
