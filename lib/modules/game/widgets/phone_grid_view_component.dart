import 'package:flutter/material.dart';
import 'package:fono_terapia/shared/utils/responsive_size.dart';
import 'package:fono_terapia/shared/widgets/image_component.dart';
import 'package:fono_terapia/shared/widgets/text_component.dart';
import 'package:fono_terapia/shared/model/game_component.dart';

class PhoneGridViewComponent extends StatelessWidget {
  const PhoneGridViewComponent(
      {super.key,
      required this.gameComponents,
      required this.onTap,
      required this.isImage,
      required this.responsiveSize});

  final List<GameComponent> gameComponents;
  final Function(GameComponent?) onTap;
  final bool isImage;
  final ResponsiveSize responsiveSize;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: gameComponents.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: responsiveSize.scaleSize(40),
        mainAxisSpacing: responsiveSize.scaleSize(40),
      ),
      itemBuilder: (context, index) {
        final component = gameComponents[index];

        return isImage
            ? ImageComponent(
                onTap: onTap,
                component: component,
              )
            : TextComponent(
                onTap: onTap,
                component: component,
              );
      },
    );
  }
}
