import 'package:flutter/material.dart';
import 'package:fono_terapia/shared/assets/app_colors.dart';
import 'package:fono_terapia/shared/assets/app_text_styles.dart';
import 'package:fono_terapia/shared/utils/data.dart';
import 'package:fono_terapia/shared/widgets/elevated_text_button.dart';
import 'package:fono_terapia/shared/widgets/picture_button_with_description.dart';

class OptionPage extends StatelessWidget {
  const OptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final menuOptionsList = buildCategoriesList(context);
    final arguments = ModalRoute.of(context)?.settings.arguments as int;
    final size = MediaQuery.of(context).size;
    final aspectRatioFactor = size.width / 400;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: size.width,
            height: size.height * 0.15,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [AppColors.lightOrange, AppColors.darkOrange],
                center: Alignment.center,
                radius: 0.7,
              ),
            ),
            child: SafeArea(
              child: Center(
                child: Text(
                  menuOptionsList[arguments].name,
                  style: TextStyles.titleOption,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: size.height * 0.005,
                horizontal: size.height * 0.005,
              ),
              child: GridView.builder(
                itemCount: menuOptionsList[arguments].subCategoriesList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.975 * aspectRatioFactor,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                itemBuilder: (_, index) {
                  final menuOption = menuOptionsList[arguments].subCategoriesList[index];

                  return PictureButtonWithDescription(
                    description: menuOption.name,
                    imagePath: menuOption.imagePath,
                    size: size,
                    onTap: menuOption.onTap,
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: size.height * 0.02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedTextButton(
                  widthRatio: size.width * 0.4,
                  textStyle: TextStyles.buttonText,
                  text: "Voltar",
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                ElevatedTextButton(
                  widthRatio: size.width * 0.4,
                  textStyle: TextStyles.buttonText,
                  text: "Histórico",
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/history',
                      arguments: arguments,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
