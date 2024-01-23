import 'package:flutter/material.dart';
import 'package:fono_terapia/shared/themes/app_colors.dart';
import 'package:fono_terapia/shared/themes/app_images.dart';
import 'package:fono_terapia/shared/themes/app_text_styles.dart';
import 'package:fono_terapia/shared/widgets/elevated_text_button.dart';

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
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Image.asset(AppImages.logomini, height: size.height * 0.2),
                          Text("Compreensão Auditiva",
                          style: TextStyles.menuOptionDescription,
                          textAlign: TextAlign.center,
                          maxLines: 2,)
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Image.asset(AppImages.logomini, height: size.height * 0.2),
                          Text("Compreensão Escrita",
                          style: TextStyles.menuOptionDescription,
                          textAlign: TextAlign.center,
                          maxLines: 2)
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(AppImages.logomini, height: size.height * 0.2),
                          Text("Escrita",
                          style: TextStyles.menuOptionDescription,
                          textAlign: TextAlign.center,
                          maxLines: 2)
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(AppImages.logomini, height: size.height * 0.2),
                          Text("Nomeação",
                          style: TextStyles.menuOptionDescription,
                          textAlign: TextAlign.center,
                          maxLines: 2)
                        ],
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
