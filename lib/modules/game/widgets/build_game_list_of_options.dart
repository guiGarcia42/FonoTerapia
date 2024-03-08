import 'package:flutter/material.dart';
import 'package:fono_terapia/shared/model/game_component.dart';

import 'error_text_container.dart';
import 'text_container_button.dart';

class BuildGameListOfOptions extends StatelessWidget {
  final List<GameComponent> gameComponents;
  final int subCategoryId;
  final Size size;
  final VoidCallback onTap;

  const BuildGameListOfOptions(
      {super.key,
      required this.gameComponents,
      required this.subCategoryId,
      required this.size,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    final aspectRatioFactor = size.width / 400;

    if ([1, 3, 4, 5].contains(subCategoryId)) {
      return _buildImageComponent(gameComponents, aspectRatioFactor);
    } else if ([2, 7].contains(subCategoryId)) {
      return _buildYesOrNoComponent();
    } else if ([6, 8].contains(subCategoryId)) {
      return _buildTextComponent(gameComponents, aspectRatioFactor);
      // } else if ([9, 10].contains(subCategoryId)) {
      //   return _buildYesOrHintComponent();
      // } else if ([11].contains(subCategoryId)) {
      //   return _buildTextOrAudioComponent();
      // } else if ([12, 13, 14].contains(subCategoryId)) {
      //   return _buildTextInputComponent();
    }

    return ErrorTextContainer(size: size);
  }

  GridView _buildImageComponent(
      List<GameComponent> gameComponents, double aspectRatioFactor) {
    return GridView.builder(
      itemCount: gameComponents.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.975 * aspectRatioFactor,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      itemBuilder: (context, index) {
        final component = gameComponents[index];

        return Padding(
          padding: EdgeInsets.all(size.height * 0.02),
          child: InkWell(
            onTap: onTap,
            child: Image.asset(
              component.imagePath,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }

  Row _buildYesOrNoComponent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: TextContainerButton(size: size, text: "Sim", onTap: () {}),
        ),
        Expanded(
          child: TextContainerButton(size: size, text: "Não", onTap: () {}),
        ),
      ],
    );
  }

  GridView _buildTextComponent(
      List<GameComponent> gameComponents, double aspectRatioFactor) {
    return GridView.builder(
      itemCount: gameComponents.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.975 * aspectRatioFactor,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      itemBuilder: (context, index) {
        final component = gameComponents[index];

        return TextContainerButton(
            size: size, text: component.name, onTap: () {});
      },
    );
  }
}
