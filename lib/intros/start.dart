import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:tweak/intros/intro_layout.dart';


class Start extends StatefulWidget {

  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {

  static List<Slide> _slides = [
    new Slide(
      icon: 'assets/images/tw-1.jpg',
      title: 'Littel Tweeks.\nBig Improvements. ',
      description: 'Improve your Self, your Family & your Home with Services & Experiences pr'
        'ovided by Tweak.',),
    new Slide(
      icon: 'assets/images/tw-2.jpg',
      title: 'Your place or Our’s.\nOutside or Virtual.',
      description: 'Enjoy the services you want,\ndelivered the way you need.',),
    new Slide(
      icon: 'assets/images/tw-3.jpg',
      title: 'Tweaks for your\nSelf, Family or Home',
      description: 'A multitude of talented providers offer unique & beneficial services for '
        'Self, Family & Home.',),
    new Slide(
      icon: 'assets/images/tw-4.jpg',
      title: 'Private or Shared.\nIt’s easy to split.',
      description: 'Whether it’s a Read-a-Loud Playdate with your neighbor or a Yoga Session'
        ' with your BFF - it’s always easy to split bookings with Tweak',)
  ];

  static String _buttonText = 'Let’s Tweak';


  SingleButtonIntro _appIntro = new SingleButtonIntro(
      _slides,
      _buttonText,
      );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _appIntro
    );
  }


}
