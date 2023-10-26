import "package:digital_card_desktop/constants/contants_vars.dart";
import "package:socket_io_client/socket_io_client.dart" as io;

io.Socket connect() {
  io.Socket socket = io.io(url, {
    "transports": ["websocket"],
    "autoConnect": true,
  });

  socket.connect();
  socket.onConnect((_) {
    print("socket connect");
  });

  return socket;
}
