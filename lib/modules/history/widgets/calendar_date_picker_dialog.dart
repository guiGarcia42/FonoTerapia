import 'package:flutter/material.dart';
import 'package:fono_terapia/shared/assets/app_colors.dart';
import 'package:fono_terapia/shared/assets/app_text_styles.dart';
import 'package:fono_terapia/shared/widgets/elevated_text_button.dart';

class CalendarDatePickerDialog extends StatefulWidget {
  const CalendarDatePickerDialog({
    super.key,
    required this.firstDate,
    required this.currentDate,
    required this.size,
  });

  final DateTime firstDate;
  final DateTime currentDate;
  final Size size;

  @override
  State<CalendarDatePickerDialog> createState() =>
      _CalendarDatePickerDialogState();
}

class _CalendarDatePickerDialogState extends State<CalendarDatePickerDialog> {
  late DateTime _firstDate;
  late DateTime _currentDate;
  late DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _firstDate = widget.firstDate;
    _currentDate = widget.currentDate;
    _selectedDate = null;
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
        "Filtrar por Data:",
        style: TextStyles.titleDialog,
        textAlign: TextAlign.start,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      content: Container(
        width: widget.size.width,
        decoration: BoxDecoration(
          color: AppColors.lightOrange,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Theme(
          data: ThemeData(
            textTheme: TextTheme(
              titleSmall: TextStyles.textSmallRegular
            ),
            colorScheme: ColorScheme.light(
              primary: AppColors.darkGray,
              onPrimary: AppColors.lightOrange,
            ),
          ),
          child: CalendarDatePicker(
            initialDate: null,
            firstDate: _firstDate,
            lastDate: _currentDate,
            onDateChanged: (value) {
              _selectedDate = value;
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
            Navigator.pop(context, _selectedDate);
          },
        ),
      ],
    );
  }
}
