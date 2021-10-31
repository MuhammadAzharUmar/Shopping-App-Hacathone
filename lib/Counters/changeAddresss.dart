import 'package:flutter/foundation.dart';

class AddressChanger extends ChangeNotifier {
  int counter = 0;
  int get count => counter;
  displayResults(int v) {
    counter = v;
    notifyListeners();
  }
}
