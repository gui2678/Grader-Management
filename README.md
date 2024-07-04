
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
7. [License](#license)

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

### `grader_management/`
This directory contains the Rails application for managing graders.
- **app/**: Contains the core application code, including models, views, controllers, helpers, mailers, and assets.
- **bin/**: Contains binary files for setup and running the application.
- **config/**: Configuration files for the application, including routes, database configuration, and environment settings.
- **db/**: Database-related files, including migrations, schema, and seeds.
- **lib/**: Custom libraries and modules.
- **log/**: Application log files.
- **public/**: Static files served directly by the web server.
- **storage/**: Files for Active Storage (if used).
- **test/**: Test files and test data.
- **tmp/**: Temporary files.
- **vendor/**: Third-party code and libraries.

### `server/`
This directory contains the main Rails server application.
- **app/**: Contains the core application code, including models, views, controllers, helpers, mailers, and assets.
- **bin/**: Contains binary files for setup and running the application.
- **config/**: Configuration files for the application, including routes, database configuration, and environment settings.
- **db/**: Database-related files, including migrations, schema, and seeds.
- **lib/**: Custom libraries and modules.
- **log/**: Application log files.
- **public/**: Static files served directly by the web server.
- **storage/**: Files for Active Storage (if used).
- **test/**: Test files and test data.
- **tmp/**: Temporary files.
- **vendor/**: Third-party code and libraries.

### Root Directory
- **.gitignore**: Specifies files and directories that should be ignored by Git.
- **README.md**: This file, containing information about the project.
- **fetchCourseData.rb**: Script for fetching course data from an external source.
- **project_structure.txt**: Description of the project structure.

## Features

- **Course Management:** Add, edit, delete courses.
- **Section Management:** Add, edit, delete sections.
- **User Management:** Devise-based authentication for users.
- **JavaScript Integration:** Uses Turbo and Stimulus for enhanced user experience.

## Usage

### Course Management

- **Add a Course:**
    - Navigate to the courses section and click on 'New Course'.
    - Fill in the course details and submit.

- **Edit a Course:**
    - Click on the 'Edit' button next to the course you want to edit.
    - Update the details and save.

- **Delete a Course:**
    - Click on the 'Destroy' button next to the course you want to delete.
    - Confirm the deletion in the popup.

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
