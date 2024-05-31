import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: NotificationList(),
    );
  }
}

class NotificationList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5, // Replace with your actual notification count
      itemBuilder: (context, index) {
        return NotificationItem(
          username: 'John Doe', // Replace with notification data
          message:
              'Your Appointment Scheduled.', // Replace with notification data
          time: '5 mins ago', // Replace with notification data
          onTap: () {
            // Handle notification tap
            // You can navigate to a different screen or perform any action here
          },
        );
      },
    );
  }
}

class NotificationItem extends StatelessWidget {
  final String username;
  final String message;
  final String time;
  final VoidCallback onTap;

  const NotificationItem({
    Key? key,
    required this.username,
    required this.message,
    required this.time,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text('JD'), // Initials or user avatar
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    username,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    message,
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(height: 4),
                  Text(
                    time,
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
