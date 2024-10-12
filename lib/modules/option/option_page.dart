import 'package:flutter/material.dart';
import 'package:fono_terapia/app_initializer.dart';
import 'package:fono_terapia/shared/assets/app_text_styles.dart';
import 'package:fono_terapia/shared/model/category.dart';
import 'package:fono_terapia/shared/model/sub_category.dart';
import 'package:fono_terapia/shared/widgets/elevated_text_button.dart';
import 'package:fono_terapia/shared/widgets/picture_button_with_description.dart';
import 'package:fono_terapia/shared/widgets/my_text.dart';
import 'package:provider/provider.dart';
import '../../shared/widgets/custom_header.dart';
import 'option_page_viewmodel.dart';

class OptionPage extends StatelessWidget {
  const OptionPage({
    Key? key,
    required this.category,
  }) : super(key: key);

  final Category category;

  @override
  Widget build(BuildContext context) {

    final responsiveSize = AppInitializer.responsiveSize;

    return ChangeNotifierProvider(
      create: (_) => OptionPageViewModel(), // Create the ViewModel
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomHeader(
              text: category.name,
            ),
            Consumer<OptionPageViewModel>(
              builder: (context, viewModel, child) {
                return FutureBuilder<List<SubCategory>>(
                  future: viewModel.findAllSubCategories(category.id),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                          child: MyText('Erro ao carregar dados: ${snapshot.error}'));
                    } else {
                      final subCategories = snapshot.data!;
                      return Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: responsiveSize.scaleSize(20),
                          ),
                          child: GridView.builder(
                            itemCount: subCategories.length,
                            gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: responsiveSize.isMini()
                                  ? responsiveSize.scaleSize(1.5)
                                  : responsiveSize.scaleSize(1),
                              crossAxisSpacing: responsiveSize.scaleSize(25),
                              mainAxisSpacing: responsiveSize.scaleSize(50),
                            ),
                            itemBuilder: (_, index) {
                              final subCategory = subCategories[index];

                              return PictureButtonWithDescription(
                                description: subCategory.name,
                                imagePath: subCategory.imagePath,
                                onTap: () => Navigator.pushNamed(
                                  context,
                                  '/game',
                                  arguments: subCategory,
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    }
                  },
                );
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: responsiveSize.height * 0.04),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedTextButton(
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
                  ElevatedTextButton(
                    widthRatio: responsiveSize.scaleSize(200),
                    textStyle: TextStyles.buttonLargeText.copyWith(
                      fontSize: responsiveSize
                          .scaleSize(TextStyles.buttonLargeText.fontSize!),
                    ),
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
      ),
    );
  }
}