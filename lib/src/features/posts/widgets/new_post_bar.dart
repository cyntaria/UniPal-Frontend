import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../config/routes/app_router.dart';
import '../../../config/routes/routes.dart';
import '../../../helpers/constants/app_colors.dart';
import '../../../helpers/constants/app_styles.dart';
import '../../profile/providers/students_provider.dart';
import '../../shared/widgets/custom_textfield.dart';

class NewPostBar extends StatelessWidget {
  const NewPostBar({Key? key}) : super(key: key);

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
                    studentsProvider.select(
                      (value) => value.currentStudent['profile_picture_url'],
                    ),
                  )! as String;
                  return CircleAvatar(
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
                    AppRouter.pushNamed(Routes.AddEditPostScreen);
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
