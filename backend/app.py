import json
import os
from flask import Flask, jsonify, request
from flask_cors import CORS

app = Flask(__name__)
CORS(app)  # Enable CORS for all routes

DATA_DIR = 'data'
CLASSES_FILE = os.path.join(DATA_DIR, 'classes.json')
ATTENDANCE_FILE = os.path.join(DATA_DIR, 'attendance.json')

def load_data(file_path):
    if os.path.exists(file_path):
        with open(file_path, 'r') as f:
            return json.load(f)
    return {}

def save_data(file_path, data):
    with open(file_path, 'w') as f:
        json.dump(data, f, indent=4)

@app.route('/api/teachers/<teacher_id>/classes', methods=['GET'])
def get_teacher_classes(teacher_id):
    classes = load_data(CLASSES_FILE)
    teacher_classes = [c for c in classes.values() if c['teacherId'] == teacher_id]
    return jsonify(teacher_classes)

@app.route('/api/classes', methods=['POST'])
def add_class():
    data = request.get_json()
    classes = load_data(CLASSES_FILE)
    class_id = str(len(classes) + 1)
    new_class = {
        'id': class_id,
        'name': data['name'],
        'teacherId': data['teacherId'],
        'students': data['students'],
    }
    classes[class_id] = new_class
    save_data(CLASSES_FILE, classes)
    return jsonify(new_class), 201

@app.route('/api/classes/<class_id>/attendance', methods=['POST'])
def mark_attendance(class_id):
    data = request.get_json()
    student_id = data.get('student_id')
    attendance_records = load_data(ATTENDANCE_FILE)

    # In a real application, you would perform face recognition here
    # For now, we'll just record the attendance
    record_id = str(len(attendance_records.get(class_id, [])) + 1)
    new_record = {
        'id': record_id,
        'classId': class_id,
        'studentId': student_id,
        'timestamp': '2024-07-30T10:00:00Z',  # Replace with actual timestamp
    }
    if class_id not in attendance_records:
        attendance_records[class_id] = []
    attendance_records[class_id].append(new_record)
    save_data(ATTENDANCE_FILE, attendance_records)
    
    return jsonify(new_record), 200

@app.route('/api/classes/<class_id>/attendance', methods=['GET'])
def get_class_attendance(class_id):
    attendance_records = load_data(ATTENDANCE_FILE)
    records = attendance_records.get(class_id, [])
    return jsonify(records)

if __name__ == '__main__':
    if not os.path.exists(DATA_DIR):
        os.makedirs(DATA_DIR)
    app.run(debug=True, port=8000)
