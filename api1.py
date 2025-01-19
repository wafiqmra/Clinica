from flask import Flask, jsonify, request
from flask_cors import CORS
import mysql.connector

app = Flask(__name__)  # Corrected from _name_ to __name__
CORS(app)  # Enable CORS for all routes

# Koneksi database
app.config['MYSQL_DATABASE_USER'] = 'root'  # Ganti dengan username MySQL Anda
app.config['MYSQL_DATABASE_PASSWORD'] = ''  # Ganti dengan password MySQL Anda
app.config['MYSQL_DATABASE_DB'] = 'clinica'  # Ganti dengan nama database Anda
app.config['MYSQL_DATABASE_HOST'] = 'localhost'  # Ganti dengan host jika perlu

# Route to get all doctors
@app.route('/api/doctors', methods=['GET'])
def get_doctors():
    try:
        conn = mysql.connector.connect(
            user=app.config['MYSQL_DATABASE_USER'],
            password=app.config['MYSQL_DATABASE_PASSWORD'],
            host=app.config['MYSQL_DATABASE_HOST'],
            database=app.config['MYSQL_DATABASE_DB']
        )
        cursor = conn.cursor()

        cursor.execute("SELECT id, name, specialization, contact, availability FROM doctors")
        doctors_data = cursor.fetchall()

        doctors = []
        for doctor in doctors_data:
            doctors.append({
                "id": doctor[0],
                "name": doctor[1],
                "specialization": doctor[2],
                "contact": doctor[3],
                "availability": doctor[4],
            })

        cursor.close()
        conn.close()

        return jsonify(doctors)

    except Exception as e:
        return jsonify({"error": str(e)}), 500

# Route to create a new doctor
@app.route('/api/doctors', methods=['POST'])
def create_doctor():
    try:
        data = request.get_json()

        if 'name' not in data or 'specialization' not in data or 'contact' not in data or 'availability' not in data:
            return jsonify({"error": "Name, specialization, contact, and availability are required"}), 400

        name = data['name']
        specialization = data['specialization']
        contact = data['contact']
        availability = data['availability']

        conn = mysql.connector.connect(
            user=app.config['MYSQL_DATABASE_USER'],
            password=app.config['MYSQL_DATABASE_PASSWORD'],
            host=app.config['MYSQL_DATABASE_HOST'],
            database=app.config['MYSQL_DATABASE_DB']
        )
        cursor = conn.cursor()

        query = """
            INSERT INTO doctors (name, specialization, contact, availability)
            VALUES (%s, %s, %s, %s)
        """
        values = (name, specialization, contact, availability)

        cursor.execute(query, values)
        conn.commit()

        cursor.close()
        conn.close()

        return jsonify({"message": "Doctor created successfully!"}), 201

    except Exception as e:
        return jsonify({"error": str(e)}), 500

# Route to delete a doctor by ID
@app.route('/api/doctors/<int:id>', methods=['DELETE'])
def delete_doctor(id):
    try:
        conn = mysql.connector.connect(
            user=app.config['MYSQL_DATABASE_USER'],
            password=app.config['MYSQL_DATABASE_PASSWORD'],
            host=app.config['MYSQL_DATABASE_HOST'],
            database=app.config['MYSQL_DATABASE_DB']
        )
        cursor = conn.cursor()

        query = "DELETE FROM doctors WHERE id = %s"
        cursor.execute(query, (id,))
        conn.commit()

        if cursor.rowcount == 0:
            return jsonify({"error": "Doctor not found"}), 404

        cursor.close()
        conn.close()

        return jsonify({"message": "Doctor deleted successfully!"}), 200

    except Exception as e:
        return jsonify({"error": str(e)}), 500

@app.route('/api/doctors/<int:id>', methods=['PUT'])
def update_doctor(id):
    try:
        # Mendapatkan data JSON dari request
        data = request.get_json()

        # Memeriksa apakah semua field yang dibutuhkan disediakan
        if 'name' not in data or 'specialization' not in data or 'contact' not in data or 'availability' not in data:
            return jsonify({"error": "Name, specialization, contact, and availability are required"}), 400

        # Menyimpan data dari JSON
        name = data['name']
        specialization = data['specialization']
        contact = data['contact']
        availability = data['availability']

        # Membuka koneksi ke database
        conn = mysql.connector.connect(
            user=app.config['MYSQL_DATABASE_USER'],
            password=app.config['MYSQL_DATABASE_PASSWORD'],
            host=app.config['MYSQL_DATABASE_HOST'],
            database=app.config['MYSQL_DATABASE_DB']
        )
        cursor = conn.cursor()

        # Query untuk memperbarui data dokter berdasarkan ID
        query = """
            UPDATE doctors
            SET name = %s, specialization = %s, contact = %s, availability = %s
            WHERE id = %s
        """
        values = (name, specialization, contact, availability, id)

        # Menjalankan query
        cursor.execute(query, values)
        conn.commit()

        # Menutup koneksi
        cursor.close()
        conn.close()

        # Periksa apakah ada baris yang diperbarui
        if cursor.rowcount == 0:
            return jsonify({"error": "Doctor not found"}), 404

        return jsonify({"message": "Doctor updated successfully!"}), 200

    except Exception as e:
        return jsonify({"error": str(e)}), 500

@app.route('/api/appointments', methods=['GET'])
def get_appointments():
    try:
        # Membuka koneksi ke database
        conn = mysql.connector.connect(
            user=app.config['MYSQL_DATABASE_USER'],
            password=app.config['MYSQL_DATABASE_PASSWORD'],
            host=app.config['MYSQL_DATABASE_HOST'],
            database=app.config['MYSQL_DATABASE_DB']
        )
        cursor = conn.cursor()

        # Query untuk mengambil data janji temu
        cursor.execute("""
            SELECT id, doctor_id, patient_name, patient_contact, appointment_date, status, reason_for_visit, notes
            FROM appointments
        """)
        appointments_data = cursor.fetchall()

        # Menyusun response dalam format JSON
        appointments = []
        for appointment in appointments_data:
            appointments.append({
                "id": appointment[0],
                "doctor_id": appointment[1],
                "patient_name": appointment[2],
                "patient_contact": appointment[3],
                "appointment_date": appointment[4],
                "status": appointment[5],
                "reason_for_visit": appointment[6],
                "notes": appointment[7],
            })

        # Menutup koneksi
        cursor.close()
        conn.close()

        return jsonify(appointments)

    except Exception as e:
        return jsonify({"error": str(e)}), 500

@app.route('/api/appointments', methods=['POST'])
def create_appointment():
    try:
        # Mendapatkan data JSON dari request
        data = request.get_json()

        # Membuka koneksi ke database
        conn = mysql.connector.connect(
            user=app.config['MYSQL_DATABASE_USER'],
            password=app.config['MYSQL_DATABASE_PASSWORD'],
            host=app.config['MYSQL_DATABASE_HOST'],
            database=app.config['MYSQL_DATABASE_DB']
        )
        cursor = conn.cursor()

        # Query untuk insert data janji temu
        query = """
            INSERT INTO appointments (doctor_id, patient_name, patient_contact, appointment_date, status, reason_for_visit, notes)
            VALUES (%s, %s, %s, %s, %s, %s, %s)
        """
        values = (
            data['doctor_id'],
            data['patient_name'],
            data['patient_contact'],
            data['appointment_date'],
            data['status'],
            data['reason_for_visit'],
            data['notes']
        )

        cursor.execute(query, values)
        conn.commit()

        # Menutup koneksi
        cursor.close()
        conn.close()

        # Mengembalikan response sukses
        return jsonify({"message": "Appointment created successfully!"}), 201

    except Exception as e:
        return jsonify({"error": str(e)}), 500

# Route for sign-in using email and password
@app.route('/api/signin', methods=['POST'])
def signin():
    try:
        # Get JSON data from the request
        data = request.get_json()

        # Check if email and password are provided
        if 'email' not in data or 'password' not in data:
            return jsonify({"error": "Email and password are required"}), 400

        email = data['email']
        password = data['password']

        # Open database connection
        conn = mysql.connector.connect(
            user=app.config['MYSQL_DATABASE_USER'],
            password=app.config['MYSQL_DATABASE_PASSWORD'],
            host=app.config['MYSQL_DATABASE_HOST'],
            database=app.config['MYSQL_DATABASE_DB']
        )
        cursor = conn.cursor()

        # Query to get user by email and password
        cursor.execute("SELECT id, username, email FROM users WHERE email = %s AND password = %s", (email, password))
        user_data = cursor.fetchone()

        if user_data:
            return jsonify({"message": "Sign-in successful", "user_id": user_data[0], "username": user_data[1], "email": user_data[2]}), 200
        else:
            return jsonify({"error": "Invalid email or password"}), 401

    except Exception as e:
        return jsonify({"error": str(e)}), 500


# Route for creating a new user (sign-up)
@app.route('/api/userspost', methods=['POST'])
def create_user():
    try:
        # Get JSON data from the request
        data = request.get_json()

        # Check if email, password, and username are provided
        if 'username' not in data or 'email' not in data or 'password' not in data:
            return jsonify({"error": "Username, email, and password are required"}), 400

        username = data['username']
        email = data['email']
        password = data['password']

        # Open database connection
        conn = mysql.connector.connect(
            user=app.config['MYSQL_DATABASE_USER'],
            password=app.config['MYSQL_DATABASE_PASSWORD'],
            host=app.config['MYSQL_DATABASE_HOST'],
            database=app.config['MYSQL_DATABASE_DB']
        )
        cursor = conn.cursor()

        # Query to insert user into the database
        query = """
            INSERT INTO users (username, email, password, created_at, updated_at)
            VALUES (%s, %s, %s, NOW(), NOW())
        """
        values = (username, email, password)

        cursor.execute(query, values)
        conn.commit()

        # Close the connection
        cursor.close()
        conn.close()

        return jsonify({"message": "User created successfully!"}), 201

    except Exception as e:
        return jsonify({"error": str(e)}), 500

@app.route('/api/users', methods=['GET'])
def get_users_with_password():
    try:
        # Membuka koneksi ke database
        conn = mysql.connector.connect(
            user=app.config['MYSQL_DATABASE_USER'],
            password=app.config['MYSQL_DATABASE_PASSWORD'],
            host=app.config['MYSQL_DATABASE_HOST'],
            database=app.config['MYSQL_DATABASE_DB']
        )
        cursor = conn.cursor()

        # Query untuk mengambil semua pengguna
        cursor.execute("SELECT id, username, email, password, created_at, updated_at FROM users")
        users_data = cursor.fetchall()

        # Menyusun response dalam format JSON
        users = []
        for user in users_data:
            users.append({
                "id": user[0],
                "username": user[1],
                "email": user[2],
                "password": user[3],  # Tambahkan password ke response
                "created_at": user[4],
                "updated_at": user[5],
            })

        # Menutup koneksi
        cursor.close()
        conn.close()

        return jsonify(users)

    except Exception as e:
        return jsonify({"error": str(e)}), 500


if __name__ == '__main__':  # Corrected from _name_ to __name__
    app.run(debug=True, host='0.0.0.0', port=5000)
