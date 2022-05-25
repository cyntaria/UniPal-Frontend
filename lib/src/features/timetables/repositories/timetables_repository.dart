import 'package:hooks_riverpod/hooks_riverpod.dart';

// Networking
import '../../../core/networking/api_endpoint.dart';
import '../../../core/networking/api_service.dart';

// Models
import '../../../helpers/extensions/int_extension.dart';
import '../models/generated_timetable_model.codegen.dart';
import '../models/timetable_model.codegen.dart';

// Providers
import '../../all_providers.dart';

// Helpers
import '../../../helpers/typedefs.dart';

final timetablesRepositoryProvider = Provider<TimetablesRepository>(
  (ref) {
    final _apiService = ref.watch(apiServiceProvider);
    return TimetablesRepository(apiService: _apiService);
  },
);

class TimetablesRepository {
  final ApiService _apiService;

  TimetablesRepository({
    required ApiService apiService,
  }) : _apiService = apiService;

  Future<List<TimetableModel>> fetchAllTimetables({
    JSON? queryParameters,
  }) async {
    return _apiService.getCollectionData<TimetableModel>(
      endpoint: ApiEndpoint.timetables(TimetableEndpoint.BASE),
      queryParams: queryParameters,
      converter: TimetableModel.fromJson,
    );
  }

  Future<TimetableModel> fetchOne({
    required int timetableId,
  }) async {
    return _apiService.getDocumentData<TimetableModel>(
      endpoint: ApiEndpoint.timetables(
        TimetableEndpoint.BY_ID,
        id: timetableId,
      ),
      converter: TimetableModel.fromJson,
    );
  }

  Future<List<GeneratedTimetableJSON>> generate({required JSON data}) async {
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
            'subject': {
              'subject_code': 'CSE452',
              'subject': 'Data Warehousing'
            },
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
            'subject': {
              'subject_code': 'CSE452',
              'subject': 'Data Warehousing'
            },
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
            'subject': {
              'subject_code': 'CSE452',
              'subject': 'Data Warehousing'
            },
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
            'subject': {
              'subject_code': 'CSE452',
              'subject': 'Data Warehousing'
            },
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

    return Future.delayed(
      3.seconds,
      () => _generatedTimetables
          .map(GeneratedTimetableModel.parseGeneratedJSON)
          .toList(),
    );

    // return _apiService.setAndGetCollectionData<GeneratedTimetableJSON>(
    //   endpoint: ApiEndpoint.timetables(TimetableEndpoint.GENERATE),
    //   data: data,
    //   converter: GeneratedTimetableModel.parseGeneratedJSON,
    // );
  }

  Future<int> create({required JSON data}) async {
    return _apiService.setData<int>(
      endpoint: ApiEndpoint.timetables(TimetableEndpoint.BASE),
      data: data,
      converter: (response) => response.body['timetable_id'] as int,
    );
  }

  Future<String> update({
    required int timetableId,
    required JSON data,
  }) async {
    return _apiService.updateData<String>(
      endpoint: ApiEndpoint.timetables(
        TimetableEndpoint.BY_ID,
        id: timetableId,
      ),
      data: data,
      converter: (response) => response.headers.message,
    );
  }

  Future<String> updateClasses({
    required int timetableId,
    required JSON data,
  }) async {
    return _apiService.updateData<String>(
      endpoint: ApiEndpoint.timetables(
        TimetableEndpoint.CLASSES_BASE,
        id: timetableId,
      ),
      data: data,
      converter: (response) => response.headers.message,
    );
  }

  Future<String> delete({
    required int timetableId,
    JSON? data,
  }) async {
    return _apiService.deleteData<String>(
      endpoint: ApiEndpoint.timetables(
        TimetableEndpoint.BY_ID,
        id: timetableId,
      ),
      data: data,
      converter: (response) => response.headers.message,
    );
  }
}
