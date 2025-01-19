/// The utility helper for the logger of the package.
mixin LogUtils {
  /// Returns the name of the caller function by the given [stackTrace].
  ///
  /// The [dept] parameter is the depth of the caller function in the stack
  /// trace. The default value is `2` that gets the caller function of the
  /// function that calls this function.
  String callerFunction({
    StackTrace? stackTrace,
    int dept = 2,
  }) {
    stackTrace ??= StackTrace.current;
    final frames = stackTrace.toString().split('\n');
    if (frames.length > dept) {
      final callerFrame = frames[dept];
      final match = RegExp(r'#\d+\s+(.+)\s+\(.+\)').firstMatch(callerFrame);
      final result = match?.group(1);
      if (result != null) return result;
    }
    return 'Unknown caller';
  }
}
