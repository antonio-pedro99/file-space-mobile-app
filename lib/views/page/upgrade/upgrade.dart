import 'package:flutter/material.dart';

class UpgradeAccountPage extends StatefulWidget {
  const UpgradeAccountPage({Key? key}) : super(key: key);
  @override
  State<UpgradeAccountPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<UpgradeAccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          physics: const BouncingScrollPhysics(),
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                forceElevated: innerBoxIsScrolled,
                title: const Text("Get Premium"),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [],
                ),
              ))),
    );
  }
}
