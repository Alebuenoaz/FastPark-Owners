class User {
  final String userId;
  final String email;

  User({this.email, this.userId});

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'email': email,
    };
  }

  factory User.fromFirestore(Map<String, dynamic> firestore) {
    if (firestore == null) return null;
    return User(userId: firestore['userId'], email: firestore['email']);
  }
}
