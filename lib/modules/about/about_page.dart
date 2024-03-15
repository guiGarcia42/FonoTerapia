import 'package:flutter/material.dart';
import 'package:fono_terapia/app_startup.dart';
import 'package:fono_terapia/shared/assets/app_colors.dart';
import 'package:fono_terapia/shared/assets/app_assets.dart';
import 'package:fono_terapia/shared/assets/app_text_styles.dart';
import 'package:fono_terapia/shared/utils/data.dart';
import 'package:fono_terapia/shared/widgets/elevated_text_button.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: responsiveSize.width,
            height: responsiveSize.height * 0.3,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [AppColors.lightOrange, AppColors.darkOrange],
                center: Alignment.center,
                radius: 0.7,
              ),
            ),
            child: SafeArea(
              child: Center(
                child: SizedBox(
                  height: responsiveSize.scaleSize(200),
                  child: Image.asset(
                    AppAssets.logoSobre,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: responsiveSize.scaleSize(20),
                vertical: responsiveSize.scaleSize(10),
              ),
              child: SingleChildScrollView(
                child: RichText(
                  text: TextSpan(
                    style: TextStyles.textRegular.copyWith(
                      fontSize: responsiveSize
                          .scaleSize(TextStyles.textRegular.fontSize! * 1.2),
                    ),
                    children: [
                      TextSpan(
                        text: "Juliana Miguel Gonzalez - CRFa 13299 SP\n\n",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: aboutUs),
                      TextSpan(
                        text: "\n\nContato:\n",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: contacts),
                      TextSpan(
                        text: "\n\nDesenvolvido por:\n",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: contactsDev),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: responsiveSize.height * 0.02),
            child: ElevatedTextButton(
              widthRatio: responsiveSize.scaleSize(200),
              textStyle: TextStyles.buttonLargeText.copyWith(
                fontSize: responsiveSize
                    .scaleSize(TextStyles.buttonLargeText.fontSize!),
              ),
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
