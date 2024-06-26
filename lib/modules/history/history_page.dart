import 'package:flutter/material.dart';
import 'package:fono_terapia/app_startup.dart';
import 'package:fono_terapia/database/dao/game_result_dao.dart';
import 'package:fono_terapia/database/dao/sub_category_dao.dart';
import 'package:fono_terapia/modules/history/widgets/calendar_date_picker_dialog.dart';
import 'package:fono_terapia/shared/assets/app_colors.dart';
import 'package:fono_terapia/shared/assets/app_text_styles.dart';
import 'package:fono_terapia/shared/model/category.dart';
import 'package:fono_terapia/shared/model/game_result.dart';
import 'package:fono_terapia/shared/model/sub_category.dart';
import 'package:fono_terapia/shared/widgets/elevated_text_button.dart';
import 'package:fono_terapia/shared/widgets/progress_indicator_with_text.dart';
import 'package:fono_terapia/shared/widgets/my_text.dart';

import 'widgets/category_filter_dialog.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({
    super.key,
    required this.category,
  });

  final Category category;

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late List<bool> subCategoriesCategoryFilter;
  late String? selectedDateFilter;
  late DateTime firstDate;
  late DateTime currentDate;
  late Category _category;
  late bool _isLoading; // Estado de carregamento
  late List<SubCategory> _subCategories;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    subCategoriesCategoryFilter = [];
    selectedDateFilter = null;
    currentDate = DateTime.now();
    firstDate = DateTime(currentDate.year, currentDate.month, 1);
    _category = widget.category;

    _getSubCategories().then((subCategories) {
      setState(() {
        _subCategories = subCategories;
        subCategoriesCategoryFilter =
            List.generate(_subCategories.length, (index) => true);
        _isLoading = false; // Estado de carregamento
      });
    });
  }

  Future<List<SubCategory>> _getSubCategories() async {
    List<SubCategory> allSubCategories =
        await SubCategoryDao().findAllSubCategories(database, _category.id);

    if (subCategoriesCategoryFilter.isNotEmpty) {
      List<SubCategory> filteredSubCategories = [];

      for (var i = 0; i < subCategoriesCategoryFilter.length; i++) {
        if (subCategoriesCategoryFilter[i]) {
          filteredSubCategories.add(allSubCategories[i]);
        }
      }
      return filteredSubCategories;
    } else {
      return allSubCategories;
    }
  }

  Future<List<GameResult>> _getFilteredGameResults() async {
    List<GameResult> allGameResults =
        await GameResultDao().findAllInCategory(database, _category.id);

    List<SubCategory> filteredSubCategories = await _getSubCategories();

    List<GameResult> filteredGameResults = allGameResults.where((result) {
      return filteredSubCategories.any((subCategory) {
        return result.subCategory.id == subCategory.id;
      });
    }).toList();

    if (selectedDateFilter != null) {
      filteredGameResults = filteredGameResults.where((result) {
        return result.date == selectedDateFilter;
      }).toList();
    }

    return filteredGameResults;
  }

  Future<void> _openDatePickerDialog() async {
    final DateTime? result = await showDialog<DateTime>(
      context: context,
      builder: (context) => CalendarDatePickerDialog(
        firstDate: firstDate,
        currentDate: currentDate,
      ),
    );

    if (result != null) {
      setState(() {
        selectedDateFilter =
            result.toString().split(' ')[0]; // Formato "YYYY-MM-DD"
      });
    }
  }

  String _formatDate(String dateString) {
    DateTime parsedDate = DateTime.parse(dateString);
    return "${parsedDate.day.toString().padLeft(2, '0')}/${parsedDate.month.toString().padLeft(2, '0')}/${parsedDate.year}";
  }

  Future<void> _openCategoryFilterDialog() async {
    final List<bool>? result = await showDialog<List<bool>>(
      context: context,
      builder: (context) => CategoryFilterDialog(
        subCategories: _subCategories,
        filteredCategories: subCategoriesCategoryFilter,
      ),
    );

    if (result != null) {
      setState(() {
        subCategoriesCategoryFilter = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: responsiveSize.scaleSize(10),
              horizontal: responsiveSize.scaleSize(20),
            ),
            child: _buildTopBar(),
          ),
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : FutureBuilder<List<GameResult>>(
                    future: _getFilteredGameResults(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(
                            child: MyText('Erro ao carregar dados $snapshot'));
                      } else {
                        final gameResults = snapshot.data!;

                        if (gameResults.isEmpty) {
                          return Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: responsiveSize.scaleSize(30),
                              ),
                              child: MyText(
                                "Histórico não encontrado.",
                                style: TextStyles.title.copyWith(
                                  fontSize: responsiveSize
                                      .scaleSize(TextStyles.title.fontSize!),
                                  color: AppColors.darkGray,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        } else {
                          return ListView.builder(
                            itemCount: gameResults.length,
                            itemBuilder: (context, index) {
                              final gameResult = gameResults[index];

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
                                      _formatDate(gameResult.date),
                                      style: TextStyles.textField.copyWith(
                                        fontSize: responsiveSize.scaleSize(
                                            TextStyles.textField.fontSize!),
                                      ),
                                    ),
                                    trailing: SizedBox(
                                      width:  responsiveSize.isTablet()
                            ? responsiveSize.scaleSize(250)
                            : responsiveSize.scaleSize(200),
                                      child: ProgressIndicatorWithText(
                                        answeredCorrectly:
                                            gameResult.answeredCorrectly,
                                        totalNumberOfQuestions:
                                            gameResult.totalQuestions,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      }
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Row _buildTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MyText(
          "Filtros:",
          style: TextStyles.textLargeRegular.copyWith(
            fontSize:
                responsiveSize.scaleSize(TextStyles.textLargeRegular.fontSize!),
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
                  fontSize: responsiveSize
                      .scaleSize(TextStyles.buttonMediumText.fontSize!),
                ),
                text: "Data",
                onPressed: () {
                  _openDatePickerDialog();
                },
              ),
              ElevatedTextButton(
                widthRatio: responsiveSize.isMini()
                    ? responsiveSize.scaleSize(250)
                    : responsiveSize.scaleSize(200),
                textStyle: TextStyles.buttonMediumText.copyWith(
                  fontSize: responsiveSize
                      .scaleSize(TextStyles.buttonMediumText.fontSize!),
                ),
                text: "Categoria",
                onPressed: () {
                  _openCategoryFilterDialog();
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}
