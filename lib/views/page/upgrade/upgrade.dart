import 'package:flutter/material.dart';
import 'package:space_client_app/data/models/subscription.dart';
import 'package:space_client_app/views/page/upgrade/widgets/subscription_tile.dart';
import 'package:space_client_app/views/theme/colors.dart';
import 'package:space_client_app/views/widgets/button_text.dart';

class UpgradeAccountPage extends StatefulWidget {
  const UpgradeAccountPage({Key? key}) : super(key: key);
  @override
  State<UpgradeAccountPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<UpgradeAccountPage> {
  List<Subscription> subScriptions = [
    Subscription(
        features: [
          "Store around3 300 photos",
          "Backup photos automatically",
          "Access any device"
        ],
        isCurrent: false,
        price: 300,
        storage: 100,
        subScriptionName: "Basic Plan Space 100 GB"),
    Subscription(
        features: [
          "Store around3 300 photos",
          "Backup photos automatically",
          "Access any device"
        ],
        isCurrent: false,
        price: 300,
        storage: 100,
        subScriptionName: "Premium Max 2 TB"),
  ];

  int current = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          physics: const BouncingScrollPhysics(),
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                forceElevated: innerBoxIsScrolled,
                title: const Text("Go Premium"),
                floating: true,
              )
            ];
          },
          body: SafeArea(
              maintainBottomViewPadding: true,
              top: false,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: subScriptions.length,
                  itemBuilder: (context, index) {
                    return SubscriptionTile(
                      onTap: () => setState(() => current = index),
                      subscription: subScriptions[index],
                      isSelected: index == current,
                    );
                  },
                ),
              ))),
      bottomNavigationBar: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: CustomButton(
          text: "Upgrade now",
          textColor: white,
          color: purple,
        ),
      ),
    );
  }
}
