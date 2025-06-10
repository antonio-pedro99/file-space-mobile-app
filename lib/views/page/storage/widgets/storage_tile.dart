import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:space_client_app/blocs/user/user_bloc.dart';
import 'package:space_client_app/data/models/cloud_storage.dart';

import '../../../theme/colors.dart';

class CloudStorageTile extends StatelessWidget {
  const CloudStorageTile(
      {super.key,
      required this.cloudStorage,
      this.onConnect,
      this.onDisconnect});

  final CloudStorage cloudStorage;
  final VoidCallback? onConnect;
  final VoidCallback? onDisconnect;
  @override
  Widget build(BuildContext context) {
    //var size = MediaQuery.of(context).size;
    var textTheme = Theme.of(context).textTheme;
    final userDetails = context.read<UserBloc>().uDetails;
    var isIntegrated = userDetails.storages!
        .contains(cloudStorage.id); // check if storage is integrated
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: blue,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                cloudStorage.icon!,
                width: 40,
                height: 40,
              ),
              const SizedBox(width: 16),
              Text(
                cloudStorage.cloudStorageName!,
                style: textTheme.titleMedium!.copyWith(
                    fontSize: 18, fontWeight: FontWeight.w500, color: purple),
              ),
              const Spacer(),
              IconButton(
                onPressed: onConnect,
                icon: Icon(
                    isIntegrated ? Icons.check_circle : Icons.add_circle,
                    size: 30),
                color: isIntegrated ? Colors.green : Colors.white,
              ),
              isIntegrated
                  ? IconButton(
                      onPressed: onDisconnect,
                      icon: const Icon(Icons.cloud_off, size: 30),
                      color: Colors.red,
                    )
                  : const SizedBox.shrink(),
            ],
          ),
          const Divider(),
          Text(
            "Supported features:",
            style: textTheme.titleMedium!
                .copyWith(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 8),
          Column(
            children: cloudStorage.features!
                .map<Widget>((e) => Row(
                      children: [
                        const Icon(
                          Icons.check,
                          color: Colors.green,
                        ),
                        const SizedBox(width: 5),
                        Text(e,
                            style: textTheme.labelLarge!.copyWith(
                                fontSize: 16, fontWeight: FontWeight.w300)),
                      ],
                    ))
                .toList(),
          ),
          const SizedBox(height: 8),
          Text(
            "First month for free after trials",
            style: textTheme.labelMedium!
                .copyWith(fontSize: 14, fontWeight: FontWeight.w300),
          ),
        ],
      ),
    );
  }
}
