import 'package:hooks_riverpod/hooks_riverpod.dart';

// Helpers
import '../../../helpers/typedefs.dart';

final requestsProvider = Provider((_) => RequestsProvider());

class RequestsProvider {
  final _sentHangoutRequests = [
    {
      'hangout_request_id': 1,
      'sender_erp': '17855',
      'receiver': {
        'erp': '15030',
        'profile_picture_url':
            'https://yourwikis.com/wp-content/uploads/2020/01/mark-zuck-img.jpg',
        'first_name': 'Mark',
        'last_name': 'Zuckerberg',
      },
      'request_status': 'request_pending',
      'purpose': 'Grabbing a snack',
      'meetup_at': '2021-10-04 17:24:40',
      'meetup_spot_id': 7,
      'accepted_at': null
    },
    {
      'hangout_request_id': 2,
      'sender_erp': '17855',
      'receiver': {
        'erp': '15030',
        'profile_picture_url':
            'https://yourwikis.com/wp-content/uploads/2020/01/mark-zuck-img.jpg',
        'first_name': 'Muhammad Rafay',
        'last_name': 'Siddiqui',
      },
      'request_status': 'request_pending',
      'purpose': 'Discussing FYP',
      'meetup_at': '2021-10-04 17:24:40',
      'meetup_spot_id': 2,
      'accepted_at': null
    }
  ];

  final _receivedHangoutRequests = [
    {
      'hangout_request_id': 1,
      'receiver_erp': '17855',
      'sender': {
        'erp': '15030',
        'profile_picture_url':
            'https://yourwikis.com/wp-content/uploads/2020/01/mark-zuck-img.jpg',
        'first_name': 'Mark',
        'last_name': 'Zuckerberg',
      },
      'request_status': 'request_pending',
      'purpose': 'Grabbing a snack',
      'meetup_at': '2021-10-04 17:24:40',
      'meetup_spot_id': 7,
      'accepted_at': null
    },
    {
      'hangout_request_id': 3,
      'receiver_erp': '17855',
      'sender': {
        'erp': '17987',
        'profile_picture_url':
            'https://the360report.com/wp-content/uploads/2020/10/jeff.jpg',
        'first_name': 'Jeff',
        'last_name': 'Bezos',
      },
      'request_status': 'request_pending',
      'purpose': 'Discussing FYP',
      'meetup_at': '2021-10-04 17:24:40',
      'meetup_spot_id': 1,
      'accepted_at': null
    },
    {
      'hangout_request_id': 4,
      'receiver_erp': '17855',
      'sender': {
        'erp': '17987',
        'profile_picture_url':
            'https://the360report.com/wp-content/uploads/2020/10/jeff.jpg',
        'first_name': 'Jeff',
        'last_name': 'Bezos',
      },
      'request_status': 'request_pending',
      'purpose': 'Need to sell Amazon',
      'meetup_at': '2021-10-04 17:24:40',
      'meetup_spot_id': 2,
      'accepted_at': null
    }
  ];

  List<JSON> getAllSentHangoutRequests() {
    return [
      ..._sentHangoutRequests,
      ..._sentHangoutRequests,
      ..._sentHangoutRequests,
    ];
  }

  List<JSON> getAllReceivedHangoutRequests() {
    return [
      ..._receivedHangoutRequests,
      ..._receivedHangoutRequests,
      ..._receivedHangoutRequests,
    ];
  }
}
