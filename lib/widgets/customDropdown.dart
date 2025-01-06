import 'package:flutter/material.dart';

class customDropdown extends StatelessWidget {
  final List<String> items;
  final double width;

  customDropdown({required this.items, required this.width}); // Constructor

  @override
  Widget build(BuildContext context) {
    // Remove duplicates to ensure unique values in the dropdown
    List<String> uniqueItems = items.toSet().toList();
    print("uniquw $uniqueItems");

    // Make sure there is at least one item in the list to avoid 'null' values
    String selectedValue = uniqueItems.isNotEmpty ? uniqueItems.last : '';

    return Container(
      width: width,
      height: 50,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(51, 51, 51, 1.0),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: DropdownButton<String>(
        value: selectedValue, // Safe assignment
        dropdownColor: const Color.fromRGBO(51, 51, 51, 1.0),
        icon: const Icon(
          Icons.arrow_drop_down,
          color: Colors.white,
        ),
        iconSize: 30,
        isExpanded: true,
        underline: Container(),
        style: const TextStyle(color: Colors.white, fontSize: 20),
        items: uniqueItems.map((String value) {
          return DropdownMenuItem(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (value) {
          print(value); // Handle item selection
        },
      ),
    );
  }
}
