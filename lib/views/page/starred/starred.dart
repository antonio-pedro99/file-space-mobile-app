import 'package:flutter/material.dart';
import 'package:space_client_app/data/repository/mock_data.dart';
import 'package:space_client_app/views/page/home/enums.dart';
import 'package:space_client_app/views/page/home/widgets/file_tile.dart';
import 'package:space_client_app/views/widgets/input_text.dart';

class StarredPage extends StatefulWidget {
  const StarredPage({Key? key}) : super(key: key);
  @override
  State<StarredPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<StarredPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          physics: const BouncingScrollPhysics(),
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                forceElevated: innerBoxIsScrolled,
                title: const Text("My Favorites"),
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
                    Flexible(
                        child: ListView.builder(
                      itemCount: MockRepository.getAllFiles().length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return FileTile(
                            object: MockRepository.getAllFiles()[index]);
                      },
                    ))
                  ],
                ),
              ))),
    );
  }
}
