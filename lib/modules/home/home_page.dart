import 'package:flutter/material.dart';
import 'package:fono_terapia/modules/startup/loading_view.dart';
import 'package:fono_terapia/shared/assets/app_colors.dart';
import 'package:fono_terapia/shared/assets/app_assets.dart';
import 'package:fono_terapia/shared/assets/app_text_styles.dart';
import 'package:fono_terapia/shared/widgets/my_text.dart';

import '../../shared/widgets/icon_button_with_description.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            width: responsiveSize.width,
            height: responsiveSize.height * 0.4,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [AppColors.lightOrange, AppColors.darkOrange],
                center: Alignment.center,
                radius: 0.7,
              ),
            ),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: responsiveSize.scaleSize(100),
                child: SizedBox(
                  height: responsiveSize.scaleSize(500),
                  child: Image.asset(
                    AppAssets.person,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Positioned(
                bottom: responsiveSize.scaleSize(50),
                child: SizedBox(
                  width: responsiveSize.scaleSize(350),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: responsiveSize.scaleSize(125),
                        child: Image.asset(
                          AppAssets.logoMini,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: responsiveSize.scaleSize(50),
                        ),
                        child: MyText(
                          "Atividades Terapêuticas para a Afasia",
                          textAlign: TextAlign.center,
                          style: TextStyles.title.copyWith(
                            fontSize: responsiveSize
                                .scaleSize(TextStyles.title.fontSize!),
                            color: AppColors.darkGray,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButtonWithDescription(
                            icon: Icons.info,
                            description: "Sobre",
                            color: AppColors.darkGray,
                            onPressed: () {
                              Navigator.pushNamed(context, "/about");
                            },
                          ),
                          IconButtonWithDescription(
                            icon: Icons.arrow_circle_right,
                            description: "Iniciar",
                            color: AppColors.darkGray,
                            onPressed: () {
                              Navigator.pushNamed(context, "/menu");
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
