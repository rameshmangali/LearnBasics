# LearnBasics Reference Document
LearnBasics – A starter project using Appsmith + Render PostgreSQL to learn full-stack basics: CRUD APIs, database integration, and low-code UI building. Ideal for students &amp; makers.

### Creating a PostgreSQL Database and Appsmith Application

## Overview

This consists of three main parts:

1. **Creating a PostgreSQL Database on Render** and setting it up with sample data.
2. **Connecting the Database to Appsmith** to use it in an application.
3. **Building an Appsmith Application** with dropdowns for school name, class, and section to filter and display student data dynamically.

You will:

- Use **Render.com** to create a free PostgreSQL database.
- Use **pgAdmin 4** to manage the database and import sample data.
- Create an **Appsmith** application to connect to the database and build a user interface with dropdowns and a table to display filtered data.
- Deploy the Appsmith app and share it.

---

## Prerequisites

Before starting, ensure you have:

1. A computer with internet access.
2. A web browser (Google Chrome recommended).
3. **pgAdmin 4** installed on your computer (you’ll install it during the process).
4. Accounts for:
    - **Render.com** (free tier).
    - **Appsmith.com** (free cloud-hosted version).
    - A GitHub account (optional, for Render setup).

---

## Step-by-Step Guide

### Part 1: Creating a PostgreSQL Database on Render

### Step 1.1: Sign Up for Render

1. Go to [Render.com](https://render.com/).
2. Click **Sign Up** in the top-right corner.
3. Sign up using your GitHub account or email address.
4. Verify your email if prompted.
5. Once signed in, you’ll land on the Render Dashboard.

### Step 1.2: Create a PostgreSQL Database

1. In the Render Dashboard, click the **New +** button at the top.
2. Select **PostgreSQL** from the dropdown menu.
3. Fill in the database details:
    - **Name**: Enter a name, e.g., `student_database`.
    - **Database**: Enter `students` (this is the database name).
    - **User**: Enter `admin` (this is the database username).
    - **Region**: Choose the region closest to you (e.g., Oregon for the US).
    - **PostgreSQL Version**: Select the latest version (e.g., 15).
    - **Instance Type**: Select **Free** to avoid charges (note: free databases expire after 90 days).
    - Leave **Datadog API Key** empty (optional).
4. Click **Create Database** at the bottom.
5. Wait a few minutes for the database to be created. You’ll see a status update in the Render Dashboard.
6. Once created, go to the database’s **Info** page in the Render Dashboard.
7. Scroll to the **Connections** section and copy:
    - **External Database URL** (e.g., `postgres://admin:password@hostname.region-postgres.render.com/students`).
    - **PSQL Command** (e.g., `psql "postgres://admin:password@hostname.region-postgres.render.com/students"`).
    - Save these in a text file for later use.

### Step 1.3: Install pgAdmin 4

1. Download **pgAdmin 4** from [pgAdmin.org](https://www.pgadmin.org/download/).
2. Choose the version for your operating system (Windows, macOS, or Linux).
3. Follow the installation instructions:
    - For Windows: Run the installer, accept defaults, and complete the setup.
    - For macOS: Drag the app to the Applications folder.
4. Launch pgAdmin 4 from your applications menu.

### Step 1.4: Connect the Render Database to pgAdmin 4

1. Open pgAdmin 4.
2. In the left panel, right-click **Servers** > **Register** > **Server**.
3. In the **General** tab:
    - **Name**: Enter `Render Student DB` (or any name you prefer).
4. In the **Connection** tab, extract details from the **External Database URL** you copied (e.g., `postgres://admin:password@hostname.region-postgres.render.com/students`):
    - **Host name/address**: Copy the part between `@` and `/` (e.g., `hostname.region-postgres.render.com`).
    - **Port**: Enter `5432` (default PostgreSQL port).
    - **Maintenance database**: Enter `students` (the database name).
    - **Username**: Enter `admin` (the user you set).
    - **Password**: Copy the password from the URL (between `admin:` and `@`).
5. Click **Save**.
6. If prompted to download drivers, click **Download** and proceed.
7. If the connection fails, double-check the details or ensure your internet is active. If you get an SSL error, go to the **SSL** tab in pgAdmin and set **SSL mode** to `Allow` or `Prefer`.

### Step 1.5: Create a Table and Import Sample Data

1. In pgAdmin 4, expand **Servers** > **Render Student DB** > **Databases** > **students** > **Schemas** > **public**.
2. Right-click **Tables** > **Create** > **Table**.
3. In the **General** tab:
    - **Name**: Enter `student_data`.
4. In the **Columns** tab, add the following columns (click **Add** for each):
    - **id**: Type `integer`, check **Primary Key**.
    - **school_name**: Type `varchar(100)`.
    - **class**: Type `varchar(10)`.
    - **section**: Type `varchar(5)`.
    - **student_name**: Type `varchar(100)`.
    - **roll_number**: Type `integer`.
5. Click **Save** to create the table.
6. **Sample Data**: Since no sample dataset was provided, here’s a sample dataset to use. Copy this into a `.csv` file named `student_data.csv`:
    
    ```
    id,school_name,class,section,student_name,roll_number
    1,Green Valley School,10,A,John Doe,101
    2,Green Valley School,10,B,Jane Smith,102
    3,Sunrise Academy,9,A,Alice Brown,201
    4,Sunrise Academy,9,B,Bob Wilson,202
    5,Green Valley School,10,A,Mary Johnson,103
    6,Sunrise Academy,10,A,Tom Clark,203
    
    ```
    
7. Save the `.csv` file to your computer.
8. In pgAdmin, right-click the `student_data` table > **Import/Export Data**.
9. Set:
    - **Import/Export**: Select **Import**.
    - **Filename**: Browse to `student_data.csv`.
    - **Format**: Select `csv`.
    - **Header**: Check **Yes** (since the CSV has headers).
    - **Delimiter**: Enter `,` (comma).
10. In the **Columns** tab, ensure all columns match the CSV headers.
11. Click **OK** to import the data.
12. Verify the data:
- Right-click `student_data` > **View/Edit Data** > **All Rows**.
- You should see the 6 rows from the CSV.

---

### Part 2: Connect the Database to Appsmith

### Step 2.1: Sign Up for Appsmith

1. Go to [Appsmith.com](https://www.appsmith.com/).
2. Click **Sign Up** and create a free account using your email or GitHub.
3. Verify your email if prompted.
4. Once signed in, you’ll see the Appsmith Dashboard.

### Step 2.2: Create a New Application

1. In the Appsmith Dashboard, click **Create New** > **Application**.
2. Name the application, e.g., `StudentFilterApp`.
3. You’ll be taken to a blank canvas with a sidebar containing **Data**, **Widgets**, and **Pages**.

### Step 2.3: Connect the PostgreSQL Database

1. In the sidebar, click the **Data** button (database icon).
2. Click the **+** next to **Datasources**.
3. Select **PostgreSQL** from the list.
4. Configure the datasource:
    - **Name**: Enter `StudentDB`.
    - **Host Address**: Copy the hostname from the Render External Database URL (e.g., `hostname.region-postgres.render.com`).
    - **Port**: Enter `5432`.
    - **Database Name**: Enter `students`.
    - **Username**: Enter `admin`.
    - **Password**: Copy the password from the External Database URL.
    - **SSL Mode**: Select **Prefer** (default).
5. Click **Test** to verify the connection. If it fails, double-check the credentials.
6. Click **Save** to create the datasource.

---

### Part 3: Create Dropdowns and Display Filtered Data in Appsmith

### Step 3.1: Create a Query to Fetch Data

1. In the Appsmith sidebar, under **Data** > **StudentDB**, click **+ New Query**.
2. Name the query `getStudentData`.
3. Enter the following SQL query to fetch all student data:
    
    ```sql
    SELECT * FROM public.student_data
    WHERE school_name = {{SchoolDropdown.selectedOptionValue || '%'}}
    AND class = {{ClassDropdown.selectedOptionValue || '%'}}
    AND section = {{SectionDropdown.selectedOptionValue || '%'}}
    
    ```
    
    - This query filters data based on dropdown selections. The `|| '%'` ensures all records are shown if no filter is selected (using SQL wildcard `%`).
4. Click **Run** to test the query. You should see the 6 rows from the database.
5. Click **Save**.

### Step 3.2: Add Dropdown Widgets

1. In the Appsmith canvas, click the **Widgets** tab in the sidebar.
2. Drag a **Dropdown** widget onto the canvas.
3. In the **Property Pane** (right side):
    - **Label**: Enter `School Name`.
    - **Name**: Set to `SchoolDropdown` (this is the widget’s identifier).
    - **Options**: Enter the following (click **Add Option** for each):
        - Option 1: **Label**: `Green Valley School`, **Value**: `Green Valley School`.
        - Option 2: **Label**: `Sunrise Academy`, **Value**: `Sunrise Academy`.
    - **Default Option**: Select `Green Valley School`.
4. Drag another **Dropdown** widget below the first.
5. Configure it:
    - **Label**: Enter `Class`.
    - **Name**: Set to `ClassDropdown`.
    - **Options**:
        - Option 1: **Label**: `9`, **Value**: `9`.
        - Option 2: **Label**: `10`, **Value**: `10`.
    - **Default Option**: Select `10`.
6. Drag a third **Dropdown** widget below the second.
7. Configure it:
    - **Label**: Enter `Section`.
    - **Name**: Set to `SectionDropdown`.
    - **Options**:
        - Option 1: **Label**: `A`, **Value**: `A`.
        - Option 2: **Label**: `B`, **Value**: `B`.
    - **Default Option**: Select `A`.

### Step 3.3: Add a Table Widget to Display Data

1. Drag a **Table** widget below the dropdowns.
2. In the **Property Pane**:
    - **Table Data**: Enter `{{getStudentData.data}}` (this binds the query results to the table).
    - **Columns**: Ensure columns like `id`, `school_name`, `class`, `section`, `student_name`, `roll_number` are displayed.
    - **Editable**: Uncheck to make the table read-only.
3. Adjust the table size by dragging its edges to fit the canvas.

### Step 3.4: Add a Button to Trigger the Query

1. Drag a **Button** widget below the dropdowns, above the table.
2. In the **Property Pane**:
    - **Label**: Enter `Filter Data`.
    - **onClick**: Select **Execute a query** > **getStudentData**.
3. This button will re-run the query when clicked, applying the dropdown filters.

### Step 3.5: Test the Application

1. Select different values in the **School Name**, **Class**, and **Section** dropdowns.
2. Click the **Filter Data** button.
3. The table should update to show only the rows matching the selected filters.
4. If no data appears, check:
    - The query syntax in `getStudentData`.
    - The dropdown names (`SchoolDropdown`, `ClassDropdown`, `SectionDropdown`) in the query.
    - The database connection in the datasource settings.

---

## Tips for Success

- **Save Frequently**: Save your work in Render PgAdmin, and Appsmith to avoid losing progress.
- **Double-Check Credentials**: Ensure database credentials (username, password, hostname) are correct when connecting in pgAdmin and Appsmith.
- **Test Incrementally**: After each major step (e.g., importing data, creating a query, adding a widget), test to ensure it works before proceeding.
- **Use the Sample Data**: The provided CSV ensures consistency. If you want to use different data, ensure it has the same columns.
- **Ask for Help**: If you get stuck, refer to the Render Docs ([docs.render.com](https://docs.render.com/)) or Appsmith Docs ([docs.appsmith.com](https://docs.appsmith.com/)).

---

## Troubleshooting Common Issues

1. **Render Database Connection Fails in pgAdmin**:
    - Verify the hostname, username, password, and database name.
    - Set SSL mode to `Prefer` or `Allow` in pgAdmin.
    - Ensure your internet connection is stable.
2. **Appsmith Database Connection Fails**:
    - Check the datasource settings (host, port, credentials).
    - Ensure the Render database is active (not suspended).
3. **No Data in Appsmith Table**:
    - Verify the `getStudentData` query runs successfully in Appsmith.
    - Check that the table’s **Table Data** is set to `{{getStudentData.data}}`.
    - Ensure dropdown names match the query (case-sensitive).
4. **Dropdown Filters Not Working**:
    - Check the query’s `WHERE` clause for correct dropdown references (e.g., `SchoolDropdown.selectedOptionValue`).
    - Ensure the button’s `onClick` action triggers the `getStudentData` query.

---

## References

- Render PostgreSQL Docs: [docs.render.com/postgresql](https://docs.render.com/postgresql)
- Appsmith PostgreSQL Connection: [docs.appsmith.com/datasource-reference/postgresql](https://docs.appsmith.com/datasource-reference/postgresql)
- pgAdmin 4 Documentation: [pgadmin.org/docs/pgadmin4/latest/](https://www.pgadmin.org/docs/pgadmin4/latest/)
- Appsmith Build Your First App: [docs.appsmith.com/getting-started/tutorials/build-your-first-app](https://docs.appsmith.com/getting-started/tutorials/build-your-first-app)

---
