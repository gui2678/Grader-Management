
# 2024-su-Team-2-Lab-2

## Project Overview

This project is a web application developed using Ruby on Rails for viewing and managing OSU CSE courses. It allows administrators to manage courses, sections, and users, providing functionalities like adding, editing, and deleting records.

## Table of Contents

1. [Project Setup](#project-setup)
2. [Directory Structure](#directory-structure)
3. [Directory Contents](#directory-contents)
4. [Features](#features)
5. [Usage](#usage)
6. [Contributing](#contributing)

## Project Setup

To set up the project locally, follow these steps:

1. **Clone the repository:**
    ```sh
    git clone https://github.com/yourusername/2024-su-Team-2-Lab-2.git
    cd 2024-su-Team-2-Lab-2
    ```

2. **Install dependencies:**
    ```sh
    cd server
    bundle install
    ```

3. **Set up the database:**
    ```sh
    rails db:create
    rails db:migrate
    rails db:seed
    ```

4. **Start the Rails server:**
    ```sh
    rails server
    ```

5. **Access the application:**
    Open your browser and go to `http://localhost:3000`.

## Directory Structure

Here is an overview of the project directory structure:

```
2024-su-Team-2-Lab-2/
├── grader_management/
│   ├── app/
│   ├── bin/
│   ├── config/
│   ├── db/
│   ├── lib/
│   ├── log/
│   ├── public/
│   ├── storage/
│   ├── test/
│   ├── tmp/
│   ├── vendor/
├── server/
│   ├── app/
│   ├── bin/
│   ├── config/
│   ├── db/
│   ├── lib/
│   ├── log/
│   ├── public/
│   ├── storage/
│   ├── test/
│   ├── tmp/
│   ├── vendor/
├── .gitignore
├── README.md
├── fetchCourseData.rb
├── project_structure.txt
```

## Directory Contents

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

- **FetchClassInfo**: Service for fetching class information from the Ohio State University API.

### Views

#### Admin

- **index.html.erb**: Dashboard view for admin user management and course info fetching.

#### Courses

- **form.html.erb**: Shared form partial for course creation and editing.
- **index.html.erb**: View for listing courses.
- **new.html.erb**: View for creating a new course.
- **edit.html.erb**: View for editing an existing course.
- **show.html.erb**: View for displaying course details.
- **reload_courses.html.erb**: View for reloading course information from an The Ohio State University source.

#### Devise

- **Confirmations**: Views for resending confirmation instructions.
- **Mailer**: Email templates for user confirmation, email change, password change, and account unlock notifications.
- **Passwords**: Views for editing and resetting passwords.
- **Registrations**: Views for user profile editing and registration.
- **Sessions**: Views for user login.
- **Shared**: Shared views for error messages and links.
- **Unlocks**: Views for resending unlock instructions.

#### Home

- **index.html.erb**: Home page view. ![Home Page](LandingPage.png)


## Features

- **Course Management:** Add, edit, delete courses.
- **Section Management:** Add, edit, delete sections.
- **User Management:** Devise-based authentication for users and editing. ![Edit Page](EditUser.png)
- **JavaScript Integration:** Uses Turbo and Stimulus for enhanced user experience.

## Usage

### Course Management![Course Listing](CourseListing.png)

- **Add a Course:**
    - Navigate to the courses section and click on 'New Course'.
    - Fill in the course details and submit.

- **Edit a Course:**
    - Click on the 'Edit' button next to the course you want to edit.
    - Update the details and save.

- **Delete a Course:**
    - Click on the 'Destroy' button next to the course you want to delete.
    - Confirm the deletion in the popup.
      
- **Search/Filter a Course:**
    - Click on the search function to search for a course name.
    - Filter course based on course info. 

### Section Management

- **Add a Section:**
    - Navigate to the sections section and click on 'New Section'.
    - Fill in the section details and submit.

- **Edit a Section:**
    - Click on the 'Edit' button next to the section you want to edit.
    - Update the details and save.

- **Delete a Section:**
    - Click on the 'Destroy' button next to the section you want to delete.
    - Confirm the deletion in the popup.
 
 ### User Registration and Login ![Login Page](LoginPage.png)

- Users can register for an account and log in:
- Admins need to approve new admins/instructors before they can access the system.
- Users that register with student role get approved automatically.
 
## Testing

To run the test suite, execute:
```sh
rails test
```

## Contributing
- Guilherme Oliveira
- Camron Vonner
- Nasser
- Elbek
- Arav
- Jarret
