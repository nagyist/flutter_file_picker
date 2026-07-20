/// Configuration options specific to the Linux platform.
final class LinuxOptions {
  /// Creates a set of Linux-specific configuration options for file picker operations.
  const LinuxOptions({this.lockParentWindow = false, this.parentWindow});

  /// Whether the child window (file picker) should stay in front of the parent window
  /// as a modal window until closed.
  final bool lockParentWindow;

  /// An optional X11 or Wayland parent window handle identifier
  /// (e.g. `"x11:0x3a00001"` or `"wayland:handle"`).
  final String? parentWindow;
}
