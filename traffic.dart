import 'package:flutter/material.dart';

void main() {
  runApp(TrafficGuardDashboard());
}

class TrafficGuardDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6FBF8),
      body: Column(
        children: [
          // Top Navigation Bar
          Container(
            height: 60,
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text("TrafficGuard", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                Spacer(),
                navItem("Dashboard", selected: true),
                navItem("Violations"),
                navItem("Users"),
                navItem("Reports"),
                Spacer(),
                Icon(Icons.notifications_none),
                SizedBox(width: 16),
                CircleAvatar(radius: 16, backgroundColor: Colors.grey),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  // Stat Cards
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      statCard("Pending Fines", "247", Icons.receipt_long, Colors.blue),
                      statCard("Approved Today", "52", Icons.check_circle, Colors.green),
                      statCard("Rejected", "18", Icons.cancel, Colors.red),
                      statCard("Court Cases", "31", Icons.gavel, Colors.purple),
                    ],
                  ),
                  SizedBox(height: 24),

                  // Fine Approval Queue
                  sectionCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Fine Approval Queue", style: sectionTitle()),
                        SizedBox(height: 12),
                        DataTable(
                          columns: [
                            DataColumn(label: Text('Case ID')),
                            DataColumn(label: Text('Vehicle')),
                            DataColumn(label: Text('Violation')),
                            DataColumn(label: Text('Date')),
                            DataColumn(label: Text('Fine Amount')),
                            DataColumn(label: Text('Actions')),
                          ],
                          rows: [
                            DataRow(cells: [
                              DataCell(Text("#VIO-2025")),
                              DataCell(Text("ABC 123")),
                              DataCell(Text("Speeding (78mph in 55mph zone)")),
                              DataCell(Text("Jan 15, 2025")),
                              DataCell(Text("\$280")),
                              DataCell(Row(
                                children: [
                                  IconButton(icon: Icon(Icons.check, color: Colors.green), onPressed: () {}),
                                  IconButton(icon: Icon(Icons.close, color: Colors.red), onPressed: () {}),
                                  IconButton(icon: Icon(Icons.edit, color: Colors.grey), onPressed: () {}),
                                ],
                              )),
                            ]),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 24),

                  // User Role Manager + Security Log
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: sectionCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("User Role Manager", style: sectionTitle()),
                              SizedBox(height: 12),
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: "Search users...",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              SizedBox(height: 12),
                              ElevatedButton.icon(
                                onPressed: () {},
                                icon: Icon(Icons.add),
                                label: Text("Add User"),
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                              ),
                              SizedBox(height: 16),
                              ListTile(
                                leading: CircleAvatar(backgroundColor: Colors.grey),
                                title: Text("John Smith"),
                                subtitle: Text("Traffic Officer"),
                                trailing: DropdownButton<String>(
                                  value: "Traffic Officer",
                                  items: ["Traffic Officer", "Admin", "Viewer"]
                                      .map((role) => DropdownMenuItem(
                                            value: role,
                                            child: Text(role),
                                          ))
                                      .toList(),
                                  onChanged: (value) {},
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: sectionCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Security Log", style: sectionTitle()),
                              SizedBox(height: 12),
                              ListTile(
                                leading: Icon(Icons.login, color: Colors.blue),
                                title: Text("Admin login from 192.168.1.105"),
                                subtitle: Text("Today, 10:41 AM"),
                              ),
                              ListTile(
                                leading: Icon(Icons.update, color: Colors.green),
                                title: Text("Role updated: Sarah Johnson → Admin"),
                                subtitle: Text("Today, 09:02 AM"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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

  Widget navItem(String title, {bool selected = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: selected ? Colors.black : Colors.grey,
        ),
      ),
    );
  }

  Widget statCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        height: 100,
        margin: EdgeInsets.symmetric(horizontal: 8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color),
            Spacer(),
            Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(title, style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget sectionCard({required Widget child}) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: child,
    );
  }

  TextStyle sectionTitle() {
    return TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  }
}
