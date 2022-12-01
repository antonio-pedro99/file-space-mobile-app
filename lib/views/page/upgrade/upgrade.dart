import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_client_app/data/models/subscription.dart';
import 'package:space_client_app/views/page/upgrade/widgets/subscription_tile.dart';
import 'package:space_client_app/views/theme/colors.dart';
import 'package:space_client_app/views/widgets/button_text.dart';

import '../../../blocs/user/user_bloc.dart';

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
        isCurrent: true,
        price: 300,
        storage: 1,
        subScriptionName: "Basic Plan Space 1 GB"),
    Subscription(
        features: [
          "Store around3 300 photos",
          "Backup photos automatically",
          "Access any device"
        ],
        isCurrent: false,
        price: 300,
        storage: 3,
        subScriptionName: "Premium Max 3 GB"),
  ];

  int current = 0;
  @override
  Widget build(BuildContext context) {
    var user = context.read<UserBloc>();
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
          body: BlocConsumer<UserBloc, UserState>(
            listener: (context, state) {
              if (state is UserLoading) {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                        content: SizedBox(
                          height: 50,
                          child: Column(
                            children: const [
                              LinearProgressIndicator(),
                            ],
                          ),
                        ),
                        title: Text(
                            "Upgrading to ${subScriptions[current].subScriptionName}"),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))));
              } else if (state is UserLoaded) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                  "Upgraded successfully",
                )));
              } else if (state is UserLoadingError) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    backgroundColor: Colors.red,
                    content: Text(
                      "Failed to upgrade",
                      style: TextStyle(color: Colors.white),
                    )));
              }
            },
            builder: (context, state) {
              return SafeArea(
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
                  ));
            },
          )),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: CustomButton(
          text: "Upgrade now",
          textColor: white,
          color: purple,
          onTap: () {
            BlocProvider.of<UserBloc>(context).add(UpgradeQuotaUser(
                quota: subScriptions[current].storage! * 1024));
          },
        ),
      ),
    );
  }
}
