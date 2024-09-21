import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:oxy_tech/models/notification_model.dart';


class NotificationService {
  Future<List<Notification>> fetchNotifications() async {
    List<Notification> notifications = [];

    final heartRateData = await FirebaseFirestore.instance.collection('heartRate').get();
    for (var heartRate in heartRateData.docs) {
      var heartRateValue = heartRate['value'];
      var timestamp = heartRate['timestamp'].toDate();

      if (heartRateValue < 60 || heartRateValue > 100) {
        notifications.add(Notification(
          message: "Irregular heart rate detected: $heartRateValue bpm",
          timestamp: timestamp,
        ));
      }
    }

    final spo2Data = await FirebaseFirestore.instance.collection('spo2').get();
    for (var spo2 in spo2Data.docs) {
      var spo2Value = spo2['value'];
      var timestamp = spo2['timestamp'].toDate();

      if (spo2Value < 90) {
        notifications.add(Notification(
          message: "Low SpO2 level detected: $spo2Value%",
          timestamp: timestamp,
        ));
      }
    }

    return notifications;
  }
}
