import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:in_between/core/cubit/user_cubit.dart';
import 'package:in_between/core/domain/user_entity.dart';
import 'package:in_between/core/routes/app_router.dart';
import 'package:in_between/core/widgets/history_tile.dart';
import 'package:in_between/core/widgets/images.dart';
import 'package:in_between/features/home/presentation/bloc/home_bloc.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:transformer_page_view_tv/transformer_page_view.dart';
// import 'package:vector_math/vector_math_64.dart' hide Colors;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late UserEntity? user;
  final TransformerPageController controller = TransformerPageController(
    itemCount: 4,
  );

  @override
  void initState() {
    super.initState();
    user = context.read<UserCubit>().state;
    if (user == null) {
      //context.read<UserCubit>().clear();
      context.go(Routes.loginScreen);
      return;
    }
    context.read<HomeBloc>().add(HomeFetchUserWallet(userId: user!.userId));
  }

  @override
  Widget build(BuildContext context) {
    List<String> rooms = ['room1', 'room2', 'room3', 'room4'];
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            String walletText = "Loading wallet...";
            if (state is HomeUserWalletFetchedSuccess) {
              walletText = state.userWallet.walletId;
            } else if (state is HomeUserWalletFetchedFailed) {
              walletText = "Failed to load wallet";
            } else if (state is HomeJoinRoomSuccess) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                context.go('${Routes.roomScreen}/${state.roomId}');
              });
            }
            return Text(
              "Welcome ${user!.username} || wallet $walletText",
              style: TextStyle(fontSize: 28),
            );
          },
        ),
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
                double depth = info.position! * -30; // Push side cards backward
                double angle =
                    info.position! * 0.12; // Slight rotation for perspective
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
                    context.read<HomeBloc>().add(
                      HomeJoinRoom(
                        user: user!,
                        roomId: rooms[index].toString(),
                      ),
                    );
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
        ),
      ),
    );
  }
}
