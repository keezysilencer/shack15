# SHACK15 Networking App

The SHACK15 Networking App is a digital platform designed to facilitate meaningful connections among SHACK15 members. It allows users to swipe through
member profiles, view detailed information, and send connection requests, fostering collaboration and networking within the SHACK15 community.

## Features

- **Networking Swipe Screen**: Swipe through profiles similar to dating apps, enabling users to connect with others in the community.
- **Member Profile Details**: Access detailed profiles including bios, roles, companies, and interests.
- **Connection Status Indicators**: View real-time availability for networking.
- **Intuitive Swipe Actions**: Swipe right to connect and left to pass on profiles, creating an engaging user experience.

## Innovation

The swipe to connect feature is crucial for SHACK15 as it enhances user engagement by transforming networking into an interactive and enjoyable
experience. This gamification element simplifies the connection process, allowing members to express interest without the intimidation often
associated with traditional networking. By enabling quick and easy interactions, the swipe interface encourages users to actively participate,
fostering a vibrant community where meaningful connections can thrive. Instant feedback from the swiping action creates a sense of accomplishment,
motivating users to explore more profiles and deepen their engagement within the community.

Moreover, this feature facilitates the formation of meaningful connections by allowing members to discover individuals aligned with their interests
and goals. By broadening the scope of networking opportunities, the swipe-to-connect feature encourages diversity and inclusion, enabling users to
connect with a variety of perspectives and ideas. This is particularly important for SHACK15, which aims to support startups, entrepreneurs, and
changemakers. By fostering a culture of connection through this modern approach, SHACK15 empowers its members to collaborate effectively and
contribute to innovative projects, ultimately driving community growth and success.


## Setup Instructions

### Prerequisites

- **Flutter SDK**: Ensure Flutter is installed on your system. For installation instructions,
  visit [Flutter's official website](https://flutter.dev/docs/get-started/install).
- **Dart SDK**: Dart is included with Flutter, but ensure it is correctly set up.

## Simulated Data and API Setup

This app currently uses mock data for member profiles. To modify the sample data or integrate an API, follow these instructions:

### For Simulated Data

	1.	Edit Sample Data: Locate the member_service.dart file in the lib/services directory. You can modify the getDummyMembers() method to customize the member profiles displayed in the app. Update fields such as name, role, company, image URL, bio, and interests as needed.

### For API Integration

	1.	Replace Dummy Data: In the member_service.dart file, you will find the functions responsible for fetching data. Replace the simulated data fetching logic with your API calls. Make sure to handle responses and map the data to the Member model used in the app.
	2.	Network Permissions: If you are using API calls, ensure that your app has the necessary permissions to access the internet. For Flutter, this typically involves configuring your AndroidManifest.xml for Android or Info.plist for iOS.