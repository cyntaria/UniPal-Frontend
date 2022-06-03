import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Providers
import '../../../requests/providers/student_connections_provider.dart';

// Models
import '../../../requests/models/sub_student_model.codegen.dart';
import '../../../requests/models/student_connection_model.codegen.dart';
import '../../models/student_model.codegen.dart';

// Helpers
import '../../../../helpers/constants/app_colors.dart';
import '../../../../helpers/constants/app_styles.dart';
import '../../../../helpers/constants/app_typography.dart';
import '../../../../helpers/extensions/datetime_extension.dart';

// Widgets
import '../../../shared/widgets/custom_network_image.dart';
import '../../../shared/widgets/error_response_handler.dart';
import '../../../shared/widgets/custom_refresh_indicator.dart';
import '../../../shared/widgets/empty_state_widget.dart';
import '../../../shared/widgets/async_value_widget.dart';
import '../../../shared/widgets/custom_circular_loader.dart';

final _friendsFutureProvider =
    FutureProvider.autoDispose.family<List<StudentConnectionModel>, String>(
  (ref, erp) async {
    final query = StudentModel.toUpdateJson(erp: erp);
    return ref.watch(studentConnectionsProvider).getAllFriends(query);
  },
);

class FriendsTabView extends ConsumerWidget {
  final String erp;

  const FriendsTabView({
    super.key,
    required this.erp,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomRefreshIndicator(
      onRefresh: () async => ref.refresh(_friendsFutureProvider(erp)),
      displacement: 21,
      child: AsyncValueWidget<List<StudentConnectionModel>>(
        value: ref.watch(_friendsFutureProvider(erp)),
        loading: () => const CustomCircularLoader(),
        error: (error, st) => ErrorResponseHandler(
          error: error,
          retryCallback: () => ref.refresh(_friendsFutureProvider(erp)),
          stackTrace: st,
        ),
        emptyOrNull: () => const SingleChildScrollView(
          physics: BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          child: EmptyStateWidget(
            height: 395,
            width: double.infinity,
            margin: EdgeInsets.only(top: 20),
            title: 'No friends added!',
          ),
        ),
        data: (connections) => ListView.separated(
          itemCount: connections.length,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          separatorBuilder: (_, __) => Insets.gapH15,
          itemBuilder: (ctx, i) => _FriendsListItem(
            friend: connections[i].sender.erp == erp
                ? connections[i].receiver
                : connections[i].sender,
            acceptedAt: connections[i].acceptedAt!,
          ),
        ),
      ),
    );
  }
}

class _FriendsListItem extends StatelessWidget {
  final SubStudentModel friend;
  final DateTime acceptedAt;

  const _FriendsListItem({
    required this.friend,
    required this.acceptedAt,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: Corners.rounded7,
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 214, 214, 214),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Other Author Image
          CustomNetworkImage(
            width: 69,
            height: 74,
            borderRadius: Corners.rounded4,
            fit: BoxFit.cover,
            imageUrl: friend.profilePictureUrl,
          ),

          Insets.gapW10,

          // Author Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  '${friend.firstName} ${friend.lastName}',
                  style: AppTypography.primary.body14.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(
                  'Batch Of ${friend.graduationYear}',
                  style: AppTypography.primary.subtitle13,
                ),

                // Request Sent Datetime
                Text(
                  'Became friends ${acceptedAt.toTimeAgoLabel()}',
                  style: AppTypography.primary.subtitle13.copyWith(
                    color: AppColors.textLightGreyColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
