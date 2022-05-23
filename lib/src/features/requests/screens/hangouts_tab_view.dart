import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Providers
import '../providers/hangout_request_provider.dart';

// Helpers
import '../../../helpers/constants/app_typography.dart';
import '../../../helpers/extensions/string_extension.dart';
import '../../../helpers/constants/app_colors.dart';
import '../../../helpers/constants/app_styles.dart';

// Widgets
import '../../shared/widgets/labeled_widget.dart';
import '../widgets/hangouts/hangout_request_status_popup_menu.dart';
import '../widgets/hangouts/received_hangouts_list.dart';
import '../widgets/hangouts/sent_hangouts_list.dart';

class HangoutsTabView extends StatefulWidget {
  const HangoutsTabView({super.key});

  @override
  _ConnectionsTabView createState() => _ConnectionsTabView();
}

class _ConnectionsTabView extends State<HangoutsTabView> {
  int _selectedSegmentValue = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Insets.gapH15,

        // Filters
        CupertinoSlidingSegmentedControl(
          children: {
            0: Padding(
              padding: const EdgeInsets.all(5),
              child: Text(
                'Received',
                style: TextStyle(
                  fontSize: 13,
                  color: _selectedSegmentValue == 0
                      ? AppColors.textWhite80Color
                      : AppColors.primaryColor,
                ),
              ),
            ),
            1: Padding(
              padding: const EdgeInsets.all(5),
              child: Text(
                'Sent',
                style: TextStyle(
                  fontSize: 13,
                  color: _selectedSegmentValue == 1
                      ? AppColors.textWhite80Color
                      : AppColors.primaryColor,
                ),
              ),
            ),
          },
          padding: const EdgeInsets.all(5),
          thumbColor: AppColors.primaryColor,
          backgroundColor: Colors.white,
          groupValue: _selectedSegmentValue,
          onValueChanged: (int? newValue) {
            if (newValue != null) {
              setState(() {
                _selectedSegmentValue = newValue;
              });
            }
          },
        ),

        Insets.gapH15,

        // Request Status Filters
        Consumer(
          builder: (_, ref, __) {
            final filter = ref.watch(hangoutsFilterProvider);
            return LabeledWidget(
              labelDirection: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.center,
              label: (filter?.name.removeUnderScore) ?? 'All',
              labelStyle: AppTypography.primary.body14.copyWith(
                color: AppColors.textLightGreyColor,
              ),
              child: HangoutRequestStatusPopupMenu(
                initialValue: filter,
                onCanceled: () {
                  ref.read(hangoutsFilterProvider.notifier).state = null;
                },
                onSelected: (status) {
                  final _selectedStatusProv = ref.read(
                    hangoutsFilterProvider.notifier,
                  );
                  if (_selectedStatusProv.state != status) {
                    _selectedStatusProv.state = status;
                  }
                },
              ),
            );
          },
        ),

        Insets.gapH15,

        // Connection Requests List
        Expanded(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            switchInCurve: Curves.easeIn,
            child: _selectedSegmentValue == 0
                ? const ReceivedHangoutsList()
                : const SentHangoutsList(),
          ),
        ),
      ],
    );
  }
}
