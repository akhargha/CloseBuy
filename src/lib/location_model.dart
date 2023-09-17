import 'package:flutter/material.dart';

class LocationModel extends ChangeNotifier {
  Map<String, Offset> options = {
    "The Long Walk": Offset(65, 235),
    "Trinity Chapel": Offset(100, 150),
    "Robin L. Sheppard Field": Offset(250, 150)
  };

  String? currentOption;
  Offset? selectedLocation;

  setCurrentOption(String newOption) {
    currentOption = newOption;
    notifyListeners();
  }

  updateSelectedLocation() {
    if(currentOption != null) {
      selectedLocation = options[currentOption];
      notifyListeners();
    }
  }
}
