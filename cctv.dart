import 'package:flutter/material.dart';

void main() {
  runApp(SettingsIntegrationApp());
}

class SettingsIntegrationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SettingsScreen(),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6FBF8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Settings & Integrations", style: TextStyle(color: Colors.black)),
        centerTitle: false,
        elevation: 0,
      ),
      body: Row(
        children: [
          // Sidebar
          Container(
            width: 200,
            color: Colors.white,
            child: ListView(
              children: [
                sidebarTile("CCTV Management", selected: true),
                sidebarTile("API Configuration"),
                sidebarTile("AWS Integration"),
                sidebarTile("Zones & Intersections"),
                sidebarTile("Backup & Recovery"),
              ],
            ),
          ),
          // Main Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  // CCTV Management
                  contentCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        headerRow("CCTV Camera Management", [
                          ElevatedButton(onPressed: () {}, child: Text("+ Add Camera")),
                          SizedBox(width: 8),
                          OutlinedButton.icon(
                            onPressed: () {},
                            icon: Icon(Icons.filter_list),
                            label: Text("Filter"),
                          ),
                        ]),
                        SizedBox(height: 8),
                        DataTable(
                          columns: [
                            DataColumn(label: Text('Camera ID')),
                            DataColumn(label: Text('Location')),
                            DataColumn(label: Text('Zone')),
                            DataColumn(label: Text('Status')),
                            DataColumn(label: Text('Actions')),
                          ],
                          rows: [
                            dataRow("CAM-001", "Main Street", "Zone A", "Active", Colors.green),
                            dataRow("CAM-002", "Central Avenue", "Zone B", "Maintenance", Colors.orange),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                  // API Configuration
                  contentCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("API Configuration", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: 16),
                        apiInputField("YOLOv8 Endpoint", "https://api.yolov8.example.com/detect", connected: true),
                        SizedBox(height: 12),
                        apiInputField("LSTM API", "https://api.lstm.example.com/predict", connected: false),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                  // AWS Integration
                  contentCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("AWS Integration", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            awsStatusItem("Kinesis", true),
                            awsStatusItem("Lambda", true),
                            awsStatusItem("Cognito", false),
                          ],
                        ),
                        SizedBox(height: 16),
                        Text("Recent Logs:", style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(height: 8),
                        logEntry("Lambda function execution completed", Colors.green),
                        logEntry("New data stream initiated", Colors.green),
                        logEntry("Cognito authentication error", Colors.red),
                      ],
                    ),
                  ),
                  SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget sidebarTile(String title, {bool selected = false}) {
    return ListTile(
      selected: selected,
      selectedTileColor: Color(0xFFE3F2FD),
      title: Text(title, style: TextStyle(color: selected ? Colors.blue : Colors.black)),
      onTap: () {},
    );
  }

  Widget contentCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: child,
    );
  }

  Widget headerRow(String title, List<Widget> actions) {
    return Row(
      children: [
        Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Spacer(),
        ...actions,
      ],
    );
  }

  DataRow dataRow(String id, String location, String zone, String status, Color color) {
    return DataRow(cells: [
      DataCell(Text(id)),
      DataCell(Text(location)),
      DataCell(Text(zone)),
      DataCell(
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(status, style: TextStyle(color: color)),
        ),
      ),
      DataCell(
        Row(
          children: [
            IconButton(onPressed: () {}, icon: Icon(Icons.edit, size: 20)),
            IconButton(onPressed: () {}, icon: Icon(Icons.delete, size: 20)),
          ],
        ),
      ),
    ]);
  }

  Widget apiInputField(String label, String url, {required bool connected}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                initialValue: url,
                readOnly: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(
                    connected ? Icons.check_circle : Icons.error,
                    color: connected ? Colors.green : Colors.red,
                  ),
                ),
              ),
            ),
            SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {},
              child: Text(connected ? "Update" : "Connect"),
              style: ElevatedButton.styleFrom(
                backgroundColor: connected ? Colors.blue : Colors.green,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget awsStatusItem(String service, bool isConnected) {
    return Column(
      children: [
        Icon(Icons.circle, color: isConnected ? Colors.green : Colors.orange, size: 16),
        SizedBox(height: 4),
        Text(service),
      ],
    );
  }

  Widget logEntry(String message, Color color) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(message, style: TextStyle(color: color)),
    );
  }
}
