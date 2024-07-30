
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
    git clone https://github.com/cse-3901-sharkey/2024-su-Team-2-Lab-3.git
    cd 2024-su-Team-2-Lab-3
    cd grader_management
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

### Postgres Troubleshooting

If you encounter issues with setting up Postgres, try the following steps:

1. **Ensure Postgres is installed and running on your machine:**
   - Verify Postgres installation by running:
     ```sh
     psql --version
     ```
   - Start Postgres service if it's not already running:
     ```sh
     sudo service postgresql start
     ```

2. **Check your database configuration in `config/database.yml` and make sure it matches your Postgres setup:**
   - Example `config/database.yml`:
     ```yaml
     default: &default
       adapter: postgresql
       encoding: unicode
       pool: 5
       username: postgres
       password: password

     development:
       <<: *default
       database: myapp_development

     test:
       <<: *default
       database: myapp_test

     production:
       <<: *default
       database: myapp_production
     ```

3. **If you encounter connection issues, verify your Postgres username and password:**
   - Check if the username and password match those in your `database.yml` file.

4. **Create and set up the database:**
   - Create the database:
     ```sh
     rails db:create
     ```
   - Run database migrations:
     ```sh
     rails db:migrate
     ```
   - Seed the database with initial data:
     ```sh
     rails db:seed
     ```

5. **Check for common Postgres errors:**
   - **Role does not exist:**
     If you encounter an error like `FATAL: role "your-username" does not exist`, create the role in Postgres:
     ```sh
     sudo -u postgres createuser your-username -s
     ```
   - **Database does not exist:**
     If you encounter an error like `FATAL: database "your-database" does not exist`, ensure the database was created properly with `rails db:create`.

6. **Test the connection:**
   - Run the Rails server and check if the application can connect to the database:
     ```sh
     rails server
     ```

If you continue to encounter issues, consult the Postgres logs for more detailed error messages:
```sh
sudo tail -f /var/log/postgresql/postgresql-12-main.log

### Seed Information

After running `rails db:seed`, use the following credentials to log in as an admin:

- **Username:** admin.1@osu.edu
- **Password:** password

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
- **CustomFailure**: Customizes the behavior when a user fails to authenticate, handling redirects and HTTP authentication responses.
- **ErrorsController**: Handles rendering custom error pages. Specifically, it defines an action for handling 404 (not found) errors.
- **GraderApplicationsController**: Manages actions related to grader applications, including listing, showing, creating, editing, updating, and approving applications, with role-based access control.
- **HomeController**: Redirects to the courses index after user authentication.
- **SectionsController**: Manages section actions including listing and showing sections for a course.

### Helpers

- **ApplicationHelper, CoursesHelper, ErrorsHelper, GraderApplicationsHelper, HomeHelper, SectionsHelper**: Contains helper methods for views.

### JavaScript

- **Controllers**: Contains Stimulus controllers for enhancing user interactions.

### Jobs

- **ApplicationJob**: Base class for background jobs.

### Mailers

- **ApplicationMailer**: Base class for mailers with default settings.

### Models

- **ApplicationRecord**: Base class for models.
- **Approval**: Model for handling user approvals with associations and validations.
- **Availability**: Model for managing user availability, with a `belongs_to` association to the `User` model.
- **Course**: Model for managing courses with associations and validations.
- **Enrollment**: Model for managing enrollments with associations and validations.
- **GraderApplication**: Model for managing grader applications, with `belongs_to` associations to `User`, `Course`, and `Section`, and validations for various attributes.
- **Meeting**: Model for managing meetings, with `belongs_to` associations to the `Section` and `Instructor` models.
- **Section**: Model for managing sections with associations and validations.
- **User**: Model for managing users with Devise modules, roles, associations, and validations.

### Services

- **FetchClassInfo**: Service for fetching class information from the Ohio State University API.

### Views

#### Admin

- **index.html.erb**: Dashboard view for admin user management and course info fetching.
- **test.html.erb**: A test page for the admin interface, including a form to fetch class information and display fetched courses.

#### Courses

- **form.html.erb**: Shared form partial for course creation and editing.
- **edit.html.erb**: View for editing an existing course.
- **index.html.erb**: View for listing courses.
- **new.html.erb**: View for creating a new course.
- **reload_courses.html.erb**: View for reloading course information from an The Ohio State University source.
- **show.html.erb**: View for displaying course details.

#### Devise

- **Confirmations**: Views for resending confirmation instructions.
- **Mailer**: Email templates for user confirmation, email change, password change, and account unlock notifications.
- **Passwords**: Views for editing and resetting passwords.
- **Registrations**: Views for user profile editing and registration.
- **Sessions**: Views for user login.
- **Shared**: Shared views for error messages and links.
- **Unlocks**: Views for resending unlock instructions.

#### Errors

- **not_found.html.erb**: Custom 404 error page displayed when a requested page is not found. Includes a message indicating the page does not exist and a spinning cat GIF for visual interest.

#### Grader Applications

- **form.html.erb**: Form view for creating and editing grader applications.
- **approve.js.erb**: JavaScript view for updating the approval status of a grader application.
- **edit.html.erb**: Form view for editing an existing grader application.
- **index.html.erb**: View for listing all grader applications.
- **new.html.erb**: Form view for creating a new grader application.
- **show.html.erb**: View for displaying details of a specific grader application.

#### Home

- **index.html.erb**: Home page view. ![Home Page](LandingPage.png)

#### Layouts

- **application.html.erb**: The main layout file for the application.
- **mailer.html.erb**: The HTML layout used for sending emails.
- **mailer.text.erb**: The plain text layout used for sending emails.
- **Sections**: Contains layout partials and views specific to managing sections.

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

- Users can register for an account and log in.
- Admins need to approve new admins/instructors before they can access the system. (note: check user logs if experiencing errors with approval: admin may not be able to be approved if the user requirements aren't met!)
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
- Jarret
