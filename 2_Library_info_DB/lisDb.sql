/*
Library Information System is the relational database schema of the library services of an academic
institute. A library having books to be issued by the faculty and students of the institute. The
library needs an LIS to manage the books, the members, and the issue-return process.

Certain rules have to be followed in the LIS:
    ● There are different book titles, each having a unique ISBN.
    ● Each title may exist in multiple copies (each having a different accession number) in the library.
    ● Each book may have multiple authors, but one publisher and one year of publication.
    ● The book copies are issued by the members, who can be a faculty member or a student.
        ● Members are of the following types:
            ● Students having name, roll number, department code, gender, mobile number, date of birth, and degree.
                ● PG: Postgraduate student
                ● UG: Undergraduate student
                ● RS: Research scholar
            ● Faculty having name, employee id, department code, gender, mobile number, and date of joining.
                ● FC
    ● The faculty members and the students belong to various departments.
    ● A book may not be issued to a member if another copy of the same book is already issued to the same member.
    ● Only one member can issue a particular book copy (having a unique accession number). In other words, no book copy may be issued by two members at the same time.
    ● Every member has a maximum quota (depending on the member type) for the number of books she/he can issue for and for the maximum duration she/he can retain a book.
    ● No issue will be done to a member if, at the time of issue, one or more books issued by the member has already exceeded the duration of the issue.
    ● No issue will also be allowed if the quota is exceeded for the member.
    ● The staffs of the library manage the LIS.
*/

CREATE TABLE book_authors (
    isbn_no character varying(13) NOT NULL,
    author_fname character varying(80) NOT NULL,
    author_lname character varying(80) NOT NULL,
    CONSTRAINT book_authors_pk PRIMARY KEY (isbn_no, author_fname, author_lname),
    CONSTRAINT book_authors_fk0 FOREIGN KEY (isbn_no) REFERENCES book_catalogue(isbn_no)

);

CREATE TABLE book_catalogue (
    isbn_no character varying(50) NOT NULL,
    title character varying(256) NOT NULL,
    publisher character varying(80) NOT NULL,
    publish_year integer NOT NULL,
    CONSTRAINT book_catalogue_pk PRIMARY KEY (isbn_no)
);

CREATE TABLE book_copies (
    isbn_no character varying(13) NOT NULL,
    accession_no character varying(20) NOT NULL,
    CONSTRAINT book_copies_pk PRIMARY KEY (accession_no),
    CONSTRAINT book_copies_fk0 FOREIGN KEY (isbn_no) REFERENCES book_catalogue(isbn_no)
);

CREATE TABLE book_issue (
    member_no character varying(20) NOT NULL,
    accession_no character varying(20) NOT NULL,
    doi date NOT NULL,
    CONSTRAINT book_issue_accession_no_key UNIQUE (accession_no),
    CONSTRAINT book_issue_pk PRIMARY KEY (member_no, accession_no),
    CONSTRAINT book_issue_fk0 FOREIGN KEY (member_no) REFERENCES members(member_no),
    CONSTRAINT book_issue_fk1 FOREIGN KEY (accession_no) REFERENCES book_copies(accession_no)
);

CREATE TABLE departments (
    department_code character varying(80) NOT NULL,
    department_name character varying(80),
    department_building character varying(80),
    CONSTRAINT departments_pkey PRIMARY KEY (department_code)
);

CREATE TABLE faculty (
    faculty_fname character varying(80) NOT NULL,
    faculty_lname character varying(80) NOT NULL,
    id character varying(20) NOT NULL,
    department_code character varying(80) NOT NULL,
    gender character varying(1) NOT NULL,
    mobile_no numeric(10,0) NOT NULL,
    doj date NOT NULL,
    CONSTRAINT faculty_pk PRIMARY KEY (id),
    CONSTRAINT faculty_fk2 FOREIGN KEY (department_code) REFERENCES departments(department_code)
);

CREATE TABLE members (
    member_no character varying(20) NOT NULL,
    member_class character varying(20) NOT NULL,
    member_type character varying(2) NOT NULL,
    roll_no character varying(20),
    id character varying(20),
    CONSTRAINT members_pk PRIMARY KEY (member_no),
    CONSTRAINT members_fk0 FOREIGN KEY (member_type) REFERENCES quota(member_type),
    CONSTRAINT members_fk1 FOREIGN KEY (roll_no) REFERENCES students(roll_no),
    CONSTRAINT members_fk2 FOREIGN KEY (id) REFERENCES faculty(id)
);

CREATE TABLE quota (
    member_type character varying(2) NOT NULL,
    max_books integer NOT NULL,
    max_duration integer NOT NULL,
    CONSTRAINT quota_pk PRIMARY KEY (member_type)
);

CREATE TABLE staff (
    staff_fname character varying(80) NOT NULL,
    staff_lname character varying(80) NOT NULL,
    id character varying(20) NOT NULL,
    gender character varying(1) NOT NULL,
    mobile_no numeric(10,0) NOT NULL,
    doj date NOT NULL,
    CONSTRAINT staff_pk PRIMARY KEY (id)
);

CREATE TABLE students (
    student_fname character varying(80) NOT NULL,
    student_lname character varying(80) NOT NULL,
    roll_no character varying(20) NOT NULL,
    department_code character varying(80) NOT NULL,
    gender character varying(1) NOT NULL,
    mobile_no numeric(10,0) NOT NULL,
    dob date NOT NULL,
    degree character varying(80) NOT NULL,
    CONSTRAINT students_pk PRIMARY KEY (roll_no),
    CONSTRAINT faculty_fk2 FOREIGN KEY (department_code) REFERENCES departments(department_code)
);
