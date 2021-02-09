import 'dart:math';

import 'package:animationtut/Widgets/card_back.dart';
import 'package:animationtut/Widgets/card_front.dart';
import 'package:flutter/material.dart';

class MyCardsPage extends StatefulWidget {
  @override
  _MyCardsPageState createState() => _MyCardsPageState();
}

class _MyCardsPageState extends State<MyCardsPage>
    with SingleTickerProviderStateMixin {
  double _rotationFactor = 0;
  String _cardNumber = '';
  String _cvvNumber = '';
  String _nameOnCard = '';
  AnimationController _flipAnimationController;
  Animation<double> _flipAnimation;
  FocusNode _cvvFocus;

  TextEditingController _cardNumberController, _cvvController, _nameController;
  _MyCardsPageState() {
    _cardNumberController = TextEditingController();
    _cvvController = TextEditingController();
    _nameController = TextEditingController();
    _cvvFocus = FocusNode();

    _cardNumberController.addListener(() {
      _cardNumber = _cardNumberController.text;
      setState(() {});
    });

    _cvvController.addListener(() {
      _cvvNumber = _cvvController.text;
      setState(() {});
    });

    _nameController.addListener(() {
      _nameOnCard = _nameController.text;
      setState(() {});
    });

    _cvvFocus.addListener(() {
      _cvvFocus.hasFocus
          ? _flipAnimationController.forward()
          : _flipAnimationController.reverse();
    });
  }

  @override
  void initState() {
    super.initState();

    _flipAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 350));

    _flipAnimation =
        Tween<double>(begin: 0, end: 1).animate(_flipAnimationController)
          ..addListener(() {
            setState(() {});
          });
    _flipAnimationController.forward();
  }

  @override
  void dispose() {
    _flipAnimationController.dispose();
    _cvvFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Cards"),
      ),
      body: ListView(
        children: [
          Center(
            child: Column(
              children: [
                Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(pi * _flipAnimation.value),
                  origin: Offset(MediaQuery.of(context).size.width / 2, 0),
                  child: _flipAnimation.value < 0.5
                      ? CardFrontView(
                          cardNumber: _cardNumber,
                          nameOnCard: _nameOnCard,
                        )
                      : CardBackView(
                          cvvNumber: _cvvNumber,
                        ),
                ),
                // Slider(
                //   onChanged: (double value) {
                //     setState(() {
                //       _rotationFactor = value;
                //     });
                //   },
                //   value: _rotationFactor,
                // ),
                Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      TextField(
                        maxLength: 16,
                        controller: _cardNumberController,
                        decoration: InputDecoration(
                          hintText: "Card Number",
                        ),
                      ),
                      TextField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          hintText: "Name on Card",
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: "Expiry Date",
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 32,
                          ),
                          Expanded(
                            flex: 1,
                            child: TextField(
                              maxLength: 3,
                              focusNode: _cvvFocus,
                              controller: _cvvController,
                              decoration: InputDecoration(
                                hintText: "CVV",
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
