import 'package:flutter/material.dart';

class SubCategory {
  final int id;
  final String name;
  final String imagePath;
  final VoidCallback onTap;

  SubCategory(
    this.id,
    this.name,
    this.imagePath,
    this.onTap,
  );
  
}


