import 'package:flutter/material.dart';
import 'package:space_client_app/views/page/home/menu.dart';
import 'package:space_client_app/views/page/home/widgets/category_tile.dart';
import 'package:space_client_app/views/page/home/widgets/file_tile.dart';
import 'package:space_client_app/views/theme/colors.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      body: NestedScrollView(
          physics: const BouncingScrollPhysics(),
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                forceElevated: innerBoxIsScrolled,
                title: const Text("Home"),
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
                    const SizedBox(
                        width: 350,
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: "Search for anything",
                            prefixIcon: Icon(Icons.search_sharp),
                          ),
                        )),
                    const SizedBox(height: 24),
                    SizedBox(
                      height: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          CategoryTile(
                            category: "All",
                            icon: Icons.apps_sharp,
                            color: deepPurple,
                          ),
                          CategoryTile(
                              category: "Folders",
                              icon: Icons.folder,
                              color: green),
                          CategoryTile(
                              category: "Files",
                              icon: Icons.file_open,
                              color: blueOcean),
                          CategoryTile(
                              category: "Shared",
                              icon: Icons.share_rounded,
                              color: purple),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [Text("Recent Files"), Icon(Icons.list)],
                    ),
                    Flexible(
                        child: ListView(
                      children: const [
                        FileTile(name: "Preview.png", size: "30 KB"),
                        SizedBox(height: 8),
                        FileTile(name: "Preview.png", size: "30 KB"),
                        SizedBox(height: 8),
                        FileTile(name: "Preview.png", size: "30 KB"),
                        SizedBox(height: 8),
                        FileTile(name: "Preview.png", size: "30 KB"),
                        FileTile(name: "Preview.png", size: "30 KB"),
                        SizedBox(height: 8),
                        FileTile(name: "Preview.png", size: "30 KB"),
                        SizedBox(height: 8),
                        FileTile(name: "Preview.png", size: "30 KB"),
                        SizedBox(height: 8),
                        FileTile(name: "Preview.png", size: "30 KB"),
                        FileTile(name: "Preview.png", size: "30 KB"),
                        SizedBox(height: 8),
                        FileTile(name: "Preview.png", size: "30 KB"),
                        SizedBox(height: 8),
                        FileTile(name: "Preview.png", size: "30 KB"),
                        SizedBox(height: 8),
                        FileTile(name: "Preview.png", size: "30 KB"),
                        FileTile(name: "Preview.png", size: "30 KB"),
                        SizedBox(height: 8),
                        FileTile(name: "Preview.png", size: "30 KB"),
                        SizedBox(height: 8),
                        FileTile(name: "Preview.png", size: "30 KB"),
                        SizedBox(height: 8),
                        FileTile(name: "Preview.png", size: "30 KB")
                      ],
                    ))
                  ],
                ),
              ))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
