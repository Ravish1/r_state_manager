
class UserState {
  final String name;
  final int age;

  UserState({required this.name, required this.age});

  UserState copyWith({String? name, int? age}) {
    return UserState(
      name: name ?? this.name,
      age: age ?? this.age,
    );
  }
}
