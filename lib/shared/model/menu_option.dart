import 'package:flutter/material.dart';

class MenuOption {
  final String imagePath;
  final String description;
  final VoidCallback onTap;

  MenuOption({
    required this.description,
    required this.imagePath,
    required this.onTap,
  });
  
}


