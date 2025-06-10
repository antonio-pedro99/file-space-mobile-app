import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:space_client_app/data/models/cloud_storage.dart';
import 'package:space_client_app/views/theme/colors.dart';

class HomeCloudStorageTile extends StatelessWidget {
  const HomeCloudStorageTile(this.cloudStorage, {super.key, this.onTap});

  final CloudStorage cloudStorage;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      margin: const EdgeInsets.fromLTRB(8, 0, 8, 8),
      width: size.width * .25,
      decoration: BoxDecoration(
        color: blue,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SvgPicture.asset(
            cloudStorage.icon!,
            width: 25,
            height: 25,
          ),
          Text(
            cloudStorage.cloudStorageName!,
            style: textTheme.titleMedium!
                .copyWith(fontSize: 12, fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "2.5 GB of 5 GB",
                style: textTheme.labelMedium!
                    .copyWith(fontSize: 8, fontWeight: FontWeight.w300),
              ),
              const SizedBox(height: 4),
              const LinearProgressIndicator(
                  value: 0.5,
                  backgroundColor: Colors.white,
                  valueColor: AlwaysStoppedAnimation<Color>(purple)),
            ],
          )
        ],
      ),
    );
  }
}
