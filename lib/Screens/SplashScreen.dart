import 'package:flutter/material.dart';
import 'package:playonn/Screens/GameListingScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
      @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 2),()=>{
Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>GameListingScreen()))
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            // AnimatedSize(
            //   vsync: this,
            //   curve: Curves.easeOut,
            //   duration: Duration(seconds: 1),
            //   child: GestureDetector(
            //     child: Align(
            //         alignment: Alignment(-0.6, 0.2),
            //         child: Image.asset(
            //           'Images/blue.png',
            //           height: 190,
            //         )),
            //   ),
            // ),
            SplashColours('blue', 190.0, -0.5, 0.2,0),
            SplashColours('orange', 140.0, -0.4, -0.1,600),
            SplashColours('purple', 190.0, 0.4, 0.2,1200),
            SplashColours('red', 190.0, 0.4,-0.1,800),
            // Align(
            //     alignment: Alignment(0.4, 0.2),
            //     child: Image.asset(
            //       'Images/purple.png',
            //       height: 190,
            //     )),
            // Align(
            //     alignment: Alignment(0.4, -0.1),
            //     child: Image.asset(
            //       'Images/red.png',
            //       height: 190,
            //     )),
            Center(
              child: Image.asset(
                'Images/logo.png',
                height: 200,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SplashColours extends StatefulWidget {
  final colorName;
  final colorSize;
  final x;
  final y;
  final delay;

  SplashColours(this.colorName, this.colorSize, this.x, this.y,this.delay);
  @override
  _SplashColoursState createState() => _SplashColoursState();
}

class _SplashColoursState extends State<SplashColours>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    _animation = Tween(begin: 0.0, end: widget.colorSize).animate(_controller)
      ..addListener(() => setState(() {}));

    Future.delayed(Duration(milliseconds:widget.delay ), () => {
    _controller.forward()

    });
  }

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment(widget.x, widget.y),
        child: Image.asset('Images/${widget.colorName}.png',
            height: _animation.value ?? 0.0));
  }
}
