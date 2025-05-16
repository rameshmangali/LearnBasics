CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    school_name VARCHAR(100) NOT NULL,
    class INTEGER NOT NULL,
    section VARCHAR(10) NOT NULL,
    student_name VARCHAR(100) NOT NULL,
    roll_number VARCHAR(20) UNIQUE NOT NULL
);
