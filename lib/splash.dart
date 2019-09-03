import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
 final Widget child;
 final GestureTapCallback onTab;

  const Splash({Key key, this.onTab, this.child}) : super(key: key);
// Splash(this.child,this.onTab);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {

  AnimationController controller;
  Tween<double> radiusTween;
  Animation<double> radiusAnimation;

  @override
  void initState() {
    // TODO: implement initState
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 400))
    ..addListener((){
      setState(() {

      });
    });
    radiusTween = Tween<double>(begin: 0,end: 50);
    radiusAnimation = radiusTween.animate(CurvedAnimation(curve: Curves.linear));
    super.initState();
  }
  void _handleTab(){
    controller.forward(from: 0);
      widget.onTab();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: SplashPaint(
        radius: radiusAnimation.value,
      ),
      child: GestureDetector(
          child: widget.child,
      onTap: _handleTab,
      ),
    );
  }
}
class SplashPaint extends CustomPainter{
  final double radius;
  final Paint blackPaint;

  SplashPaint({this.radius}):blackPaint= Paint()
    ..color=Colors.black
  ..style = PaintingStyle.stroke
  ..strokeWidth = 7;
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
//var newPaint = new Paint()
//    ..color= Colors.black;
    canvas.drawCircle(Offset(size.width/2, size.height/2), radius, blackPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }

}