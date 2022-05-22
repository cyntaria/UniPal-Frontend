import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Providers
import '../../providers/student_connections_provider.dart';

// Models
import '../../models/student_connection_model.codegen.dart';

// Helpers
import '../../../../helpers/constants/app_styles.dart';
import '../../../../helpers/constants/app_colors.dart';

// Widgets
import '../../../shared/widgets/error_response_handler.dart';
import '../../../shared/widgets/async_value_widget.dart';
import '../../../shared/widgets/custom_circular_loader.dart';
import 'connection_list_item.dart';

class SentConnectionsList extends ConsumerWidget {
  const SentConnectionsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueWidget<List<StudentConnectionModel>>(
      value: ref.watch(sentConnectionsProvider),
      loading: () => const CustomCircularLoader(
        color: AppColors.primaryColor,
      ),
      error: (error, st) => ErrorResponseHandler(
        error: error,
        retryCallback: () => ref.refresh(sentConnectionsProvider),
        stackTrace: st,
      ),
      data: (requests) => ListView.separated(
        itemCount: requests.length,
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(),
        separatorBuilder: (_, __) => Insets.gapH15,
        itemBuilder: (_, i) => ConnectionListItem(
          studentConnection: requests[i],
        ),
      ),
    );
  }
}
