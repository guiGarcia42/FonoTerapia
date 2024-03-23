import 'package:flutter/material.dart';
import 'package:fono_terapia/app_startup.dart';
import 'package:fono_terapia/shared/model/game_component.dart';

import '../../../shared/widgets/image_component.dart';
import '../../../shared/widgets/text_component.dart';

class TabletGridViewComponent extends StatelessWidget {
  TabletGridViewComponent(
      {super.key,
      required this.gameComponents,
      required this.onTap,
      required this.isImage});

  final List<GameComponent> gameComponents;
  final Function(GameComponent?) onTap;
  final bool isImage;

  @override
  Widget build(BuildContext context) {
    return gameComponents.length == 4
        ? Padding(
            padding: EdgeInsets.symmetric(
              horizontal: responsiveSize.scaleSize(60),
              vertical: responsiveSize.scaleSize(20),
            ),
            child: Wrap(
              spacing: responsiveSize.scaleSize(40),
              runSpacing: responsiveSize.scaleSize(20),
              children: List.generate(
                gameComponents.length,
                (index) {
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
              ),
            ),
          )
        : Padding(
            padding: EdgeInsets.symmetric(
              vertical: gameComponents.length == 2
                  ? responsiveSize.scaleSize(60)
                  : responsiveSize.scaleSize(20),
            ),
            child: Wrap(
              spacing: responsiveSize.scaleSize(40),
              runSpacing: responsiveSize.scaleSize(20),
              children: List.generate(
                gameComponents.length,
                (index) {
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
              ),
            ),
          );
  }
}
