import 'package:flutter/material.dart';
import 'package:fono_terapia/shared/model/sub_category.dart';
import 'package:fono_terapia/shared/assets/app_colors.dart';
import 'package:fono_terapia/shared/assets/app_text_styles.dart';
import 'package:fono_terapia/shared/widgets/elevated_text_button.dart';

class CategoryFilterDialog extends StatefulWidget {
  const CategoryFilterDialog({
    super.key,
    required this.subCategories,
    required this.checkedStates,
    required this.size,
  });

  final List<SubCategory> subCategories;
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
        widget.subCategories.length,
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
            widget.subCategories.length,
            (index) {
              final subCategory = widget.subCategories[index];

              return CheckboxListTile(
                title: Text(
                  subCategory.name,
                  style: TextStyles.textRegular,
                ),
                value: _checkedStates[index],
                activeColor: AppColors.darkGray,
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
          onPressed: () {
            Navigator.pop(context, _checkedStates);
          },
        ),
      ],
    );

    
  }
}
