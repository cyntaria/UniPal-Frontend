import 'package:flutter/cupertino.dart';

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
        // Sent/Receive Picker
        CupertinoSlidingSegmentedControl(
          children: const {
            0: Text('Sent'),
            1: Text('Received'),
          },
          groupValue: _selectedSegmentValue,
          onValueChanged: (int? newValue) {
            if (newValue != null) {
              setState(() {
                _selectedSegmentValue = newValue;
              });
            }
          },
        ),

        // Connection Requests List
        if (_selectedSegmentValue == 0)
          const ReceivedConnectionsList()
        else
          const SentConnectionsList(),
      ],
    );
  }
}
