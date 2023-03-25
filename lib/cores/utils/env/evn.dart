import 'package:flutter_dotenv/flutter_dotenv.dart';

class ENV {
  static final String flutterWavePublicKey = dotenv.get('flutterWavePublicKey');
  static final String paystackPublicKey = dotenv.get('PAYSTACK_PUBLIC_KEY');
}
