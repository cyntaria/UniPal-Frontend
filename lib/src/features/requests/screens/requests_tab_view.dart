import 'package:flutter/material.dart';

// Widgets
import '../widgets/received_requests_list.dart';
import '../widgets/request_type_tab_bar.dart';
import '../widgets/sent_requests_list.dart';

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
            const SliverToBoxAdapter(
              child: RequestTypeTabBar(),
            ),

            // Requests View
            const SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              sliver: SliverFillRemaining(
                child: TabBarView(
                  children: [
                    // Received list
                    ReceivedRequestsList(),

                    // Sent list
                    SentRequestsList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
