import 'package:flutter/material.dart';

// Widgets
import '../widgets/request_type_tab_bar.dart';
import 'connections_tab_view.dart';
import 'hangouts_tab_view.dart';

class RequestsTabView extends StatelessWidget {
  const RequestsTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: DefaultTabController(
        length: 2,
        child: CustomScrollView(
          key: const PageStorageKey<String>('Requests'),
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
                    // Connections
                    ConnectionsTabView(),

                    // Sent list
                    HangoutsTabView(),
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
