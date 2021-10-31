import 'package:e_shop/Store/cart.dart';
import 'package:e_shop/Counters/cartitemcounter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyAppBar extends StatelessWidget with PreferredSizeWidget {
  final PreferredSizeWidget bottom;
  MyAppBar({this.bottom});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        iconTheme: IconThemeData(color: Colors.white),
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
              fontSize: 50, color: Colors.white, fontFamily: "Signatra"),
        ),
        centerTitle: true,
        bottom: bottom,
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  Route route =
                      MaterialPageRoute(builder: (BuildContext) => CartPage());
                  Navigator.pushReplacement(context, route);
                },
                icon: Icon(Icons.shopping_cart),
                color: Colors.pink,
              ),
              Positioned(
                child: Stack(
                  children: [
                    Icon(
                      Icons.brightness_1,
                      size: 20,
                      color: Colors.green,
                    ),
                    Positioned(
                        top: 3,
                        bottom: 4,
                        left: 4,
                        child: Consumer<CartItemCounter>(
                          builder: (Context, counter, _) {
                            return Text(
                              counter.count.toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            );
                          },
                        ))
                  ],
                ),
              ),
            ],
          )
        ]);
  }

  Size get preferredSize => bottom == null
      ? Size(56, AppBar().preferredSize.height)
      : Size(56, 80 + AppBar().preferredSize.height);
}
