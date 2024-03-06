import 'package:flutter/material.dart';
import 'package:fono_terapia/app_startup.dart';
import 'package:fono_terapia/database/dao/category_dao.dart';
import 'package:fono_terapia/shared/assets/app_colors.dart';
import 'package:fono_terapia/shared/assets/app_text_styles.dart';
import 'package:fono_terapia/shared/model/category.dart';
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
              child: FutureBuilder<List<Category>>(
                future: CategoryDao().findAll(database),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Erro ao carregar dados'));
                  } else {
                    final categories = snapshot.data!;

                    return Center(
                      child: GridView.builder(
                        itemCount: categories.length,
                        gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.975 * aspectRatioFactor,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                        ),
                        itemBuilder: (_, index) {
                          final category = categories[index];
                    
                          return PictureButtonWithDescription(
                            description: category.name,
                            imagePath: category.imagePath,
                            size: size,
                            onTap: () => Navigator.pushNamed(
                              context,
                              '/option',
                              arguments: category.id,
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
            child: ElevatedTextButton(
              widthRatio: size.width * 0.4,
              textStyle: TextStyles.buttonLargeText,
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
