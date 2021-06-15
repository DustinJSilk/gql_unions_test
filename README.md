This is a simple project to reproduce an issue with a Flutter package dart-gql that builds auto generated classes from a GraphQL schema.

## The issue

GraphQL union types fail to work when built for release using code obfuscation.

Running the app in a local simulator will correctly show either a success or error typed message returned from the server.
When built for release and run on a physical device, the types can't be checked and are unusable.

## Setup

Start the simple GraphQL server:

`$ npm install`

`$ npm run server`

Next, you'll need to point the app to your local GraphQL server.

Get the local IP address (on mac):

`$ ipconfig getifaddr en0`

Replace `localhost` in the url found in `lib/main.dart` on line 10 with your computers local IP address.

## Running

You should now be able to run the app in a simulator and see the correct messages on screen.

You can then run the following to build a release APK:

`$ flutter build apk --release --obfuscate --split-debug-info=./debug_split`

Connect a physical device and install the built APK:

`$ adb install build/app/outputs/flutter-apk/app-release.apk`
