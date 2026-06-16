import pyodbc
import streamlit as st
import pandas as pd
from streamlit_option_menu import option_menu

st.set_page_config(page_title="MedCore Enterprise", page_icon="⚕️", layout="wide", initial_sidebar_state="expanded")

st.markdown("""
    <style>
    .stButton>button {
        border-radius: 8px;
        font-weight: bold;
        transition: all 0.3s ease;
    }
    .stButton>button:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(0,0,0,0.15);
    }
    div[data-testid="stMetricValue"] {
        font-size: 2.2rem;
        color: #0f52ba;
        font-weight: 700;
    }
    </style>
""", unsafe_allow_html=True)

@st.cache_resource
def get_connection():
    return pyodbc.connect(
        'DRIVER={ODBC Driver 17 for SQL Server};'
        'SERVER=localhost\\SQLEXPRESS;'          
        'DATABASE=HealthcareDB;'
        'Trusted_Connection=yes;'
        'TrustServerCertificate=yes;'
    )

try:
    conn = get_connection()
except Exception as e:
    st.error("Critical Error: Database Connection Failed. Please start SQL Server.")
    st.stop()

with st.sidebar:
    st.image("https://cdn-icons-png.flaticon.com/512/2966/2966327.png", width=80)
    st.title("MedCore v2.0")
    st.caption("Hospital Management System")
    st.markdown("---")
    
    menu = option_menu(
        menu_title=None, 
        options=["Dashboard", "Patient Management", "Doctor Directory", "Appointments", "Billing & Finance", "BI & Analytics"],
        icons=["bar-chart-fill", "person-lines-fill", "heart-pulse-fill", "calendar-check-fill", "wallet2", "graph-up-arrow"],
        menu_icon="cast",
        default_index=0,
        styles={
            "container": {"padding": "0!important", "background-color": "transparent"},
            "icon": {"color": "#0f52ba", "font-size": "18px"},
            "nav-link": {"font-size": "15px", "text-align": "left", "margin":"5px", "--hover-color": "#262730"},
            "nav-link-selected": {"background-color": "#0f52ba"},
        }
    )

if menu == "Dashboard":
    st.title("Executive Overview")
    st.markdown("Real-time telemetry of hospital operations and patient influx.")

    cursor = conn.cursor()
    tot_patients = cursor.execute("SELECT COUNT(*) FROM PATIENT").fetchone()[0]
    tot_doctors = cursor.execute("SELECT COUNT(*) FROM DOCTOR").fetchone()[0]
    tot_revenue = cursor.execute("SELECT SUM(TotalAmount) FROM BILL").fetchone()[0]
    tot_appointments = cursor.execute("SELECT COUNT(*) FROM APPOINTMENT").fetchone()[0]

    c1, c2, c3, c4 = st.columns(4)
    c1.metric("Total Patients", tot_patients, "Active")
    c2.metric("Total Appointments", tot_appointments, "Scheduled")
    c3.metric("Available Doctors", tot_doctors, "On Duty")
    c4.metric("Total Revenue", f"Rs. {tot_revenue:,.2f}", "+12% MTD")

    st.markdown("<br>", unsafe_allow_html=True)

    tab1, tab2 = st.tabs(["📈 Operational Charts", "🗓️ Recent Activities"])
    
    with tab1:
        colA, colB = st.columns(2)
        with colA:
            st.subheader("Patient Demographics (Gender)")
            df_gender = pd.read_sql("SELECT Gender, COUNT(*) as Count FROM PATIENT GROUP BY Gender", conn)
            if not df_gender.empty:
                df_gender.set_index("Gender", inplace=True)
                st.bar_chart(df_gender, color="#ff7f0e")

        with colB:
            st.subheader("Appointments by Status")
            df_status = pd.read_sql("SELECT Status, COUNT(*) as Count FROM APPOINTMENT GROUP BY Status", conn)
            if not df_status.empty:
                df_status.set_index("Status", inplace=True)
                st.bar_chart(df_status, color="#2ca02c")

    with tab2:
        st.subheader("Latest Appointments Queue")
        df_app = pd.read_sql("SELECT TOP 8 AppDate, AppTime, PatientName, DoctorName, Status FROM vw_PatientAppointments ORDER BY AppDate DESC", conn)
        st.dataframe(df_app, use_container_width=True, hide_index=True)

elif menu == "Patient Management":
    st.title("Patient Control Center")
    
    tab_reg, tab_view = st.tabs(["➕ New Registration", "🔍 Patient Directory"])
    
    with tab_reg:
        with st.form("patient_form", clear_on_submit=True):
            st.subheader("Patient Enrollment Form")
            col1, col2, col3 = st.columns(3)
            
            with col1:
                fname = st.text_input("First Name")
                nic = st.text_input("NIC Number", max_chars=12)
            with col2:
                lname = st.text_input("Last Name")
                contact = st.text_input("Contact Number", max_chars=15)
            with col3:
                dob = st.date_input("Date of Birth")
                gender = st.selectbox("Gender", ["M", "F"])

            blood_group = st.selectbox("Blood Group", ["A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-"])

            submit_btn = st.form_submit_button("Create Patient Profile", type="primary", use_container_width=True)

            if submit_btn:
                if fname and lname and nic:
                    try:
                        cursor = conn.cursor()
                        cursor.execute("{CALL sp_AddNewPatient (?, ?, ?, ?, ?, ?, ?)}", (fname, lname, dob, gender, nic, contact, blood_group))
                        conn.commit()
                        st.success(f"Profile for {fname} {lname} created successfully.")
                        st.balloons()
                    except Exception as e:
                        st.error(f"Transaction Failed: {e}")
                else:
                    st.warning("Validation Error: Missing mandatory fields.")
                    
    with tab_view:
        st.subheader("Registered Patients Archive")
        search_term = st.text_input("Search by Name or NIC:", placeholder="Type to search...")
        
        query = "SELECT PatientID, FirstName + ' ' + LastName AS FullName, NIC, Gender, BloodGroup, ContactNo FROM PATIENT"
        if search_term:
            query += f" WHERE FirstName LIKE '%{search_term}%' OR LastName LIKE '%{search_term}%' OR NIC LIKE '%{search_term}%'"
            
        df_patients = pd.read_sql(query, conn)
        st.dataframe(df_patients, use_container_width=True, hide_index=True)

elif menu == "Doctor Directory":
    st.title("Medical Staff Directory")
    
    tab_docs, tab_add_doc = st.tabs(["👨‍⚕️ Active Roster", "➕ Add New Doctor"])
    
    with tab_docs:
        df_docs = pd.read_sql("""
            SELECT D.LicenseNo, D.FirstName + ' ' + D.LastName AS DoctorName, D.Specialization, DEP.DeptName, D.ConsultFee 
            FROM DOCTOR D
            JOIN DEPARTMENT DEP ON D.DeptID = DEP.DeptID
        """, conn)
        st.dataframe(df_docs, use_container_width=True, hide_index=True)
        
    with tab_add_doc:
        with st.form("doctor_form", clear_on_submit=True):
            st.subheader("Doctor Onboarding Form")
            
            df_depts = pd.read_sql("SELECT DeptID, DeptName FROM DEPARTMENT", conn)
            dept_dict = dict(zip(df_depts.DeptName, df_depts.DeptID))
            
            c1, c2 = st.columns(2)
            with c1:
                dfname = st.text_input("First Name")
                dspec = st.text_input("Specialization (e.g. Cardiologist)")
                dfee = st.number_input("Consultation Fee (Rs.)", min_value=0.0, step=500.0)
            with c2:
                dlname = st.text_input("Last Name")
                dlic = st.text_input("License Number", max_chars=20)
                ddept = st.selectbox("Assign Department", options=list(dept_dict.keys()))
                
            doc_submit = st.form_submit_button("Register Doctor", type="primary", use_container_width=True)
            
            if doc_submit:
                if dfname and dlname and dlic and dspec:
                    try:
                        cursor = conn.cursor()
                        dept_id = dept_dict[ddept]
                        cursor.execute("INSERT INTO DOCTOR (FirstName, LastName, Specialization, LicenseNo, DeptID, ConsultFee) VALUES (?, ?, ?, ?, ?, ?)", 
                                       (dfname, dlname, dspec, dlic, dept_id, dfee))
                        conn.commit()
                        st.success(f"Dr. {dfname} {dlname} registered successfully under {ddept}.")
                    except Exception as e:
                        st.error(f"Database Error: {e}")
                else:
                    st.warning("Please fill all required fields.")

elif menu == "Appointments":
    st.title("Scheduling & Appointments")
    
    df_pats = pd.read_sql("SELECT PatientID, NIC + ' - ' + FirstName + ' ' + LastName AS PatInfo FROM PATIENT", conn)
    df_docs = pd.read_sql("SELECT DoctorID, Specialization + ' - Dr. ' + FirstName + ' ' + LastName AS DocInfo FROM DOCTOR", conn)
    df_branches = pd.read_sql("SELECT BranchID, BranchName FROM BRANCH", conn)
    
    pat_dict = dict(zip(df_pats.PatInfo, df_pats.PatientID))
    doc_dict = dict(zip(df_docs.DocInfo, df_docs.DoctorID))
    branch_dict = dict(zip(df_branches.BranchName, df_branches.BranchID))

    with st.form("appointment_form", clear_on_submit=True):
        st.subheader("Book an Appointment")
        
        col1, col2 = st.columns(2)
        with col1:
            sel_pat = st.selectbox("Select Patient", options=list(pat_dict.keys()))
            sel_branch = st.selectbox("Select Branch", options=list(branch_dict.keys()))
            app_date = st.date_input("Appointment Date")
        with col2:
            sel_doc = st.selectbox("Select Doctor", options=list(doc_dict.keys()))
            app_time = st.time_input("Appointment Time")
            
        app_submit = st.form_submit_button("Confirm Appointment", type="primary", use_container_width=True)
        
        if app_submit:
            try:
                cursor = conn.cursor()
                cursor.execute("INSERT INTO APPOINTMENT (PatientID, DoctorID, BranchID, AppDate, AppTime, Status) VALUES (?, ?, ?, ?, ?, ?)",
                               (pat_dict[sel_pat], doc_dict[sel_doc], branch_dict[sel_branch], app_date, app_time.strftime('%H:%M'), 'Scheduled'))
                conn.commit()
                st.success("Appointment Scheduled Successfully!")
                st.balloons()
            except Exception as e:
                st.error(f"Failed to book appointment: {e}")

elif menu == "Billing & Finance":
    st.title("Financial Operations")
    
    col1, col2 = st.columns(2)
    with col1:
        st.subheader("Pending Payments")
        df_pending = pd.read_sql("SELECT BillDate, TotalAmount, PaymentStatus FROM BILL WHERE PaymentStatus = 'Pending'", conn)
        st.dataframe(df_pending, use_container_width=True, hide_index=True)
        
        csv_billing = df_pending.to_csv(index=False).encode('utf-8')
        st.download_button(label="📥 Download Pending Bills Report (CSV)", data=csv_billing, file_name='pending_bills.csv', mime='text/csv')
        
    with col2:
        st.subheader("Revenue by Payment Status")
        df_rev = pd.read_sql("SELECT PaymentStatus, SUM(TotalAmount) as Total FROM BILL GROUP BY PaymentStatus", conn)
        if not df_rev.empty:
            df_rev.set_index("PaymentStatus", inplace=True)
            st.bar_chart(df_rev)

elif menu == "BI & Analytics":
    st.title("Business Intelligence & Inventory")
    st.caption("Predictive alerts and stock flow visualization.")

    col1, col2 = st.columns([1, 1.5])

    with col1:
        st.subheader("Stock Threshold Alerts")
        df_low = pd.read_sql("SELECT MedicineName, ReorderLevel, TotalStock FROM vw_LowStockMedicines", conn)
        
        if not df_low.empty:
            st.error("Critical: Replenishment required for the following inventory items.")
            st.dataframe(df_low, use_container_width=True, hide_index=True)
            
            csv_inventory = df_low.to_csv(index=False).encode('utf-8')
            st.download_button(label="📥 Export Critical Stock List (CSV)", data=csv_inventory, file_name='critical_stock.csv', mime='text/csv')
        else:
            st.success("All inventory items are operating within safe thresholds.")

    with col2:
        st.subheader("Inventory Distribution Curve")
        df_chart = pd.read_sql("""
            SELECT M.MedicineName, SUM(I.Quantity) as TotalStock 
            FROM MEDICINE M 
            JOIN INVENTORY I ON M.MedicineID = I.MedicineID 
            GROUP BY M.MedicineName
        """, conn)
        
        if not df_chart.empty:
            df_chart.set_index("MedicineName", inplace=True)
            st.line_chart(df_chart, color="#d62728")