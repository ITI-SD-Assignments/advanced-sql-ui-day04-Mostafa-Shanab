--
-- PostgreSQL database dump
--

\restrict PzZtosotQN9tuBmTQCdHbCeDwZ1RgpJYWc7q8gblWS66sy2krgjhajp6ZqHoKIh

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
-- Data for Name: faculties; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.faculties (faculty_id, faculty_name, dean, building, budget, established) FROM stdin;
1	Faculty of Engineering	Dr. Tarek Mansour	A	15000000.00	1952-09-01
2	Faculty of Computer Science	Dr. Mona Sherif	B	12000000.00	1990-01-15
3	Faculty of Business	Dr. Hisham Farouk	C	9500000.00	1965-03-20
4	Faculty of Science	Dr. Nadia Saleh	D	11000000.00	1950-06-10
5	Faculty of Arts	Dr. Layla Ibrahim	E	6000000.00	1948-10-05
6	Faculty of Law	Dr. Hany Aziz	G	8000000.00	\N
\.


--
-- Data for Name: departments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.departments (dept_id, dept_name, faculty_id, head_name, location, phone) FROM stdin;
1	Computer Engineering	1	Dr. Sameh Adel	Cairo	0221001100
2	Electronics	1	Dr. Rania Fouad	Cairo	0221001101
3	Computer Science	2	Dr. Khaled Nour	Giza	0221002200
4	Information Systems	2	Dr. Dina Hassan	Giza	0221002201
5	Business Administration	3	Dr. Omar Saad	Alexandria	0221003300
6	Accounting	3	Dr. Sara Magdy	Alexandria	0221003301
7	Mathematics	4	Dr. Youssef Ali	Cairo	0221004400
8	Physics	4	Dr. Hana Mostafa	Cairo	0221004401
9	Arabic Literature	5	Dr. Faten Wagdy	Luxor	0221005500
10	History	5	Dr. Amr Galal	Luxor	0221005501
\.


--
-- Data for Name: courses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.courses (course_id, course_code, course_name, dept_id, credit_hours, level, max_students, is_active, description) FROM stdin;
1	CS101	Introduction to Programming	3	3	1	50	t	Python basics, variables, loops, functions
2	CS201	Data Structures	3	3	2	40	t	Arrays, linked lists, stacks, queues, trees
3	CS301	Database Systems	3	3	3	35	t	Relational databases, SQL, normalization
4	CS401	Software Engineering	3	3	4	30	t	SDLC, UML, design patterns, testing
5	CE101	Circuit Analysis	1	3	1	45	t	Kirchhoff laws, resistors, capacitors
6	CE201	Digital Logic	1	3	2	40	t	Boolean algebra, gates, flip-flops
7	CE301	Computer Architecture	1	3	3	35	t	CPU design, memory hierarchy, pipelines
8	IS201	Systems Analysis	4	3	2	40	t	Requirements, modeling, feasibility
9	IS301	IT Project Management	4	3	3	30	t	Planning, tracking, Agile, Scrum
10	BA101	Principles of Management	5	3	1	60	t	Management functions, leadership, motivation
11	BA201	Marketing Fundamentals	5	3	2	50	t	Market analysis, 4Ps, consumer behavior
12	ACC101	Financial Accounting	6	3	1	55	t	Journal entries, ledger, trial balance
13	ACC201	Cost Accounting	6	3	2	40	t	Job costing, process costing, variance
14	MATH101	Calculus I	7	4	1	70	t	Limits, derivatives, integrals
15	MATH201	Linear Algebra	7	3	2	55	t	Vectors, matrices, eigenvalues
16	PHY101	Physics I	8	3	1	65	t	Mechanics, kinematics, energy
17	PHY201	Electromagnetism	8	3	2	50	t	Electric fields, magnetic fields, waves
18	EL201	Electronics I	2	3	2	40	t	Diodes, BJTs, amplifier basics
19	EL301	Signal Processing	2	3	3	35	t	Fourier, Laplace, Z-transforms
20	ARAB101	Arabic Language	9	2	1	80	t	Grammar, writing, literature basics
\.


--
-- Data for Name: enrollment_audit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.enrollment_audit (audit_id, student_id, old_grade, new_grade, changed_at, changed_by) FROM stdin;
1	1	92.00	90.00	2026-03-26 15:35:52.816909	postgres
\.


--
-- Data for Name: students; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.students (student_id, first_name, last_name, email, phone, birthdate, gender, nationality, dept_id, enroll_date, gpa, is_active, address, metadata, created_at) FROM stdin;
2	Nour	Ibrahim	nour.ibrahim@student.edu	01002222222	2003-07-22	Female	Egyptian	3	2022-09-01	3.60	t	Giza, Dokki	\N	2026-03-23 14:35:21.091795+02
3	Omar	Farouk	omar.farouk@student.edu	01003333333	2001-11-05	Male	Egyptian	1	2020-09-01	2.90	t	Alexandria	\N	2026-03-23 14:35:21.091795+02
4	Sara	Magdy	sara.magdy@student.edu	01004444444	2002-01-18	Female	Egyptian	4	2021-09-01	3.20	t	Cairo, Maadi	\N	2026-03-23 14:35:21.091795+02
5	Khaled	Nasser	khaled.nasser@student.edu	01005555555	2003-05-30	Male	Egyptian	2	2022-09-01	3.50	t	Cairo, Heliopolis	\N	2026-03-23 14:35:21.091795+02
6	Mona	Sherif	mona.sherif@student.edu	01006666666	2001-09-14	Female	Egyptian	5	2020-09-01	3.10	t	Alexandria	\N	2026-03-23 14:35:21.091795+02
9	Hassan	Gamal	hassan.gamal@student.edu	01009999999	2001-08-17	Male	Egyptian	7	2020-09-01	3.40	f	Cairo, Shubra	\N	2026-03-23 14:35:21.091795+02
10	Dina	Kamal	dina.kamal@student.edu	01011111111	2002-06-08	Female	Egyptian	8	2021-09-01	2.50	t	Giza, Mohandessin	\N	2026-03-23 14:35:21.091795+02
11	Amr	Sayed	amr.sayed@student.edu	01012222222	2003-02-14	Male	Egyptian	3	2022-09-01	3.70	t	Cairo, Helwan	\N	2026-03-23 14:35:21.091795+02
12	Heba	Fawzy	heba.fawzy@student.edu	01013333333	2001-10-29	Female	Egyptian	1	2020-09-01	3.00	t	Alexandria	\N	2026-03-23 14:35:21.091795+02
13	Tarek	Mansour	tarek.mansour@student.edu	01014444444	2002-07-11	Male	Egyptian	4	2021-09-01	2.20	f	Cairo, Nasr City	\N	2026-03-23 14:35:21.091795+02
14	Rana	Wahba	rana.wahba@student.edu	01015555555	2003-03-19	Female	Saudi	5	2022-09-01	3.85	t	Giza, Dokki	\N	2026-03-23 14:35:21.091795+02
15	Mahmoud	Saber	mahmoud.saber@student.edu	01016666666	2001-12-01	Male	Egyptian	2	2020-09-01	3.15	t	Cairo, Maadi	\N	2026-03-23 14:35:21.091795+02
16	Yasmin	Helmy	yasmin.helmy@student.edu	01017777777	2002-09-06	Female	Egyptian	6	2021-09-01	3.55	t	Alexandria	\N	2026-03-23 14:35:21.091795+02
17	Karim	Anwar	karim.anwar@student.edu	01018888888	2003-01-23	Male	Egyptian	3	2022-09-01	2.95	t	Cairo, Heliopolis	\N	2026-03-23 14:35:21.091795+02
18	Reem	Fathy	reem.fathy@student.edu	01019999999	2001-05-16	Female	Egyptian	7	2020-09-01	3.25	t	Giza, 6th October	\N	2026-03-23 14:35:21.091795+02
19	Ziad	Lotfy	ziad.lotfy@student.edu	01021111111	2002-11-28	Male	Lebanese	1	2021-09-01	3.65	t	Cairo, Zamalek	\N	2026-03-23 14:35:21.091795+02
20	Nada	Wagdy	nada.wagdy@student.edu	01022222222	2003-08-09	Female	Egyptian	8	2022-09-01	2.80	t	Cairo, Shubra	\N	2026-03-23 14:35:21.091795+02
21	Sherif	Badr	sherif.badr@student.edu	01023333333	2001-04-02	Male	Egyptian	5	2020-09-01	3.45	t	Giza, Mohandessin	\N	2026-03-23 14:35:21.091795+02
22	Mariam	Sobhi	mariam.sobhi@student.edu	01024444444	2002-02-20	Female	Egyptian	4	2021-09-01	3.05	t	Alexandria	\N	2026-03-23 14:35:21.091795+02
23	Fares	Zaki	fares.zaki@student.edu	01025555555	2003-06-15	Male	Egyptian	6	2022-09-01	2.60	t	Cairo, Nasr City	\N	2026-03-23 14:35:21.091795+02
24	Salma	Nabil	salma.nabil@student.edu	01026666666	2001-01-07	Female	Egyptian	3	2020-09-01	3.75	t	Giza, Dokki	\N	2026-03-23 14:35:21.091795+02
25	Adam	Youssef	adam.youssef@student.edu	01027777777	2002-10-13	Male	Egyptian	2	2021-09-01	3.30	t	Cairo, Maadi	\N	2026-03-23 14:35:21.091795+02
26	Hana	Samir	hana.samir@student.edu	01028888888	2003-04-01	Female	Egyptian	7	2022-09-01	2.40	f	Alexandria	\N	2026-03-23 14:35:21.091795+02
27	Bassem	Ramzy	bassem.ramzy@student.edu	01029999999	2001-07-25	Male	Egyptian	1	2020-09-01	3.10	t	Cairo, Heliopolis	\N	2026-03-23 14:35:21.091795+02
29	Mostafa	Gamal	mostafa.gamal@student.edu	01032222222	2003-09-04	Male	Egyptian	6	2022-09-01	2.85	t	Cairo, Zamalek	\N	2026-03-23 14:35:21.091795+02
30	Farah	Essam	farah.essam@student.edu	01033333333	2001-03-28	Female	Syrian	3	2020-09-01	3.55	t	Cairo, Shubra	\N	2026-03-23 14:35:21.091795+02
8	Layla	Mostafa	layla.mostafa@student.edu	01008888888	2003-04-25	Female	Egyptian	6	2022-09-01	3.90	t	Cairo, Zamalek	{"laptop": true, "hobbies": ["painting", "music"], "languages": ["Arabic", "English", "French"], "extra_activities": "Drama Club"}	2026-03-23 14:35:21.091795+02
7	Youssef	Ali	youssef.ali@student.edu	01007777777	2002-12-03	Male	Jordanian	3	2021-09-01	2.75	t	Giza, 6th October	{"laptop": false, "hobbies": ["sports", "gaming"], "languages": ["Arabic", "English"]}	2026-03-23 14:35:21.091795+02
28	Nadia	Selim	nadia.selim@student.edu	01031111111	2002-05-17	Female	Egyptian	5	2021-09-01	3.95	t	Giza, 6th October	{"laptop": true, "hobbies": ["reading", "volunteering"], "languages": ["Arabic", "English", "German"], "extra_activities": "Research Assistant"}	2026-03-23 14:35:21.091795+02
1	Ahmed	Hassan	ahmed.hassan@student.edu	01001111111	2002-03-10	Male	Egyptian	3	2021-09-01	3.80	t	Cairo, Nasr City	{"laptop": true, "hobbies": ["chess", "reading", "coding"], "languages": ["Arabic", "English"], "extra_activities": "Student Union President"}	2026-03-23 14:35:21.091795+02
31	Mostafa	Shanab	mostafa.shanab@student.edu	\N	\N	\N	Egyptian	\N	2026-03-26	\N	t	\N	\N	2026-03-26 15:28:42.009722+02
33	Test	User	test_readonly@student.edu	\N	\N	\N	Egyptian	\N	2026-03-26	\N	t	\N	\N	2026-03-26 15:55:23.545688+02
\.


--
-- Data for Name: enrollments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.enrollments (enrollment_id, student_id, course_id, semester, year, grade, letter_grade, enrolled_at) FROM stdin;
2	1	2	Spring	2022	87.00	B+	2026-03-23 14:35:21.121451+02
4	1	14	Fall	2021	78.00	B	2026-03-23 14:35:21.121451+02
5	2	1	Fall	2022	88.00	B+	2026-03-23 14:35:21.121451+02
6	2	2	Spring	2023	91.00	A	2026-03-23 14:35:21.121451+02
7	2	14	Fall	2022	85.00	B+	2026-03-23 14:35:21.121451+02
8	3	5	Fall	2020	72.00	C+	2026-03-23 14:35:21.121451+02
9	3	6	Spring	2021	68.00	C	2026-03-23 14:35:21.121451+02
10	3	14	Fall	2020	81.00	B	2026-03-23 14:35:21.121451+02
11	3	16	Fall	2020	76.00	B-	2026-03-23 14:35:21.121451+02
12	4	8	Fall	2021	83.00	B	2026-03-23 14:35:21.121451+02
13	4	9	Spring	2022	79.00	B-	2026-03-23 14:35:21.121451+02
14	4	14	Fall	2021	90.00	A-	2026-03-23 14:35:21.121451+02
15	5	18	Fall	2022	86.00	B+	2026-03-23 14:35:21.121451+02
16	5	16	Fall	2022	80.00	B	2026-03-23 14:35:21.121451+02
17	5	17	Spring	2023	74.00	C+	2026-03-23 14:35:21.121451+02
18	6	10	Fall	2020	77.00	B-	2026-03-23 14:35:21.121451+02
19	6	11	Spring	2021	82.00	B	2026-03-23 14:35:21.121451+02
20	6	12	Fall	2020	88.00	B+	2026-03-23 14:35:21.121451+02
21	7	1	Fall	2021	65.00	C	2026-03-23 14:35:21.121451+02
22	7	2	Spring	2022	71.00	C+	2026-03-23 14:35:21.121451+02
23	7	14	Fall	2021	69.00	C	2026-03-23 14:35:21.121451+02
24	8	12	Fall	2022	96.00	A+	2026-03-23 14:35:21.121451+02
25	8	13	Spring	2023	93.00	A	2026-03-23 14:35:21.121451+02
26	9	14	Fall	2020	55.00	D+	2026-03-23 14:35:21.121451+02
27	9	15	Spring	2021	60.00	D+	2026-03-23 14:35:21.121451+02
28	10	16	Fall	2021	63.00	C-	2026-03-23 14:35:21.121451+02
29	10	17	Spring	2022	58.00	D+	2026-03-23 14:35:21.121451+02
30	11	1	Fall	2022	94.00	A	2026-03-23 14:35:21.121451+02
31	11	2	Spring	2023	89.00	B+	2026-03-23 14:35:21.121451+02
32	11	3	Fall	2023	91.00	A	2026-03-23 14:35:21.121451+02
33	12	5	Fall	2020	84.00	B	2026-03-23 14:35:21.121451+02
34	12	6	Spring	2021	79.00	B-	2026-03-23 14:35:21.121451+02
35	12	7	Fall	2021	77.00	B-	2026-03-23 14:35:21.121451+02
36	14	10	Fall	2022	97.00	A+	2026-03-23 14:35:21.121451+02
37	14	11	Spring	2023	94.00	A	2026-03-23 14:35:21.121451+02
38	15	18	Fall	2020	73.00	C+	2026-03-23 14:35:21.121451+02
39	15	19	Spring	2021	68.00	C	2026-03-23 14:35:21.121451+02
40	16	12	Fall	2021	89.00	B+	2026-03-23 14:35:21.121451+02
41	16	13	Spring	2022	85.00	B+	2026-03-23 14:35:21.121451+02
42	17	1	Fall	2022	78.00	B	2026-03-23 14:35:21.121451+02
43	17	2	Spring	2023	75.00	B-	2026-03-23 14:35:21.121451+02
44	19	5	Fall	2021	90.00	A-	2026-03-23 14:35:21.121451+02
45	19	6	Spring	2022	88.00	B+	2026-03-23 14:35:21.121451+02
46	19	7	Fall	2022	85.00	B+	2026-03-23 14:35:21.121451+02
47	20	16	Fall	2022	70.00	C+	2026-03-23 14:35:21.121451+02
48	20	17	Spring	2023	66.00	C	2026-03-23 14:35:21.121451+02
49	21	10	Fall	2020	80.00	B	2026-03-23 14:35:21.121451+02
50	21	11	Spring	2021	76.00	B-	2026-03-23 14:35:21.121451+02
51	24	1	Fall	2020	91.00	A	2026-03-23 14:35:21.121451+02
52	24	2	Spring	2021	93.00	A	2026-03-23 14:35:21.121451+02
53	24	3	Fall	2021	88.00	B+	2026-03-23 14:35:21.121451+02
54	28	10	Fall	2021	99.00	A+	2026-03-23 14:35:21.121451+02
55	28	11	Spring	2022	96.00	A+	2026-03-23 14:35:21.121451+02
56	30	1	Fall	2020	87.00	B+	2026-03-23 14:35:21.121451+02
57	30	2	Spring	2021	90.00	A-	2026-03-23 14:35:21.121451+02
58	30	3	Fall	2021	94.00	A	2026-03-23 14:35:21.121451+02
3	1	3	Fall	2022	98.00	A+	2026-03-23 14:35:21.121451+02
1	1	1	Fall	2021	90.00	A	2026-03-23 14:35:21.121451+02
\.


--
-- Data for Name: professors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.professors (prof_id, first_name, last_name, email, title, dept_id, hire_date, salary, is_active, manager_id, metadata, created_at) FROM stdin;
2	Rania	Fouad	rania.fouad@uni.edu	Associate Professor	2	2008-03-15	23000.00	t	1	\N	2026-03-23 14:35:21.08112+02
4	Dina	Hassan	dina.hassan@uni.edu	Asst. Professor	4	2015-08-20	18000.00	t	3	\N	2026-03-23 14:35:21.08112+02
5	Omar	Saad	omar.saad@uni.edu	Professor	5	2001-02-01	32000.00	t	\N	\N	2026-03-23 14:35:21.08112+02
6	Sara	Magdy	sara.magdy@uni.edu	Associate Professor	6	2010-07-01	24000.00	t	5	\N	2026-03-23 14:35:21.08112+02
7	Youssef	Ali	youssef.ali@uni.edu	Professor	7	2000-09-01	29000.00	t	\N	\N	2026-03-23 14:35:21.08112+02
8	Hana	Mostafa	hana.mostafa@uni.edu	Lecturer	8	2019-01-15	14000.00	t	7	\N	2026-03-23 14:35:21.08112+02
9	Faten	Wagdy	faten.wagdy@uni.edu	Associate Professor	9	2007-04-01	22000.00	t	\N	\N	2026-03-23 14:35:21.08112+02
10	Amr	Galal	amr.galal@uni.edu	Asst. Professor	10	2016-09-01	17000.00	t	9	\N	2026-03-23 14:35:21.08112+02
13	Maha	Lotfy	maha.lotfy@uni.edu	Lecturer	5	2022-09-01	12000.00	t	5	\N	2026-03-23 14:35:21.08112+02
14	Tarek	Sobhi	tarek.sobhi@uni.edu	Associate Professor	2	2012-03-01	25000.00	t	2	\N	2026-03-23 14:35:21.08112+02
15	Eman	Farid	eman.farid@uni.edu	Lecturer	4	2020-08-01	13500.00	t	4	\N	2026-03-23 14:35:21.08112+02
3	Khaled	Nour	khaled.nour@uni.edu	Professor	3	2003-01-10	34500.00	t	\N	\N	2026-03-23 14:35:21.08112+02
11	Nour	Samy	nour.samy@uni.edu	Lecturer	3	2021-02-01	14950.00	t	3	\N	2026-03-23 14:35:21.08112+02
1	Sameh	Adel	sameh.adel@uni.edu	Professor	1	2005-09-01	30800.00	t	\N	\N	2026-03-23 14:35:21.08112+02
12	Karim	Zaki	karim.zaki@uni.edu	Asst. Professor	1	2018-06-15	20900.00	t	1	\N	2026-03-23 14:35:21.08112+02
16	Test	Prof	test@uni.edu	\N	1	\N	5500.00	t	\N	\N	2026-03-26 15:38:17.176541+02
\.


--
-- Data for Name: salary_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.salary_log (log_id, prof_id, old_salary, new_salary, changed_by, changed_at) FROM stdin;
1	1	28000.000000000000	30800.00	postgres	2026-03-26 15:43:30.969255+02
2	12	19000.000000000000	20900.00	postgres	2026-03-26 15:43:30.969255+02
3	16	5000.0000000000000000	5500.00	postgres	2026-03-26 15:43:30.969255+02
\.


--
-- Data for Name: scholarships; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scholarships (scholarship_id, student_id, amount, type, start_date, end_date, notes) FROM stdin;
1	1	5000.00	Merit	2022-09-01	2023-08-31	Top student in CS
2	8	8000.00	Merit	2022-09-01	2023-08-31	Highest GPA in Accounting
3	14	6000.00	Need-Based	2022-09-01	2023-08-31	Financial support
4	28	10000.00	Merit	2022-09-01	2023-08-31	National honor student
5	24	4000.00	Merit	2021-09-01	2022-08-31	Excellence award
6	11	3000.00	Need-Based	2023-09-01	2024-08-31	Partial support
7	7	5000.00	International	2021-09-01	2022-08-31	International student support
\.


--
-- Data for Name: teaches; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.teaches (teach_id, prof_id, course_id, semester, year, room, schedule) FROM stdin;
1	3	1	Fall	2021	B-101	Sun/Tue 10:00-11:30
2	3	1	Fall	2022	B-101	Sun/Tue 10:00-11:30
3	3	2	Spring	2022	B-102	Mon/Wed 12:00-13:30
4	3	2	Spring	2023	B-102	Mon/Wed 12:00-13:30
5	11	3	Fall	2022	B-201	Tue/Thu 09:00-10:30
6	11	3	Fall	2023	B-201	Tue/Thu 09:00-10:30
7	4	8	Fall	2021	B-301	Wed/Sat 11:00-12:30
8	4	9	Spring	2022	B-302	Sun/Tue 14:00-15:30
9	1	5	Fall	2020	A-101	Mon/Wed 08:00-09:30
10	1	5	Fall	2021	A-101	Mon/Wed 08:00-09:30
11	12	6	Spring	2021	A-102	Tue/Thu 10:00-11:30
12	12	6	Spring	2022	A-102	Tue/Thu 10:00-11:30
13	1	7	Fall	2021	A-201	Sun/Tue 13:00-14:30
14	5	10	Fall	2020	C-101	Mon/Wed 09:00-10:30
15	5	10	Fall	2021	C-101	Mon/Wed 09:00-10:30
16	5	10	Fall	2022	C-101	Mon/Wed 09:00-10:30
17	13	11	Spring	2021	C-102	Sun/Tue 11:00-12:30
18	6	12	Fall	2020	C-201	Wed/Sat 10:00-11:30
19	6	12	Fall	2021	C-201	Wed/Sat 10:00-11:30
20	7	14	Fall	2020	D-101	Sun/Mon/Tue 09:00-10:00
21	7	14	Fall	2021	D-101	Sun/Mon/Tue 09:00-10:00
22	7	14	Fall	2022	D-101	Sun/Mon/Tue 09:00-10:00
23	7	15	Spring	2021	D-102	Mon/Wed 11:00-12:30
24	8	16	Fall	2020	D-201	Tue/Thu 08:00-09:30
25	8	16	Fall	2021	D-201	Tue/Thu 08:00-09:30
26	8	16	Fall	2022	D-201	Tue/Thu 08:00-09:30
27	14	18	Fall	2022	A-301	Wed/Sat 13:00-14:30
28	2	19	Spring	2021	A-302	Mon/Wed 15:00-16:30
\.


--
-- Name: courses_course_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.courses_course_id_seq', 20, true);


--
-- Name: departments_dept_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.departments_dept_id_seq', 10, true);


--
-- Name: enrollment_audit_audit_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.enrollment_audit_audit_id_seq', 1, true);


--
-- Name: enrollments_enrollment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.enrollments_enrollment_id_seq', 58, true);


--
-- Name: faculties_faculty_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.faculties_faculty_id_seq', 6, true);


--
-- Name: professors_prof_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.professors_prof_id_seq', 16, true);


--
-- Name: salary_log_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.salary_log_log_id_seq', 9, true);


--
-- Name: scholarships_scholarship_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.scholarships_scholarship_id_seq', 7, true);


--
-- Name: students_student_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.students_student_id_seq', 33, true);


--
-- Name: teaches_teach_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.teaches_teach_id_seq', 28, true);


--
-- PostgreSQL database dump complete
--

\unrestrict PzZtosotQN9tuBmTQCdHbCeDwZ1RgpJYWc7q8gblWS66sy2krgjhajp6ZqHoKIh

