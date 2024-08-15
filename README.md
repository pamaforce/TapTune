# TapTuneSDK

[![Pub Version](https://img.shields.io/pub/v/taptune.svg)](https://pub.dev/packages/taptune)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

TapTuneSDK is an intelligent settings assistant SDK designed to interact with large model workflow APIs. This SDK simplifies the integration of complex AI workflows into your applications, allowing for easy configuration and management of various settings through a seamless API interface.

## Features

- **Easy Initialization**: Quickly set up with a few lines of code.
- **Workflow Interaction**: Effortlessly interact with large language model workflows.
- **Customizable Knowledge Base**: Create and manage your own knowledge base for specific workflows.
- **Callback Support**: Supports automatic execution of callbacks after workflow completion.

## Installation

Add the following dependency to your `pubspec.yaml`:

```yaml
dependencies:
  taptune: ^1.0.0
```

Then run:

```bash
flutter pub get
```

## Getting Started

### Import the SDK

```dart
import 'package:taptune/taptune.dart';
```

### Initialize the SDK

To start using `TapTuneSDK`, you first need to initialize it with your `appID`, a knowledge base, and a callback function:

```dart
void main() async {
  final tapTune = TapTuneSDK();

  bool initSuccess = await tapTune.init(
    appID: 'appid0001',
    knowledgeBase: [
      KnowledgeBase(
        id: 'c6c7aa5f-066e-aa87-f42a-b230ace2aa5b',
        name: 'Dark Mode',
        params: [
          Params(name: 'false', desc: 'Turn off dark mode'),
          Params(name: 'true', desc: 'Turn on dark mode'),
        ],
        desc: 'This setting helps users enable dark mode, also known as night mode, which can reduce eye strain caused by screen brightness.',
      ),
    ],
    callback: (result) {
      print('Callback executed with result: $result');
    },
  );

  if (initSuccess) {
    print('Initialization successful.');
    // Further operations
  } else {
    print('Initialization failed.');
  }
}
```

### Calling a Workflow

You can call a workflow by providing a query string. Optionally, you can enable automatic callback execution:

```dart
var result = await tapTune.callWorkflow('Enable dark mode', auto: true);
print('Result with auto: $result');

var resultWithoutAuto = await tapTune.callWorkflow('Disable dark mode');
print('Result without auto: $resultWithoutAuto');
```

### Updating the Knowledge Base

You can update or modify the knowledge base at any point:

```dart
bool success = await tapTune.updateKnowledgeBase([
  KnowledgeBase(
    id: 'c6c7aa5f-066e-aa87-f42a-b230ace2aa5b',
    name: 'Dark Mode',
    params: [
      Params(name: 'false', desc: 'Turn off dark mode'),
      Params(name: 'true', desc: 'Turn on dark mode'),
    ],
    desc: 'This setting helps users enable dark mode.',
  ),
]);
```

## API Reference

### TapTuneSDK

- **init({required String appID, required List<KnowledgeBase> knowledgeBase, required Function callback})**: Initializes the SDK with the provided `appID`, `knowledgeBase`, and `callback`.
- **updateKnowledgeBase(List<KnowledgeBase> content, {String? appID})**: Updates or creates the knowledge base.
- **callWorkflow(String query, {bool auto = false, String? appID})**: Calls the workflow with the given query.

### KnowledgeBase

- **id**: The ID of the knowledge base.
- **name**: The name of the knowledge base.
- **params**: A list of parameters for the knowledge base.
- **desc**: A description of the knowledge base.

### Params

- **name**: The name of the parameter.
- **desc**: A description of the parameter.

## Example

```dart
void main() async {
  final tapTune = TapTuneSDK();

  bool initSuccess = await tapTune.init(
    appID: 'appid0001',
    knowledgeBase: [
      KnowledgeBase(
        id: 'c6c7aa5f-066e-aa87-f42a-b230ace2aa5b',
        name: 'Dark Mode',
        params: [
          Params(name: 'false', desc: 'Turn off dark mode'),
          Params(name: 'true', desc: 'Turn on dark mode'),
        ],
        desc: 'This setting helps users enable dark mode, also known as night mode, which can reduce eye strain caused by screen brightness.',
      ),
    ],
    callback: (result) {
      print('Callback executed with result: $result');
    },
  );

  if (initSuccess) {
    print('Initialization successful.');

    var result = await tapTune.callWorkflow('Enable dark mode', auto: true);
    print('Result with auto: $result');

    var resultWithoutAuto = await tapTune.callWorkflow('Disable dark mode');
    print('Result without auto: $resultWithoutAuto');
  } else {
    print('Initialization failed.');
  }
}
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome! Please read the [Contributing Guide](CONTRIBUTING.md) for more details.

## Contact

For any issues or feature requests, please open an issue on the [GitHub repository](https://github.com/pamaforce/TapTune/issues).

---

Thank you for using TapTuneSDK! We hope it helps you simplify your workflow interactions.
```