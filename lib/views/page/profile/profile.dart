import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_client_app/blocs/auth/auth_bloc.dart';
import 'package:space_client_app/blocs/user/user_bloc.dart';

import 'package:space_client_app/views/page/auth/login.dart';
import 'package:space_client_app/views/page/overview/storage_overview.dart';
import 'package:space_client_app/views/page/upgrade/upgrade.dart';
import 'package:space_client_app/views/theme/colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);
  @override
  State<ProfilePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ProfilePage> {
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
                forceElevated: innerBoxIsScrolled,
                title: const Text("Personal"),
                floating: true,
              )
            ];
          },
          body: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthLoading) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                  "Logging out",
                  style: TextStyle(),
                )));
              } else if (state is AuthError) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.red,
                    content: Text(
                      state.message,
                      style: const TextStyle(color: Colors.white),
                    )));
              } else if (state is AuthLoaded) {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                    (route) => false);
              }
            },
            builder: (context, state) {
              return SafeArea(
                  maintainBottomViewPadding: true,
                  top: false,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CircleAvatar(
                              backgroundColor: purple,
                              child: Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("${userDetails.name}",
                                    style: textTheme.headline5),
                                Text(
                                  "Basic Plan",
                                  style: textTheme.subtitle2!.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            const Spacer(),
                            ElevatedButton(
                                onPressed: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const UpgradeAccountPage())),
                                child: const Text("Upgrade"))
                          ],
                        ),
                        const SizedBox(height: 24),
                        Text(
                          "Account Details",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Email",
                              style: textTheme.subtitle1!.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w300),
                            ),
                            Text(
                              "${userDetails.email}",
                              style: textTheme.subtitle1!.copyWith(
                                  fontSize: 14, fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Storage",
                              style: textTheme.subtitle1!.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w300),
                            ),
                            InkWell(
                              onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const StorageOverviewPage()),
                              ),
                              child: Text(
                                "${userDetails.getTotalSpacePercentage()} % of ${userDetails.quotaLimit!.toDouble() / 1024} GB used",
                                style:
                                    textTheme.subtitle1!.copyWith(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Devices",
                              style: textTheme.subtitle1!.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w300),
                            ),
                            Text(
                              "1 of 2",
                              style: textTheme.subtitle1!.copyWith(
                                  fontSize: 14, fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                        const Divider(),
                        const SizedBox(height: 24),
                        Text(
                          "Rewards",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Get free storage",
                              style: textTheme.subtitle1!.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w300),
                            ),
                            Text(
                              "Invite Friends",
                              style: textTheme.subtitle1!.copyWith(
                                  fontSize: 14, fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "My Earnings",
                              style: textTheme.subtitle1!.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w300),
                            ),
                            Text(
                              "250 MB",
                              style: textTheme.subtitle1!.copyWith(
                                  fontSize: 14, fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Text(
                          "Session",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        TextButton(
                          onPressed: () {
                            BlocProvider.of<AuthBloc>(context).add(Logout());
                          },
                          child: Text(
                            "Sign out of SpaceFile",
                            style: textTheme.subtitle1!.copyWith(
                                color: Colors.red,
                                fontSize: 16,
                                fontWeight: FontWeight.w300),
                          ),
                        )
                      ],
                    ),
                  ));
            },
          )),
    );
  }
}
