import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_moon/widgets/customDropdown.dart';
import 'package:http/http.dart' as http;


class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late double _deviceHeight, _deviceWidth;
  List<String> _flightNames = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _fetchFlightNames(); // Trigger the function here
  }

  Future<void> _fetchFlightNames() async {
    log("inise fetch");

    const String apiUrl =
        'http://api.aviationstack.com/v1/flights?access_key=ca8d6c88e6453677af9cc05f9cb3bb71'; // Replace YOUR_API_KEY with your API key.
    try {
      log("inside try");
      final response = await http.get(Uri.parse(apiUrl));
      print("reposne ${response.toString()}");
      if (response.statusCode == 200) {
        print("reposne 1${response.body}");
        final data = jsonDecode(response.body);
        final flights = data['data'] as List;
        log("flight name $flights");

        setState(() {
          // Extracting the 'iata' from the 'airline' field and filtering out null values
          _flightNames = flights
              .map((flight) => flight['airline']['name'] as String?)
              .where((name) => name != null)
              .map((name) => name!) // Null safety: ensures the name is non-null
              .toList();
          _loading = false;
        });
        log("message1 $_flightNames");
      } else {
        throw Exception('Failed to load flight data');
      }
    } catch (error) {
      print(error);
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: Container(
              height: _deviceHeight,
              width: _deviceWidth,
              padding: EdgeInsets.symmetric(
                  horizontal: _deviceWidth * 0.05,
                  vertical: _deviceHeight * 0.05),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: _imageWidget(),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _titleWidget(),
                      _bookAride(),
                    ],
                  ),
                ],
              ))),
    );
  }

  Widget _imageWidget() {
    return Container(
      height: _deviceHeight * 0.7,
      width: _deviceWidth * 0.7,
      decoration: const BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage("assets/images/astro_moon.png")),
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

  Widget _bookAride() {
    return Container(
      height: _deviceHeight * 0.23,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _placesDropdownWidget(),
          _travellersInfo(),
          _bookRideButton()
        ],
      ),
    );
  }

  Widget _placesDropdownWidget() {
    return customDropdown(
      items: _flightNames,
      width: _deviceWidth,
    );
  }

  Widget _travellersInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        customDropdown(
          items: const ['1', '2', '3'],
          width: _deviceWidth * 0.35,
        ),
        customDropdown(
          items: const ['Economy', 'Business', 'First'],
          width: _deviceWidth * 0.50,
        ),
      ],
    );
  }

  Widget _bookRideButton() {
    return Container(
      width: _deviceWidth,
      height: _deviceHeight * 0.07,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: MaterialButton(
          onPressed: () {},
          child: const Text("Book a Ride",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ))),
    );
  }
}
