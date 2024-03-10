import 'package:flutter/material.dart';
import 'package:fono_terapia/app_startup.dart';
import 'package:fono_terapia/database/dao/game_result_dao.dart';
import 'package:fono_terapia/database/dao/sub_category_dao.dart';
import 'package:fono_terapia/shared/assets/app_colors.dart';
import 'package:fono_terapia/shared/assets/app_text_styles.dart';
import 'package:fono_terapia/shared/model/category.dart';
import 'package:fono_terapia/shared/model/game_result.dart';
import 'package:fono_terapia/shared/model/sub_category.dart';
import 'package:fono_terapia/shared/widgets/elevated_text_button.dart';

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
  late List<bool> checkedStates;
  late DateTime firstDate;
  late DateTime currentDate;
  late Category _category;
  late bool _isLoading; // Estado de carregamento
  late List<SubCategory> _subCategories;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    checkedStates = [];
    firstDate = DateTime(2024, 3, 1);
    currentDate = DateTime.now();
    _category = widget.category;

    _getSubCategories().then((subCategories) {
      setState(() {
        _subCategories = subCategories;
        _isLoading = false; // Estado de carregamento
      });
    });
  }

  Future<List<SubCategory>> _getSubCategories() async {
    return await SubCategoryDao().findAllSubCategories(database, _category.id);
  }

  Future<void> openCategoryFilterDialog(Size size) async {
    final List<bool>? result = await showDialog<List<bool>>(
      context: context,
      builder: (context) => CategoryFilterDialog(
        subCategories: _subCategories,
        checkedStates: checkedStates,
        size: size,
      ),
    );

    if (result != null) {
      setState(() {
        checkedStates = result;
      });
    }
  }

  Future<void> openDatePickerDialog() async {
    final DateTime? result = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: currentDate,
      helpText: 'Selecione uma data',
      cancelText: 'Cancelar',
      confirmText: 'Filtrar',
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: AppColors.darkGray,
              onPrimary: AppColors.background,
              surface: AppColors.orange,
            ),
          ),
          child: child!,
        );
      },
    );

    if (result != null) {
      // Aqui você pode atualizar a data conforme a seleção do usuário
      setState(() {
        currentDate = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (_isLoading) {
      //Gerenciando carregamento da tela aqui
      return Center(child: CircularProgressIndicator());
    } else {
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
              style: TextStyles.titleAppBar,
            ),
          ),
          centerTitle: true,
          backgroundColor: AppColors.darkOrange,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            vertical: size.height * 0.01,
            horizontal: size.width * 0.04,
          ),
          child: Column(
            children: [
              _buildTopBar(size),
              Expanded(
                child: FutureBuilder<List<GameResult>>(
                  future: GameResultDao().findAll(database),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                          child: Text('Erro ao carregar dados $snapshot'));
                    } else {
                      final gameResults = snapshot.data!;

                      return ListView.builder(
                        itemCount: gameResults.length,
                        itemBuilder: (context, index) {
                          final gameResult = gameResults[index];
                          print(gameResult);

                          return ListTile(
                            title: Text(gameResult.subCategory.name),
                            subtitle: Text(gameResult.date),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  Row _buildTopBar(Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Filtros:",
          style: TextStyles.textLargeRegular,
        ),
        ElevatedTextButton(
          widthRatio: size.width * 0.25,
          textStyle: TextStyles.buttonMediumText,
          text: "Data",
          onPressed: () {
            openDatePickerDialog();
          },
        ),
        ElevatedTextButton(
          widthRatio: size.width * 0.4,
          textStyle: TextStyles.buttonMediumText,
          text: "Categoria",
          onPressed: () {
            openCategoryFilterDialog(size);
          },
        ),
      ],
    );
  }
}
