import 'package:flutter/material.dart';

void main() => runApp(const LogoApp());

class LogoApp extends StatefulWidget {
  const LogoApp({Key? key}) : super(key: key);

  @override
  _LogoAppState createState() => _LogoAppState();
}

class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
    animation = Tween<double>(begin: 0, end: 300).animate(controller);
    //controller.forward();
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      }
      // else if (status == AnimationStatus.dismissed) {
      //   controller.forward();
      // }
    });
    //animation.addStatusListener((state) => print("State: $state"));

  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GrowTransition(
          child: const LogoWidget(),
          animation: animation,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            controller.forward();
          },
        ),
      ),
    );
  }
}

class GrowTransition extends StatelessWidget {
  const GrowTransition({
    required this.child,
    required this.animation,
    Key? key,
  }) : super(key: key);

  final Widget child;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return SizedBox(
            height: animation.value,
            width: animation.value,
            child: child,
          );
        },
        child: child,
      ),
    );
  }
}

class LogoWidget extends StatelessWidget {
  const LogoWidget({Key? key}) : super(key: key);

  // Leave out the height and width so it fills the animating parent
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: const FlutterLogo(),
    );
  }
}









