import 'package:flutter/material.dart';
import 'package:fono_terapia/shared/model/game_component.dart';

class ImageComponent extends StatelessWidget {
  const ImageComponent({
    super.key,
    required this.onTap,
    required this.component,
  });

  final Function(GameComponent? p1) onTap;
  final GameComponent component;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(component),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Image.asset(
          component.imagePath,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
