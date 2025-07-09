import 'dart:async';
import 'package:flutter/material.dart';

/// Provider for managing splash screen state and navigation timing
/// Triggers navigation to the home screen after a fixed delay
class SplashProvider extends ChangeNotifier {
  // Internal flag to indicate when to navigate
  bool _shouldNavigate = false;
  // Public getter for navigation flag
  bool get shouldNavigate => _shouldNavigate;

  /// Constructor starts the splash delay timer
  SplashProvider() {
    _startDelay();
  }

  /// Starts a timer for the splash screen duration
  /// After the timer, sets the navigation flag and notifies listeners
  void _startDelay() {
    Timer(const Duration(seconds: 3), () {
      _shouldNavigate = true;
      notifyListeners();
    });
  }
} 