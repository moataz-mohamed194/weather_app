import 'dart:async';
import 'package:flutter/material.dart';

class SplashProvider extends ChangeNotifier {
  bool _shouldNavigate = false;
  bool get shouldNavigate => _shouldNavigate;

  SplashProvider() {
    _startDelay();
  }

  void _startDelay() {
    Timer(const Duration(seconds: 3), () {
      _shouldNavigate = true;
      notifyListeners();
    });
  }
} 