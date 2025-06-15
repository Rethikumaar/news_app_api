
import 'package:flutter/material.dart';

class Countries extends StatelessWidget {
  static final router = '/change-countries';

  final List<Map<String, String>> _countries = const [
    {'name': 'India', 'code': 'in'},
    {'name': 'United States', 'code': 'us'},
    {'name': 'United Kingdom', 'code': 'gb'},
    {'name': 'Canada', 'code': 'ca'},
    {'name': 'Australia', 'code': 'au'},
    {'name': 'Germany', 'code': 'de'},
    {'name': 'France', 'code': 'fr'},
    {'name': 'Japan', 'code': 'jp'},
    {'name': 'China', 'code': 'cn'},
    {'name': 'Brazil', 'code': 'br'},
  ];

  const Countries({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Country'),
      ),
      body: ListView.builder(
        itemCount: _countries.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(_countries[index]['name']!),
          onTap: () {
            Navigator.of(context).pop(_countries[index]['code']);
          },
        ),
      ),
    );
  }
}