import 'package:hooks_riverpod/hooks_riverpod.dart';

// Helpers
import '../../../helpers/typedefs.dart';

final requestsProvider = Provider((_) => RequestsProvider());

class RequestsProvider {
  final _sentRequests = [
    {
      'student_connection_id': 4,
      'sender_erp': '17855',
      'receiver': {
        'erp': '15030',
        'profile_picture_url':
            'https://yourwikis.com/wp-content/uploads/2020/01/mark-zuck-img.jpg',
        'first_name': 'Mark',
        'last_name': 'Zuckerberg',
      },
      'connection_status': 'request_pending',
      'sent_at': '2021-10-04 17:24:40',
      'accepted_at': null
    },
    {
      'student_connection_id': 6,
      'sender_erp': '17855',
      'receiver': {
        'erp': '17987',
        'profile_picture_url':
            'https://the360report.com/wp-content/uploads/2020/10/jeff.jpg',
        'first_name': 'Jeff',
        'last_name': 'Bezos',
      },
      'connection_status': 'request_pending',
      'sent_at': '2021-10-04 17:24:40',
      'accepted_at': null
    },
    {
      'student_connection_id': 1,
      'sender_erp': '17855',
      'receiver': {
        'erp': '17167',
        'profile_picture_url':
            'https://the360report.com/wp-content/uploads/2020/10/jeff.jpg',
        'first_name': 'Kill',
        'last_name': 'Bill',
      },
      'connection_status': 'request_pending',
      'sent_at': '2021-10-04 17:24:40',
      'accepted_at': null
    },
  ];

  final _receivedRequests = [
    {
      'student_connection_id': 2,
      'receiver_erp': '17855',
      'sender': {
        'erp': '15030',
        'profile_picture_url':
            'https://yourwikis.com/wp-content/uploads/2020/01/mark-zuck-img.jpg',
        'first_name': 'Mark',
        'last_name': 'Zuckerberg',
      },
      'connection_status': 'request_pending',
      'sent_at': '2021-10-04 17:24:40',
      'accepted_at': null
    },
    {
      'student_connection_id': 3,
      'receiver_erp': '17855',
      'sender': {
        'erp': '17987',
        'profile_picture_url':
            'https://the360report.com/wp-content/uploads/2020/10/jeff.jpg',
        'first_name': 'Jeff',
        'last_name': 'Bezos',
      },
      'connection_status': 'request_pending',
      'sent_at': '2021-10-04 17:24:40',
      'accepted_at': null
    },
    {
      'student_connection_id': 5,
      'receiver_erp': '17855',
      'sender': {
        'erp': '17167',
        'profile_picture_url':
            'https://the360report.com/wp-content/uploads/2020/10/jeff.jpg',
        'first_name': 'Kill',
        'last_name': 'Bill',
      },
      'connection_status': 'request_pending',
      'sent_at': '2021-10-04 17:24:40',
      'accepted_at': null
    },
  ];

  List<JSON> getAllSentRequests() {
    return [..._sentRequests, ..._sentRequests, ..._sentRequests];
  }

  List<JSON> getAllReceivedRequests() {
    return [..._receivedRequests, ..._receivedRequests, ..._receivedRequests];
  }
}
