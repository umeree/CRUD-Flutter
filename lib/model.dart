class UserModel {
  int? id;
  String? name;
  String? description;
  String? contact;

  UserModel(
      {this.id,
      required this.name,
      required this.description,
      required this.contact});

  UserModel.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        name = res['name'],
        description = res['description'],
        contact = res['contact'];

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'contact': contact,
    };
  }
}
