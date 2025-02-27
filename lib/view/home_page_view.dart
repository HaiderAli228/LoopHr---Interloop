import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loophr/utlis/app_colors.dart';

// MainScreen with Bottom Navigation Bar and Three Tabs
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  // List of pages for each tab
  final List<Widget> _tabs = [
    const HomeContent(),
    const PlaceholderWidget(text: "Profile Content"),
    const PlaceholderWidget(text: "Notification Content"),
  ];

  // Function to show the language selection dialog
  void _showLanguageDialog() {
    String selectedLanguage = "English"; // default selection
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("Select Language"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RadioListTile<String>(
                    title: const Text("English"),
                    value: "English",
                    groupValue: selectedLanguage,
                    onChanged: (value) {
                      setState(() {
                        selectedLanguage = value!;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text("Urdu"),
                    value: "Urdu",
                    groupValue: selectedLanguage,
                    onChanged: (value) {
                      setState(() {
                        selectedLanguage = value!;
                      });
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Cancel dialog
                  },
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    // Handle language change if needed.
                    Navigator.pop(context);
                  },
                  child: const Text("OK"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Conditionally build the AppBar based on the current tab.
    PreferredSizeWidget? appBar;
    if (_currentIndex == 1) {
      // Profile tab: no AppBar.
      appBar = null;
    } else if (_currentIndex == 2) {
      // Notification tab: show AppBar with "Notification" title.
      appBar = AppBar(
        title: const Text(
          "Notification",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1),
        ),
        centerTitle: true,
        backgroundColor: AppColor.themeColor,
      );
    } else {
      // Home tab: show default AppBar with language icon.
      appBar = AppBar(
        title: const Text(
          "Loop HR Icon",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColor.themeColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.language_outlined, color: Colors.white),
            onPressed: _showLanguageDialog,
          ),
        ],
      );
    }

    return Scaffold(
      appBar: appBar,
      body: _tabs[_currentIndex],
      // Wrap BottomNavigationBar in a SizedBox to increase its height.
      bottomNavigationBar: SizedBox(
        height: 70, // Custom height for the navigation bar.
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          backgroundColor: Colors.grey.shade200,
          selectedItemColor: Colors.blue,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: "Notification",
            ),
          ],
        ),
      ),
    );
  }
}

// HomeContent widget: Contains your home tab content.
class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const NotificationTile(),
          const SizedBox(height: 20),
          const SectionTitle(title: "Services"),
          const SizedBox(height: 20),
          GridSection(
            items: services,
            crossAxisCount: 3, // Display 3 items per row for services.
          ),
          const SizedBox(height: 25),
          const SectionTitle(title: "Employee Engagements"),
          const SizedBox(height: 10),
          GridSection(
            items: engagements,
            crossAxisCount: 2, // Display 2 items per row for engagements.
          ),
        ],
      ),
    );
  }
}

// Reusable widget for the notification card.
class NotificationTile extends StatelessWidget {
  const NotificationTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190,
      width: 190,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.lightBlueAccent,
            Colors.blueAccent.shade200,
          ],
        ),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 60,
            alignment: Alignment.center,
            padding: EdgeInsets.all(6),
            margin: EdgeInsets.all(5),
            width: 60,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: Icon(
              Icons.notifications_active,
              color: Colors.amber,
              size: 40,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          const Text(
            "No New Notification",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 0.6,
              color: Colors.white,
              fontSize: 17,
            ),
          ),
        ],
      ),
    );
  }
}

// Reusable widget for section titles.
class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 24,
      ),
    );
  }
}

// Reusable dashboard tile widget for icon and label.
class DashboardTile extends StatelessWidget {
  final IconData iconData;
  final Color iconColor;
  final String title;

  const DashboardTile({
    super.key,
    required this.iconData,
    required this.iconColor,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          iconData,
          size: 55,
          color: iconColor,
        ),
        const SizedBox(height: 10),
        Text(
          title,
          style: const TextStyle(fontSize: 15),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

// GridSection widget to display a list of DashboardTile widgets in a grid layout.
class GridSection extends StatelessWidget {
  final List<DashboardTile> items;
  final int crossAxisCount;

  const GridSection({
    super.key,
    required this.items,
    required this.crossAxisCount,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: crossAxisCount,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      // Adjust the childAspectRatio to fit content without taking extra height.
      childAspectRatio: 1.2,
      children: items,
    );
  }
}

// List of service items.
final List<DashboardTile> services = [
  const DashboardTile(
    iconData: Icons.document_scanner_outlined,
    iconColor: Colors.green,
    title: "Attendance",
  ),
  const DashboardTile(
    iconData: FontAwesomeIcons.amazonPay,
    iconColor: Colors.blue,
    title: "Payslip Here",
  ),
  const DashboardTile(
    iconData: FontAwesomeIcons.pencil,
    iconColor: Colors.amber,
    title: "Leave Here",
  ),
];

// List of employee engagement items.
final List<DashboardTile> engagements = [
  const DashboardTile(
    iconData: Icons.menu_book,
    iconColor: Colors.purple,
    title: "Survey Icon Here",
  ),
  const DashboardTile(
    iconData: Icons.notifications_active_outlined,
    iconColor: Colors.red,
    title: "Announcements",
  ),
  const DashboardTile(
    iconData: Icons.person_add_alt_outlined,
    iconColor: Colors.black,
    title: "CEO Message",
  ),
  const DashboardTile(
    iconData: FontAwesomeIcons.chartBar,
    iconColor: Colors.orange,
    title: "Poll Icon Here",
  ),
];

// A simple placeholder widget for tabs 2 and 3.
class PlaceholderWidget extends StatelessWidget {
  final String text;
  const PlaceholderWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: const TextStyle(fontSize: 24),
      ),
    );
  }
}
