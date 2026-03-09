import 'window_lifecycle_manager.dart';

/// Global reference to window lifecycle manager
late WindowLifecycleManager _windowLifecycleManager;

/// Get the window lifecycle manager instance
WindowLifecycleManager getWindowLifecycleManager() {
  return _windowLifecycleManager;
}

/// Set the window lifecycle manager instance (call this from main.dart)
void setWindowLifecycleManager(WindowLifecycleManager manager) {
  _windowLifecycleManager = manager;
}
