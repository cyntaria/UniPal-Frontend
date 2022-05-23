import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Providers
import '../providers/hangout_request_provider.dart';

// Helpers
import '../../../helpers/constants/app_colors.dart';
import '../../../helpers/constants/app_styles.dart';

// Enums
import '../enums/hangout_request_status_enum.dart';

// Widgets
import '../../shared/widgets/custom_dropdown_field.dart';
import '../../shared/widgets/labeled_widget.dart';
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
        Row(
          children: [
            // Sent/Receive Picker
            CupertinoSlidingSegmentedControl(
              children: {
                0: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    'Sent',
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
                    'Received',
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

            // Request Status Filters
            HookConsumer(
              builder: (_, ref, __) {
                final controller = useTextEditingController(
                  text: ref.watch(hangoutsFilterProvider)?.name ?? '',
                );
                return LabeledWidget(
                  label: 'Request Status',
                  useDarkerLabel: true,
                  child: CustomDropdownField<HangoutRequestStatus>.animated(
                    controller: controller,
                    enableSearch: true,
                    hintText: 'All',
                    items: {
                      for (var e in HangoutRequestStatus.values) e.name: e
                    },
                    onSelected: (studentType) => ref
                        .read(hangoutsFilterProvider.notifier)
                        .state = studentType,
                  ),
                );
              },
            ),
          ],
        ),

        Insets.gapH15,

        // Connection Requests List
        Expanded(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            switchInCurve: Curves.easeIn,
            child: _selectedSegmentValue == 0
                ? const SentHangoutsList()
                : const ReceivedHangoutsList(),
          ),
        ),
      ],
    );
  }
}
