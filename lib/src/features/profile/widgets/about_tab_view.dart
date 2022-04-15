import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Providers
import '../providers/students_provider.dart';

// Helpers
import '../../../helpers/constants/app_styles.dart';

// Widgets
import '../../shared/widgets/labeled_widget.dart';

class AboutTabView extends HookConsumerWidget {
  const AboutTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentStudent = ref.watch(
      studentsProvider.select((value) => value.currentStudent),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: ListView(
        children: [
          LabeledWidget(
            label: 'ERP',
            child: Text(
              currentStudent['erp']! as String,
            ),
          ),

          Insets.gapH20,

          // Gender
          LabeledWidget(
            label: 'Gender',
            child: Text(
              currentStudent['gender']! as String,
            ),
          ),

          Insets.gapH20,

          // Contact
          LabeledWidget(
            label: 'Contact',
            child: Text(
              currentStudent['contact']! as String,
            ),
          ),

          Insets.gapH20,
          
          // Email
          LabeledWidget(
            label: 'Email',
            child: Text(
              currentStudent['email']! as String,
            ),
          ),

          
          Insets.gapH20,
          
          // Birthday
          LabeledWidget(
            label: 'Birthday',
            child: Text(
              currentStudent['birthday']! as String,
            ),
          ),
        ],
      ),
    );
  }
}
