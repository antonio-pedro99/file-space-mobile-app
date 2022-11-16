import 'package:flutter/material.dart';
import 'package:space_client_app/views/theme/colors.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var textTheme = Theme.of(context).textTheme;
    return Drawer(
      child: ListView(
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
                Text("Antonio Pedro", style: textTheme.headline5),
                Text(
                  "antonio20028@iiitd.ac.in",
                  style: textTheme.subtitle2!
                      .copyWith(fontSize: 16, fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 8),
                const LinearProgressIndicator(),
                const SizedBox(height: 2),
                Text(
                  "0.0% of 2.0 GB used",
                  style: textTheme.subtitle1!.copyWith(fontSize: 14),
                ),
                ElevatedButton(
                    onPressed: () {}, child: const Text("Upgrade Storage"))
              ],
            )),
          ),
          const ListTile(
            leading: Icon(Icons.notifications, color: grey),
            title: Text("Notifications"),
          ),
          const ListTile(
            leading: Icon(Icons.security_update, color: grey),
            title: Text("Upgrade Account"),
          ),
          const ListTile(
            leading: Icon(Icons.settings, color: grey),
            title: Text("Settings"),
          )
        ],
      ),
    );
  }
}
