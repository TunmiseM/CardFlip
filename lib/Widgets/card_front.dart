import 'package:flutter/material.dart';

class CardFrontView extends StatelessWidget {
  final String cardNumber;
  String _formattedCardNumber;
  final String nameOnCard;

  CardFrontView({Key key, this.cardNumber, this.nameOnCard}) : super(key: key) {
    _formattedCardNumber = this.cardNumber.padRight(16, '*');
    _formattedCardNumber = _formattedCardNumber.replaceAllMapped(
        RegExp(r".{4}"), (match) => "${match.group(0)} ");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      height: 300,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 8,
        margin: EdgeInsets.all(16),
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Image.asset(
                    'assets/visa.png',
                    width: 100,
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                Text(
                  _formattedCardNumber,
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 25, letterSpacing: 2, shadows: [
                    Shadow(color: Colors.black12, offset: Offset(2, 1))
                  ]),
                ),
                SizedBox(
                  height: 32,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Card Holder'),
                        Text(
                          nameOnCard,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Expiry'),
                        Text(
                          '10/24',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}
