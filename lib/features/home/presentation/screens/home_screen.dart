import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:in_between/core/routes/app_router.dart';
import 'package:in_between/core/widgets/history_tile.dart';
import 'package:in_between/core/widgets/images.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:transformer_page_view_tv/transformer_page_view.dart';
// import 'package:vector_math/vector_math_64.dart' hide Colors;

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final TransformerPageController controller = TransformerPageController(
    itemCount: 4,
  );

  @override
  Widget build(BuildContext context) {
    List<String> rooms = ['Room 1', 'Room 2', 'Room 3', 'Room 4'];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),

        actions: [
          Text('Php 3000', style: TextStyle(color: Colors.white)),
          IconButton(
            onPressed: () {
              context.go(Routes.cashinoutScreen);
            },
            icon: Icon(Icons.add_box_rounded),
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Color(0xffffb53d),
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Profile"),
              onTap: () {
                context.go(Routes.profileScreen);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
              onTap: () {},
            ),
          ],
        ),
      ),

      body: Container(
        padding: EdgeInsets.all(16),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImagePaths.bg.path),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 200,
              child: TransformerPageView(
                pageSnapping: true,
                pageController: controller,
                itemCount: rooms.length,
                transformer: PageTransformerBuilder(
                  builder: (Widget child, TransformInfo info) {
                    double scale =
                        1 - (0.15 * info.position!.abs()); // Shrink side cards
                    double depth =
                        info.position! * -30; // Push side cards backward
                    double angle =
                        info.position! *
                        0.12; // Slight rotation for perspective
                    double offsetX = info.position! * -25;

                    return Transform(
                      alignment: Alignment.center,
                      transform:
                          Matrix4.identity()
                            ..setEntry(3, 2, 0.001) // Perspective effect
                            ..translate(
                              offsetX,
                              // info.position! * -30,
                              0.2,
                              depth,
                            ) // Push cards backward
                            ..rotateY(angle), // Slight horizontal tilt
                      child: Opacity(
                        opacity:
                            info.position!.abs() > 1
                                ? 0.5
                                : 1, // Fade side cards a little
                        child: Transform.scale(scale: scale, child: child),
                      ),
                    );
                  },
                ),
                itemBuilder: (context, index) {
                  return Align(
                    alignment: Alignment.center,
                    child: SliderBg(
                      index: rooms[index].toString(),
                      onPressed: () {
                        context.go(Routes.gameZoneScreen);
                      },
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 3, bottom: 8),
              child: SmoothPageIndicator(
                controller: controller,
                count: rooms.length,
                effect: SwapEffect(
                  dotColor: Colors.grey,
                  activeDotColor: Color(0xffd5bc79),
                  dotHeight: 8,
                  dotWidth: 8,
                  // paintStyle: PaintingStyle.stroke,
                ),
              ),
            ),

            Text('History', textAlign: TextAlign.start),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => HistoryTile(index: index),
                      childCount: 7,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SliderBg extends StatelessWidget {
  final String index;
  final VoidCallback onPressed;
  const SliderBg({super.key, required this.index, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(15),
        width: 230,
        height: 200,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImagePaths.cardComp.path),
            fit: BoxFit.fill,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          children: [
            Center(
              child: Text(
                index.toString(),
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ), // dito maglalagay ng labels
      ),
    );
  }
}
