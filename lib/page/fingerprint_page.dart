import 'package:fingerprintlogin_app/api/local_auth_api.dart';
import 'package:fingerprintlogin_app/main.dart';
import 'package:fingerprintlogin_app/page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class FingerprintPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(MyApp.title),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(32),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildAvailability(context),
                // const SizedBox(height: 24),
                // buildAuthenticate(context),
                const SizedBox(height: 24),
                IconButton(
                  onPressed: () async {
                    final isAuthenticated = await LocalAuthApi.authenticate();
                    isAuthenticated
                        ? Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => HomePage()),
                          )
                        : TweenAnimationBuilder(
                            tween: Tween(begin: 30.0, end: 0),
                            duration: const Duration(seconds: 30),
                            builder: (context, value, child) {
                              double val = value as double;
                              int time = val.toInt();
                              return Text(
                                "Retry in $time to continue",
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center,
                              );
                            },
                            onEnd: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FingerprintPage(),
                                ),
                              );
                            },
                          );
                  },
                  icon: const Icon(
                    Icons.fingerprint_sharp,
                  ),
                  iconSize: 50,
                ),
              ],
            ),
          ),
        ),
      );

  Widget buildAvailability(BuildContext context) => buildButton(
        text: 'Check Availability',
        icon: Icons.event_available,
        onClicked: () async {
          final isAvailable = await LocalAuthApi.hasBiometrics();
          final biometrics = await LocalAuthApi.getBiometrics();
          bool isBiometricSupported = await LocalAuthApi.isDeviceSupported();
          final hasFingerprint = biometrics.contains(BiometricType.fingerprint);
          final hasFace = biometrics.contains(BiometricType.face);
          final hasiris = biometrics.contains(BiometricType.iris);
          final hasStrong = biometrics.contains(BiometricType.strong);
          final hasWeak = biometrics.contains(BiometricType.weak);

          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Availability'),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildText('Device Supported', isBiometricSupported),
                  buildText('Biometrics', isAvailable),
                  buildText('Fingerprint', hasFingerprint),
                  buildText('Face', hasFace),
                  buildText('Iris', hasiris),
                  buildText('Strong', hasStrong),
                  buildText('Weak', hasWeak),
                ],
              ),
            ),
          );
        },
      );

  Widget buildText(String text, bool checked) => Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            checked
                ? const Icon(Icons.check, color: Colors.green, size: 24)
                : const Icon(Icons.close, color: Colors.red, size: 24),
            const SizedBox(width: 12),
            Text(text, style: const TextStyle(fontSize: 24)),
          ],
        ),
      );

  Widget buildAuthenticate(BuildContext context) => buildButton(
        text: 'Authenticate',
        icon: Icons.fingerprint_sharp,
        onClicked: () async {
          final isAuthenticated = await LocalAuthApi.authenticate();
          isAuthenticated
              ? Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => HomePage()),
                )
              : TweenAnimationBuilder(
                  tween: Tween(begin: 30.0, end: 0),
                  duration: const Duration(seconds: 30),
                  builder: (context, value, child) {
                    double val = value as double;
                    int time = val.toInt();
                    return Text(
                      "Retry in $time to continue",
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    );
                  },
                  onEnd: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FingerprintPage(),
                      ),
                    );
                  },
                );
          // if (isAuthenticated) {
          //   Navigator.of(context).pushReplacement(
          //     MaterialPageRoute(builder: (context) => HomePage()),
          //   );
          // }else{
          //   TweenAnimationBuilder(
          //           tween: Tween(begin: 30.0, end: 0),
          //           duration: const Duration(seconds: 30),
          //           builder: (context, value, child) {
          //             double val = value as double;
          //             int time = val.toInt();
          //             return Text(
          //               "Retry after $time seconds",
          //               style: const TextStyle(
          //                 fontSize: 16,
          //               ),
          //               textAlign: TextAlign.center,
          //             );
          //           },
          //   );
          // }
        },
      );

  Widget buildButton({
    required String text,
    required IconData icon,
    required VoidCallback onClicked,
  }) =>
      ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(50),
        ),
        icon: Icon(icon, size: 26),
        label: Text(
          text,
          style: const TextStyle(fontSize: 20),
        ),
        onPressed: onClicked,
      );
}
