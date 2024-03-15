import 'package:flutter/material.dart';
import 'package:fono_terapia/app_startup.dart';
import 'package:fono_terapia/shared/model/sub_category.dart';
import 'package:fono_terapia/shared/assets/app_colors.dart';
import 'package:fono_terapia/shared/assets/app_text_styles.dart';
import 'package:fono_terapia/shared/widgets/elevated_text_button.dart';

class CategoryFilterDialog extends StatefulWidget {
  const CategoryFilterDialog({
    super.key,
    required this.subCategories,
    required this.filteredCategories,
  });

  final List<SubCategory> subCategories;
  final List<bool> filteredCategories;

  @override
  State<CategoryFilterDialog> createState() => _CategoryFilterDialogState();
}

class _CategoryFilterDialogState extends State<CategoryFilterDialog> {
  late List<SubCategory> _subCategories;
  late List<bool> _filteredCategories;

  @override
  void initState() {
    super.initState();
    _subCategories = widget.subCategories;
    _filteredCategories = widget.filteredCategories;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.orange,
      elevation: 10,
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actionsOverflowAlignment: OverflowBarAlignment.center,
      actionsOverflowButtonSpacing: responsiveSize.scaleSize(20),
      title: Text(
        "Filtrar por Categoria:",
        style: TextStyles.titleDialog.copyWith(
          fontSize: responsiveSize.scaleSize(TextStyles.titleDialog.fontSize!),
        ),
        textAlign: TextAlign.start,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      content: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.lightOrange,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              _subCategories.length,
              (index) {
                final subCategory = _subCategories[index];

                return CheckboxListTile(
                  title: Text(
                    subCategory.name,
                    style: TextStyles.textRegular.copyWith(
                      fontSize: responsiveSize
                          .scaleSize(TextStyles.textRegular.fontSize!),
                    ),
                  ),
                  value: _filteredCategories[index],
                  activeColor: AppColors.darkGray,
                  onChanged: (value) {
                    setState(() {
                      _filteredCategories[index] = value ?? false;
                    });
                  },
                );
              },
            ),
          ),
        ),
      ),
      actions: [
        ElevatedTextButton(
          widthRatio: responsiveSize.scaleSize(150),
          textStyle: TextStyles.buttonMediumText.copyWith(
            fontSize:
                responsiveSize.scaleSize(TextStyles.buttonMediumText.fontSize!),
          ),
          text: "Cancelar",
          onPressed: () => Navigator.pop(context),
        ),
        ElevatedTextButton(
          widthRatio: responsiveSize.scaleSize(150),
          textStyle: TextStyles.buttonMediumText.copyWith(
            fontSize:
                responsiveSize.scaleSize(TextStyles.buttonMediumText.fontSize!),
          ),
          text: "Filtrar",
          onPressed: () {
            Navigator.pop(context, _filteredCategories);
          },
        ),
      ],
    );
  }
}
