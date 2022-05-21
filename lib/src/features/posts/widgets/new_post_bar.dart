import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Providers
import '../../auth/providers/auth_provider.dart';

// Helpers
import '../../../helpers/constants/app_assets.dart';
import '../../../helpers/constants/app_colors.dart';
import '../../../helpers/constants/app_styles.dart';

// Routing
import '../../../config/routes/app_router.dart';
import '../../../config/routes/routes.dart';

// Enums
import '../../profile/enums/gender_enum.dart';

// Widgets
import '../../shared/widgets/custom_textfield.dart';

class NewPostBar extends StatelessWidget {
  const NewPostBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: ColoredBox(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Author
              Consumer(
                builder: (_, ref, __) {
                  final currentStudent = ref.watch(currentStudentProvider)!;
                  return Row(
                    children: [
                      // Name
                      Text(
                        'Hi, ${currentStudent.firstName}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Insets.gapW5,

                      // Icon
                      Image.asset(
                        currentStudent.gender == Gender.MALE
                            ? AppAssets.maleStudent
                            : AppAssets.femaleStudent,
                        width: 20,
                        height: 20,
                      ),
                    ],
                  );
                },
              ),

              Insets.gapH10,

              // New Post Button
              InkWell(
                onTap: () {
                  AppRouter.pushNamed(Routes.AddEditPostScreenRoute);
                },
                child: const CustomTextField(
                  height: 43,
                  enabled: false,
                  hintText: "What's on your mind?",
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: AppColors.textGreyColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
