import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'page/fingerprint_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const String title = 'Fingerprint Login';
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(primarySwatch: Colors.purple),
        home: FingerprintPage(),
      );
}
// import 'package:flutter/material.dart';
// //1. imported local authentication plugin
// import 'package:local_auth/local_auth.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(title: 'Fingerprint Authentication',),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);
//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   // 2. created object of localauthentication class
//   final LocalAuthentication _localAuthentication = LocalAuthentication();
//   // 3. variable for track whether your device support local authentication means
//   //    have fingerprint or face recognization sensor or not
//   bool _hasFingerPrintSupport = false;
//   // 4. we will set state whether user authorized or not
//   String _authorizedOrNot = "Not Authorized";
//   // 5. list of avalable biometric authentication supports of your device will be saved in this array
//   List<BiometricType> _availableBuimetricType = <BiometricType>[];

//   Future<void> _getBiometricsSupport() async {
//     // 6. this method checks whether your device has biometric support or not
//     bool hasFingerPrintSupport = false;
//     try {
//       hasFingerPrintSupport = await _localAuthentication.canCheckBiometrics;
//     } catch (e) {
//       print(e);
//     }
//     if (!mounted) return;
//     setState(() {
//       _hasFingerPrintSupport = hasFingerPrintSupport;
//     });
//   }

//   Future<void> _getAvailableSupport() async {
//     // 7. this method fetches all the available biometric supports of the device
//     List<BiometricType> availableBuimetricType = <BiometricType>[];
//     try {
//       availableBuimetricType =
//           await _localAuthentication.getAvailableBiometrics();
//     } catch (e) {
//       print(e);
//     }
//     if (!mounted) return;
//     setState(() {
//       _availableBuimetricType = availableBuimetricType;
//     });
//   }

//   Future<void> _authenticateMe() async {
//     // 8. this method opens a dialog for fingerprint authentication.
//     //    we do not need to create a dialog nut it popsup from device natively.
//     bool authenticated = false;
//     try {
//       authenticated = await _localAuthentication.authenticate(
//         localizedReason: "Authenticate for Testing", // message for dialog
//         // useErrorDialogs: true,// show error in dialog
//         // stickyAuth: true,// native process
//       );
//     } catch (e) {
//       print(e);
//     }
//     if (!mounted) return;
//     setState(() {
//       _authorizedOrNot = authenticated ? "Authorized" : "Not Authorized";
//     });
//   }

//   @override
//   void initState() {
//     _getBiometricsSupport();
//     _getAvailableSupport();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text("Has FingerPrint Support : $_hasFingerPrintSupport"),
//             Text(
//                 "List of Biometrics Support: ${_availableBuimetricType.toString()}"),
//             Text("Authorized : $_authorizedOrNot"),
//             TextButton(
//               //color: Colors.green,
//               onPressed: _authenticateMe,
//               child: const Text("Authorize Now"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
