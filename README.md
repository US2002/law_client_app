# **Case Connect**
The *Law Client App* is a Flutter-based mobile application for both lawyers and clients to connect and manage legal services. It facilitates user authentication, document uploads for lawyer authorization, and password reset functionalities. This README provides an overview of the project structure and how to use the application.

## Table of Contents

1. [Features](#features)
2. [Getting Started](#getting-started)
   - [Prerequisites](#prerequisites)
   - [Installation](#installation)
3. [Project Structure](#project-structure)
4. [Usage](#usage)
5. [Contributing](#contributing)
6. [License](#license)

## Features

The Law Client App offers the following features:

- **User Authentication**: Users can register and log in as either lawyers or clients using their email addresses.
- **Password Reset**: A password reset functionality is available for users who have forgotten their passwords.
- **Document Upload**: Lawyers can upload legal documents for authorization by providing their Aadhar and BAR registration numbers.
- **Authentication**: Documents uploaded by lawyers are authenticated by the app using Firebase Cloud Storage.
- **User Profiles**: The app allows users to set up and maintain their profiles.


## Getting Started

### Prerequisites

Before running the app, make sure you have the following:

- [Flutter](https://flutter.dev/) installed on your machine.
- A Firebase project set up with authentication and storage services.

### Installation

To set up the Law Client App on your local machine, follow these steps:

1. **Clone the repository**:
    ```
    git clone https://github.com/US2002/law_client_app.git
    ```
2. **Navigate to the project directory**:
    ```
    cd law_client_app
    ```
3. **Install Dependencies**:
    ```
    flutter pub get
    ```
4. **Open in Code Editor**:

Open the project in your preferred code editor (e.g., Visual Studio Code).

5. **Firebase Configuration**:

- **Firebase Project**: Ensure you have a Firebase project set up with authentication and storage services. If not, create one in the [Firebase Console](https://console.firebase.google.com/).

- **Add Configuration Files**: Configure Firebase by adding your Firebase configuration files. These files typically include `google-services.json` for Android and `GoogleService-Info.plist` for iOS. Place these files in the appropriate folders within the project.

Now you have the Law Client App set up on your machine and ready to run.

## Project Structure

The project follows this structure:

- `lib/`: Contains the Flutter Dart code for the application.
- `pages/`: Individual app pages, such as login, registration, password reset, home, and lawyer authorization.
- `Services/`: Services for Firebase authentication and user information management.
- `widgets/`: Reusable UI widgets used throughout the app.
- `main.dart`: The entry point for the Flutter app.

## Usage

1. **Run the App**:

Run the app on an emulator or a physical device. Make sure you've set up the appropriate emulator or connected a device via USB.
```
flutter run
```

2. **Use the App**:

- Register and log in as either a lawyer or a client.
- Access various features according to your user type.
- Lawyers can use the "Lawyer Authorization" page for specific functionalities like document uploads.
- Explore other features, such as password reset.

## Contributing

Contributions to the Law Client App are welcome. If you'd like to contribute, please follow these steps:

1. **Fork the Repository**:

Fork the repository to your GitHub account.

2. **Create a New Branch**:

Create a new branch for your feature or bug fix:
```
git checkout -b feature/your-feature-name
```

3. **Make Changes**:

Make your changes and commit them:
```
git commit -m "Add your feature"
```


4. **Push Changes**:

Push your changes to your forked repository:
```
git push origin feature/your-feature-name
```


5. **Create a Pull Request**:

Create a pull request to the main repository's `main` branch.

Please provide clear and concise descriptions of your changes in the pull request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
