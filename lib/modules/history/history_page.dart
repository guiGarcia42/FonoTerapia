import 'package:flutter/material.dart';
import 'package:fono_terapia/app_startup.dart';
import 'package:fono_terapia/database/dao/sub_category_dao.dart';
import 'package:fono_terapia/shared/assets/app_colors.dart';
import 'package:fono_terapia/shared/assets/app_text_styles.dart';
import 'package:fono_terapia/shared/model/sub_category.dart';
import 'package:fono_terapia/shared/widgets/elevated_text_button.dart';

import '../../shared/widgets/category_filter_dialog.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<bool> checkedStates = [];

  @override
  Widget build(BuildContext context) {
    final categoryId = ModalRoute.of(context)?.settings.arguments as int;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_outlined),
          color: AppColors.background,
          iconSize: size.width * 0.1,
        ),
        title: SafeArea(
          child: Text(
            "Histórico",
            style: TextStyles.titleOption,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.darkOrange,
      ),
      body: FutureBuilder<List<SubCategory>>(
        future: SubCategoryDao().findAll(database),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar dados'));
          } else {
            final subCategories = snapshot.data!;
            List<bool> checkedStates = [];

            Future<void> openCategoryFilterDialog() async {
              final List<bool>? result = await showDialog<List<bool>>(
                context: context,
                builder: (context) => CategoryFilterDialog(
                  subCategories: subCategories,
                  checkedStates: checkedStates,
                  size: size,
                ),
              );

              if (result != null) {
                checkedStates = result;
              }
            }

            return Padding(
              padding: EdgeInsets.symmetric(
                vertical: size.height * 0.01,
                horizontal: size.width * 0.04,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedTextButton(
                        widthRatio: size.width * 0.4,
                        textStyle: TextStyles.buttonText,
                        text: "Data",
                        onPressed: () {},
                      ),
                      ElevatedTextButton(
                        widthRatio: size.width * 0.4,
                        textStyle: TextStyles.buttonText,
                        text: "Categoria",
                        onPressed: () {
                          openCategoryFilterDialog();
                        },
                      ),
                    ],
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        "Arguments $categoryId \n CategoryFilters $checkedStates",
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}