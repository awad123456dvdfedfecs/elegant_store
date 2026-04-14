import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  String _selectedMainCategory = '';
  String _selectedSubCategory = 'الكل';
  bool _isLoading = false;

  String get selectedMainCategory => _selectedMainCategory;
  String get selectedSubCategory => _selectedSubCategory;
  bool get isLoading => _isLoading;

  void setMainCategory(String category) {
    _selectedMainCategory = category;
    _selectedSubCategory = 'الكل';
    notifyListeners();
  }

  void setSubCategory(String category) {
    _selectedSubCategory = category;
    notifyListeners();
  }

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}