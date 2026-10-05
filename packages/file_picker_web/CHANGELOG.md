## 4.0.1

- Fixed picking files on Safari (macOS and iOS) never returning the selection. The hidden `<input type="file">` was never actually attached to the document: `children.add(...)` resolved to `dart:js_interop`'s `JSAny.add` (the JS `+` operator) rather than a DOM insertion, so it silently did nothing. Chromium still delivers `change` for a detached input, but WebKit does not, leaving the returned future hanging or completing with `null`. The input is now appended with `appendChild` and kept attached until the picking session ends. [#2222](https://github.com/vicajilau/flutter_file_picker/issues/2222)
- When the window regains focus before the `change` event arrives, a selection already present on the input is now returned instead of being reported as a cancellation.
- Fixed `PlatformFile.readAsByteStream()` silently ending the stream when reading the picked file failed, which handed the app a truncated or empty file as if the read had succeeded. The error is now emitted on the stream. `readAsBytes()` now throws the original read error instead of retrying through `xFile` and losing it. [#2229](https://github.com/vicajilau/flutter_file_picker/issues/2229)
- Fixed picking files larger than 2 GB on web with the default options. The preloaded bytes were copied into a new `Blob` to build the file's `blob:` URL, which doubled the memory use and made Firefox throw `can't be an ArrayBuffer or an ArrayBufferView larger than 2 GB`. The URL now points at the picked `File` directly. As a side effect, an empty picked file now also gets a valid `blob:` URL instead of an empty one. [#2223](https://github.com/vicajilau/flutter_file_picker/issues/2223)
- Fixed `pickFiles()`/`pickFile()` never completing when processing the picked files failed. The error now completes the returned future instead of escaping uncaught.

## 4.0.0

- **BREAKING CHANGE**: `PlatformFile.length()` now returns `Future<int?>` instead of `Future<int>`. Returns `null` when the length could not be determined (e.g. a failed disk read), instead of `0`, matching `lengthSync()`. [#2197](https://github.com/vicajilau/flutter_file_picker/issues/2197)
- Fixed `FilePickerWebOptions.readSequential` having no effect. Files are now genuinely read one at a time when `true`, and concurrently (the default) when `false`, preserving selection order in the result either way. [#2206](https://github.com/vicajilau/flutter_file_picker/issues/2206)

## 3.1.0

- Implemented `PlatformFile.lengthSync()`, returning the browser's `File.size` (or the loaded bytes' length) synchronously, without doing any I/O.

## 3.0.3

- Tightened the `file_picker_platform_interface` lower bound to `^3.2.0`. This package's `pickFile()`/`pickFiles()` signatures reference `DarwinOptions`, added in that version, so resolving against an older one would fail to compile.

## 3.0.2

- Fixed the `window` `focus` listener used to detect a cancelled picker dialog never being removed after use. `removeEventListener` was passed a freshly created `.toJS` function object on every call, which never matches the one originally passed to `addEventListener`, so the listener leaked on `window` on every `pickFiles`/`pickFile` call. The JS function references are now cached and reused for both add and remove.

## 3.0.1

- Improved package description, added example, and added missing API documentation.

## 3.0.0

* Unified Web platform release for federated `file_picker` architecture using `package:web` and `dart:js_interop`.

## 2.0.0

* Deprecates plugin in favor of standalone `file_picker` for all platforms.

## 1.0.2+1

* Fix custom filter String creation.

## 1.0.2

* Addresses an issue that would cause dot being required on filters for web (#343).

## 1.0.1+2

* Bumps `file_picker_platform_interface` dependency version.

## 1.0.1+1

* Updates homepage & description.

## 1.0.1

* Updates API to support `onFileLoading` from `FilePickerInterface`.

## 1.0.0

* Adds public API documentation and updates `file_picker_platform_interface` dependency.

## 0.0.2

* Added no-op iOS podspec to prevent build issues on iOS.

## 0.0.1

* Creation of File Picker Web project draft.
