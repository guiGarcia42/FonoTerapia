import 'package:flutter/material.dart';
import 'package:fono_terapia/shared/assets/app_colors.dart';
import 'package:fono_terapia/shared/model/game_component.dart';
import 'package:fono_terapia/shared/widgets/icon_button_with_description.dart';

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
    }

    if ([2, 7, 9, 10, 11].contains(subCategoryId)) {
      if ([2, 7].contains(subCategoryId)) {
        return _buildRightOrWrongComponent("Sim", "Não");
      } else {
        return _buildRightOrWrongComponent("Correto", "Incorreto");
      }
    }

    if ([6, 8].contains(subCategoryId)) {
      return _buildTextComponent(gameComponents, aspectRatioFactor);
    }

    if ([12, 13, 14].contains(subCategoryId)) {
      return _buildTextInputComponent();
    }

    return ErrorTextContainer(size: size);
  }

  GridView _buildImageComponent( // IMAGEM
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

  GridView _buildTextComponent( // TEXTO
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

  Padding _buildRightOrWrongComponent(String right, String wrong) { // CERTO OU ERRADO
    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.height * 0.05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButtonWithDescription(
            size: size,
            icon: Icons.check_circle,
            description: right,
            color: AppColors.right,
            onPressed: () {},
          ),
          IconButtonWithDescription(
            size: size,
            icon: Icons.cancel,
            description: wrong,
            color: AppColors.wrong,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Padding _buildTextInputComponent() { // ESCREVER
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: size.height * 0.05,
        horizontal: size.width * 0.1,
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Digite aqui...',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          filled: true,
          fillColor: AppColors.lightGray,
        ),
      ),
    );
  }
}
