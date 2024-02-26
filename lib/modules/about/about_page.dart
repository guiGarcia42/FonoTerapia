import 'package:flutter/material.dart';
import 'package:fono_terapia/shared/themes/app_colors.dart';
import 'package:fono_terapia/shared/themes/app_images.dart';
import 'package:fono_terapia/shared/themes/app_text_styles.dart';
import 'package:fono_terapia/shared/utils/data.dart';
import 'package:fono_terapia/shared/widgets/elevated_text_button.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: size.width,
            height: size.height * 0.30,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [AppColors.lightOrange, AppColors.darkOrange],
                center: Alignment.center,
                radius: 0.7,
              ),
            ),
            child: SafeArea(
              child: Center(
                child: Image.asset(
                  AppImages.logoSobre,
                  height: size.height * 0.2,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.035,
                  vertical: size.height * 0.025),
              child: SingleChildScrollView(
                child: RichText(
                  text: TextSpan(
                    style: TextStyles.textRegular,
                    children: [
                      TextSpan(
                          text: "Juliana Miguel Gonzalez - CRFa 13299 SP\n\n",
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: aboutUs),
                      TextSpan(
                        text: "\n\nContato:\n",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: contacts),
                      TextSpan(
                          text: "\n\nDesenvolvido por:\n",
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: contactsDev),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: size.height * 0.02),
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
    );
  }
}
