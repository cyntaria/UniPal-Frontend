import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Helpers
import '../../../helpers/constants/app_colors.dart';
import '../../../helpers/constants/app_styles.dart';

// Widgets
import '../widgets/connections/received_connections_list.dart';
import '../widgets/connections/sent_connections_list.dart';

class ConnectionsTabView extends StatefulWidget {
  const ConnectionsTabView({Key? key}) : super(key: key);

  @override
  _ConnectionsTabView createState() => _ConnectionsTabView();
}

class _ConnectionsTabView extends State<ConnectionsTabView> {
  int _selectedSegmentValue = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Insets.gapH15,

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

        Insets.gapH15,

        // Connection Requests List
        Expanded(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            switchInCurve: Curves.easeIn,
            child: _selectedSegmentValue == 0
                ? const SentConnectionsList()
                : const ReceivedConnectionsList(),
          ),
        ),
      ],
    );
  }
}
