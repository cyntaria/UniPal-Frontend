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
          // Bio Data
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // ERP
              LabeledWidget(
                label: 'ERP',
                child: Text(
                  currentStudent['erp']! as String,
                ),
              ),

              // Gender
              LabeledWidget(
                label: 'Gender',
                child: Text(
                  currentStudent['gender']! as String,
                ),
              ),

              // Birthday
              LabeledWidget(
                label: 'Birthday On',
                child: Text(
                  currentStudent['birthday']! as String,
                ),
              ),
            ],
          ),

          Insets.gapH20,

          // Uni Data
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Program
              LabeledWidget(
                label: 'Program',
                child: Text(
                  programs[currentStudent['program_id']! as int]!,
                ),
              ),

              // Batch
              LabeledWidget(
                label: 'Batch',
                child: Text(
                  currentStudent['graduation_year'].toString(),
                ),
              ),

              // Favourite Campus
              LabeledWidget(
                label: 'Favourite Campus',
                child: Text(
                  campuses[currentStudent['campus_id']! as int]!,
                ),
              ),
            ],
          ),

          Insets.gapH20,

          // Uni Email
          LabeledWidget(
            label: 'University Email',
            child: Text(
              currentStudent['uni_email']! as String,
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

          // Contact
          LabeledWidget(
            label: 'Contact',
            child: Text(
              currentStudent['contact']! as String,
            ),
          ),
        ],
      ),
    );
  }
}
