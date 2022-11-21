import 'package:flutter/material.dart';
import 'package:space_client_app/data/models/subscription.dart';

import '../../../theme/colors.dart';

class SubscriptionTile extends StatelessWidget {
  const SubscriptionTile(
      {Key? key, required this.subscription, this.isSelected, this.onTap})
      : super(key: key);

  final Subscription subscription;
  final bool? isSelected;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
            color: blue,
            borderRadius: BorderRadius.circular(16),
            border: isSelected! ? Border.all(color: purple, width: 2) : null),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              subscription.subScriptionName!,
              style: textTheme.titleMedium!.copyWith(
                  fontSize: 18, fontWeight: FontWeight.w500, color: purple),
            ),
            const Divider(),
            Text(
              "Includes",
              style: textTheme.titleMedium!
                  .copyWith(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 8),
            Column(
              children: subscription.features!
                  .map<Widget>((e) => Row(
                        children: [
                          const Icon(
                            Icons.check,
                            color: Colors.green,
                          ),
                          const SizedBox(width: 5),
                          Text(e,
                              style: textTheme.subtitle1!.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w300)),
                        ],
                      ))
                  .toList(),
            ),
            const SizedBox(height: 8),
            Text(
              "First month for free, Rs ${subscription.price!}/month after trials",
              style: textTheme.subtitle2!
                  .copyWith(fontSize: 14, fontWeight: FontWeight.w300),
            ),
          ],
        ),
      ),
    );
  }
}
