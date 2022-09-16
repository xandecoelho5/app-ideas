import 'package:cause_effect/mocks.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'models/person.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cause Effect App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Person _selectedPerson = people[0];

  void onPersonNamePressed(Person person) {
    Navigator.pop(context);
    setState(() {
      _selectedPerson.selected = false;
      _selectedPerson = person;
      _selectedPerson.selected = true;
    });
  }

  Widget personName(Person person) {
    return TextButton(
      onHover: (isHovering) => setState(() => person.isHovering = isHovering),
      onPressed: () => onPersonNamePressed(person),
      child: Text(
        person.name,
        style: TextStyle(
          fontSize: person.selected ? 24 : 20,
          color: person.selected ? Colors.deepPurple : Colors.blue,
          fontWeight: FontWeight.bold,
          decoration: person.isHovering
              ? TextDecoration.underline
              : TextDecoration.none,
        ),
      ),
    );
  }

  Drawer drawer(context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: const Center(
              child: Text(
                'People List',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          ),
          ...people.map(personName).toList(),
        ],
      ),
    );
  }

  personDetails(Person person) {
    const spacer = SizedBox(height: 10);

    informationRow(String label, String value) {
      return Row(
        children: [
          Text(
            '$label: ',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(value, style: const TextStyle(fontSize: 18)),
        ],
      );
    }

    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          informationRow('Name', person.name),
          spacer,
          informationRow('Street', person.street),
          spacer,
          informationRow('City', person.city),
          spacer,
          informationRow('State', person.state),
          spacer,
          informationRow('Country', person.country),
          spacer,
          informationRow('Telephone', person.telephone),
          spacer,
          informationRow(
            'Birthday',
            DateFormat.yMMMd().format(person.birthday),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _selectedPerson.selected = true;

    return Scaffold(
      appBar: AppBar(title: const Text('Cause Effect')),
      body: personDetails(_selectedPerson),
      drawer: drawer(context),
      drawerEdgeDragWidth: 100,
    );
  }
}
