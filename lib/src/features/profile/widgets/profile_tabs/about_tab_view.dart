import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Providers
import '../../../auth/providers/auth_provider.dart';
import '../../providers/campuses_provider.dart';
import '../../providers/programs_provider.dart';

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
    return ListView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 25),
      children: [
        // Bio Data
        Row(
          children: [
            // ERP
            LabeledWidget(
              label: 'ERP',
              child: Text(currentStudent.erp),
            ),

            const SizedBox(width: 60),

            // Gender
            LabeledWidget(
              label: 'Gender',
              child: Text(currentStudent.gender.name.capitalize),
            ),

            const SizedBox(width: 50),

            // Birthday
            LabeledWidget(
              label: 'Birthday Date',
              child: Text(currentStudent.birthday.toDateString('d MMM, y')),
            ),
          ],
        ),

        Insets.gapH20,

        // Uni Data
        Row(
          children: [
            // Program
            Consumer(
              builder: (_, _ref, __) {
                final program = _ref.watch(
                  programByIdProvider(currentStudent.programId),
                );
                return LabeledWidget(
                  label: 'Program',
                  child: Text(program.program),
                );
              },
            ),

            const SizedBox(width: 45),

            // Batch
            LabeledWidget(
              label: 'Batch',
              child: Text('${currentStudent.graduationYear}'),
            ),

            const SizedBox(width: 60),

            // Enrolled Campus
            Consumer(
              builder: (_, _ref, __) {
                final campus = _ref.watch(
                  campusByIdProvider(currentStudent.campusId),
                );
                return LabeledWidget(
                  label: 'Enrolled Campus',
                  child: Text(campus.campus),
                );
              },
            ),
          ],
        ),

        Insets.gapH20,

        // Uni Email
        LabeledWidget(
          label: 'University Email',
          child: Text(currentStudent.uniEmail),
        ),

        Insets.gapH20,

        // Email
        LabeledWidget(
          label: 'Email',
          child: Text(currentStudent.email ?? 'Not specified'),
        ),

        Insets.gapH20,

        // Contact
        LabeledWidget(
          label: 'Contact',
          child: Text(currentStudent.contact),
        ),
      ],
    );
  }
}
