import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tweak/constants.dart';
import 'package:tweak/components/item_object.dart';
import 'package:tweak/widgets/service_card.dart';

class CardRow extends StatefulWidget {

  final List<ItemObject> cardRow;
  final String rowTitle;

  CardRow(this.cardRow,this.rowTitle);

  @override
  _CardRowState createState() => _CardRowState();
}

class _CardRowState extends State<CardRow> {
  List<Widget> cardSliders;

  @override
  void initState() {
    cardSliders = widget.cardRow.map((item) => ServiceCard(item.title, item.path)).toList();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    //this gonna give us total height and with of our device
    return Container(
      //margin: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          SizedBox(height: 15,),
          SizedBox(
            width: size.width*0.8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  widget.rowTitle,
                  style: TextStyle(
                    fontFamily: 'HKGrotesk-Bold',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor,
                    height: 1,
                  ),
                ),
                Text(
                  'See all',
                  style: TextStyle(
                    fontFamily: 'HKGrotesk-Medium',
                    fontSize: 14,
                    color: kGreenColor,
                    height: 1,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10,),
          CarouselSlider(
            options: CarouselOptions(
              height: 210,
              viewportFraction: 0.8,
              enableInfiniteScroll: false,
              initialPage: 0,
              autoPlay: false,
              //aspectRatio: 1.5,
              enlargeCenterPage: true,
              disableCenter: true,
            ),
            items: cardSliders,
          ),
        ],
      ),
    );
  }

}

