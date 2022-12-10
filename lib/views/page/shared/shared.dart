import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:space_client_app/views/widgets/input_text.dart';

class SharedPage extends StatefulWidget {
  const SharedPage({Key? key}) : super(key: key);
  @override
  State<SharedPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<SharedPage> {
  late final Future<ListResult> files;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          physics: const BouncingScrollPhysics(),
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                forceElevated: innerBoxIsScrolled,
                title: const Text("Shared with you"),
                floating: true,
              )
            ];
          },
          body: SafeArea(
              maintainBottomViewPadding: true,
              top: false,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomTextInput(
                      hint: "Search for anything",
                      leading: Icons.search,
                    ),
                    const SizedBox(height: 24),
                    Flexible(child: Container())
                  ],
                ),
              ))),
    );
  }
}
