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

  static const double minRadius=50;
  static const double maxRadius=120;

  AnimationController controller;
  Tween<double> radiusTween;
  Tween<double>  borderWidthTween;
  Animation<double> radiusAnimation;
  Animation<double> borderWidthAnimation;
  AnimationStatus status;
  Offset _tapPosition;

  @override
  void initState() {
    // TODO: implement initState
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 400))
    ..addListener((){
      setState(() {

      });
    })..addStatusListener((listener){
status = listener;
      });
    radiusTween = Tween<double>(begin: 0,end: 50);
    radiusAnimation = radiusTween.animate(CurvedAnimation(curve: Curves.ease,parent: controller));
    borderWidthTween = Tween<double>(begin: 25,end: 1);
    borderWidthAnimation = radiusTween.animate(CurvedAnimation(curve: Curves.fastOutSlowIn,parent: controller));

    super.initState();
  }

  void _animate(){
    controller.forward(from: 0);
  }

  void _handleTab(TapUpDetails tapUpDetails){

    RenderBox renderBox = context.findRenderObject();
     _tapPosition = renderBox.globalToLocal(tapUpDetails.globalPosition);
     double radius = (renderBox.size.width>renderBox.size.height?
     renderBox.size.width:renderBox.size.height);

     double constraintRadius;
     if(radius >maxRadius ){
      constraintRadius = maxRadius;
     }else{
       constraintRadius = radius;
     }
radiusTween.end = constraintRadius*0.6;
     borderWidthTween.begin = radiusTween.end/2;
     borderWidthTween.end = radiusTween.end*0.01;
     _animate();
      widget.onTab();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: SplashPaint(
        radius: radiusAnimation.value,
        borderSize: borderWidthAnimation.value,
        status: status,
        tapPosition: _tapPosition,
      ),
      child:new Column(
        children: <Widget>[
          Container(
            color: Colors.blue,
            height:200.0,
            width:200.0,
            child:  GestureDetector(
              child: widget.child,
              onTapUp: _handleTab,
            ),
          ),
         SizedBox(
           height: 100,
         ),
         GestureDetector(
           onTapUp: _handleTab,
           child:Icon(Icons.close),
         ),
        ],
      ),
    );
  }
}
class SplashPaint extends CustomPainter{
  final double radius;
  final Paint blackPaint;
  final double borderSize;
  final AnimationStatus status;
  final Offset tapPosition;

  SplashPaint({@required this.radius,@required this.borderSize,@required this.status,this.tapPosition}):blackPaint= Paint()
    ..color=Colors.black
  ..style = PaintingStyle.stroke
  ..strokeWidth = borderSize;
  @override
  void paint(Canvas canvas, Size size) {

    if(status ==AnimationStatus.forward){
      canvas.drawCircle(tapPosition, radius, blackPaint);
    }

//var newPaint = new Paint()
//    ..color= Colors.black;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }

}