import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Providers
import '../../../auth/providers/auth_provider.dart';
import '../../providers/campus_provider.dart';
import '../../providers/program_provider.dart';

// Helpers
import '../../../../helpers/extensions/datetime_extension.dart';
import '../../../../helpers/extensions/string_extension.dart';
import '../../../../helpers/constants/app_styles.dart';

// Widgets
import '../../../shared/widgets/labeled_widget.dart';

class AboutTabView extends HookConsumerWidget {
  const AboutTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentStudent = ref.watch(currentStudentProvider)!;
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
                  currentStudent.erp,
                ),
              ),

              // Gender
              LabeledWidget(
                label: 'Gender',
                child: Text(
                  currentStudent.gender.name.capitalize,
                ),
              ),

              // Birthday
              LabeledWidget(
                label: 'Birthday On',
                child: Text(
                  currentStudent.birthday.toDateString('d MMM, y'),
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
                  programs[currentStudent.programId]!,
                ),
              ),

              // Batch
              LabeledWidget(
                label: 'Batch',
                child: Text(
                  '${currentStudent.graduationYear}',
                ),
              ),

              // Favourite Campus
              LabeledWidget(
                label: 'Favourite Campus',
                child: Text(
                  campuses[currentStudent.campusId]!,
                ),
              ),
            ],
          ),

          Insets.gapH20,

          // Uni Email
          LabeledWidget(
            label: 'University Email',
            child: Text(
              currentStudent.uniEmail,
            ),
          ),

          Insets.gapH20,

          // Email
          LabeledWidget(
            label: 'Email',
            child: Text(
              currentStudent.email ?? 'Not specified',
            ),
          ),

          Insets.gapH20,

          // Contact
          LabeledWidget(
            label: 'Contact',
            child: Text(
              currentStudent.contact,
            ),
          ),
        ],
      ),
    );
  }
}
