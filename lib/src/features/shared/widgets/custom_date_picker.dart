import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Helpers
import '../../../helpers/constants/app_colors.dart';
import '../../../helpers/constants/app_styles.dart';
import '../../../helpers/constants/app_typography.dart';

// Widgets
import './cupertino_date_picker_dialog.dart';
import './custom_text_button.dart';

class CustomDatePicker extends StatelessWidget {
  /// The initially selected [DateTime] that the picker should display.
  final DateTime? initialDate;

  /// The earliest allowable [DateTime] that the user can select.
  final DateTime firstDate;

  /// The latest allowable [DateTime] that the user can select.
  final DateTime? lastDate;

  /// The [DateTime] representing today. It will be highlighted in the day grid.
  final DateTime? currentDate;

  /// The initial mode of date entry method for the date picker dialog.
  ///
  /// See [DatePickerEntryMode] for more details on the different data entry
  /// modes available.
  final DatePickerEntryMode initialEntryMode;

  /// Function to provide full control over which [DateTime] can be selected.
  final SelectableDayPredicate? selectableDayPredicate;

  /// The text that is displayed at the top of the header.
  ///
  /// This is used to indicate to the user what they are selecting a date for.
  final String? helpText;

  /// The initial display of the calendar picker.
  final DatePickerMode initialMaterialDatePickerMode;

  /// The mode of the date picker as one of [CupertinoDatePickerMode].
  /// Defaults to [CupertinoDatePickerMode.dateAndTime]. Cannot be null and
  /// value cannot change after initial build.
  final CupertinoDatePickerMode initialCupertinoDatePickerMode;

  /// The notifier used to store and passback selected values to the parent.
  final ValueNotifier<DateTime?> dateNotifier;

  /// The format used to decide the pattern of the selected datetime's
  /// output in the form field.
  final DateFormat dateFormat;

  final CustomDatePickerStyle pickerStyle;

  const CustomDatePicker({
    super.key,
    this.lastDate,
    this.helpText,
    this.currentDate,
    this.initialDate,
    this.selectableDayPredicate,
    this.initialEntryMode = DatePickerEntryMode.calendar,
    this.initialMaterialDatePickerMode = DatePickerMode.day,
    this.initialCupertinoDatePickerMode = CupertinoDatePickerMode.date,
    this.pickerStyle = const CustomDatePickerStyle(),
    required this.firstDate,
    required this.dateNotifier,
    required this.dateFormat,
  });

  Future<void> _pickDate(BuildContext context) async {
    final nowDate = DateTime.now();
    if (!Platform.isIOS) {
      dateNotifier.value = await showDatePicker(
            helpText: helpText,
            context: context,
            initialEntryMode: initialEntryMode,
            initialDatePickerMode: initialMaterialDatePickerMode,
            initialDate: dateNotifier.value ?? initialDate ?? nowDate,
            firstDate: firstDate,
            lastDate: lastDate ?? nowDate,
          ) ??
          dateNotifier.value;
    } else {
      dateNotifier.value = await showCupertinoModalPopup<DateTime>(
            context: context,
            builder: (BuildContext ctx) {
              return CupertinoDatePickerDialog(
                mode: initialCupertinoDatePickerMode,
                initialDateTime: dateNotifier.value ?? initialDate ?? nowDate,
                minimumDate: firstDate,
                maximumDate: lastDate ?? nowDate,
              );
            },
          ) ??
          dateNotifier.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Label
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            pickerStyle.floatingText,
            style:
                pickerStyle.floatingTextStyle ?? AppTypography.primary.body16,
          ),
        ),

        Insets.gapH5,

        // Field
        CustomTextButton(
          width: double.infinity,
          height: 47,
          onPressed: () => _pickDate(context),
          color: pickerStyle.displayFieldColor,
          padding: const EdgeInsets.only(left: 20, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ValueListenableBuilder<DateTime?>(
                valueListenable: dateNotifier,
                builder: (_, date, __) {
                  var dateString = pickerStyle.initialDateString;
                  if (date != null) {
                    dateString = dateFormat.format(date);
                  }
                  return Text(
                    dateString,
                    style: pickerStyle.displayTextStyle,
                  );
                },
              ),

              // Icon
              pickerStyle.icon,
            ],
          ),
        ),
      ],
    );
  }
}

class CustomDatePickerStyle {
  final Widget icon;
  final TextStyle displayTextStyle;
  final TextStyle? floatingTextStyle;
  final String floatingText;
  final Color displayFieldColor;
  final String initialDateString;

  const CustomDatePickerStyle({
    this.floatingTextStyle,
    this.icon = const Icon(
      Icons.calendar_month_rounded,
      color: AppColors.primaryColor,
      size: IconSizes.med22,
    ),
    this.displayTextStyle = const TextStyle(
      fontSize: 16,
      color: AppColors.textGreyColor,
    ),
    this.displayFieldColor = AppColors.fieldFillColor,
    this.initialDateString = 'Select a date',
    this.floatingText = 'Date Picker',
  });
}
