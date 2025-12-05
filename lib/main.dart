import 'package:flutter/material.dart';
import 'services/api_service.dart';
import 'models/people.dart';

void main() {
  runApp(const StarWarsApp());
}

class StarWarsApp extends StatelessWidget {
  const StarWarsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Star Wars Characters',
      home: PeoplePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PeoplePage extends StatefulWidget {
  @override
  State<PeoplePage> createState() => _PeoplePageState();
}

class _PeoplePageState extends State<PeoplePage> {
  final ApiService api = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Star Wars Characters"),
        centerTitle: true,
      ),
      body: FutureBuilder<List<People>>(
        future: api.fetchPeople(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          final people = snapshot.data ?? [];

          return ListView.builder(
            itemCount: people.length,
            itemBuilder: (context, index) {
              final person = people[index];
              return ListTile(
                title: Text("Name: ${person.name}"),
                subtitle: Text("Height: ${person.height} cm"),
              );
            },
          );
        },
      ),
    );
  }
}
