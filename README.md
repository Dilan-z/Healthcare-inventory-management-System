# 🏥 MedCore Enterprise - Healthcare Management System

A web-based healthcare management system built with **Python Streamlit** and **Microsoft SQL Server** to streamline hospital operations.

## 📌 Overview

MedCore Enterprise helps healthcare organizations manage patients, doctors, appointments, billing, and analytics through a centralized dashboard.

## ✨ Features

* 📊 Real-time dashboard and analytics
* 👨‍⚕️ Patient management (Add, Update, View, Delete)
* 🩺 Doctor and department management
* 📅 Appointment scheduling and tracking
* 💳 Billing and payment management
* 📈 Business intelligence reports

## 🛠️ Tech Stack

* Python
* Streamlit
* Pandas
* PyODBC
* Microsoft SQL Server

## 🗄️ Database

**Database Name:** `HealthcareDB`

### Main Tables

* PATIENT
* DOCTOR
* APPOINTMENT
* BILL
* DEPARTMENT
* BRANCH
* MEDICINE

## ⚙️ Installation

```bash
git clone https://github.com/your-username/medcore-enterprise.git

cd medcore-enterprise

pip install -r requirements.txt

streamlit run APP.py
```

## 🔧 Database Setup

1. Open SQL Server Management Studio (SSMS).
2. Restore `HealthcareDB.bak`.
3. Update the SQL connection string in `APP.py` if required.

## 📸 Screenshots

Add screenshots inside a `screenshots/` folder.

```md
![Dashboard](screenshots/dashboard.png)
```

## 🔮 Future Enhancements

* Role-based authentication
* Electronic Medical Records (EMR)
* Prescription management
* Cloud deployment
* Mobile support

## 📄 License

This project is developed for educational purposes.
