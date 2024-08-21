import 'package:flutter/material.dart';
import 'package:fono_terapia/database/dao/category_dao.dart';
import 'package:fono_terapia/modules/menu/menu_viewmodel.dart';
import 'package:fono_terapia/modules/startup/loading_view.dart';
import 'package:fono_terapia/shared/assets/app_colors.dart';
import 'package:fono_terapia/shared/assets/app_text_styles.dart';
import 'package:fono_terapia/shared/widgets/elevated_text_button.dart';
import 'package:fono_terapia/shared/widgets/my_text.dart';
import 'package:fono_terapia/shared/widgets/picture_button_with_description.dart';
import 'package:provider/provider.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MenuViewModel(categoryDao: CategoryDao())
        ..loadUserData()
        ..loadCategories(),
      child: Scaffold(
        body: Consumer<MenuViewModel>(
          builder: (context, viewModel, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MenuHeader(
                  text: "Menu de Atividades Terapêuticas",
                  userName:
                      viewModel.userData?.name ?? "Usuário não identificado",
                ),
                if (viewModel.categories.isEmpty)
                  Center(child: CircularProgressIndicator())
                else
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: responsiveSize.scaleSize(20),
                      ),
                      child: GridView.builder(
                        itemCount: viewModel.categories.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: responsiveSize.isMini()
                              ? responsiveSize.scaleSize(1.5)
                              : responsiveSize.scaleSize(1),
                          crossAxisSpacing: responsiveSize.scaleSize(25),
                          mainAxisSpacing: responsiveSize.scaleSize(50),
                        ),
                        itemBuilder: (_, index) {
                          final category = viewModel.categories[index];

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
                  ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.03,
                    top: MediaQuery.of(context).size.height * 0.01,
                  ),
                  child: ElevatedTextButton(
                    widthRatio: MediaQuery.of(context).size.width * 0.5,
                    textStyle: TextStyles.buttonLargeText.copyWith(
                      fontSize: 18,
                    ),
                    text: "Sair",
                    onPressed: () async {
                      final viewModel =
                          Provider.of<MenuViewModel>(context, listen: false);
                      await viewModel.signOut();
                      Navigator.pushReplacementNamed(context, '/startup');
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class MenuHeader extends StatelessWidget {
  final String text;
  final String userName;

  const MenuHeader({
    super.key,
    required this.text,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [AppColors.lightOrange, AppColors.darkOrange],
          center: Alignment.center,
          radius: 0.7,
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: responsiveSize.scaleSize(20),
                vertical: responsiveSize.scaleSize(5),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: responsiveSize.scaleSize(10),
                        right: responsiveSize.scaleSize(20),
                      ),
                      child: RichText(
                        text: TextSpan(
                            style: TextStyles.profileName.copyWith(
                              fontSize: responsiveSize.scaleSize(
                                TextStyles.profileName.fontSize!,
                              ),
                            ),
                            children: [
                              TextSpan(
                                text: "Olá, ",
                                style: TextStyle(
                                  color: AppColors.darkGray,
                                ),
                              ),
                              TextSpan(
                                text: userName,
                              ),
                            ]),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: responsiveSize.scaleSize(20),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      backgroundColor: AppColors.darkGray,
                    ),
                    child: MyText(
                      'Sobre',
                      maxLines: 1,
                      style: TextStyles.buttonTextDialog.copyWith(
                        fontSize: responsiveSize.scaleSize(
                          TextStyles.buttonTextDialog.fontSize!,
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/about');
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: responsiveSize.scaleSize(20),
              ),
              child: Divider(
                color: AppColors.background,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: responsiveSize.scaleSize(50),
                vertical: responsiveSize.scaleSize(10),
              ),
              child: Center(
                child: MyText(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyles.title.copyWith(
                    fontSize: responsiveSize.scaleSize(
                      TextStyles.title.fontSize!,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
