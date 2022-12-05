import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_client_app/extensions.dart';
import 'package:space_client_app/views/page/overview/widgets/static_tile.dart';
import 'package:space_client_app/views/theme/colors.dart';

import '../../../blocs/user/user_bloc.dart';

class StorageOverviewPage extends StatefulWidget {
  const StorageOverviewPage({Key? key}) : super(key: key);
  @override
  State<StorageOverviewPage> createState() => _StorageOverviewPageState();
}

class _StorageOverviewPageState extends State<StorageOverviewPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var textTheme = Theme.of(context).textTheme;
    var userDetails = context.read<UserBloc>().user;
    return Scaffold(
      body: NestedScrollView(
          physics: const BouncingScrollPhysics(),
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                centerTitle: true,
                forceElevated: innerBoxIsScrolled,
                title: const Text("Storage"),
                floating: true,
              )
            ];
          },
          body: SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    height: size.height * .25,
                    child: Stack(
                      children: [
                        DChartPie(
                          showLabelLine: false,
                          data: [
                            {
                              'domain': 'not_used',
                              'measure': userDetails.quotaLimit! -
                                  userDetails.quotaUsed!
                            },
                            {
                              'domain': 'used',
                              'measure': userDetails.quotaUsed!
                            },
                          ],
                          strokeWidth: 0,
                          fillColor: (pieData, index) {
                            switch (pieData["domain"]) {
                              case 'used':
                                return purple;
                              case 'not_used':
                                return blue;
                            }
                          },
                          donutWidth: 25,
                          labelColor: Colors.transparent,
                          labelLineColor: Colors.transparent,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                              "${userDetails.getTotalSpacePercentage()} %",
                              style: textTheme.headline5!.copyWith(
                                  fontSize: 28, fontWeight: FontWeight.w400)),
                        )
                      ],
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Total",
                          style: textTheme.subtitle2!.copyWith(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                        Text(
                            "${(userDetails.quotaLimit!.toDouble() / 1024).toStringAsFixed(2)} GB",
                            style: textTheme.headline5!
                                .copyWith(fontWeight: FontWeight.w400)),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "Used",
                          style: textTheme.subtitle2!.copyWith(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                        Text(
                            "${(userDetails.quotaUsed!.toDouble() / 1024).toStringAsFixed(2)} GB",
                            style: textTheme.headline5!
                                .copyWith(fontWeight: FontWeight.w400)),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 35),
                Container(
                    height: size.height * .14,
                    width: size.width,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    decoration: BoxDecoration(
                        color: purple, borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Running out of Space?"),
                        const SizedBox(height: 8),
                        Text(
                          "Upgrade to Premium",
                          style: textTheme.displaySmall!.copyWith(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        Text("and get unlimited storage",
                            style: textTheme.subtitle2!.copyWith(
                                fontSize: 16, fontWeight: FontWeight.w300))
                      ],
                    )),
                const SizedBox(
                  height: 24,
                ),
                Flexible(
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: false,
                    children: const [
                      StatTile(
                        fileTypeName: "Documents",
                        icon: Icons.insert_drive_file,
                        totalFiles: "0",
                        color: pink,
                      ),
                      StatTile(
                        fileTypeName: "Videos",
                        icon: Icons.play_arrow,
                        totalFiles: "0",
                        color: deepPurple,
                      ),
                      StatTile(
                          fileTypeName: "Images",
                          icon: Icons.image,
                          color: green,
                          totalFiles: "0"),
                      StatTile(
                          fileTypeName: "Musics",
                          icon: Icons.music_note,
                          totalFiles: "0"),
                      StatTile(
                          fileTypeName: "Others",
                          icon: Icons.insert_drive_file,
                          color: blueOcean,
                          totalFiles: "0"),
                    ],
                  ),
                )
              ],
            ),
          ))),
    );
  }
}
