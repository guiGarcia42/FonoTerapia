import 'package:flutter/material.dart';
import 'package:fono_terapia/app_startup.dart';
import 'package:fono_terapia/database/dao/category_dao.dart';
import 'package:fono_terapia/database/dao/sub_category_dao.dart';
import 'package:fono_terapia/shared/assets/app_colors.dart';
import 'package:fono_terapia/shared/assets/app_text_styles.dart';
import 'package:fono_terapia/shared/model/sub_category.dart';
import 'package:fono_terapia/shared/widgets/elevated_text_button.dart';
import 'package:fono_terapia/shared/widgets/picture_button_with_description.dart';

class OptionPage extends StatelessWidget {
  const OptionPage({Key? key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final aspectRatioFactor = size.width / 400;
    final categoryId = ModalRoute.of(context)?.settings.arguments as int;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: size.width,
            height: size.height * 0.15,
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
                  CategoryDao.categoryNames[categoryId - 1],
                  style: TextStyles.titleOption,
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
              child: FutureBuilder<List<SubCategory>>(
                future: SubCategoryDao().findAllSubCategories(database, categoryId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Erro ao carregar dados $snapshot'));
                  } else {
                    final subCategories = snapshot.data!;
                    

                    return Center(
                      child: GridView.builder(
                        itemCount: subCategories.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.975 * aspectRatioFactor,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
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
                      arguments: categoryId,
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
