import 'package:flutter/material.dart';

void main() {
  runApp(TrafficPriorityApp());
}

class TrafficPriorityApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TrafficPriorityScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TrafficPriorityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6FBF8),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Set Signal Priority Order",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Drag and drop to prioritize vehicle types for signal clearance.",
                style: TextStyle(color: Colors.grey[600]),
              ),
              SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  children: [
                    priorityTile(Icons.local_hospital, "Ambulance", Colors.red.shade100),
                    Divider(height: 1),
                    priorityTile(Icons.directions_bus, "Public Transport", Colors.blue.shade100),
                  ],
                ),
              ),
              SizedBox(height: 24),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.check_circle, color: Colors.green),
                        SizedBox(width: 8),
                        Text(
                          "Giving Priority to: Ambulance",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.green.shade100,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "Active",
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    infoRow("Vehicle ID", "AMB-2025-X789"),
                    infoRow("Direction", "Approaching from East"),
                    infoRow("ETA to Intersection", "00:45 seconds"),
                    infoRow("Signal Status", "Green for 15 seconds"),
                  ],
                ),
              ),
              SizedBox(height: 24),
              Text(
                "AI Decision Log",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    decisionLogEntry(Icons.speaker_phone, Colors.red, "Ambulance detected with siren active, giving highest priority.", "2 seconds ago"),
                    Divider(height: 20),
                    decisionLogEntry(Icons.bus_alert, Colors.orange, "Bus delay threshold exceeded – elevating priority.", "15 seconds ago"),
                    Divider(height: 20),
                    decisionLogEntry(Icons.school, Colors.amber, "School bus approaching intersection during school hours.", "1 minute ago"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget priorityTile(IconData icon, String title, Color color) {
    return Container(
      color: color,
      child: ListTile(
        leading: Icon(icon, color: Colors.black),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        trailing: Icon(Icons.drag_indicator),
      ),
    );
  }

  Widget infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget decisionLogEntry(IconData icon, Color iconColor, String text, String time) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: iconColor),
        SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(text),
              SizedBox(height: 4),
              Text(
                time,
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
