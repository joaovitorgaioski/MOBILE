import 'package:local_auth/local_auth.dart';

class Auth {
  final LocalAuthentication _auth = LocalAuthentication();

  Future<bool> authenticate() async {
    return await _auth.authenticate(
      localizedReason: 'Por favor, autentique-se',
      biometricOnly: true,
    );
  }
}
