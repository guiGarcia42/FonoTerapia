import 'package:flutter/material.dart';
import 'package:fono_terapia/app_initializer.dart';
import 'package:fono_terapia/modules/history/history_page_viewmodel.dart';
import 'package:fono_terapia/modules/history/widgets/calendar_date_picker_dialog.dart';
import 'package:fono_terapia/shared/assets/app_colors.dart';
import 'package:fono_terapia/shared/assets/app_text_styles.dart';
import 'package:fono_terapia/shared/model/category.dart';
import 'package:fono_terapia/shared/utils/responsive_size.dart';
import 'package:fono_terapia/shared/widgets/elevated_text_button.dart';
import 'package:fono_terapia/shared/widgets/my_text.dart';
import 'package:fono_terapia/shared/widgets/progress_indicator_with_text.dart';
import 'package:provider/provider.dart';

import 'widgets/category_filter_dialog.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({
    Key? key,
    required this.category,
  }) : super(key: key);

  final Category category;

  @override
  Widget build(BuildContext context) {
    final responsiveSize = AppInitializer.responsiveSize; // Accessing responsiveSize globally

    return ChangeNotifierProvider(
      create: (_) => HistoryViewModel(
        category: category,
        database: AppInitializer.database, // Pass global database
      ),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_outlined),
            color: AppColors.background,
            iconSize: responsiveSize.isTablet()
                ? responsiveSize.scaleSize(30)
                : responsiveSize.scaleSize(50),
          ),
          title: SafeArea(
            child: MyText(
              "Histórico",
              style: TextStyles.title.copyWith(
                fontSize: responsiveSize.scaleSize(TextStyles.title.fontSize!),
                color: AppColors.background,
              ),
            ),
          ),
          centerTitle: true,
          backgroundColor: AppColors.darkOrange,
        ),
        body: Consumer<HistoryViewModel>(
          builder: (context, viewModel, child) {
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: responsiveSize.scaleSize(10),
                    horizontal: responsiveSize.scaleSize(20),
                  ),
                  child: _buildTopBar(context, viewModel, responsiveSize),
                ),
                Expanded(
                  child: viewModel.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : viewModel.gameResults.isEmpty
                      ? Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: responsiveSize.scaleSize(30),
                      ),
                      child: MyText(
                        "Histórico não encontrado.",
                        style: TextStyles.title.copyWith(
                          fontSize: responsiveSize.scaleSize(
                              TextStyles.title.fontSize!),
                          color: AppColors.darkGray,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                      : ListView.builder(
                    itemCount: viewModel.gameResults.length,
                    itemBuilder: (context, index) {
                      final gameResult = viewModel.gameResults[index];

                      return Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: responsiveSize.scaleSize(5),
                          horizontal: responsiveSize.scaleSize(20),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 3),
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.lightGray,
                          ),
                          child: ListTile(
                            title: MyText(
                              gameResult.subCategory.name,
                              style: TextStyles.titleListTile.copyWith(
                                fontSize: responsiveSize.scaleSize(
                                    TextStyles.titleListTile.fontSize!),
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: MyText(
                              viewModel.formatDate(gameResult.date),
                              style: TextStyles.textField.copyWith(
                                fontSize: responsiveSize.scaleSize(
                                    TextStyles.textField.fontSize!),
                              ),
                            ),
                            trailing: SizedBox(
                              width: responsiveSize.isTablet()
                                  ? responsiveSize.scaleSize(250)
                                  : responsiveSize.scaleSize(200),
                              child: ProgressIndicatorWithText(
                                answeredCorrectly: gameResult.answeredCorrectly,
                                totalNumberOfQuestions: gameResult.totalQuestions,
                              ),
                            ),
                          ),
                        ),
                      );
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

  Row _buildTopBar(
      BuildContext context, HistoryViewModel viewModel, ResponsiveSize responsiveSize) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MyText(
          "Filtros:",
          style: TextStyles.textLargeRegular.copyWith(
            fontSize: responsiveSize.scaleSize(TextStyles.textLargeRegular.fontSize!),
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedTextButton(
                widthRatio: responsiveSize.isMini()
                    ? responsiveSize.scaleSize(150)
                    : responsiveSize.scaleSize(120),
                textStyle: TextStyles.buttonMediumText.copyWith(
                  fontSize: responsiveSize.scaleSize(TextStyles.buttonMediumText.fontSize!),
                ),
                text: "Data",
                onPressed: () {
                  _openDatePickerDialog(context, viewModel);
                },
              ),
              ElevatedTextButton(
                widthRatio: responsiveSize.isMini()
                    ? responsiveSize.scaleSize(250)
                    : responsiveSize.scaleSize(200),
                textStyle: TextStyles.buttonMediumText.copyWith(
                  fontSize: responsiveSize.scaleSize(TextStyles.buttonMediumText.fontSize!),
                ),
                text: "Categoria",
                onPressed: () {
                  _openCategoryFilterDialog(context, viewModel);
                },
              ),
            ],
          ),
        )
      ],
    );
  }

  Future<void> _openDatePickerDialog(
      BuildContext context, HistoryViewModel viewModel) async {
    final DateTime? result = await showDialog<DateTime>(
      context: context,
      builder: (context) => CalendarDatePickerDialog(
        firstDate: viewModel.firstDate,
        currentDate: viewModel.currentDate,
      ),
    );

    if (result != null) {
      viewModel.setSelectedDateFilter(result.toString().split(' ')[0]);
    }
  }

  Future<void> _openCategoryFilterDialog(
      BuildContext context, HistoryViewModel viewModel) async {
    final List<bool>? result = await showDialog<List<bool>>(
      context: context,
      builder: (context) => CategoryFilterDialog(
        subCategories: viewModel.subCategories,
        filteredCategories: viewModel.subCategoriesCategoryFilter,
      ),
    );

    if (result != null) {
      viewModel.setCategoryFilter(result);
    }
  }
}