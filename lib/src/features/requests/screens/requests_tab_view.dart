import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Providers
import '../providers/requests_provider.dart';

// Widgets
import '../widgets/request_type_tab_bar.dart';
import '../widgets/requests_list.dart';

class RequestsTabView extends StatelessWidget {
  const RequestsTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: DefaultTabController(
        length: 2,
        child: CustomScrollView(
          key: const PageStorageKey<String>('Friend Requests'),
          slivers: <Widget>[
            SliverOverlapInjector(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            ),

            // Sent/Received Tab Bar
            const RequestTypeTabBar(),

            // Requests View
            SliverToBoxAdapter(
              child: Consumer(
                builder: (_, ref, __) {
                  final sentRequests = ref.watch(
                    requestsProvider.select(
                      (value) => value.getAllSentRequests(),
                    ),
                  );
                  final receivedRequests = ref.watch(
                    requestsProvider.select(
                      (value) => value.getAllReceivedRequests(),
                    ),
                  );
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TabBarView(
                      children: [
                        // Sent list
                        RequestsList(requests: sentRequests),

                        // Received list
                        RequestsList(requests: receivedRequests),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
