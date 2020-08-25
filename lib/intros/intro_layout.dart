import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tweak/constants.dart';
import 'package:tweak/intros/slide_right_route.dart';
import 'package:tweak/intros/sign_in.dart';


double _width, _height;
List<Slide> _slides;
String _buttonText;

class SingleButtonIntro extends StatefulWidget {

  SingleButtonIntro(List<Slide> slidesList,String buttonText,){
    _slides = slidesList;
    _buttonText = buttonText;
  }

  @override
  State<StatefulWidget> createState() {
    return SingleButtonIntroState();
  }
}

class SingleButtonIntroState extends State<SingleButtonIntro> {

  static final PageController pageController = new PageController();
  static int pos = 0;

  static const _kDuration = const Duration(milliseconds: 300);
  var _dotIndicatorPlus = new Dots(
    controller: pageController,
    itemCount: _slides.length,
    onPageSelected: (int page) {
      pageController.animateToPage(page,
          duration: _kDuration, curve: Curves.decelerate);
    },
    color: Colors.black87,
  );

  @override
  Widget build(BuildContext context) {

    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;
//    _orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          AnimatedContainer(
            curve: Curves.bounceInOut,
            duration: Duration(milliseconds: 400),
            child: PageView.builder(
              physics: new ClampingScrollPhysics(),
              controller: pageController,
              itemBuilder: (BuildContext context, int index) {
                return _slides[index % _slides.length];
              },
              itemCount: _slides.length,
              onPageChanged: (int value) {
                setState(() {
                  pos = value;
                });
              },
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).orientation == Orientation.portrait ? _height * 1.9/ 10 : _height*2.10/10,
            right: 0.0,
            left: 0.0,
            child: Center(
              child: _dotIndicatorPlus,
            ),
          ),
          Positioned(
              right: _width*0.5/10,
              left: _width*0.5/10,
              bottom: _height * 0.35 / 10,
              child: _bottomFixed()),
        ],
      ),
    );
  }

  Widget _bottomFixed() {
    return Center(
      child: Column(
        children: <Widget>[
          platformButton(),
          SizedBox(height: _height*0.023),
          SvgPicture.asset(
            "assets/icons/tweakapp.svg",
          ),
        ],
      ),
    );
  }

  Widget platformButton() {
    return new InkWell(
        onTap: (){
          pos<_slides.length-1 ? pageController.animateToPage(pos+1,
              duration: _kDuration, curve: Curves.decelerate) : Navigator.push(
              context, SlideRightRoute(
            page: SignIn(),
          )
          );
        },
        child: new Container(
          width: _width*0.8,
          height: _height*0.08,
          decoration: new BoxDecoration(
            color: kPrimaryColor,
            borderRadius: new BorderRadius.circular(15.0),
          ),
          child: new Center(
            child: new Text(
              _buttonText,
              style: TextStyle(
                fontFamily: 'Metropolis-Bold',
                fontSize: 15,
                color: kPrimaryLightColor,
                height: 1,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }
}

class Dots extends AnimatedWidget {
  // @Collin Jackson
  Dots({
    this.controller,
    this.itemCount,
    this.onPageSelected,
    this.color: Colors.white,
  }) : super(listenable: controller);

  final PageController controller;
  final int itemCount;
  final ValueChanged<int> onPageSelected;
  final Color color;
  static const double _kDotSize = 6.0;
  static const double _kMaxZoom = 1.5;
  static const double _kDotSpacing = 18.0;

  Widget _buildDot(int index) {
    double selectedNess = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((controller.page ?? controller.initialPage) - index).abs(),
      ),
    );

    double zoom = 1.0 + (_kMaxZoom - 1.0) * selectedNess;
    return new Container(
      width: _kDotSpacing,
      child: new Center(
        child: new Material(
          color: color,
          type: MaterialType.circle,
          child: new Container(
            width: _kDotSize * zoom,
            height: _kDotSize * zoom,
            child: new InkWell(
              onTap: () => onPageSelected(index),
            ),
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: new List<Widget>.generate(itemCount, _buildDot),
    );
  }
}

// ignore: must_be_immutable
class Slide extends StatelessWidget {
  double _height;
  double _width;
  String title, description, icon;

  Slide({this.title, this.description, this.icon});

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;


    return Scaffold(
        backgroundColor: kPrimaryLightColor,
        body:
        SizedBox(
          height: _height * 8.5 / 10,
          width: double.infinity,
          child: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).orientation == Orientation.portrait ? _height * 1 / 10 : _height * 0.5 / 10,
                  bottom: MediaQuery.of(context).orientation == Orientation.portrait ? _height * 0.75 / 10 : _height * 0.25 / 10,
                  left: 20.0,
                  right: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(icon, width: _width*(1-1*0.03), fit: BoxFit.fitWidth,),
                  SizedBox(height: _height*0.07),
                  SizedBox(
                    width: 355.0,
                    height: 72.0,
                    child: Text(
                      title,
                      style: TextStyle(
                        fontFamily: 'Metropolis-ExtraBold',
                        fontSize: 30,
                        color: kPrimaryColor,
                        height: 1,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    width: 293.0,
                    height: 60.0,
                    child: Text(
                      description,
                      style: TextStyle(
                        fontFamily: 'Metropolis-Regular',
                        fontSize: 13,
                        color: kTextColor,
                        height: 1.5384615384615385,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              )
              ),
        )
    );
  }
}
