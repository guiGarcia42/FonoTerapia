import 'package:flutter/material.dart';
import 'package:fono_terapia/shared/assets/app_colors.dart';
import 'package:fono_terapia/shared/assets/app_images.dart';
import 'package:fono_terapia/shared/assets/app_text_styles.dart';
import 'package:fono_terapia/shared/widgets/elevated_text_button.dart';
import '../../shared/widgets/picture_button_with_description.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final aspectRatioFactor = size.width / 400;
    
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: size.width,
            height: size.height * 0.20,
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
                  "Menu de Atividades Terapêuticas",
                  style: TextStyles.titleMenu,
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
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 0.975 * aspectRatioFactor,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                children: [
                  PictureButtonWithDescription(
                    description: "Compreensão Auditiva",
                    imagePath: AppImages.logoCompreensaoAuditiva,
                    size: size,
                    onTap: () => Navigator.pushNamed(
                      context,
                      '/option',
                      arguments: 0,
                    ),
                  ),
                  PictureButtonWithDescription(
                    description: "Compreensão Escrita",
                    imagePath: AppImages.logoCompreensaoEscrita,
                    size: size,
                    onTap: () => Navigator.pushNamed(
                      context,
                      '/option',
                      arguments: 1,
                    ),
                  ),
                  PictureButtonWithDescription(
                    description: "Nomeação Escrita",
                    imagePath: AppImages.logoNomeacaoEscrita,
                    size: size,
                    onTap: () => Navigator.pushNamed(
                      context,
                      '/option',
                      arguments: 2,
                    ),
                  ),
                  PictureButtonWithDescription(
                    description: "Nomeação Oral",
                    imagePath: AppImages.logoNomeacaoOral,
                    size: size,
                    onTap: () => Navigator.pushNamed(
                      context,
                      '/option',
                      arguments: 3,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
            child: ElevatedTextButton(
              widthRatio: size.width * 0.4,
              textStyle: TextStyles.buttonText,
              text: "Voltar",
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
