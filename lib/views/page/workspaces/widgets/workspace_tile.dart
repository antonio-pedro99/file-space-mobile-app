import 'package:flutter/material.dart';
import 'package:space_client_app/views/theme/colors.dart';

class WorkSpaceTile extends StatelessWidget {
  const WorkSpaceTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      height: 180,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration:
          BoxDecoration(color: blue, borderRadius: BorderRadius.circular(16)),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "CSE569 Team",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: size.width,
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  const CircleAvatar(
                    backgroundColor: green,
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                  const Positioned(
                    left: 30,
                    child: CircleAvatar(
                      backgroundColor: purple,
                      radius: 20,
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 60,
                    child: CircleAvatar(
                      backgroundColor: deepPurple,
                      radius: 20,
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 90,
                    child: CircleAvatar(
                      backgroundColor: purple,
                      radius: 20,
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                      left: 145,
                      child: Text(
                        "+6 Members",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: lightGrey, fontSize: 12),
                      ))
                ],
              ),
            ),
            const SizedBox(height: 12),
            const Text("10 MB of 2GB"),
            const SizedBox(height: 4),
            const LinearProgressIndicator(),
            const SizedBox(height: 12),
            Text(
              "Joined on 30th of March, 2022",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: lightGrey, fontSize: 14),
            ),
          ]),
    );
  }
}
