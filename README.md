# Hostel Management System (Outing Pass and Complaints)

## Overview

The Hostel Management System is a digital solution designed to streamline the management of hostel complaints and outing passes. It replaces traditional book-keeping methods with a structured, centralized approach for both hostel managers and students.

## Features

### Manager Login:
- **Add Students:** Easily add new students to the system.
- **View Complaints:** Access and manage complaints lodged by students.
- **Manage Outing Passes:** Approve or reject outing pass requests from students.

### Student Login:
- **Apply Complaints:** Lodge complaints directly through the app.
- **Apply for Outing Pass:** Request outing passes through a digital form.

## Technology Stack

- **Frontend:** Flutter
- **Backend:** PHP
- **Database:** SQL

## Installation

### Prerequisites

- Flutter SDK
- PHP and XAMPP (or any other local server)
- MySQL (or any compatible SQL database)

### Steps

1. **Clone the repository:**

    ```bash
    git clone https://github.com/your-username/hostel-management-system.git
    cd hostel-management-system
    ```

2. **Setup Backend:**

    - Start your XAMPP server.
    - Copy the backend PHP files to the `htdocs` directory in your XAMPP installation.
    - Import the SQL database:

        ```sql
        -- Open phpMyAdmin and create a new database
        CREATE DATABASE hostel_management;

        -- Import the provided SQL file
        USE hostel_management;
        SOURCE /path-to-your-cloned-repo/database/hostel_management.sql;
        ```

3. **Setup Frontend:**

    - Navigate to the Flutter project directory:

        ```bash
        cd hostel-management-system/flutter_app
        ```

    - Get the Flutter dependencies:

        ```bash
        flutter pub get
        ```

    - Run the Flutter app:

        ```bash
        flutter run
        ```

## Usage

1. **Manager Login:** Access the manager dashboard to add students, view complaints, and manage outing passes.
2. **Student Login:** Students can log in to apply for outing passes and lodge complaints.

## Project Structure

- **Backend:** Contains PHP scripts for handling database operations and server-side logic.
- **Frontend:** Contains the Flutter project for the mobile and web interface.

## Objectives

- **Centralized Complaints Management:** Efficiently handle and resolve student complaints.
- **Streamlined Outing Pass Management:** Digitalize the outing pass request and approval process.
- **Detailed Student Records:** Maintain accurate and up-to-date records of all students.
- **Manager Interface:** Provide a comprehensive interface for hostel managers to manage operations.

## Challenges Addressed

- Inefficiencies in manual complaint management.
- Delays in handling outing pass requests.
- Data inconsistencies with traditional record-keeping.

## Contributing

1. Fork the repository.
2. Create your feature branch (`git checkout -b feature/your-feature`).
3. Commit your changes (`git commit -m 'Add some feature'`).
4. Push to the branch (`git push origin feature/your-feature`).
5. Open a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contact

For any inquiries or support, please contact [Sharath's Mail](mailto:alsharath66@gmail.com).

## App Images

| Image | Image |
|-------|-------|
| ![Image 1](https://github.com/vinaya-kumaraSS/hostel_management/blob/main/student%20login.png) | ![Image 2](https://github.com/vinaya-kumaraSS/hostel_management/blob/main/student%20landing.png) |
| **Student Login** | **Student Landing Page** |
| Students can log in to the system using their credentials. | This is the landing page for students after logging in. |
| ![Image 3](https://github.com/vinaya-kumaraSS/hostel_management/blob/main/student%20reset%20password.png) | ![Image 4](https://github.com/vinaya-kumaraSS/hostel_management/blob/main/student%20profile.png) |
| **Reset Password** | **Student Profile** |
| Students can reset their passwords if they forget them. | Students can view and update their profile information. |
| ![Image 5](https://github.com/vinaya-kumaraSS/hostel_management/blob/main/add%20outing.png) | ![Image 6](https://github.com/vinaya-kumaraSS/hostel_management/blob/main/add%20complaints.png) |
| **Apply for Outing Pass** | **Apply Complaint** |
| Students can request outing passes through this form. | Students can lodge complaints directly through this form. |
| ![Image 7](https://github.com/vinaya-kumaraSS/hostel_management/blob/main/manager%20login.png) | ![Image 8](https://github.com/vinaya-kumaraSS/hostel_management/blob/main/manager%20landing1.png) |
| **Manager Login** | **Manager Landing Page** |
| Managers can log in using their credentials to access the dashboard. | This is the landing page for managers after logging in. |
| ![Image 9](https://github.com/vinaya-kumaraSS/hostel_management/blob/main/manager%20landing2.png) | ![Image 10](https://github.com/vinaya-kumaraSS/hostel_management/blob/main/add%20students.png) |
| **Manager Dashboard** | **Add Students** |
| Managers can view and manage all operations from this dashboard. | Managers can add new students to the system through this form. |
| ![Image 11](https://github.com/vinaya-kumaraSS/hostel_management/blob/main/view%20outing.png) | ![Image 12](https://github.com/vinaya-kumaraSS/hostel_management/blob/main/view%20complaints.png) |
| **View Outing Pass Requests** | **View Complaints** |
| Managers can view and approve/reject outing pass requests. | Managers can view and manage complaints lodged by students. |
| ![Image 13](https://github.com/vinaya-kumaraSS/hostel_management/blob/main/view%20outing%20History.png) | ![Image 14](https://github.com/vinaya-kumaraSS/hostel_management/blob/main/view%20complaints%20History.png) |
| **Outing Pass History** | **Complaints History** |
| Managers can view the history of all outing pass requests. | Managers can view the history of all complaints lodged by students. |
