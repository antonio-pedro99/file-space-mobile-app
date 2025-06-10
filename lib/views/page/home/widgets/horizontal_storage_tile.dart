import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:space_client_app/data/models/cloud_storage.dart';
import 'package:space_client_app/views/theme/colors.dart';

class HorizontalCloudStorageTile extends StatelessWidget {
  const HorizontalCloudStorageTile(this.cloudStorage, {super.key, this.onTap});

  final CloudStorage cloudStorage;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    //var size = MediaQuery.of(context).size;
    var textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      margin: const EdgeInsets.fromLTRB(8, 0, 8, 8),
      
      decoration: BoxDecoration(
        color: blue,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SvgPicture.asset(
            cloudStorage.icon!,
            width: 40,
            height: 40,
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cloudStorage.cloudStorageName!,
                style: textTheme.titleMedium!
                    .copyWith(fontSize: 12, fontWeight: FontWeight.w400),
              ),
              Text(
                "2.5 GB of 5 GB",
                style: textTheme.labelMedium!
                    .copyWith(fontSize: 10, fontWeight: FontWeight.w300),
              ),
              const SizedBox(height: 8),
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
