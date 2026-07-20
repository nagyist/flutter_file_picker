/// Configuration options specific to the Linux platform.
final class LinuxOptions {
  /// Creates a set of Linux-specific configuration options for file picker operations.
  const LinuxOptions({this.lockParentWindow = false});

  /// Whether the child window (file picker) should stay in front of the parent window
  /// as a modal window until closed.
  final bool lockParentWindow;
}
