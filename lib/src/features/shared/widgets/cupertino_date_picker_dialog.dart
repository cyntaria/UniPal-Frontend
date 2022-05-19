import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Helpers
import '../../../helpers/constants/app_colors.dart';
import '../../../helpers/constants/app_styles.dart';
import '../../../helpers/constants/app_typography.dart';

class CupertinoDatePickerDialog extends StatefulWidget {
  /// The mode of the date picker as one of [CupertinoDatePickerMode].
  /// Defaults to [CupertinoDatePickerMode.dateAndTime]. Cannot be null and
  /// value cannot change after initial build.
  final CupertinoDatePickerMode mode;

  /// The initial date and/or time of the picker. Defaults to the present date
  /// and time and must not be null. The present must conform to the intervals
  /// set in [minimumDate], [maximumDate], [minimumYear], and [maximumYear].
  ///
  /// Changing this value after the initial build will not affect the currently
  /// selected date time.
  final DateTime initialDateTime;

  /// The minimum selectable date that the picker can settle on.
  ///
  /// The user can still scroll the picker to [DateTime]s earlier
  /// than [minimumDate], but the [onDateTimeChanged] will not be called on
  /// these [DateTime]s. Once let go, the picker will scroll back to [minimumDate].
  ///
  /// In [CupertinoDatePickerMode.time] mode, a time becomes unselectable if the
  /// [DateTime] produced by combining that particular time and the date part of
  /// [initialDateTime] is earlier than [minimumDate]. So typically [minimumDate]
  /// needs to be set to a [DateTime] that is on the same date as [initialDateTime].
  final DateTime minimumDate;

  /// The maximum selectable date that the picker can settle on.
  ///
  /// The user can still scroll the picker to [DateTime]s later
  /// than [maximumDate], but the [onDateTimeChanged] will not be called on
  /// these [DateTime]s. Once let go, the picker will scroll back to [maximumDate].
  ///
  /// In [CupertinoDatePickerMode.time] mode, a time becomes unselectable if the
  /// [DateTime] produced by combining that particular time and the date part of
  /// [initialDateTime] is later than [maximumDate]. So typically [maximumDate]
  /// needs to be set to a [DateTime] that is on the same date as [initialDateTime].
  final DateTime maximumDate;

  /// Background color of date picker dialog.
  ///
  /// Defaults to null, which disables background painting entirely.
  final Color? backgroundColor;

  /// The text that is displayed at the top of the header.
  ///
  /// This is used to indicate to the user what they are selecting a date for.
  final String? helpText;

  const CupertinoDatePickerDialog({
    super.key,
    this.helpText,
    this.backgroundColor,
    this.mode = CupertinoDatePickerMode.date,
    required this.initialDateTime,
    required this.minimumDate,
    required this.maximumDate,
  });

  @override
  _CupertinoDatePickerDialogState createState() =>
      _CupertinoDatePickerDialogState();
}

class _CupertinoDatePickerDialogState extends State<CupertinoDatePickerDialog> {
  late DateTime _selectedDate;

  @override
  void initState() {
    _selectedDate = widget.initialDateTime;
    super.initState();
  }

  void _onCancel() {
    return Navigator.of(context).pop(widget.initialDateTime);
  }

  void _onDone() {
    return Navigator.of(context).pop(_selectedDate);
  }

  void _selectPickedDate(DateTime picked) {
    setState(() {
      _selectedDate = picked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      color: widget.backgroundColor ?? AppColors.lightBackgroundColor,
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            // Options Row
            Material(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Cancel Link
                  GestureDetector(
                    onTap: _onCancel,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text(
                        'Cancel',
                        style: AppTypography.primary.body14.copyWith(
                          color: AppColors.textGreyColor,
                        ),
                      ),
                    ),
                  ),

                  // Help Text
                  Text(
                    widget.helpText ?? 'Select A Date',
                    style: AppTypography.primary.body16.copyWith(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  // Done Link
                  GestureDetector(
                    onTap: _onDone,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text(
                        'Done',
                        style: AppTypography.primary.body14.copyWith(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Divider(
              height: 0,
              thickness: 1.2,
              color: Color(0xFFE0E0E0),
            ),

            Insets.gapH5,

            Expanded(
              child: CupertinoDatePicker(
                mode: widget.mode,
                onDateTimeChanged: _selectPickedDate,
                initialDateTime: _selectedDate,
                minimumDate: widget.minimumDate,
                maximumDate: widget.maximumDate,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
