import 'package:flutter/material.dart';

extension EmptySpace on num {
  SizedBox get ph => SizedBox(height: toDouble());

  SizedBox get pw => SizedBox(width: toDouble());
}

extension ImageHandling on String {
  String get image => "https:$this";
}
