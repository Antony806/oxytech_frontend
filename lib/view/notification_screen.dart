import 'package:flutter/material.dart';
import 'package:oxy_tech/services/notification_service.dart';
import 'package:oxy_tech/models/notification_model.dart' as model;


class NotificationsPage extends StatelessWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notificationService = NotificationService();

    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: FutureBuilder<List<model.Notification>>(
        future: notificationService.fetchNotifications() as Future<List<model.Notification>>?,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final notifications = snapshot.data ?? [];

          return ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notification = notifications[index];
              return ListTile(
                title: Text(notification.message),
                subtitle: Text(notification.timestamp.toLocal().toString()),
              );
            },
          );
        },
      ),
    );
  }
}
