import 'package:flutter/material.dart';

class FloatingReactionModel<T> {
  final T value;
  final String assetPath;
  final String logoPath;
  final Color color;
  final String label;

  const FloatingReactionModel({
    required this.value,
    required this.assetPath,
    required this.logoPath,
    required this.color,
    required this.label,
  });
}
