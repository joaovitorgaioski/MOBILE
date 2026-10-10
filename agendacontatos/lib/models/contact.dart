class Contact {
  final int? id;
  final String name;
  final String phone;
  final String email;
  final String? age;

  Contact({
    this.id,
    required this.name,
    required this.phone,
    required this.email,
    this.age,
  });

  factory Contact.fromMap(Map<String, dynamic> map) => Contact(
    id: map['id'] as int?,
    name: map['name'] as String,
    phone: map['phone'] as String,
    email: map['email'] as String,
    age: map['age'] as String,
  );

  Map<String, dynamic> toMap() => {
    if (id != null) 'id': id,
    'name': name,
    'phone': phone,
    'email': email,
    'age': age,
  };
}
