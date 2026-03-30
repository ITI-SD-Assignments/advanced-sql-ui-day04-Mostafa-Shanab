--
-- PostgreSQL database dump
--

\restrict bjtnqttVyXCHY8at1IfNv1eKNGU3Wwu7gumpB1cShuuESZvLRwalU08HBko2gQ4

-- Dumped from database version 18.3
-- Dumped by pg_dump version 18.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: fix_salary(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fix_salary() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW.salary IS NULL OR NEW.salary < 5000 THEN
        NEW.salary := 5000;
    END IF;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.fix_salary() OWNER TO postgres;

--
-- Name: get_dept_student_count(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_dept_student_count(dept_id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN (
        SELECT COUNT(*) 
        FROM students 
        WHERE students.dept_id = get_dept_student_count.dept_id
    );
END;
$$;


ALTER FUNCTION public.get_dept_student_count(dept_id integer) OWNER TO postgres;

--
-- Name: give_gpa_bonus(integer, numeric); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.give_gpa_bonus(dept_id integer, bonus_percent numeric) RETURNS TABLE(student_name text, old_gpa numeric, new_gpa numeric)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        first_name || ' ' || last_name,
        gpa,
        gpa + (gpa * bonus_percent / 100)
    FROM students
    WHERE students.dept_id = give_gpa_bonus.dept_id;
END;
$$;


ALTER FUNCTION public.give_gpa_bonus(dept_id integer, bonus_percent numeric) OWNER TO postgres;

--
-- Name: log_grade_change(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.log_grade_change() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW.grade IS DISTINCT FROM OLD.grade THEN
        INSERT INTO enrollment_audit(student_id, old_grade, new_grade, changed_by)
        VALUES (OLD.student_id, OLD.grade, NEW.grade, current_user);
    END IF;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.log_grade_change() OWNER TO postgres;

--
-- Name: transfer_student(integer, integer); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.transfer_student(IN student_id integer, IN new_dept_id integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE students
    SET dept_id = new_dept_id
    WHERE students.student_id = transfer_student.student_id;

    RAISE NOTICE 'Student % transferred to department %', student_id, new_dept_id;
END;
$$;


ALTER PROCEDURE public.transfer_student(IN student_id integer, IN new_dept_id integer) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: courses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.courses (
    course_id integer NOT NULL,
    course_code character varying(10) NOT NULL,
    course_name character varying(150) NOT NULL,
    dept_id integer,
    credit_hours integer,
    level integer,
    max_students integer DEFAULT 40,
    is_active boolean DEFAULT true,
    description text,
    CONSTRAINT courses_credit_hours_check CHECK (((credit_hours >= 1) AND (credit_hours <= 6))),
    CONSTRAINT courses_level_check CHECK ((level = ANY (ARRAY[1, 2, 3, 4])))
);


ALTER TABLE public.courses OWNER TO postgres;

--
-- Name: courses_course_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.courses_course_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.courses_course_id_seq OWNER TO postgres;

--
-- Name: courses_course_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.courses_course_id_seq OWNED BY public.courses.course_id;


--
-- Name: departments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.departments (
    dept_id integer NOT NULL,
    dept_name character varying(100) NOT NULL,
    faculty_id integer,
    head_name character varying(100),
    location character varying(100),
    phone character varying(20)
);


ALTER TABLE public.departments OWNER TO postgres;

--
-- Name: departments_dept_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.departments_dept_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.departments_dept_id_seq OWNER TO postgres;

--
-- Name: departments_dept_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.departments_dept_id_seq OWNED BY public.departments.dept_id;


--
-- Name: enrollment_audit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.enrollment_audit (
    audit_id integer NOT NULL,
    student_id integer,
    old_grade numeric,
    new_grade numeric,
    changed_at timestamp without time zone DEFAULT now(),
    changed_by text
);


ALTER TABLE public.enrollment_audit OWNER TO postgres;

--
-- Name: enrollment_audit_audit_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.enrollment_audit_audit_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.enrollment_audit_audit_id_seq OWNER TO postgres;

--
-- Name: enrollment_audit_audit_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.enrollment_audit_audit_id_seq OWNED BY public.enrollment_audit.audit_id;


--
-- Name: enrollments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.enrollments (
    enrollment_id integer NOT NULL,
    student_id integer,
    course_id integer,
    semester character varying(20) NOT NULL,
    year integer NOT NULL,
    grade numeric(4,2),
    letter_grade character varying(2),
    enrolled_at timestamp with time zone DEFAULT now(),
    CONSTRAINT enrollments_grade_check CHECK (((grade >= (0)::numeric) AND (grade <= (100)::numeric)))
);


ALTER TABLE public.enrollments OWNER TO postgres;

--
-- Name: enrollments_enrollment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.enrollments_enrollment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.enrollments_enrollment_id_seq OWNER TO postgres;

--
-- Name: enrollments_enrollment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.enrollments_enrollment_id_seq OWNED BY public.enrollments.enrollment_id;


--
-- Name: faculties; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.faculties (
    faculty_id integer NOT NULL,
    faculty_name character varying(100) NOT NULL,
    dean character varying(100),
    building character varying(50),
    budget numeric(15,2),
    established date
);


ALTER TABLE public.faculties OWNER TO postgres;

--
-- Name: faculties_faculty_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.faculties_faculty_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.faculties_faculty_id_seq OWNER TO postgres;

--
-- Name: faculties_faculty_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.faculties_faculty_id_seq OWNED BY public.faculties.faculty_id;


--
-- Name: professors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.professors (
    prof_id integer NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    email character varying(150) NOT NULL,
    title character varying(30),
    dept_id integer,
    hire_date date,
    salary numeric(10,2),
    is_active boolean DEFAULT true,
    manager_id integer,
    metadata jsonb,
    created_at timestamp with time zone DEFAULT now(),
    CONSTRAINT professors_title_check CHECK (((title)::text = ANY ((ARRAY['Lecturer'::character varying, 'Asst. Professor'::character varying, 'Associate Professor'::character varying, 'Professor'::character varying])::text[]))),
    CONSTRAINT salary_check CHECK (((salary >= (5000)::numeric) AND (salary <= (100000)::numeric)))
);


ALTER TABLE public.professors OWNER TO postgres;

--
-- Name: professors_prof_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.professors_prof_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.professors_prof_id_seq OWNER TO postgres;

--
-- Name: professors_prof_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.professors_prof_id_seq OWNED BY public.professors.prof_id;


--
-- Name: salary_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.salary_log (
    log_id integer NOT NULL,
    prof_id integer,
    old_salary numeric,
    new_salary numeric,
    changed_by text DEFAULT CURRENT_USER,
    changed_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.salary_log OWNER TO postgres;

--
-- Name: salary_log_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.salary_log_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.salary_log_log_id_seq OWNER TO postgres;

--
-- Name: salary_log_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.salary_log_log_id_seq OWNED BY public.salary_log.log_id;


--
-- Name: scholarships; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scholarships (
    scholarship_id integer NOT NULL,
    student_id integer,
    amount numeric(10,2),
    type character varying(50),
    start_date date,
    end_date date,
    notes text
);


ALTER TABLE public.scholarships OWNER TO postgres;

--
-- Name: scholarships_scholarship_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.scholarships_scholarship_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.scholarships_scholarship_id_seq OWNER TO postgres;

--
-- Name: scholarships_scholarship_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.scholarships_scholarship_id_seq OWNED BY public.scholarships.scholarship_id;


--
-- Name: students; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.students (
    student_id integer NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    email character varying(150) NOT NULL,
    phone character varying(20),
    birthdate date,
    gender character varying(10),
    nationality character varying(50) DEFAULT 'Egyptian'::character varying,
    dept_id integer,
    enroll_date date DEFAULT CURRENT_DATE NOT NULL,
    gpa numeric(3,2),
    is_active boolean DEFAULT true,
    address text,
    metadata jsonb,
    created_at timestamp with time zone DEFAULT now(),
    CONSTRAINT students_gender_check CHECK (((gender)::text = ANY ((ARRAY['Male'::character varying, 'Female'::character varying])::text[]))),
    CONSTRAINT students_gpa_check CHECK (((gpa >= 0.0) AND (gpa <= 4.0)))
);


ALTER TABLE public.students OWNER TO postgres;

--
-- Name: students_student_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.students_student_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.students_student_id_seq OWNER TO postgres;

--
-- Name: students_student_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.students_student_id_seq OWNED BY public.students.student_id;


--
-- Name: teaches; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.teaches (
    teach_id integer NOT NULL,
    prof_id integer,
    course_id integer,
    semester character varying(20) NOT NULL,
    year integer NOT NULL,
    room character varying(20),
    schedule character varying(100)
);


ALTER TABLE public.teaches OWNER TO postgres;

--
-- Name: teaches_teach_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.teaches_teach_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.teaches_teach_id_seq OWNER TO postgres;

--
-- Name: teaches_teach_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.teaches_teach_id_seq OWNED BY public.teaches.teach_id;


--
-- Name: v_student_details; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v_student_details AS
 SELECT s.student_id,
    (((s.first_name)::text || ' '::text) || (s.last_name)::text) AS full_name,
    s.email,
    s.dept_id,
    s.gpa,
    d.dept_name,
    f.faculty_name
   FROM ((public.students s
     JOIN public.departments d ON ((s.dept_id = d.dept_id)))
     JOIN public.faculties f ON ((d.faculty_id = f.faculty_id)));


ALTER VIEW public.v_student_details OWNER TO postgres;

--
-- Name: courses course_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.courses ALTER COLUMN course_id SET DEFAULT nextval('public.courses_course_id_seq'::regclass);


--
-- Name: departments dept_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departments ALTER COLUMN dept_id SET DEFAULT nextval('public.departments_dept_id_seq'::regclass);


--
-- Name: enrollment_audit audit_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollment_audit ALTER COLUMN audit_id SET DEFAULT nextval('public.enrollment_audit_audit_id_seq'::regclass);


--
-- Name: enrollments enrollment_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollments ALTER COLUMN enrollment_id SET DEFAULT nextval('public.enrollments_enrollment_id_seq'::regclass);


--
-- Name: faculties faculty_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faculties ALTER COLUMN faculty_id SET DEFAULT nextval('public.faculties_faculty_id_seq'::regclass);


--
-- Name: professors prof_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.professors ALTER COLUMN prof_id SET DEFAULT nextval('public.professors_prof_id_seq'::regclass);


--
-- Name: salary_log log_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.salary_log ALTER COLUMN log_id SET DEFAULT nextval('public.salary_log_log_id_seq'::regclass);


--
-- Name: scholarships scholarship_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scholarships ALTER COLUMN scholarship_id SET DEFAULT nextval('public.scholarships_scholarship_id_seq'::regclass);


--
-- Name: students student_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.students ALTER COLUMN student_id SET DEFAULT nextval('public.students_student_id_seq'::regclass);


--
-- Name: teaches teach_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teaches ALTER COLUMN teach_id SET DEFAULT nextval('public.teaches_teach_id_seq'::regclass);


--
-- Name: courses courses_course_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.courses
    ADD CONSTRAINT courses_course_code_key UNIQUE (course_code);


--
-- Name: courses courses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.courses
    ADD CONSTRAINT courses_pkey PRIMARY KEY (course_id);


--
-- Name: departments departments_dept_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departments
    ADD CONSTRAINT departments_dept_name_key UNIQUE (dept_name);


--
-- Name: departments departments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departments
    ADD CONSTRAINT departments_pkey PRIMARY KEY (dept_id);


--
-- Name: enrollment_audit enrollment_audit_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollment_audit
    ADD CONSTRAINT enrollment_audit_pkey PRIMARY KEY (audit_id);


--
-- Name: enrollments enrollments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollments
    ADD CONSTRAINT enrollments_pkey PRIMARY KEY (enrollment_id);


--
-- Name: enrollments enrollments_student_id_course_id_semester_year_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollments
    ADD CONSTRAINT enrollments_student_id_course_id_semester_year_key UNIQUE (student_id, course_id, semester, year);


--
-- Name: faculties faculties_faculty_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faculties
    ADD CONSTRAINT faculties_faculty_name_key UNIQUE (faculty_name);


--
-- Name: faculties faculties_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faculties
    ADD CONSTRAINT faculties_pkey PRIMARY KEY (faculty_id);


--
-- Name: professors professors_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.professors
    ADD CONSTRAINT professors_email_key UNIQUE (email);


--
-- Name: professors professors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.professors
    ADD CONSTRAINT professors_pkey PRIMARY KEY (prof_id);


--
-- Name: salary_log salary_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.salary_log
    ADD CONSTRAINT salary_log_pkey PRIMARY KEY (log_id);


--
-- Name: scholarships scholarships_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scholarships
    ADD CONSTRAINT scholarships_pkey PRIMARY KEY (scholarship_id);


--
-- Name: students students_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_email_key UNIQUE (email);


--
-- Name: students students_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_pkey PRIMARY KEY (student_id);


--
-- Name: teaches teaches_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teaches
    ADD CONSTRAINT teaches_pkey PRIMARY KEY (teach_id);


--
-- Name: teaches teaches_prof_id_course_id_semester_year_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teaches
    ADD CONSTRAINT teaches_prof_id_course_id_semester_year_key UNIQUE (prof_id, course_id, semester, year);


--
-- Name: idx_students_dept_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_students_dept_id ON public.students USING btree (dept_id);


--
-- Name: idx_students_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_students_email ON public.students USING btree (email);


--
-- Name: professors trg_fix_salary; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_fix_salary BEFORE INSERT ON public.professors FOR EACH ROW EXECUTE FUNCTION public.fix_salary();


--
-- Name: enrollments trg_grade_update; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_grade_update BEFORE UPDATE ON public.enrollments FOR EACH ROW EXECUTE FUNCTION public.log_grade_change();


--
-- Name: courses courses_dept_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.courses
    ADD CONSTRAINT courses_dept_id_fkey FOREIGN KEY (dept_id) REFERENCES public.departments(dept_id);


--
-- Name: departments departments_faculty_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departments
    ADD CONSTRAINT departments_faculty_id_fkey FOREIGN KEY (faculty_id) REFERENCES public.faculties(faculty_id);


--
-- Name: enrollments enrollments_course_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollments
    ADD CONSTRAINT enrollments_course_id_fkey FOREIGN KEY (course_id) REFERENCES public.courses(course_id);


--
-- Name: enrollments enrollments_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enrollments
    ADD CONSTRAINT enrollments_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.students(student_id) ON DELETE CASCADE;


--
-- Name: professors professors_dept_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.professors
    ADD CONSTRAINT professors_dept_id_fkey FOREIGN KEY (dept_id) REFERENCES public.departments(dept_id);


--
-- Name: professors professors_manager_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.professors
    ADD CONSTRAINT professors_manager_id_fkey FOREIGN KEY (manager_id) REFERENCES public.professors(prof_id);


--
-- Name: scholarships scholarships_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scholarships
    ADD CONSTRAINT scholarships_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.students(student_id);


--
-- Name: students students_dept_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_dept_id_fkey FOREIGN KEY (dept_id) REFERENCES public.departments(dept_id);


--
-- Name: teaches teaches_course_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teaches
    ADD CONSTRAINT teaches_course_id_fkey FOREIGN KEY (course_id) REFERENCES public.courses(course_id);


--
-- Name: teaches teaches_prof_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teaches
    ADD CONSTRAINT teaches_prof_id_fkey FOREIGN KEY (prof_id) REFERENCES public.professors(prof_id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

GRANT USAGE ON SCHEMA public TO uni_readonly;
GRANT USAGE ON SCHEMA public TO uni_readwrite;


--
-- Name: TABLE courses; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.courses TO uni_readonly;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.courses TO uni_readwrite;


--
-- Name: TABLE departments; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.departments TO uni_readonly;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.departments TO uni_readwrite;


--
-- Name: TABLE enrollment_audit; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.enrollment_audit TO uni_readonly;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.enrollment_audit TO uni_readwrite;


--
-- Name: TABLE enrollments; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.enrollments TO uni_readonly;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.enrollments TO uni_readwrite;


--
-- Name: TABLE faculties; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.faculties TO uni_readonly;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.faculties TO uni_readwrite;


--
-- Name: TABLE professors; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.professors TO uni_readonly;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.professors TO uni_readwrite;


--
-- Name: TABLE salary_log; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.salary_log TO uni_readonly;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.salary_log TO uni_readwrite;


--
-- Name: TABLE scholarships; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.scholarships TO uni_readonly;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.scholarships TO uni_readwrite;


--
-- Name: TABLE students; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.students TO uni_readonly;


--
-- Name: TABLE teaches; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.teaches TO uni_readonly;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.teaches TO uni_readwrite;


--
-- Name: TABLE v_student_details; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.v_student_details TO uni_readonly;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.v_student_details TO uni_readwrite;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT SELECT ON TABLES TO uni_readonly;


--
-- PostgreSQL database dump complete
--

\unrestrict bjtnqttVyXCHY8at1IfNv1eKNGU3Wwu7gumpB1cShuuESZvLRwalU08HBko2gQ4

