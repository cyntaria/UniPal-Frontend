import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Providers
import '../../providers/campus_provider.dart';
import '../../providers/program_provider.dart';
import '../../providers/students_provider.dart';

// Helpers
import '../../../../helpers/constants/app_styles.dart';

// Widgets
import '../../../shared/widgets/labeled_widget.dart';

class UniversityTabView extends HookConsumerWidget {
  const UniversityTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentStudent = ref.watch(
      studentsProvider.select((value) => value.currentStudent),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: ListView(
        children: [
          // Uni Email
          LabeledWidget(
            label: 'University Email',
            child: Text(
              currentStudent['uni_email']! as String,
            ),
          ),

          Insets.gapH20,

          // Batch
          LabeledWidget(
            label: 'Batch',
            child: Text(
              currentStudent['graduation_year'].toString(),
            ),
          ),

          Insets.gapH20,

          // Program
          LabeledWidget(
            label: 'Program',
            child: Text(
              programs[currentStudent['program_id']! as int]!,
            ),
          ),

          Insets.gapH20,

          // Favourite Campus
          LabeledWidget(
            label: 'Favourite Campus',
            child: Text(
              campuses[currentStudent['campus_id']! as int]!,
            ),
          ),
        ],
      ),
    );
  }
}
