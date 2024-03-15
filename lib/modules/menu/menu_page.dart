import 'package:flutter/material.dart';
import 'package:fono_terapia/app_startup.dart';
import 'package:fono_terapia/database/dao/category_dao.dart';
import 'package:fono_terapia/shared/assets/app_text_styles.dart';
import 'package:fono_terapia/shared/model/category.dart';
import 'package:fono_terapia/shared/widgets/elevated_text_button.dart';
import '../../shared/widgets/picture_button_with_description.dart';
import '../../shared/widgets/custom_header.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomHeader(
            text: "Menu de Atividades Terapêuticas",
          ),
          FutureBuilder<List<Category>>(
            future: CategoryDao().findAllCategories(database),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Erro ao carregar dados'));
              } else {
                final categories = snapshot.data!;

                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: responsiveSize.scaleSize(20),
                    ),
                    child: GridView.builder(
                      itemCount: categories.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: responsiveSize.isMini()
                            ? responsiveSize.scaleSize(1.5)
                            : responsiveSize.scaleSize(1),
                        crossAxisSpacing: responsiveSize.scaleSize(25),
                        mainAxisSpacing: responsiveSize.scaleSize(50),
                      ),
                      itemBuilder: (_, index) {
                        final category = categories[index];

                        return PictureButtonWithDescription(
                          description: category.name,
                          imagePath: category.imagePath,
                          onTap: () => Navigator.pushNamed(
                            context,
                            '/option',
                            arguments: category,
                          ),
                        );
                      },
                    ),
                  ),
                );
              }
            },
          ),
          Padding(
            padding:
                EdgeInsets.symmetric(vertical: responsiveSize.height * 0.02),
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
