import 'package:flutter/cupertino.dart';

class TotalAmount extends ChangeNotifier {
  double _totalAmount = 0.0;
  double get totalAmount => _totalAmount;
  display(double no) async {
    _totalAmount = no;
    await Future.delayed(Duration(microseconds: 100), () {
      notifyListeners();
    });
  }
}
