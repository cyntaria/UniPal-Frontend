import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Models
import '../../models/hangout_request_model.codegen.dart';

// Providers
import '../../../activities/providers/campus_spots_provider.dart';
import '../../../profile/providers/campuses_provider.dart';
import '../../../profile/providers/programs_provider.dart';

// Helpers
import '../../../../helpers/constants/app_utils.dart';
import '../../../../helpers/constants/app_colors.dart';
import '../../../../helpers/constants/app_styles.dart';
import '../../../../helpers/constants/app_typography.dart';
import '../../../../helpers/extensions/string_extension.dart';
import '../../../../helpers/extensions/datetime_extension.dart';

// Widgets
import '../../../shared/widgets/custom_network_image.dart';
import '../../../shared/widgets/labeled_widget.dart';
import '../connections/connection_list_item.dart';

class HangoutListItem extends StatelessWidget {
  final HangoutRequestModel hangoutRequest;
  final bool isReceived;
  final Animation<double> animation;
  final Widget? actions;

  const HangoutListItem({
    super.key,
    required this.hangoutRequest,
    required this.animation,
    required this.isReceived,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    final author = isReceived ? hangoutRequest.sender : hangoutRequest.receiver;
    return SizeTransition(
      sizeFactor: ConnectionListItem.sizeTween.animate(animation),
      child: SlideTransition(
        position: ConnectionListItem.slideTween.animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.easeInCirc,
            reverseCurve: Curves.easeOutCirc,
          ),
        ),
        child: Container(
          height: 235,
          padding: const EdgeInsets.all(15),
          decoration: const BoxDecoration(
            color: AppColors.surfaceColor,
            borderRadius: Corners.rounded7,
            boxShadow: [
              BoxShadow(
                color: Color(0xFFE0E0E0),
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Author Details
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Other Author Image
                  CustomNetworkImage(
                    width: 50,
                    height: 45,
                    borderRadius: Corners.rounded4,
                    fit: BoxFit.cover,
                    imageUrl: author.profilePictureUrl,
                  ),

                  Insets.gapW10,

                  // Author Name and ERP
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Author Name
                      Text(
                        '${author.firstName} ${author.lastName} ',
                        style: AppTypography.primary.body14,
                      ),

                      Insets.gapH5,

                      // Meta Details
                      Row(
                        children: [
                          // Program and Year
                          Consumer(
                            builder: (_, ref, __) {
                              final program = ref.watch(
                                programByIdProvider(author.programId),
                              );
                              return Text(
                                '${program.program} ${author.graduationYear}',
                                style: AppTypography.primary.subtitle13,
                              );
                            },
                          ),

                          Insets.gapW5,

                          // Type
                          Text(
                            AppUtils.gradYearToStudentType(author.graduationYear)
                                .name
                                .capitalize,
                            style: AppTypography.primary.subtitle13.copyWith(
                              color: AppColors.textLightGreyColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              Insets.gapH15,

              // Hangout Purpose
              LabeledWidget(
                label: 'Purpose',
                labelGap: Insets.gapH3,
                labelStyle: AppTypography.primary.body14,
                child: Text(
                  hangoutRequest.purpose,
                  style: AppTypography.primary.subtitle13.copyWith(
                    color: AppColors.textLightGreyColor,
                  ),
                ),
              ),

              Insets.gapH15,

              // Meetup Details
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Meeting Spot
                  LabeledWidget(
                    label: 'Meetup Spot',
                    labelGap: Insets.gapH3,
                    labelStyle: AppTypography.primary.body14,
                    child: Consumer(
                      builder: (_, ref, __) {
                        final meetupSpot = ref.watch(
                          campusSpotByIdProvider(hangoutRequest.meetupSpotId),
                        );
                        final campus = ref.watch(
                          campusByIdProvider(meetupSpot.campusId),
                        );
                        return Text(
                          '${meetupSpot.campusSpot}, ${campus.campus.capitalize} Campus',
                          style: AppTypography.primary.subtitle13.copyWith(
                            color: AppColors.textLightGreyColor,
                          ),
                        );
                      },
                    ),
                  ),

                  // Meetup Datetime
                  LabeledWidget(
                    label: 'Meetup At',
                    labelGap: Insets.gapH3,
                    labelStyle: AppTypography.primary.body14,
                    child: Text(
                      hangoutRequest.meetupAt.toDateString(),
                      style: AppTypography.primary.subtitle13.copyWith(
                        color: AppColors.textLightGreyColor,
                      ),
                    ),
                  ),
                ],
              ),

              Insets.gapH20,

              // Action Buttons
              if (actions != null) actions!,
            ],
          ),
        ),
      ),
    );
  }
}
