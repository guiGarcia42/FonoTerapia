import 'package:flutter/material.dart';
import 'package:fono_terapia/shared/themes/app_colors.dart';
import 'package:fono_terapia/shared/themes/app_images.dart';
import 'package:fono_terapia/shared/themes/app_text_styles.dart';
import 'package:fono_terapia/shared/widgets/elevated_text_button.dart';

import '../../shared/widgets/picture_button_with_description.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: size.width,
            height: size.height * 0.25,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [AppColors.lightOrange, AppColors.darkOrange],
                center: Alignment.center,
                radius: 0.7,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 45),
                child: Text(
                  "Menu de Atividades Terapêuticas",
                  style: TextStyles.title,
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, top: 30, bottom: 20),
                  child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 0.9,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    children: [
                      PictureButtonWithDescription(
                        description: "Compreensão Auditiva",
                        imagePath: AppImages.logomini,
                        size: size,
                        onTap: () {},
                      ),
                      
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: ElevatedTextButton(
                  size: size,
                  text: "Voltar",
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
