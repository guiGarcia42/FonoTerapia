import 'package:flutter/material.dart';
import 'package:fono_terapia/app_initializer.dart';
import 'package:fono_terapia/modules/game/game_page_viewmodel.dart';
import 'package:fono_terapia/modules/game/widgets/build_game_question.dart';
import 'package:fono_terapia/modules/game/widgets/build_game_list_of_options.dart';
import 'package:fono_terapia/shared/assets/app_text_styles.dart';
import 'package:fono_terapia/shared/model/sub_category.dart';
import 'package:fono_terapia/shared/utils/responsive_size.dart';
import 'package:fono_terapia/shared/widgets/custom_header.dart';
import 'package:fono_terapia/shared/widgets/elevated_text_button.dart';
import 'package:fono_terapia/shared/widgets/my_text.dart';
import 'package:fono_terapia/shared/widgets/progress_indicator_with_text.dart';
import 'package:provider/provider.dart';

class GamePage extends StatelessWidget {
  final SubCategory subCategory;

  const GamePage({super.key, required this.subCategory});

  @override
  Widget build(BuildContext context) {

    final responsiveSize = AppInitializer.responsiveSize;

    return ChangeNotifierProvider(
      create: (_) => GameViewModel(
        subCategory: subCategory,
        database: AppInitializer.database,
      ),
      child: Consumer<GameViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          return Scaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    bottom: responsiveSize.scaleSize(20),
                  ),
                  child: CustomHeader(
                    text: subCategory.name,
                  ),
                ),
                _buildTopBar(context, viewModel, responsiveSize),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(responsiveSize.scaleSize(20)),
                    child: _buildContent(context, viewModel, responsiveSize),
                  ),
                ),
                _buildBottomBar(context, viewModel, responsiveSize),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTopBar(BuildContext context, GameViewModel viewModel, ResponsiveSize responsiveSize) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: responsiveSize.scaleSize(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedTextButton(
            widthRatio: responsiveSize.scaleSize(250),
            textStyle: TextStyles.buttonMediumText.copyWith(
              fontSize: responsiveSize
                  .scaleSize(TextStyles.buttonMediumText.fontSize!),
            ),
            text: "Configuração",
            onPressed: () {
              viewModel.openConfigurationDialog(context, subCategory.id);
            },
          ),
          Expanded(
            child: ProgressIndicatorWithText(
              answeredCorrectly: viewModel.answeredCorrectly,
              totalNumberOfQuestions: viewModel.configuration.totalNumberOfQuestions,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context, GameViewModel viewModel, ResponsiveSize responsiveSize) {
    return Padding(
      padding: EdgeInsets.only(bottom: responsiveSize.scaleSize(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedTextButton(
            widthRatio: responsiveSize.scaleSize(160),
            textStyle: TextStyles.buttonMediumText.copyWith(
              fontSize: responsiveSize
                  .scaleSize(TextStyles.buttonMediumText.fontSize!),
            ),
            text: "Ajuda",
            onPressed: () {
              viewModel.updateHintText();
            },
          ),
          ElevatedTextButton(
            widthRatio: responsiveSize.scaleSize(160),
            textStyle: TextStyles.buttonMediumText.copyWith(
              fontSize: responsiveSize
                  .scaleSize(TextStyles.buttonMediumText.fontSize!),
            ),
            text: "Próximo",
            onPressed: () {
              viewModel.optionSelected(null); // Update with correct logic
            },
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context, GameViewModel viewModel, ResponsiveSize responsiveSize) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: responsiveSize.scaleSize(50),
            ),
            child: BuildGameQuestion(
              player: viewModel.player,
              subCategoryId: subCategory.id,
              rightAnswer: viewModel.rightAnswer,
              responsiveSize: responsiveSize,
            ),
          ),
          MyText(
            viewModel.buildHintText(),
            style: TextStyles.textLargeRegular,
          ),
          BuildGameListOfOptions(
            gameComponents: viewModel.gameComponents,
            subCategoryId: subCategory.id,
            rightAnswer: viewModel.rightAnswer,
            onTap: viewModel.optionSelected,
            responsiveSize: responsiveSize,
          ),
        ],
      ),
    );
  }
}