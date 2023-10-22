import 'package:flutter/material.dart';
import 'package:football_app/screens/player_card.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MultiScreenPlayerCard extends StatefulWidget {
  MultiScreenPlayerCard({super.key, required this.count});
  final int count;

  @override
  State<MultiScreenPlayerCard> createState() => _MultiScreenPlayerCardState();
}

class _MultiScreenPlayerCardState extends State<MultiScreenPlayerCard> {
  final controller = PageController();
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      int next = controller.page!.round();
      if (currentPage != next) {
        if (next < currentPage) {
          controller.animateToPage(currentPage,
              duration: Duration(milliseconds: 1), curve: Curves.easeIn);
        } else {
          currentPage = next;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              child: PageView.builder(
                controller: controller,
                itemCount: widget.count,
                itemBuilder: (_, index) => Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: PlayerCard(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: SmoothPageIndicator(
                  controller: controller, // PageController
                  count: widget
                      .count, // the number of pages // your preferred effect
                  effect: SlideEffect(
                    dotColor: Colors.grey, // Set the dot color to black
                    activeDotColor: Colors.black,
                  ),
                  onDotClicked: (index) {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
