

// class LocationScreen extends StatefulWidget {
//   const LocationScreen({Key? key}) : super(key: key);

//   @override
//   _LocationScreenState createState() => _LocationScreenState();
// }

// class _LocationScreenState extends State<LocationScreen> {
//   ReceivePort port = ReceivePort();

//   String logStr = '';
//   bool isRunning = false;
//   LocationDto? lastLocation;

//   @override
//   void initState() {
//     super.initState();

//     if (IsolateNameServer.lookupPortByName(LocationServiceRepository.isolateName) != null) {
//       IsolateNameServer.removePortNameMapping(LocationServiceRepository.isolateName);
//     }

//     IsolateNameServer.registerPortWithName(port.sendPort, LocationServiceRepository.isolateName);

//     port.listen(
//       (dynamic data) async {
//         await updateUI(data);
//       },
//     );
//     initPlatformState();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   Future<void> updateUI(LocationDto data) async {
//     final log = await FileManager.readLogFile();

//     await _updateNotificationText(data);

//     setState(() {
//       if (data != null) {
//         lastLocation = data;
//       }
//       logStr = log;
//     });
//   }

//   Future<void> _updateNotificationText(LocationDto data) async {
//     if (data == null) {
//       return;
//     }

//     await BackgroundLocator.updateNotificationText(
//         title: "new location received",
//         msg: "${DateTime.now()}",
//         bigMsg: "${data.latitude}, ${data.longitude}");
//   }

//   Future<void> initPlatformState() async {
//     print('Initializing...');
//     await BackgroundLocator.initialize();
//     logStr = await FileManager.readLogFile();
//     print('Initialization done');
//     final _isRunning = await BackgroundLocator.isServiceRunning();
//     setState(() {
//       isRunning = _isRunning;
//     });
//     print('Running ${isRunning.toString()}');
//   }

//   @override
//   Widget build(BuildContext context) {
//     final start = SizedBox(
//       width: double.maxFinite,
//       child: ElevatedButton(
//         child: Text('Start'),
//         onPressed: () {
//           _onStart();
//         },
//       ),
//     );
//     final stop = SizedBox(
//       width: double.maxFinite,
//       child: ElevatedButton(
//         child: Text('Stop'),
//         onPressed: () {
//           onStop();
//         },
//       ),
//     );
//     final clear = SizedBox(
//       width: double.maxFinite,
//       child: ElevatedButton(
//         child: Text('Clear Log'),
//         onPressed: () {
//           FileManager.clearLogFile();
//           setState(() {
//             logStr = '';
//           });
//         },
//       ),
//     );
//     String msgStatus = "-";
//     if (isRunning != null) {
//       if (isRunning) {
//         msgStatus = 'Is running';
//       } else {
//         msgStatus = 'Is not running';
//       }
//     }
//     final status = Text("Status: $msgStatus");

//     final log = Text(
//       logStr,
//     );

//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Flutter background Locator'),
//         ),
//         body: Container(
//           width: double.maxFinite,
//           padding: const EdgeInsets.all(22),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[start, stop, clear, status, log],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void onStop() async {
//     await BackgroundLocator.unRegisterLocationUpdate();
//     final _isRunning = await BackgroundLocator.isServiceRunning();
//     setState(() {
//       isRunning = _isRunning;
//     });
//   }

//   void _onStart() async {
//     if (await _checkLocationPermission()) {
//       await _startLocator();
//       final _isRunning = await BackgroundLocator.isServiceRunning();

//       setState(() {
//         isRunning = _isRunning;
//         lastLocation = null;
//       });
//     } else {
//       // show error
//     }
//   }

//   Future<bool> _checkLocationPermission() async {
//     final access = await Permission.locationAlways.status;
//     switch (access) {
//       case PermissionStatus.denied:
//       case PermissionStatus.restricted:
//         final permission = await Permission.locationAlways.request();
//         if (permission == PermissionStatus.granted) {
//           return true;
//         } else {
//           return false;
//         }
//       case PermissionStatus.granted:
//         return true;
//       default:
//         return false;
//     }
//   }

//   Future<void> _startLocator() async {
//     Map<String, dynamic> data = {'countInit': 1};
//     return await BackgroundLocator.registerLocationUpdate(
//       LocationCallbackHandler.callback,
//       initCallback: LocationCallbackHandler.initCallback,
//       initDataCallback: data,
//       disposeCallback: LocationCallbackHandler.disposeCallback,
//       iosSettings: const IOSSettings(accuracy: LocationAccuracy.NAVIGATION, distanceFilter: 0),
//       autoStop: false,
//       androidSettings: const AndroidSettings(
//         accuracy: LocationAccuracy.NAVIGATION,
//         interval: 5,
//         distanceFilter: 0,
//         client: LocationClient.google,
//         androidNotificationSettings: AndroidNotificationSettings(
//           notificationChannelName: 'Location tracking',
//           notificationTitle: 'Start Location Tracking',
//           notificationMsg: 'Track location in background',
//           notificationBigMsg:
//               'Background location is on to keep the app up-tp-date with your location. This is required for main features to work properly when the app is not running.',
//           notificationIconColor: Colors.grey,
//           notificationTapCallback: LocationCallbackHandler.notificationCallback,
//         ),
//       ),
//     );
//   }
// }
