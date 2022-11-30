import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_client_app/blocs/user/user_bloc.dart';
import 'package:space_client_app/views/page/notifications/notifications.dart';
import 'package:space_client_app/views/page/overview/storage_overview.dart';
import 'package:space_client_app/views/page/settings/settings.dart';
import 'package:space_client_app/views/page/upgrade/upgrade.dart';
import 'package:space_client_app/views/theme/colors.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var textTheme = Theme.of(context).textTheme;

    var userDetails = context.read<UserBloc>().user;

    return Drawer(
      child: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return ListView(
            children: [
              SizedBox(
                height: size.height * .3,
                child: DrawerHeader(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const CircleAvatar(
                      backgroundColor: purple,
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text("${userDetails.name}", style: textTheme.headline5),
                    Text(
                      "${userDetails.email}",
                      style: textTheme.subtitle2!
                          .copyWith(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(height: 8),
                    const LinearProgressIndicator(),
                    const SizedBox(height: 2),
                    InkWell(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const StorageOverviewPage()),
                      ),
                      child: Text(
                        "0.0% of 2.0 GB used",
                        style: textTheme.subtitle1!.copyWith(fontSize: 14),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  const UpgradeAccountPage()));
                        },
                        child: const Text("Upgrade Storage"))
                  ],
                )),
              ),
              ListTile(
                  leading: const Icon(Icons.notifications, color: grey),
                  title: const Text("Notifications"),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const NotificationsPage()))),
              ListTile(
                leading: const Icon(Icons.security_update, color: grey),
                title: const Text("Upgrade Account"),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const UpgradeAccountPage())),
              ),
              ListTile(
                  leading: const Icon(Icons.settings, color: grey),
                  title: const Text("Settings"),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SettingsPage())))
            ],
          );
        },
      ),
    );
  }
}
