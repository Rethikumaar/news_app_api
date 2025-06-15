import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './country.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _selectedCountryCode = '';

  Future<List<dynamic>> getNews() async {
    final url = Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=$_selectedCountryCode&category=business&apiKey=b925e3863f4b4054a0a59468c7872f66');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['articles'];
    } else {
      throw Exception('Failed to load news');
    }
  }

  void _selectCountry() async {
    final selectedCode = await Navigator.of(context).pushNamed(Countries.router);
    if (selectedCode != null && selectedCode is String) {
      setState(() {
        _selectedCountryCode = selectedCode;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jackie News ($_selectedCountryCode)'),
        backgroundColor: Colors.grey,
        actions: [
          MaterialButton(
            onPressed: _selectCountry,
            child: const Text(
              'Change',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: getNews(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong!'));
          } else {
            final articles = snapshot.data as List;

            if (articles.isEmpty) {
              return const Center(child: Text('No news available for this country.'));
            }

            return ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];
                final imageUrl = article['urlToImage'] ?? '';
                final title = article['title'] ?? 'No title';

                return Card(
                  margin: const EdgeInsets.all(10),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        if (imageUrl.isNotEmpty)
                          Image.network(
                            imageUrl,
                            errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.broken_image),
                          ),
                        const SizedBox(height: 11),
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
