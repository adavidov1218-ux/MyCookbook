class Ingredient {
  final String name;
  final String? amount; // e.g., "400 г", "1/2 ч.л."

  Ingredient({required this.name, this.amount});

  // TODO: Add toJson and fromJson methods for persistence/serialization
}
