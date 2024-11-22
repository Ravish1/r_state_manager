
import 'user_state.dart';
import 'user_event.dart';
import 'r_state_manager.dart';

class UserManager extends RStateManager<UserState, UserEvent> {
  UserManager() : super(
    UserState(name: 'John Doe', age: 25),
    (state, event) {
      if (event is UpdateUserNameEvent) {
        return state.copyWith(name: event.name);
      } else if (event is UpdateUserAgeEvent) {
        return state.copyWith(age: event.age);
      }
      return state;
    },
  );
}
