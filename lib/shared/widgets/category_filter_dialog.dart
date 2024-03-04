import 'package:flutter/material.dart';
import 'package:fono_terapia/shared/model/menu_option.dart';
import 'package:fono_terapia/shared/themes/app_colors.dart';
import 'package:fono_terapia/shared/themes/app_text_styles.dart';
import 'package:fono_terapia/shared/widgets/elevated_text_button.dart';

class CategoryFilterDialog extends StatefulWidget {
  const CategoryFilterDialog({
    super.key,
    required this.menuOptionsList,
    required this.checkedStates,
    required this.size,
  });

  final List<MenuOption> menuOptionsList;
  final List<bool> checkedStates;
  final Size size;

  @override
  State<CategoryFilterDialog> createState() => _CategoryFilterDialogState();
}

class _CategoryFilterDialogState extends State<CategoryFilterDialog> {
  late List<bool> _checkedStates;

  @override
  void initState() {
    super.initState();

    if (widget.checkedStates.isEmpty) {
      _checkedStates = List.generate(
        widget.menuOptionsList.length,
        (_) => false,
      );
    } else {
      _checkedStates = widget.checkedStates;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.orange,
      elevation: 10,
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actionsOverflowAlignment: OverflowBarAlignment.center,
      actionsOverflowButtonSpacing: widget.size.height * 0.02,
      title: Text(
        "Filtrar por categoria:",
        style: TextStyles.titleDialog,
        textAlign: TextAlign.center,
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            widget.menuOptionsList.length,
            (index) {
              final option = widget.menuOptionsList[index];

              return CheckboxListTile(
                title: Text(
                  option.description,
                  style: TextStyles.textRegular,
                ),
                value: _checkedStates[index],
                onChanged: (value) {
                  setState(() {
                    _checkedStates[index] = value ?? false;
                  });
                },
              );
            },
          ),
        ),
      ),
      actions: [
        ElevatedTextButton(
          widthRatio: widget.size.width * 0.3,
          textStyle: TextStyles.buttonTextDialog,
          text: "Cancelar",
          onPressed: () => Navigator.pop(context),
        ),
        ElevatedTextButton(
          widthRatio: widget.size.width * 0.3,
          textStyle: TextStyles.buttonTextDialog,
          text: "Filtrar",
          onPressed: () => Navigator.pop(context, _checkedStates),
        ),
      ],
    );
  }
}
