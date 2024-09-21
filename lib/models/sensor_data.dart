class SensorData {
  double current;
  double gasConcentration;
  double spo2;
  double flowRate;
  double temperature;
  double heartRate;
  double humidity;
  double pressure;
  double voltage;

  SensorData({
    required this.current,
    required this.gasConcentration,
    required this.spo2,
    required this.flowRate,
    required this.temperature,
    required this.heartRate,
    required this.humidity,
    required this.pressure,
    required this.voltage,
  });

  // Optional: Create a factory constructor for creating a SensorData object from a map (for example, from JSON)
  factory SensorData.fromMap(Map<String, dynamic> map) {
    return SensorData(
      current: map['current'] ?? 0.0,
      gasConcentration: map['gas_concentration'] ?? 0.0,
      spo2: map['spo2'] ?? 0.0,
      flowRate: map['flow_rate'] ?? 0.0,
      temperature: map['temperature'] ?? 0.0,
      heartRate: map['heart_rate'] ?? 0.0,
      humidity: map['humidity'] ?? 0.0,
      pressure: map['pressure'] ?? 0.0,
      voltage: map['voltage'] ?? 0.0,
    );
  }

  // Optional: Convert SensorData object to a map (for example, to JSON)
  Map<String, dynamic> toMap() {
    return {
      'current': current,
      'gas_concentration': gasConcentration,
      'spo2': spo2,
      'flow_rate': flowRate,
      'temperature': temperature,
      'heart_rate': heartRate,
      'humidity': humidity,
      'pressure': pressure,
      'voltage': voltage,
    };
  }
}
