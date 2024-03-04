import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:fono_terapia/shared/assets/app_colors.dart';
import 'package:fono_terapia/shared/assets/app_images.dart';
import 'package:fono_terapia/shared/assets/app_text_styles.dart';

import '../../shared/widgets/floating_icon_card.dart';
import '../../shared/widgets/icon_button_with_description.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Container(
              width: size.width,
              height: size.height * 0.40,
              decoration: BoxDecoration(
                  gradient: RadialGradient(
                colors: [AppColors.lightOrange, AppColors.darkOrange],
                center: Alignment.center,
                radius: 0.7,
              )),
            ),
            Stack(
              children: [
                Positioned(
                  top: size.height * 0.05,
                  left: 0,
                  right: 0,
                  child: Image.asset(
                    AppImages.person,
                    width: size.width * 0.25,
                    height: size.height * 0.48,
                  ),
                ),
                Positioned(
                  top: size.height * 0.235,
                  left: 0,
                  right: 0,
                  child: Image.asset(
                    AppImages.gradient,
                    width: size.width * 0.2,
                    height: size.height * 0.475,
                  ),
                ),
              ],
            ),
            Positioned(
              top: size.height * 0.215,
              left: size.width * 0.665,
              child: FloatingIconCard(icon: Icons.hearing_outlined),
            ),
            Positioned(
              top: size.height * 0.35,
              left: size.width * 0.17,
              child: FloatingIconCard(icon: Icons.wechat_rounded),
            ),
            Positioned(
              bottom: size.width * 0.1,
              left: 0,
              right: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(AppImages.logoMini, height: size.height * 0.1),
                  AnimatedCard(
                    direction: AnimatedCardDirection.bottom,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.2,
                        vertical: size.height * 0.025,
                      ),
                      child: Text(
                        "Atividades Terapêuticas para a Afasia",
                        textAlign: TextAlign.center,
                        style: TextStyles.titleHome,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButtonWithDescription(
                        size: size,
                        icon: Icons.info_outline,
                        description: "Sobre",
                        onPressed: () {
                          Navigator.pushNamed(context, "/about");
                        },
                      ),
                      IconButtonWithDescription(
                        size: size,
                        icon: Icons.arrow_circle_right_outlined,
                        description: "Iniciar",
                        onPressed: () {
                          Navigator.pushNamed(context, "/menu");
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
