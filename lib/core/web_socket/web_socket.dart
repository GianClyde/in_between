import 'dart:async';
import 'dart:convert';

import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  final WebSocketChannel _channel;
  final StreamController<Map<String, dynamic>> _controller =
      StreamController.broadcast();

  WebSocketService(this._channel) {
    _channel.stream.listen(
      (event) {
        try {
          final decoded = jsonDecode(event);
          if (decoded is Map<String, dynamic>) {
            _controller.add(decoded);
          }
        } catch (e) {
          print('WebSocketService: Error parsing data: $e');
        }
      },
      onError: (e) => print('WebSocketService: Stream error: $e'),
      onDone: () => print('WebSocketService: Connection closed'),
    );
  }

  Stream<Map<String, dynamic>> get stream => _controller.stream;

  void send(Map<String, dynamic> message) {
    final encoded = jsonEncode(message);
    _channel.sink.add(encoded);
  }

  void dispose() {
    _channel.sink.close();
    _controller.close();
  }
}
