import 'package:flutter/material.dart';

void main() {
  runApp(InfrastructureDashboard());
}

class InfrastructureDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DashboardScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          'Infrastructure Insights',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_none, color: Colors.black),
          ),
          CircleAvatar(
            backgroundColor: Colors.grey.shade300,
            child: Icon(Icons.person, color: Colors.black),
          ),
          SizedBox(width: 16),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Container(
            color: Colors.grey.shade100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                navTab("Dashboard", true),
                navTab("Reports", false),
                navTab("Analytics", false),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Top Stats
            Row(
              children: [
                Expanded(child: statCard("Total Issues", "247", "+12% from last month", Icons.warning, Colors.red)),
                SizedBox(width: 12),
                Expanded(child: statCard("Resolved", "156", "+8% from last month", Icons.check_circle, Colors.green)),
                SizedBox(width: 12),
                Expanded(child: statCard("Pending", "91", "+15% from last month", Icons.access_time, Colors.orange)),
                SizedBox(width: 12),
                Expanded(child: statCard("Critical Issues", "24", "+5% from last month", Icons.priority_high, Colors.pink)),
              ],
            ),
            SizedBox(height: 24),
            // Heatmap + Side panel
            LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 800) {
                  // Wide layout
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 3, child: heatmapSection()),
                      SizedBox(width: 16),
                      Expanded(flex: 2, child: sidePanel()),
                    ],
                  );
                } else {
                  // Mobile layout
                  return Column(
                    children: [
                      heatmapSection(),
                      SizedBox(height: 16),
                      sidePanel(),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget navTab(String label, bool selected) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 16,
          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
          color: selected ? Colors.blue : Colors.black,
        ),
      ),
    );
  }

  Widget statCard(String title, String count, String subtitle, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: color.withOpacity(0.2),
                child: Icon(icon, color: color),
              ),
              SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            count,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget heatmapSection() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Infrastructure Heatmap",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              TextButton(onPressed: () {}, child: Text("Filter")),
              ElevatedButton(
                onPressed: () {},
                child: Text("Export"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Container(
            height: 300,
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(child: Text("Heatmap Placeholder")),
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              legendItem(Colors.red, "Critical"),
              SizedBox(width: 8),
              legendItem(Colors.orange, "Moderate"),
              SizedBox(width: 8),
              legendItem(Colors.green, "Minor"),
            ],
          )
        ],
      ),
    );
  }

  Widget legendItem(Color color, String label) {
    return Row(
      children: [
        Container(width: 12, height: 12, color: color),
        SizedBox(width: 4),
        Text(label),
      ],
    );
  }

  Widget sidePanel() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Priority Issues", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              priorityIssue("Critical", "Junction 14: Road Wear", 9.8, Colors.red),
              priorityIssue("Moderate", "Street Light Malfunction", 7.5, Colors.orange),
              priorityIssue("Minor", "Traffic Sign Cleaning", 5.2, Colors.green),
            ],
          ),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Report Issue", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 12),
              Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Center(child: Text("Drag and drop files here")),
              ),
              SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Add description or comments...",
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
              SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {},
                child: Text("Submit Report"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: Size(double.infinity, 45),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget priorityIssue(String type, String title, double rating, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                Text(
                  type,
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          Text(
            rating.toString(),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
