class SpeciesName {
  final int id;
  final String name;

  const SpeciesName({required this.id, required this.name});

  factory SpeciesName.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'id': int id, 'name': String name} => SpeciesName(id: id, name: name),
      _ => throw FormatException('Failed to load SpeciesName: $json'),
    };
  }
}
