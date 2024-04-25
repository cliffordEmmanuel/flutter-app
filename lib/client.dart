

class Client {
  final String name;
  final String number;
  final String photoURL;

  Client({
    required this.name,
    required this.number,
    required this.photoURL,
  });

  Map<String, dynamic> toJson() {
    var jsonObj = {
      'name': name,
      'number': number,
      'photoURL': photoURL,
    };
    return jsonObj;
  }

  factory Client.fromJson(dynamic json) {
    return Client(
      name: json['name'] as String,
      number: json['number'] as String,
      photoURL: json['photoURL'] as String,
    );
  }
}
