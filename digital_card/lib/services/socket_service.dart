import "package:socket_io_client/socket_io_client.dart" as io;

class SocketService {
  late io.Socket socket;

  connect() {
    socket = io.io("http://localhost:3000", <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false
    });
    socket.connect();
  }
}
