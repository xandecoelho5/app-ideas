class Person {
  Person({
    required this.name,
    required this.street,
    required this.city,
    required this.state,
    required this.country,
    required this.telephone,
    required this.birthday,
    this.isHovering = false,
    this.selected = false,
  });

  final String name;
  final String street;
  final String city;
  final String state;
  final String country;
  final String telephone;
  final DateTime birthday;
  bool isHovering;
  bool selected;
}
