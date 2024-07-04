## Devoida: Your Streamlined Task Management App

Devoida is a mobile task manager application built using Flutter to empower you with efficient organization and project tracking. It leverages Firebase for a robust backend and Dio for seamless email communication via EmailJS.

**Key Features:**

- **Project Management:**
    - Create, view, and filter projects to maintain a clear overview.
- **Task Management:**
    - Within a project, create, view, and filter tasks.
    - Assign tasks to specific users for collaborative workflows.
    - Update task statuses to track progress effectively.
- **Visual Analytics:**
    - Interactive pie charts depict task distribution percentages within each project.
    - Insightful bar charts reveal task assignments per user.

**Technical Specifications:**

- **Flutter Version:** 3.22.0
- **Backend:** Firebase
- **Email Communication:** Dio (using EmailJS service)

**Installation Instructions:**

1. **Prerequisites:**
    - Ensure you have Flutter installed on your development machine. Refer to the official documentation for installation instructions: [https://docs.flutter.dev/get-started/install](https://docs.flutter.dev/get-started/install)
2. **Clone the Repository:**
    - Open your terminal and navigate to your desired project directory.
    - Clone this repository using the following command:
        ```bash
        git clone [https://github.com/Willyyyy9/devoida.git](https://github.com/Willyyyy9/devoida.git)
        ```
 
3. **Run the App:**
    - Navigate into the cloned project directory:
        ```bash
        cd devoida
        ```
    - Run the following command to start the development server:
        ```bash
        flutter run
        ```

**Additional Information:**

- A comprehensive technical report detailing the app's architecture and implementation choices is included in the root directory (**Devoida Report.pdf**).
- For quick testing and exploration, a ready-to-use APK file is provided (**devoida.apk**).

**Rationale for Omitting Gantt Charts:**

While Gantt charts offer a valuable visualization tool, they often require significant horizontal space, which can be a constraint on mobile devices. Devoida prioritizes a user-friendly mobile experience, so interactive pie and bar charts were chosen to effectively convey project analytics within the limited screen real estate.

**Feel free to contribute!**

We welcome your valuable feedback and contributions to enhance Devoida. If you have any suggestions or encounter issues, please don't hesitate to create a pull request or raise an issue on the GitHub repository.

**Let Devoida empower your task management journey!**
