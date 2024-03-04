import 'package:flutter/material.dart';
import 'package:fono_terapia/shared/assets/app_colors.dart';
import 'package:fono_terapia/shared/assets/app_text_styles.dart';
import 'package:fono_terapia/shared/utils/data.dart';
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
    final menuOptionsList = buildCategoriesList(context);
    final arguments = ModalRoute.of(context)?.settings.arguments as int;
    final size = MediaQuery.of(context).size;

    Future<void> openCategoryFilterDialog() async {
      final List<bool>? result = await showDialog<List<bool>>(
        context: context,
        builder: (context) => CategoryFilterDialog(
            menuOptionsList: menuOptionsList[arguments].subCategoriesList,
            checkedStates: checkedStates,
            size: size),
      );

      if (result != null) {
        setState(() {
          checkedStates = result;
        });
      }
    }

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
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: size.height * 0.01, horizontal: size.width * 0.04),
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
                  "Arguments $arguments \n CategoryFilters $checkedStates"),
            ))
          ],
        ),
      ),
    );
  }
}
