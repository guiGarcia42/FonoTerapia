import 'package:flutter/material.dart';
import 'package:fono_terapia/app_startup.dart';
import 'package:fono_terapia/database/dao/sub_category_dao.dart';
import 'package:fono_terapia/shared/assets/app_text_styles.dart';
import 'package:fono_terapia/shared/model/category.dart';
import 'package:fono_terapia/shared/model/sub_category.dart';
import 'package:fono_terapia/shared/widgets/elevated_text_button.dart';
import 'package:fono_terapia/shared/widgets/picture_button_with_description.dart';

import '../../shared/widgets/custom_header.dart';

class OptionPage extends StatelessWidget {
  const OptionPage({
    Key? key,
    required this.category,
  });

  final Category category;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final aspectRatioFactor = size.width / 400;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomHeader(
            text: category.name,
            size: size,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.height * 0.015,
            ),
            child: FutureBuilder<List<SubCategory>>(
              future:
                  SubCategoryDao().findAllSubCategories(database, category.id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                      child: Text('Erro ao carregar dados AQUI $snapshot'));
                } else {
                  final subCategories = snapshot.data!;

                  return SizedBox(
                    height: size.height * 0.6,
                    child: GridView.builder(
                      itemCount: subCategories.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.975 * aspectRatioFactor,
                        crossAxisSpacing: size.width * 0.03,
                        mainAxisSpacing: size.height * 0.06,
                      ),
                      itemBuilder: (_, index) {
                        final subCategory = subCategories[index];

                        return PictureButtonWithDescription(
                          description: subCategory.name,
                          imagePath: subCategory.imagePath,
                          size: size,
                          onTap: () => Navigator.pushNamed(
                            context,
                            '/game',
                            arguments: subCategory,
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: size.height * 0.02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedTextButton(
                  widthRatio: size.width * 0.4,
                  textStyle: TextStyles.buttonLargeText,
                  text: "Voltar",
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                ElevatedTextButton(
                  widthRatio: size.width * 0.4,
                  textStyle: TextStyles.buttonLargeText,
                  text: "Histórico",
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/history',
                      arguments: category,
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
