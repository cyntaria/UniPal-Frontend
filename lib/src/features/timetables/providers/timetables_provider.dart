import 'dart:collection';

import 'package:hooks_riverpod/hooks_riverpod.dart';

// Helpers
import '../../../helpers/typedefs.dart';

final timetablesProvider = Provider((ref) {
  return TimetablesProvider();
});

class TimetablesProvider {
  final _generatedTimetables = [
    {
      'monday': {
        '2': {
          'class_erp': '5756',
          'semester': 'CS-3',
          'parent_class_erp': null,
          'day_1': 'monday',
          'day_2': 'wednesday',
          'term_id': 1,
          'classroom': {
            'classroom_id': 1,
            'classroom': 'MTC1',
            'campus': {'campus_id': 1, 'campus': 'MAIN'}
          },
          'subject': {'subject_code': 'CSE555', 'subject': 'Data Structures'},
          'teacher': {
            'teacher_id': 5,
            'full_name': 'Imran Khan',
            'average_rating': '0.000',
            'total_reviews': 0
          },
          'timeslot_1': {
            'timeslot_id': 2,
            'start_time': '10:00:00',
            'end_time': '11:15:00',
            'slot_number': 2
          },
          'timeslot_2': {
            'timeslot_id': 2,
            'start_time': '10:00:00',
            'end_time': '11:15:00',
            'slot_number': 2
          }
        },
        '3': {
          'class_erp': '5757',
          'semester': 'CS-3',
          'parent_class_erp': '5756',
          'day_1': 'monday',
          'day_2': 'wednesday',
          'term_id': 1,
          'classroom': {
            'classroom_id': 4,
            'classroom': 'MTL4',
            'campus': {'campus_id': 1, 'campus': 'MAIN'}
          },
          'subject': {'subject_code': 'CSE555', 'subject': 'Data Structures'},
          'teacher': {
            'teacher_id': 5,
            'full_name': 'Imran Khan',
            'average_rating': '0.000',
            'total_reviews': 0
          },
          'timeslot_1': {
            'timeslot_id': 3,
            'start_time': '11:30:00',
            'end_time': '12:45:00',
            'slot_number': 3
          },
          'timeslot_2': {
            'timeslot_id': 3,
            'start_time': '11:30:00',
            'end_time': '12:45:00',
            'slot_number': 3
          }
        }
      },
      'wednesday': {
        '2': {
          'class_erp': '5756',
          'semester': 'CS-3',
          'parent_class_erp': null,
          'day_1': 'monday',
          'day_2': 'wednesday',
          'term_id': 1,
          'classroom': {
            'classroom_id': 1,
            'classroom': 'MTC1',
            'campus': {'campus_id': 1, 'campus': 'MAIN'}
          },
          'subject': {'subject_code': 'CSE555', 'subject': 'Data Structures'},
          'teacher': {
            'teacher_id': 5,
            'full_name': 'Imran Khan',
            'average_rating': '0.000',
            'total_reviews': 0
          },
          'timeslot_1': {
            'timeslot_id': 2,
            'start_time': '10:00:00',
            'end_time': '11:15:00',
            'slot_number': 2
          },
          'timeslot_2': {
            'timeslot_id': 2,
            'start_time': '10:00:00',
            'end_time': '11:15:00',
            'slot_number': 2
          }
        },
        '3': {
          'class_erp': '5757',
          'semester': 'CS-3',
          'parent_class_erp': '5756',
          'day_1': 'monday',
          'day_2': 'wednesday',
          'term_id': 1,
          'classroom': {
            'classroom_id': 4,
            'classroom': 'MTL4',
            'campus': {'campus_id': 1, 'campus': 'MAIN'}
          },
          'subject': {'subject_code': 'CSE555', 'subject': 'Data Structures'},
          'teacher': {
            'teacher_id': 5,
            'full_name': 'Imran Khan',
            'average_rating': '0.000',
            'total_reviews': 0
          },
          'timeslot_1': {
            'timeslot_id': 3,
            'start_time': '11:30:00',
            'end_time': '12:45:00',
            'slot_number': 3
          },
          'timeslot_2': {
            'timeslot_id': 3,
            'start_time': '11:30:00',
            'end_time': '12:45:00',
            'slot_number': 3
          }
        }
      },
      'tuesday': {
        '2': {
          'class_erp': '5758',
          'semester': 'ACF-2',
          'parent_class_erp': null,
          'day_1': 'tuesday',
          'day_2': 'thursday',
          'term_id': 2,
          'classroom': {
            'classroom_id': 3,
            'classroom': 'MCC1',
            'campus': {'campus_id': 1, 'campus': 'MAIN'}
          },
          'subject': {
            'subject_code': 'CSE401',
            'subject': 'Network Communications'
          },
          'teacher': {
            'teacher_id': 1,
            'full_name': 'Waseem Arain',
            'average_rating': '5.000',
            'total_reviews': 1
          },
          'timeslot_1': {
            'timeslot_id': 2,
            'start_time': '10:00:00',
            'end_time': '11:15:00',
            'slot_number': 2
          },
          'timeslot_2': {
            'timeslot_id': 2,
            'start_time': '10:00:00',
            'end_time': '11:15:00',
            'slot_number': 2
          }
        },
        '3': {
          'class_erp': '5760',
          'semester': 'ECO-2',
          'parent_class_erp': null,
          'day_1': 'tuesday',
          'day_2': 'thursday',
          'term_id': 2,
          'classroom': {
            'classroom_id': 5,
            'classroom': 'MTS2',
            'campus': {'campus_id': 1, 'campus': 'MAIN'}
          },
          'subject': {
            'subject_code': 'HUM201',
            'subject': 'Speech Communication'
          },
          'teacher': {
            'teacher_id': 2,
            'full_name': 'Faisal Iradat',
            'average_rating': '3.600',
            'total_reviews': 2
          },
          'timeslot_1': {
            'timeslot_id': 3,
            'start_time': '11:30:00',
            'end_time': '12:45:00',
            'slot_number': 3
          },
          'timeslot_2': {
            'timeslot_id': 3,
            'start_time': '11:30:00',
            'end_time': '12:45:00',
            'slot_number': 3
          }
        },
        '5': {
          'class_erp': '5755',
          'semester': 'CS-7',
          'parent_class_erp': null,
          'day_1': 'tuesday',
          'day_2': 'thursday',
          'term_id': 2,
          'classroom': {
            'classroom_id': 3,
            'classroom': 'MCC1',
            'campus': {'campus_id': 1, 'campus': 'MAIN'}
          },
          'subject': {'subject_code': 'CSE452', 'subject': 'Data Warehousing'},
          'teacher': {
            'teacher_id': 4,
            'full_name': 'Anwar-Ul-Haq',
            'average_rating': '0.000',
            'total_reviews': 0
          },
          'timeslot_1': {
            'timeslot_id': 5,
            'start_time': '14:30:00',
            'end_time': '15:45:00',
            'slot_number': 5
          },
          'timeslot_2': {
            'timeslot_id': 5,
            'start_time': '14:30:00',
            'end_time': '15:45:00',
            'slot_number': 5
          }
        }
      },
      'thursday': {
        '2': {
          'class_erp': '5758',
          'semester': 'ACF-2',
          'parent_class_erp': null,
          'day_1': 'tuesday',
          'day_2': 'thursday',
          'term_id': 2,
          'classroom': {
            'classroom_id': 3,
            'classroom': 'MCC1',
            'campus': {'campus_id': 1, 'campus': 'MAIN'}
          },
          'subject': {
            'subject_code': 'CSE401',
            'subject': 'Network Communications'
          },
          'teacher': {
            'teacher_id': 1,
            'full_name': 'Waseem Arain',
            'average_rating': '5.000',
            'total_reviews': 1
          },
          'timeslot_1': {
            'timeslot_id': 2,
            'start_time': '10:00:00',
            'end_time': '11:15:00',
            'slot_number': 2
          },
          'timeslot_2': {
            'timeslot_id': 2,
            'start_time': '10:00:00',
            'end_time': '11:15:00',
            'slot_number': 2
          }
        },
        '3': {
          'class_erp': '5760',
          'semester': 'ECO-2',
          'parent_class_erp': null,
          'day_1': 'tuesday',
          'day_2': 'thursday',
          'term_id': 2,
          'classroom': {
            'classroom_id': 5,
            'classroom': 'MTS2',
            'campus': {'campus_id': 1, 'campus': 'MAIN'}
          },
          'subject': {
            'subject_code': 'HUM201',
            'subject': 'Speech Communication'
          },
          'teacher': {
            'teacher_id': 2,
            'full_name': 'Faisal Iradat',
            'average_rating': '3.600',
            'total_reviews': 2
          },
          'timeslot_1': {
            'timeslot_id': 3,
            'start_time': '11:30:00',
            'end_time': '12:45:00',
            'slot_number': 3
          },
          'timeslot_2': {
            'timeslot_id': 3,
            'start_time': '11:30:00',
            'end_time': '12:45:00',
            'slot_number': 3
          }
        },
        '5': {
          'class_erp': '5755',
          'semester': 'CS-7',
          'parent_class_erp': null,
          'day_1': 'tuesday',
          'day_2': 'thursday',
          'term_id': 2,
          'classroom': {
            'classroom_id': 3,
            'classroom': 'MCC1',
            'campus': {'campus_id': 1, 'campus': 'MAIN'}
          },
          'subject': {'subject_code': 'CSE452', 'subject': 'Data Warehousing'},
          'teacher': {
            'teacher_id': 4,
            'full_name': 'Anwar-Ul-Haq',
            'average_rating': '0.000',
            'total_reviews': 0
          },
          'timeslot_1': {
            'timeslot_id': 5,
            'start_time': '14:30:00',
            'end_time': '15:45:00',
            'slot_number': 5
          },
          'timeslot_2': {
            'timeslot_id': 5,
            'start_time': '14:30:00',
            'end_time': '15:45:00',
            'slot_number': 5
          }
        }
      }
    },
    {
      'monday': {
        '2': {
          'class_erp': '5756',
          'semester': 'CS-3',
          'parent_class_erp': null,
          'day_1': 'monday',
          'day_2': 'wednesday',
          'term_id': 1,
          'classroom': {
            'classroom_id': 1,
            'classroom': 'MTC1',
            'campus': {'campus_id': 1, 'campus': 'MAIN'}
          },
          'subject': {'subject_code': 'CSE555', 'subject': 'Data Structures'},
          'teacher': {
            'teacher_id': 5,
            'full_name': 'Imran Khan',
            'average_rating': '0.000',
            'total_reviews': 0
          },
          'timeslot_1': {
            'timeslot_id': 2,
            'start_time': '10:00:00',
            'end_time': '11:15:00',
            'slot_number': 2
          },
          'timeslot_2': {
            'timeslot_id': 2,
            'start_time': '10:00:00',
            'end_time': '11:15:00',
            'slot_number': 2
          }
        },
        '3': {
          'class_erp': '5757',
          'semester': 'CS-3',
          'parent_class_erp': '5756',
          'day_1': 'monday',
          'day_2': 'wednesday',
          'term_id': 1,
          'classroom': {
            'classroom_id': 4,
            'classroom': 'MTL4',
            'campus': {'campus_id': 1, 'campus': 'MAIN'}
          },
          'subject': {'subject_code': 'CSE555', 'subject': 'Data Structures'},
          'teacher': {
            'teacher_id': 5,
            'full_name': 'Imran Khan',
            'average_rating': '0.000',
            'total_reviews': 0
          },
          'timeslot_1': {
            'timeslot_id': 3,
            'start_time': '11:30:00',
            'end_time': '12:45:00',
            'slot_number': 3
          },
          'timeslot_2': {
            'timeslot_id': 3,
            'start_time': '11:30:00',
            'end_time': '12:45:00',
            'slot_number': 3
          }
        }
      },
      'wednesday': {
        '2': {
          'class_erp': '5756',
          'semester': 'CS-3',
          'parent_class_erp': null,
          'day_1': 'monday',
          'day_2': 'wednesday',
          'term_id': 1,
          'classroom': {
            'classroom_id': 1,
            'classroom': 'MTC1',
            'campus': {'campus_id': 1, 'campus': 'MAIN'}
          },
          'subject': {'subject_code': 'CSE555', 'subject': 'Data Structures'},
          'teacher': {
            'teacher_id': 5,
            'full_name': 'Imran Khan',
            'average_rating': '0.000',
            'total_reviews': 0
          },
          'timeslot_1': {
            'timeslot_id': 2,
            'start_time': '10:00:00',
            'end_time': '11:15:00',
            'slot_number': 2
          },
          'timeslot_2': {
            'timeslot_id': 2,
            'start_time': '10:00:00',
            'end_time': '11:15:00',
            'slot_number': 2
          }
        },
        '3': {
          'class_erp': '5757',
          'semester': 'CS-3',
          'parent_class_erp': '5756',
          'day_1': 'monday',
          'day_2': 'wednesday',
          'term_id': 1,
          'classroom': {
            'classroom_id': 4,
            'classroom': 'MTL4',
            'campus': {'campus_id': 1, 'campus': 'MAIN'}
          },
          'subject': {'subject_code': 'CSE555', 'subject': 'Data Structures'},
          'teacher': {
            'teacher_id': 5,
            'full_name': 'Imran Khan',
            'average_rating': '0.000',
            'total_reviews': 0
          },
          'timeslot_1': {
            'timeslot_id': 3,
            'start_time': '11:30:00',
            'end_time': '12:45:00',
            'slot_number': 3
          },
          'timeslot_2': {
            'timeslot_id': 3,
            'start_time': '11:30:00',
            'end_time': '12:45:00',
            'slot_number': 3
          }
        }
      },
      'tuesday': {
        '2': {
          'class_erp': '5759',
          'semester': 'ECO-2',
          'parent_class_erp': null,
          'day_1': 'tuesday',
          'day_2': 'thursday',
          'term_id': 2,
          'classroom': {
            'classroom_id': 5,
            'classroom': 'MTS2',
            'campus': {'campus_id': 1, 'campus': 'MAIN'}
          },
          'subject': {
            'subject_code': 'HUM201',
            'subject': 'Speech Communication'
          },
          'teacher': {
            'teacher_id': 2,
            'full_name': 'Faisal Iradat',
            'average_rating': '3.600',
            'total_reviews': 2
          },
          'timeslot_1': {
            'timeslot_id': 2,
            'start_time': '10:00:00',
            'end_time': '11:15:00',
            'slot_number': 2
          },
          'timeslot_2': {
            'timeslot_id': 2,
            'start_time': '10:00:00',
            'end_time': '11:15:00',
            'slot_number': 2
          }
        },
        '5': {
          'class_erp': '5755',
          'semester': 'CS-7',
          'parent_class_erp': null,
          'day_1': 'tuesday',
          'day_2': 'thursday',
          'term_id': 2,
          'classroom': {
            'classroom_id': 3,
            'classroom': 'MCC1',
            'campus': {'campus_id': 1, 'campus': 'MAIN'}
          },
          'subject': {'subject_code': 'CSE452', 'subject': 'Data Warehousing'},
          'teacher': {
            'teacher_id': 4,
            'full_name': 'Anwar-Ul-Haq',
            'average_rating': '0.000',
            'total_reviews': 0
          },
          'timeslot_1': {
            'timeslot_id': 5,
            'start_time': '14:30:00',
            'end_time': '15:45:00',
            'slot_number': 5
          },
          'timeslot_2': {
            'timeslot_id': 5,
            'start_time': '14:30:00',
            'end_time': '15:45:00',
            'slot_number': 5
          }
        }
      },
      'thursday': {
        '2': {
          'class_erp': '5759',
          'semester': 'ECO-2',
          'parent_class_erp': null,
          'day_1': 'tuesday',
          'day_2': 'thursday',
          'term_id': 2,
          'classroom': {
            'classroom_id': 5,
            'classroom': 'MTS2',
            'campus': {'campus_id': 1, 'campus': 'MAIN'}
          },
          'subject': {
            'subject_code': 'HUM201',
            'subject': 'Speech Communication'
          },
          'teacher': {
            'teacher_id': 2,
            'full_name': 'Faisal Iradat',
            'average_rating': '3.600',
            'total_reviews': 2
          },
          'timeslot_1': {
            'timeslot_id': 2,
            'start_time': '10:00:00',
            'end_time': '11:15:00',
            'slot_number': 2
          },
          'timeslot_2': {
            'timeslot_id': 2,
            'start_time': '10:00:00',
            'end_time': '11:15:00',
            'slot_number': 2
          }
        },
        '5': {
          'class_erp': '5755',
          'semester': 'CS-7',
          'parent_class_erp': null,
          'day_1': 'tuesday',
          'day_2': 'thursday',
          'term_id': 2,
          'classroom': {
            'classroom_id': 3,
            'classroom': 'MCC1',
            'campus': {'campus_id': 1, 'campus': 'MAIN'}
          },
          'subject': {'subject_code': 'CSE452', 'subject': 'Data Warehousing'},
          'teacher': {
            'teacher_id': 4,
            'full_name': 'Anwar-Ul-Haq',
            'average_rating': '0.000',
            'total_reviews': 0
          },
          'timeslot_1': {
            'timeslot_id': 5,
            'start_time': '14:30:00',
            'end_time': '15:45:00',
            'slot_number': 5
          },
          'timeslot_2': {
            'timeslot_id': 5,
            'start_time': '14:30:00',
            'end_time': '15:45:00',
            'slot_number': 5
          }
        }
      }
    }
  ];

  UnmodifiableListView<JSON> get generatedTimetables =>
      UnmodifiableListView(_generatedTimetables);
}
