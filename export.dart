import 'package:flutter/material.dart';

void main() {
  runApp(ReportsExportsScreen());
}

class ReportsExportsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ReportsScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ReportsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reports & Exports'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Quick Reports",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.add),
                  label: Text("New Report"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            // Quick Reports Cards
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  quickReportCard("Violation Summary", "Daily overview of traffic violations and infractions", "2h ago", Icons.warning, Colors.orange),
                  quickReportCard("Accident Analysis", "Comprehensive accident reports and statistics", "1h ago", Icons.car_crash, Colors.redAccent),
                  quickReportCard("Carbon Report", "Environmental impact and emissions data", "30m ago", Icons.eco, Colors.green),
                ],
              ),
            ),
            SizedBox(height: 24),
            // Custom Report Generator
            sectionTitle("Custom Report Generator"),
            customReportGenerator(),
            SizedBox(height: 24),
            // Export Options
            sectionTitle("Export Options"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                exportButton("PDF", Colors.red),
                exportButton("CSV", Colors.green),
                exportButton("PNG", Colors.blue),
              ],
            ),
            SizedBox(height: 24),
            // Scheduled Reports
            sectionTitle("Scheduled Reports"),
            scheduledReportsForm(),
          ],
        ),
      ),
    );
  }

  Widget quickReportCard(String title, String description, String updated, IconData icon, Color color) {
    return Container(
      width: 220,
      margin: EdgeInsets.only(right: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 6,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 32),
          SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 6),
          Text(
            description,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Last updated: $updated",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              TextButton(
                onPressed: () {},
                child: Text("Export"),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget sectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  Widget customReportGenerator() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: dropdownField("Select Metrics"),
              ),
              SizedBox(width: 12),
              Expanded(
                child: textField("Date Range"),
              ),
              SizedBox(width: 12),
              Expanded(
                child: dropdownField("Zone"),
              ),
            ],
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            child: Text("Generate Report"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              minimumSize: Size(double.infinity, 45),
            ),
          ),
        ],
      ),
    );
  }

  Widget dropdownField(String hint) {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        labelText: hint,
        border: OutlineInputBorder(),
      ),
      items: [],
      onChanged: (value) {},
    );
  }

  Widget textField(String hint) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: hint,
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget exportButton(String type, Color color) {
    return ElevatedButton(
      onPressed: () {},
      child: Text(type),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: Size(100, 45),
      ),
    );
  }

  Widget scheduledReportsForm() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: dropdownField("Frequency")),
              SizedBox(width: 12),
              Expanded(child: textField("Email Recipients")),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: textField("Time")),
              SizedBox(width: 12),
              Expanded(child: dropdownField("Report Format")),
            ],
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            child: Text("Save Schedule"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              minimumSize: Size(double.infinity, 45),
            ),
          ),
        ],
      ),
    );
  }
}
