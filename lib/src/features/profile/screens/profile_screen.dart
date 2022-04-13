import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Providers
import '../../auth/providers/auth_provider.dart';

// Helpers
import '../../../helpers/constants/app_colors.dart';
import '../../../helpers/typedefs.dart';

// Widgets
import '../widgets/profile_app_bar.dart';
import '../widgets/profile_tab_bar.dart';
import '../widgets/student_connection_buttons.dart';

const connectStudent = {
  'erp': '15030',
  'first_name': 'Mohammad Rafay',
  'last_name': 'Siddiqui',
  'gender': 'male',
  'contact': '+923009999999',
  'email': 'rafaysiddiqui58@gmail.com',
  'birthday': '1999-09-18',
  'profile_picture_url':
      'https://i.pinimg.com/564x/8d/e3/89/8de389c84e919d3577f47118e2627d95.jpg',
  'graduation_year': 2022,
  'uni_email': 'm.rafay.15030@iba.khi.edu.pk',
  'hobby_1': 1,
  'hobby_2': 2,
  'hobby_3': 3,
  'interest_1': 1,
  'interest_2': 2,
  'interest_3': 3,
  'program_id': 1,
  'campus_id': 1,
  'favourite_campus_hangout_spot': 'CED',
  'favourite_campus_activity': 'Lifting',
  'current_status': 'Looking for friends',
  'is_active': 1,
  'role': 'admin',
  'student_connection': {
    'student_connection_id': 5,
    'sender_erp': '17855',
    'receiver_erp': '15030',
    'connection_status': 'request_pending',
    'sent_at': '2021-10-04 17:24:40',
    'accepted_at': null
  }
};

const myProfile = {
  'erp': '17855',
  'first_name': 'Abdur Rafay',
  'last_name': 'Saleem',
  'gender': 'male',
  'contact': '+923009999999',
  'email': 'arafaysaleem@gmail.com',
  'birthday': '1999-09-18',
  'profile_picture_url':
      'https://i.pinimg.com/564x/8d/e3/89/8de389c84e919d3577f47118e2627d95.jpg',
  'graduation_year': 2022,
  'uni_email': 'a.rafay.17855@iba.khi.edu.pk',
  'hobby_1': 1,
  'hobby_2': 2,
  'hobby_3': 3,
  'interest_1': 1,
  'interest_2': 2,
  'interest_3': 3,
  'program_id': 1,
  'campus_id': 1,
  'favourite_campus_hangout_spot': 'CED',
  'favourite_campus_activity': 'Lifting',
  'current_status': 1,
  'is_active': 1,
  'role': 'api_user',
  'token':
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlcnAiOiIxNzg1NSIsImlhdCI6MTYzMDAxMzEwMywiZXhwIjoxNjMwMjcyMzAzfQ.VMcjA3JcOTDlg6roDKBJjJBHShzjemeGh2w6degMfkc'
};

class ProfileScreen extends HookConsumerWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: 3,
          child: NestedScrollView(
            headerSliverBuilder: (BuildContext context, _) {
              return <Widget>[
                // Profile Picture and Name
                ProfileAppBar(
                  extent: 310,
                  avatarUrl: connectStudent['profile_picture_url']! as String,
                  title:
                      "${connectStudent['first_name']} ${connectStudent['last_name']}",
                  subtitle: connectStudent['current_status']! as String,
                  trailing: InkWell(
                    onTap: () => ref.read(authProvider.notifier).logout(),
                    child: const Icon(
                      Icons.logout_rounded,
                      color: AppColors.redColor,
                    ),
                  ),
                  child: StudentConnectionButtons(
                    studentConnection:
                        connectStudent['student_connection'] as JSON?,
                    myErp: myProfile['erp']! as String,
                    studentErp: connectStudent['erp']! as String,
                  ),
                ),

                // Tabs
                const ProfileTabBar(),
              ];
            },
            body: const Center(
              child: Text('Sample Text'),
            ),
          ),
        ),
      ),
    );
  }
}
