# Complaint Management System 🛠️📋

A web-based application to streamline complaint handling and management for both employees and administrators.
Built using **Java**, **JSP**, **Servlets**, **MySQL**, and **Apache Tomcat**, following the MVC architecture and utilizing **Apache Commons DBCP** for database connection pooling.

---

## 🌟 Project Overview

This system supports two user roles with distinct functionalities:

### 👤 Employee Role

* Submit new complaints
* View a personal list of submitted complaints
* Edit or delete complaints that are not yet resolved

### 🛡️ Admin Role

* View all complaints submitted by all users
* Update complaint status and add remarks
* Delete any complaint

Both roles feature secure login access and personalized dashboards.

---

## 🚀 Features

* **User Registration and Authentication**
* **Complaint Submission and Tracking**
* **Role-Based Access Control**
* **Admin Control Panel**
* **Complaint Status Monitoring**
* **Responsive UI with JSP + CSS**
* **Secure Session Management**

---

## ⚙️ Technologies Used

* Java Servlets
* JSP (JavaServer Pages)
* MySQL Database
* JDBC (via Apache Commons DBCP)
* Apache Tomcat Server
* HTML, CSS, JavaScript
* MVC Design Pattern

---

## 🗂️ Project Structure

```
ComplainManagementSystem/
├── src/
│   └── main/
│       └── java/
│           └── com/
│               └── service/
│                   └── Project/
│                       ├── Controller/
│                       │   ├── AdminServlet.java
│                       │   ├── EmployeeServlet.java
│                       │   ├── SignInServlet.java
│                       │   └── UserServlet.java
│                       ├── DAO/
│                       │   ├── EmployeeDAO.java
│                       │   └── UserDAO.java
│                       ├── DB/                 # (Database configuration classes)
│                       └── Model/              # JavaBeans like User.java, Complaint.java
├── resources/                                  # (Optional, for configs or i18n)
├── test/                                       # (Optional test files)
├── target/                                     # Compiled output by Maven or build tool
├── web/
│   ├── META-INF/
│   │   └── context.xml                         # JDBC DataSource configuration
│   ├── View/
│   │   ├── admin.jsp
│   │   ├── employee.jsp
│   │   ├── Login.jsp
│   │   └── Signup.jsp
│   └── WEB-INF/
│       └── web.xml                             # Servlet routing and configurations
```

---

## 🧩 Database Configuration

Create a MySQL database named:

```sql
CREATE DATABASE complaint_db;
```

Then execute the following SQL schema:

```sql
CREATE TABLE users (
        id INT AUTO_INCREMENT PRIMARY KEY,
        name VARCHAR(100) NOT NULL,
        email VARCHAR(100) UNIQUE NOT NULL,
        password VARCHAR(30),
        role VARCHAR(50)
);

CREATE TABLE complaints (
        id INT AUTO_INCREMENT PRIMARY KEY,
        userID INT NOT NULL,
        date DATE DEFAULT CURRENT_DATE,
        subject VARCHAR(255) NOT NULL,
        description VARCHAR(100) NOT NULL,
        status VARCHAR(50) DEFAULT 'Pending',
        remark VARCHAR(255),
        FOREIGN KEY (userID) REFERENCES users(id) ON DELETE CASCADE
);

```

---

## 🔧 JDBC Context Configuration (`context.xml`)

```xml
<?xml version="1.0" encoding="UTF-8"?>
<Context path="/">
    <Resource
        name="jdbc/pool"
        type="javax.sql.DataSource"
        driverClassName="com.mysql.cj.jdbc.Driver"
        url="jdbc:mysql://localhost:3306/complaint_db"
        username="your_db_username"
        password="your_db_password"
        maxTotal="10"
        initialSize="5"
    />
</Context>
```

> 💡 Replace `your_db_username` and `your_db_password` with your actual MySQL credentials.

---

## 🛠️ Setup & Deployment Instructions

### ✅ Prerequisites

* Java JDK 8 or higher
* Apache Tomcat 9+
* MySQL 8.0+
* Maven (optional for builds)

### 🔨 How to Run

1. Clone the project or download the ZIP.
2. Set up your MySQL database using the schema provided.
3. Configure `context.xml` with your database credentials.
4. Import into an IDE (like IntelliJ IDEA or Eclipse).
5. Deploy the project to Tomcat (`/web` folder goes into `webapps` if using WAR).
6. Start the Tomcat server.
7. Access the app via: `http://localhost:8080/ComplainManagementSystem/`

---

## 🤝 Contribution Guide

You're welcome to contribute! Here's how:

1. Fork the repository
2. Create your feature branch (`git checkout -b feature-name`)
3. Commit your changes (`git commit -m 'Add some feature'`)
4. Push to the branch (`git push origin feature-name`)
5. Open a pull request

---

## 📜 License

This project is licensed under the MIT License. See the `LICENSE` file for full details.

---

## 📧 Contact

* 📩 Email: `ushangimhan@gmail.com`
* 🔗 LinkedIn: [Ushan Ghimhan](https://www.linkedin.com/in/ushan-ghimhan/)

---
