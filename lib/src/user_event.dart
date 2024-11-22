
abstract class UserEvent {}

class UpdateUserNameEvent extends UserEvent {
  final String name;
  UpdateUserNameEvent(this.name);
}

class UpdateUserAgeEvent extends UserEvent {
  final int age;
  UpdateUserAgeEvent(this.age);
}
