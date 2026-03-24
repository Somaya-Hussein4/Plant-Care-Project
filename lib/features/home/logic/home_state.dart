abstract class HomeState {}

// The starting state when the user opens the app
class HomeInitial extends HomeState {}

// The state that triggers the navigation handoff
class HomeNavigateToResult extends HomeState {
  final String path; // The data being handed off
  HomeNavigateToResult(this.path);
}
