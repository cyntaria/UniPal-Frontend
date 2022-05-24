import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

// Models
import '../../../activities/models/campus_spot_model.codegen.dart';
import '../../../profile/models/campus_model.codegen.dart';

// Providers
import '../../../activities/providers/campus_spots_provider.dart';
import '../../../profile/providers/campuses_provider.dart';
import '../../providers/profile_hangout_provider.dart';

// Helpers
import '../../../../helpers/constants/app_colors.dart';
import '../../../../helpers/constants/app_styles.dart';
import '../../../../helpers/constants/app_typography.dart';

// Widgets
import '../../../shared/widgets/custom_date_picker.dart';
import '../../../shared/widgets/custom_dropdown_field.dart';
import '../../../shared/widgets/custom_dropdown_sheet.dart';
import '../../../shared/widgets/custom_text_button.dart';
import '../../../shared/widgets/custom_textfield.dart';
import '../../../shared/widgets/dropdown_sheet_item.dart';
import '../../../shared/widgets/labeled_widget.dart';
import '../../../shared/widgets/scrollable_column.dart';

final _campusFilterProvider = StateProvider<CampusModel?>((ref) => null);

class SendHangoutRequestModal extends HookConsumerWidget {
  final VoidCallback closeFunction;
  final String studentErp;

  const SendHangoutRequestModal({
    super.key,
    required this.closeFunction,
    required this.studentErp,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final purposeController = useTextEditingController(text: '');
    final campusController = useTextEditingController(text: '');
    final meetupSpotController = useValueNotifier<CampusSpotModel?>(null);
    final meetupAtController = useValueNotifier<DateTime>(
      DateTime.now().add(
        const Duration(days: 1),
      ),
    );

    bool validate() {
      final runValidators = formKey.currentState!.validate();
      final hasMeetupSpot = meetupSpotController.value != null;
      return runValidators && hasMeetupSpot;
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.lightBackgroundColor,
        appBar: AppBar(
          title: const Text('Send Hangout Request'),
        ),
        body: Form(
          key: formKey,
          child: ScrollableColumn(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              Insets.gapH30,

              // Purpose
              CustomTextField(
                controller: purposeController,
                multiline: true,
                maxLength: 50,
                textAlignVertical: TextAlignVertical.top,
                expands: true,
                height: 68,
                floatingText: 'Hangout Purpose',
                hintText: 'Why do want to meet?',
                textInputAction: TextInputAction.next,
                validator: (purpose) {
                  if (purpose == null || purpose.isEmpty) {
                    return 'Please describe a purpose';
                  }
                  return null;
                },
              ),

              Insets.gapH15,

              // Meetup Campus
              Consumer(
                builder: (context, ref, child) {
                  final campuses = ref.watch(campusesProvider).getAllCampuses();
                  return LabeledWidget(
                    label: 'Campus',
                    useDarkerLabel: true,
                    child: CustomDropdownField<CampusModel>.animated(
                      controller: campusController,
                      hintText: 'Select a campus',
                      hintStyle: AppTypography.primary.body16.copyWith(
                        color: AppColors.textGreyColor,
                      ),
                      items: {for (var e in campuses) e.campus: e},
                      onSelected: (campus) {
                        ref.read(_campusFilterProvider.notifier).state = campus;
                      },
                    ),
                  );
                },
              ),

              Insets.gapH15,

              // Meetup Spot
              Consumer(
                builder: (context, ref, child) {
                  final allSpots =
                      ref.watch(campusSpotsProvider).getAllCampusSpots();
                  final _campusFilter = ref.watch(_campusFilterProvider);
                  final campusSpots = _campusFilter != null
                      ? allSpots
                          .where(
                            (e) => e.campusId == _campusFilter.campusId,
                          )
                          .toList()
                      : allSpots;
                  return LabeledWidget(
                    label: 'Meetup Spot',
                    useDarkerLabel: true,
                    child: CustomDropdownField<CampusSpotModel>.sheet(
                      controller: meetupSpotController,
                      hintText: 'Select a spot to meet',
                      selectedItemText: (item) => item.campusSpot,
                      itemsSheet: CustomDropdownSheet(
                        items: campusSpots,
                        showSearch: true,
                        searchFilterCondition: (search, campusSpot) {
                          return campusSpot.campusSpot
                              .toLowerCase()
                              .startsWith(search);
                        },
                        bottomSheetTitle: 'Campus Spots',
                        itemBuilder: (_, item) => DropdownSheetItem(
                          label: item.campusSpot,
                        ),
                      ),
                    ),
                  );
                },
              ),

              Insets.gapH15,

              // Meeting datetime
              CustomDatePicker(
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365)),
                dateNotifier: meetupAtController,
                dateFormat: DateFormat('d MMMM, y'),
                helpText: 'Select a meetup time',
                initialEntryMode: DatePickerEntryMode.calendarOnly,
                pickerStyle: const CustomDatePickerStyle(
                  initialDateString: 'DD MONTH, YYYY',
                  floatingText: 'Meetup At',
                ),
              ),

              Insets.expand,

              // Confirm Details Button
              CustomTextButton.gradient(
                width: double.infinity,
                onPressed: () {
                  if (validate()) {
                    formKey.currentState!.save();
                    ref
                        .read(profileHangoutProvider.notifier)
                        .sendHangoutRequest(
                          receiverErp: studentErp,
                          purpose: purposeController.text,
                          meetupAt: meetupAtController.value,
                          meetupSpotId:
                              meetupSpotController.value!.campusSpotId,
                        );
                    closeFunction.call();
                  }
                },
                gradient: AppColors.buttonGradientPurple,
                child: Center(
                  child: Text(
                    'SEND',
                    style: AppTypography.secondary.body16.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              Insets.bottomInsetsLow,
            ],
          ),
        ),
      ),
    );
  }
}
