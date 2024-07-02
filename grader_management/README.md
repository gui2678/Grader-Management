# Grader Management System

## Overview

The Grader Management System is a web application designed to streamline the management of course information, student enrollments, and instructor assignments for the Computer Science and Engineering department at Ohio State University. This system provides functionalities for students, instructors, and administrators to manage course-related activities efficiently.

## Features

- **User Authentication and Authorization**: Secure login and registration for students, instructors, and administrators using Devise.
- **Course Management**: Create, read, update, and delete course information.
- **User Management**: Administrators can approve or reject user registration requests.
- **Section Management**: Manage sections of courses including assignments of instructors and enrollments of students.
- **Fetch Class Info**: Fetch course information from an external API.

## Project Structure

### Assets

- **Stylesheets**: Contains the main stylesheet for the application.

### Controllers

- **Users::ConfirmationsController**: Handles user confirmation actions.
- **Users::OmniauthCallbacksController**: Handles user authentication via OmniAuth providers.
- **Users::PasswordsController**: Manages user password actions.
- **Users::RegistrationsController**: Handles user registration actions.
- **Users::SessionsController**: Manages user session actions.
- **AdminController**: Handles admin actions such as indexing users and courses, and approving user requests.
- **ApplicationController**: The base controller for the application.
- **CoursesController**: Manages course actions including listing, showing, creating, updating, and destroying courses, as well as reloading course information.
- **HomeController**: Redirects to the courses index after user authentication.
- **SectionsController**: Manages section actions including listing and showing sections for a course.

### Helpers

- **ApplicationHelper, CoursesHelper, HomeHelper, SectionsHelper**: Contains helper methods for views.

### JavaScript

- **Controllers**: Contains Stimulus controllers for enhancing user interactions.

### Jobs

- **ApplicationJob**: Base class for background jobs.

### Mailers

- **ApplicationMailer**: Base class for mailers with default settings.

### Models

- **ApplicationRecord**: Base class for models.
- **Approval**: Model for handling user approvals with associations and validations.
- **Course**: Model for managing courses with associations and validations.
- **Enrollment**: Model for managing enrollments with associations and validations.
- **Section**: Model for managing sections with associations and validations.
- **User**: Model for managing users with Devise modules, roles, associations, and validations.

### Services

- **FetchClassInfo**: Service for fetching class information from an external API.

### Views

#### Admin

- **index.html.erb**: Dashboard view for admin user management and course info fetching.

#### Courses

- **form.html.erb**: Shared form partial for course creation and editing.
- **index.html.erb**: View for listing courses.
- **new.html.erb**: View for creating a new course.
- **edit.html.erb**: View for editing an existing course.
- **show.html.erb**: View for displaying course details.
- **reload_courses.html.erb**: View for reloading course information from an external source.

#### Devise

- **Confirmations**: Views for resending confirmation instructions.
- **Mailer**: Email templates for user confirmation, email change, password change, and account unlock notifications.
- **Passwords**: Views for editing and resetting passwords.
- **Registrations**: Views for user profile editing and registration.
- **Sessions**: Views for user login.
- **Shared**: Shared views for error messages and links.
- **Unlocks**: Views for resending unlock instructions.

#### Home

- **index.html.erb**: Home page view.

## Setup Instructions

### Prerequisites

- Ruby (version 2.7.2 or higher)
- Rails (version 6.1.4 or higher)
- PostgreSQL

### Installation

1. **Clone the repository**:
    ```sh
    git clone https://github.com/your-username/grader_management.git
    cd grader_management
    ```

2. **Install dependencies**:
    ```sh
    bundle install
    npm install
    ```

3. **Setup the database**:
    ```sh
    rails db:create
    rails db:migrate
    ```

4. **Run the Rails server**:
    ```sh
    rails server
    ```

5. **Access the application**:
    Open your web browser and navigate to `http://localhost:3000`.

## Usage

### Admin Dashboard

- Admin users can manage other users, approve registration requests, and reload course information from the external API.

### Course Management

- Create, view, edit, and delete courses.
- Fetch and display course information from an external API.

### User Registration and Login

- Users can register for an account and log in.
- Admins need to approve new users before they can access the system.

## Testing

To run the test suite, execute:
```sh
rails test
