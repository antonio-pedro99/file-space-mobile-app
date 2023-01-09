import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_client_app/blocs/user/user_bloc.dart';
import 'package:space_client_app/data/models/device.dart';

class DeviceTile extends StatelessWidget {
  const DeviceTile({super.key, this.device, this.onTap});
  final DesktopDevice? device;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    var user = context.read<UserBloc>().user;

    return InkWell(
      onTap: onTap,
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(8),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.desktop_mac,
              size: 100,
              color: Colors.deepPurple,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 50,
                  child: Text(
                    device!.deviceName!,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.titleMedium!
                        .copyWith(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_vert),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
