// profile_picture_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:cached_network_image/cached_network_image.dart';

const FlutterSecureStorage storage = const FlutterSecureStorage();

class ProfilePictureWidget extends StatelessWidget {
  const ProfilePictureWidget({super.key});

  Future<String?> getProfilePicture() async {
    return await storage.read(key: 'ProfilePicture');
  }

  Widget buildProfilePicture(String imageUrl) {
    return CircleAvatar(
      radius: 50.0,
      backgroundColor: Colors.grey,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        placeholder: (context, url) => defaultAvatar(), // Placeholder while loading
        errorWidget: (context, url, error) => defaultAvatar(), // Default avatar on error
        imageBuilder: (context, imageProvider) => CircleAvatar(
          radius: 50.0,
          backgroundColor: Colors.grey,
          backgroundImage: imageProvider,
        ),
      ),
    );
  }

  Widget defaultAvatar() {
    return const CircleAvatar(
      radius: 50.0,
      backgroundColor: Colors.grey,
      child: Icon(Icons.person, color: Colors.white, size: 50.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: getProfilePicture(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
          return defaultAvatar();
        } else {
          return buildProfilePicture(snapshot.data!);
        }
      },
    );
  }
}
