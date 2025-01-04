import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  late double _deviceHeight, _deviceWidth;

  Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: Container(
        // color: Colors.red,
        height: _deviceHeight,
        width: _deviceWidth,
        padding: EdgeInsets.symmetric(horizontal: _deviceWidth * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [_titleWidget(), _imageWidget(), _placesDropdownWidget()],
        ),
      )),
    );
  }

  Widget _imageWidget() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage("assets/images/gomoonpicture.jpg")),
      ),
    );
  }

  Widget _titleWidget() {
    return const Text(
      "Lunar Pass",
      textAlign: TextAlign.center,
      style: TextStyle(
          color: Colors.white, fontSize: 50, fontWeight: FontWeight.w400),
    );
  }

  Widget _placesDropdownWidget() {
    List<DropdownMenuItem<String>> _items = [
      'Manjeri',
      'Kondotty',
    ].map((e) {
      return DropdownMenuItem(
        child: Text(e),
        value: e,
      );
    }).toList();
    return Container(
      child: DropdownButton(items: _items, onChanged: (_) {}),
    );
  }
}
