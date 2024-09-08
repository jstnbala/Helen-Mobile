import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketProvider with ChangeNotifier {
  IO.Socket? _socket;
  List<String> _onlineUsers = [];
  int _notificationCount = 0;

  IO.Socket? get socket => _socket;
  List<String> get onlineUsers => _onlineUsers;
  int get notificationCount => _notificationCount;

  void connectSocket(String userId) {
    _socket = IO.io(
      'https://helen-server-lmp4.onrender.com',
      <String, dynamic>{
        'transports': ['websocket'],
        'query': {'userId': userId},
      },
    );

    _socket?.on('connect', (_) {
      print('Connected: ${_socket?.id}');
      _listenForMessages(); // Start listening globally
      _listenForNotifications(); // Start listening for notifications
    });

    _socket?.on('getOnlineUsers', (users) {
      _onlineUsers = List<String>.from(users);
      notifyListeners();
    });

   _socket?.on('disconnect', (_) {
      print('Disconnected');
      _onlineUsers.clear();
      _notificationCount = 0; // Reset notification count
      notifyListeners();
    });
  }

  void disconnectSocket() {
    _socket?.disconnect();
    _socket = null;
    _notificationCount = 0; // Reset notification count
    notifyListeners();
  }
  void _listenForMessages() {
    _socket?.on("newMessage", (newMessage) {
      // Handle new messages
      print('New message received globally: $newMessage');
    });
  }

  void _listenForNotifications() {
    if (_socket == null) return;

    _socket?.off("newNotification"); // Remove previous listeners
    _socket?.on("newNotification", (data) {
      if (data != null) {
        _notificationCount += 1;
        print('New notification received $_notificationCount');
        notifyListeners();
      }
    });
  }
}

class SocketContextProvider extends StatelessWidget {
  final Widget child;

  SocketContextProvider({required this.child});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SocketProvider(),
      child: child,
    );
  }
}

SocketProvider useSocketProvider(BuildContext context) {
  return Provider.of<SocketProvider>(context, listen: false);
}

List<String> useOnlineUsers(BuildContext context) {
  return Provider.of<SocketProvider>(context).onlineUsers;
}

int useNotificationCount(BuildContext context) {
  return Provider.of<SocketProvider>(context).notificationCount;
}
