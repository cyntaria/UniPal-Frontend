import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Providers
import '../../auth/providers/auth_provider.dart';

// Helpers
import '../../../helpers/constants/app_colors.dart';
import '../../../helpers/constants/app_styles.dart';

// Routing
import '../../../config/routes/app_router.dart';
import '../../../config/routes/routes.dart';

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
          child: Row(
            children: [
              // Author Avatar
              Consumer(
                builder: (_, ref, __) {
                  final authorProfilePicture = ref.watch(
                    currentStudentProvider.select(
                      (value) => value?.profilePictureUrl,
                    ),
                  );
                  return authorProfilePicture == null
                      ? const SizedBox.shrink()
                      : CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(authorProfilePicture),
                        );
                },
              ),

              Insets.gapW15,

              // New Post Button
              Expanded(
                child: InkWell(
                  onTap: () {
                    AppRouter.pushNamed(Routes.AddEditPostScreenRoute);
                  },
                  child: const CustomTextField(
                    height: 40,
                    enabled: false,
                    hintText: "What's on your mind?",
                    hintStyle: TextStyle(
                      fontSize: 14,
                      color: AppColors.textGreyColor,
                    ),
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
