-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               PostgreSQL 15.8, compiled by Visual C++ build 1940, 64-bit
-- Server OS:                    
-- HeidiSQL Version:             12.8.0.6908
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES  */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Dumping structure for table public.attendance
CREATE TABLE IF NOT EXISTS "attendance" (
	"id" SERIAL NOT NULL,
	"subject_class_schedule_id" INTEGER NULL DEFAULT NULL,
	"student_id" INTEGER NULL DEFAULT NULL,
	"create_date" TIMESTAMP NULL DEFAULT now(),
	"create_id" INTEGER NULL DEFAULT NULL,
	"update_date" TIMESTAMP NULL DEFAULT now(),
	"update_id" INTEGER NULL DEFAULT NULL,
	"is_deleted" BOOLEAN NULL DEFAULT false,
	PRIMARY KEY ("id")
);

-- Dumping data for table public.attendance: -1 rows
DELETE FROM "attendance";
/*!40000 ALTER TABLE "attendance" DISABLE KEYS */;
INSERT INTO "attendance" ("id", "subject_class_schedule_id", "student_id", "create_date", "create_id", "update_date", "update_id", "is_deleted") VALUES
	(1, 1, 1, '2024-08-27 17:08:51.391991', NULL, '2024-08-27 17:09:09.092801', 1, 'true'),
	(2, 1, 1, '2024-08-27 17:09:09.093305', NULL, '2024-08-27 17:09:53.058138', 1, 'true'),
	(3, 1, 1, '2024-08-27 17:09:53.060899', NULL, '2024-08-27 17:15:57.27233', 1, 'true'),
	(4, 1, 1, '2024-08-27 17:16:07.283065', NULL, '2024-08-27 17:30:09.486008', 1, 'true'),
	(5, 2, 1, '2024-08-27 17:30:02.201514', 1, '2024-08-29 18:28:21.281404', 1, 'true'),
	(6, 2, 1, '2024-08-29 18:28:21.285281', 1, '2024-08-29 18:28:21.285281', 1, 'false');
/*!40000 ALTER TABLE "attendance" ENABLE KEYS */;

-- Dumping structure for table public.course
CREATE TABLE IF NOT EXISTS "course" (
	"id" SERIAL NOT NULL,
	"course_code" VARCHAR NULL DEFAULT NULL,
	"course_name" VARCHAR NULL DEFAULT NULL,
	"duration" VARCHAR NULL DEFAULT NULL,
	"category" VARCHAR NULL DEFAULT NULL,
	"create_date" TIMESTAMP NOT NULL DEFAULT now(),
	"create_id" INTEGER NULL DEFAULT NULL,
	"update_date" TIMESTAMP NOT NULL DEFAULT now(),
	"update_id" INTEGER NULL DEFAULT NULL,
	"is_deleted" BOOLEAN NOT NULL DEFAULT false,
	PRIMARY KEY ("id")
);

-- Dumping data for table public.course: 4 rows
DELETE FROM "course";
/*!40000 ALTER TABLE "course" DISABLE KEYS */;
INSERT INTO "course" ("id", "course_code", "course_name", "duration", "category", "create_date", "create_id", "update_date", "update_id", "is_deleted") VALUES
	(1, 'IT00001', 'Computering', '2', 'IT', '2024-08-09 17:43:26.246592', 1, '2024-08-09 17:43:26.246592', 1, 'false'),
	(2, 'IT00002', 'Creative Media', '2', 'IT', '2024-08-09 17:43:26.246592', 1, '2024-08-09 17:43:26.246592', 1, 'false'),
	(3, 'IT00003', 'Cyber Security', '2', 'IT', '2024-08-09 17:43:26.246592', 1, '2024-08-09 17:43:26.246592', 1, 'false'),
	(4, 'IT00004', 'Data Science', '2', 'IT', '2024-08-09 17:43:26.246592', 1, '2024-08-09 17:43:26.246592', 1, 'false');
/*!40000 ALTER TABLE "course" ENABLE KEYS */;

-- Dumping structure for table public.course_subject
CREATE TABLE IF NOT EXISTS "course_subject" (
	"id" SERIAL NOT NULL,
	"course_id" INTEGER NULL DEFAULT NULL,
	"subject_id" INTEGER NULL DEFAULT NULL,
	"create_date" TIMESTAMP NOT NULL DEFAULT now(),
	"create_id" INTEGER NULL DEFAULT NULL,
	"update_date" TIMESTAMP NOT NULL DEFAULT now(),
	"update_id" INTEGER NULL DEFAULT NULL,
	"is_deleted" BOOLEAN NOT NULL DEFAULT false,
	PRIMARY KEY ("id")
);

-- Dumping data for table public.course_subject: 17 rows
DELETE FROM "course_subject";
/*!40000 ALTER TABLE "course_subject" DISABLE KEYS */;
INSERT INTO "course_subject" ("id", "course_id", "subject_id", "create_date", "create_id", "update_date", "update_id", "is_deleted") VALUES
	(1, 1, 2, '2024-08-09 17:50:25.785656', 1, '2024-08-09 17:50:25.785656', 1, 'false'),
	(2, 1, 3, '2024-08-09 17:50:29.654435', 1, '2024-08-09 17:50:29.654435', 1, 'false'),
	(3, 1, 4, '2024-09-02 12:40:02.36045', NULL, '2024-09-02 12:40:02.36045', NULL, 'false'),
	(4, 1, 5, '2024-09-02 12:40:02.36045', NULL, '2024-09-02 12:40:02.36045', NULL, 'false'),
	(5, 2, 3, '2024-09-02 12:40:02.36045', NULL, '2024-09-02 12:40:02.36045', NULL, 'false'),
	(7, 2, 5, '2024-09-02 12:40:02.36045', NULL, '2024-09-02 12:40:02.36045', NULL, 'false'),
	(8, 2, 6, '2024-09-02 12:40:02.36045', NULL, '2024-09-02 12:40:02.36045', NULL, 'false'),
	(6, 2, 4, '2024-09-02 12:40:02.36045', NULL, '2024-09-03 02:12:32.089115', NULL, 'false'),
	(10, 3, 2, '2024-09-03 02:17:34.26178', 1, '2024-09-03 02:18:46.554067', NULL, 'true'),
	(11, 3, 3, '2024-09-03 02:17:34.262186', 1, '2024-09-03 02:18:56.699977', NULL, 'true'),
	(14, 3, 3, '2024-09-03 02:19:16.273328', 1, '2024-09-03 02:19:16.273328', NULL, 'false'),
	(15, 3, 6, '2024-09-03 02:19:16.273716', 1, '2024-09-03 02:19:16.273716', NULL, 'false'),
	(12, 3, 4, '2024-09-03 02:17:34.262553', 1, '2024-09-03 02:20:41.608804', NULL, 'true'),
	(13, 3, 2, '2024-09-03 02:19:16.271703', 1, '2024-09-03 02:20:41.608804', NULL, 'true'),
	(16, 3, 7, '2024-09-03 02:21:05.042879', 1, '2024-09-03 02:21:05.042879', NULL, 'false'),
	(18, 4, 2, '2024-09-03 02:53:05.692133', 1, '2024-09-03 02:53:05.692133', NULL, 'false'),
	(17, 4, NULL, '2024-09-03 02:53:05.690532', 1, '2024-09-03 02:53:05.690532', NULL, 'true');
/*!40000 ALTER TABLE "course_subject" ENABLE KEYS */;

-- Dumping structure for table public.staff
CREATE TABLE IF NOT EXISTS "staff" (
	"id" SERIAL NOT NULL,
	"staff_no" VARCHAR NULL DEFAULT NULL,
	"surname" VARCHAR NULL DEFAULT NULL,
	"sex" VARCHAR NULL DEFAULT NULL,
	"tel" VARCHAR NULL DEFAULT NULL,
	"onboard_date" TIMESTAMP NULL DEFAULT NULL,
	"last_date" TIMESTAMP NULL DEFAULT NULL,
	"create_date" TIMESTAMP NOT NULL DEFAULT now(),
	"create_id" INTEGER NULL DEFAULT NULL,
	"update_date" TIMESTAMP NOT NULL DEFAULT now(),
	"update_id" INTEGER NULL DEFAULT NULL,
	"is_deleted" BOOLEAN NOT NULL DEFAULT false,
	"given_name" VARCHAR NULL DEFAULT NULL,
	"username" VARCHAR NOT NULL,
	"password" VARCHAR NOT NULL,
	PRIMARY KEY ("id")
);

-- Dumping data for table public.staff: 3 rows
DELETE FROM "staff";
/*!40000 ALTER TABLE "staff" DISABLE KEYS */;
INSERT INTO "staff" ("id", "staff_no", "surname", "sex", "tel", "onboard_date", "last_date", "create_date", "create_id", "update_date", "update_id", "is_deleted", "given_name", "username", "password") VALUES
	(8, 'T2400002', 'LAW', 'M', '24567111', '2024-09-02 12:41:17', NULL, '2024-09-02 12:41:40.848932', NULL, '2024-09-02 12:41:40.848932', NULL, 'false', 'Teacher', 'teacher', '$2b$10$sYMJeT3/TOf/CTEHgYx7Seyo4fmYh3JEKqJoocHmLt3cFb93P2nIq'),
	(1, 'T2400001', 'LAW', 'M', '24567111', '2024-01-01 00:00:00', NULL, '2024-08-09 17:33:25.388089', 1, '2024-09-03 01:06:00.233032', 1, 'false', 'Admin', 'admin', '$2b$10$sYMJeT3/TOf/CTEHgYx7Seyo4fmYh3JEKqJoocHmLt3cFb93P2nIq'),
	(9, 'T2400003', 'LAW', 'M', '24567111', '2024-09-03 15:51:48.427866', NULL, '2024-09-03 15:51:48.427866', NULL, '2024-09-03 15:51:48.427866', NULL, 'false', 'Teacher2', 'teacher2', '$2b$10$R0xJFda85hAnEg9.8447aORPyE43uY.iI0N80wMj7eDVr3HRwdoau'),
	(10, 'T2400004', 'LAW', 'M', '21800000', '2024-09-03 15:55:04.550933', NULL, '2024-09-03 15:55:04.550933', NULL, '2024-09-03 16:01:40.099403', NULL, 'false', 'Admin2', 'admin2', '$2b$10$6WXvNUuuy5szvx5hy6yOO.s03jfaTkkEiDcpnlSIUKXbsj/scVfsa');
/*!40000 ALTER TABLE "staff" ENABLE KEYS */;

-- Dumping structure for table public.staff_title
CREATE TABLE IF NOT EXISTS "staff_title" (
	"id" SERIAL NOT NULL,
	"staff_id" INTEGER NULL DEFAULT NULL,
	"create_date" TIMESTAMP NOT NULL DEFAULT now(),
	"create_id" INTEGER NULL DEFAULT NULL,
	"update_date" TIMESTAMP NOT NULL DEFAULT now(),
	"update_id" INTEGER NULL DEFAULT NULL,
	"is_deleted" BOOLEAN NOT NULL DEFAULT false,
	"title_id" INTEGER NULL DEFAULT NULL,
	PRIMARY KEY ("id")
);

-- Dumping data for table public.staff_title: 4 rows
DELETE FROM "staff_title";
/*!40000 ALTER TABLE "staff_title" DISABLE KEYS */;
INSERT INTO "staff_title" ("id", "staff_id", "create_date", "create_id", "update_date", "update_id", "is_deleted", "title_id") VALUES
	(1, 1, '2024-08-09 17:37:56', 1, '2024-08-09 17:38:01.671531', 1, 'false', 1),
	(2, 8, '2024-08-09 17:37:56', 1, '2024-08-09 17:38:01.671531', 1, 'false', 3),
	(3, 9, '2024-09-03 15:53:26.328075', NULL, '2024-09-03 15:53:26.328075', NULL, 'false', 3),
	(4, 10, '2024-09-03 15:55:04.552705', NULL, '2024-09-03 16:01:40.099898', NULL, 'false', 1);
/*!40000 ALTER TABLE "staff_title" ENABLE KEYS */;

-- Dumping structure for table public.student
CREATE TABLE IF NOT EXISTS "student" (
	"id" SERIAL NOT NULL,
	"student_no" VARCHAR NULL DEFAULT NULL,
	"course_id" INTEGER NULL DEFAULT NULL,
	"surname" VARCHAR NULL DEFAULT NULL,
	"given_name" VARCHAR NULL DEFAULT NULL,
	"sex" CHAR(1) NULL DEFAULT NULL::bpchar,
	"tel" VARCHAR NULL DEFAULT NULL,
	"create_date" TIMESTAMP NOT NULL DEFAULT now(),
	"create_id" INTEGER NULL DEFAULT NULL,
	"update_date" TIMESTAMP NOT NULL DEFAULT now(),
	"update_id" INTEGER NULL DEFAULT NULL,
	"is_deleted" BOOLEAN NOT NULL DEFAULT false,
	"username" VARCHAR NOT NULL,
	"password" VARCHAR NOT NULL,
	PRIMARY KEY ("id")
);

-- Dumping data for table public.student: 28 rows
DELETE FROM "student";
/*!40000 ALTER TABLE "student" DISABLE KEYS */;
INSERT INTO "student" ("id", "student_no", "course_id", "surname", "given_name", "sex", "tel", "create_date", "create_id", "update_date", "update_id", "is_deleted", "username", "password") VALUES
	(27, 'SIT240027', 3, 'Au', 'Kai Man', 'M', '94567890', '2024-08-09 17:42:05.448518', 3, '2024-09-03 01:04:34.158183', 3, 'false', 'au001', '$2b$10$57Q3VhkPT14WJPnOZ8mgqOcLcZrIL/Eys4XD3OIvA96aC2edif3bC'),
	(2, 'SIT240030', 3, 'LAW', 'Student2', 'M', '24567111', '2024-09-03 15:39:11.088446', NULL, '2024-09-03 15:39:11.088446', NULL, 'false', 'student2', '$2b$10$hnd6.Pd8rrygq4PAxzFTQOZFWnrwI0QZHPlJkIbQfvlLNa5dET6Ym'),
	(4, 'SIT240004', 2, 'Wong', 'Mei Ling', 'F', '91234567', '2024-08-09 17:42:05.448518', 2, '2024-08-19 16:15:09.535785', 2, 'false', 'wong001', '$2b$10$57Q3VhkPT14WJPnOZ8mgqOcLcZrIL/Eys4XD3OIvA96aC2edif3bC'),
	(5, 'SIT240005', 2, 'Ng', 'Chun Hei', 'M', '92345678', '2024-08-09 17:42:05.448518', 2, '2024-08-19 16:15:09.535785', 2, 'false', 'ng001', '$2b$10$57Q3VhkPT14WJPnOZ8mgqOcLcZrIL/Eys4XD3OIvA96aC2edif3bC'),
	(6, 'SIT240006', 3, 'Yip', 'Wai Yan', 'F', '93456789', '2024-08-09 17:42:05.448518', 3, '2024-08-19 16:15:09.535785', 3, 'false', 'yip001', '$2b$10$57Q3VhkPT14WJPnOZ8mgqOcLcZrIL/Eys4XD3OIvA96aC2edif3bC'),
	(7, 'SIT240007', 3, 'Ho', 'Ka Yin', 'F', '94567890', '2024-08-09 17:42:05.448518', 3, '2024-08-19 16:15:09.535785', 3, 'false', 'ho001', '$2b$10$57Q3VhkPT14WJPnOZ8mgqOcLcZrIL/Eys4XD3OIvA96aC2edif3bC'),
	(8, 'SIT240008', 4, 'Cheung', 'Lok Man', 'M', '95678901', '2024-08-09 17:42:05.448518', 4, '2024-08-19 16:15:09.535785', 4, 'false', 'cheung001', '$2b$10$57Q3VhkPT14WJPnOZ8mgqOcLcZrIL/Eys4XD3OIvA96aC2edif3bC'),
	(9, 'SIT240009', 1, 'Tam', 'Hin Chun', 'M', '96789012', '2024-08-09 17:42:05.448518', 1, '2024-08-19 16:15:09.535785', 1, 'false', 'tam001', '$2b$10$57Q3VhkPT14WJPnOZ8mgqOcLcZrIL/Eys4XD3OIvA96aC2edif3bC'),
	(10, 'SIT240010', 2, 'Chan', 'Wing Yee', 'F', '97890123', '2024-08-09 17:42:05.448518', 2, '2024-08-19 16:15:09.535785', 2, 'false', 'chan002', '$2b$10$57Q3VhkPT14WJPnOZ8mgqOcLcZrIL/Eys4XD3OIvA96aC2edif3bC'),
	(11, 'SIT240011', 3, 'Leung', 'Siu Ting', 'F', '98901234', '2024-08-09 17:42:05.448518', 3, '2024-08-19 16:15:09.535785', 3, 'false', 'leung001', '$2b$10$57Q3VhkPT14WJPnOZ8mgqOcLcZrIL/Eys4XD3OIvA96aC2edif3bC'),
	(12, 'SIT240012', 4, 'Wong', 'Chi Wai', 'M', '99012345', '2024-08-09 17:42:05.448518', 4, '2024-08-19 16:15:09.535785', 4, 'false', 'wong002', '$2b$10$57Q3VhkPT14WJPnOZ8mgqOcLcZrIL/Eys4XD3OIvA96aC2edif3bC'),
	(13, 'SIT240013', 1, 'Lam', 'Hoi Ching', 'F', '90123456', '2024-08-09 17:42:05.448518', 1, '2024-08-19 16:15:09.535785', 1, 'false', 'lam001', '$2b$10$57Q3VhkPT14WJPnOZ8mgqOcLcZrIL/Eys4XD3OIvA96aC2edif3bC'),
	(14, 'SIT240014', 2, 'Ng', 'Ka Lun', 'M', '91234567', '2024-08-09 17:42:05.448518', 2, '2024-08-19 16:15:09.535785', 2, 'false', 'ng002', '$2b$10$57Q3VhkPT14WJPnOZ8mgqOcLcZrIL/Eys4XD3OIvA96aC2edif3bC'),
	(15, 'SIT240015', 3, 'Ho', 'Yee Man', 'F', '92345678', '2024-08-09 17:42:05.448518', 3, '2024-08-19 16:15:09.535785', 3, 'false', 'ho002', '$2b$10$57Q3VhkPT14WJPnOZ8mgqOcLcZrIL/Eys4XD3OIvA96aC2edif3bC'),
	(16, 'SIT240016', 4, 'Cheng', 'Chun Kit', 'M', '93456789', '2024-08-09 17:42:05.448518', 4, '2024-08-19 16:15:09.535785', 4, 'false', 'cheng001', '$2b$10$57Q3VhkPT14WJPnOZ8mgqOcLcZrIL/Eys4XD3OIvA96aC2edif3bC'),
	(17, 'SIT240017', 1, 'Yip', 'Wai Ling', 'F', '94567890', '2024-08-09 17:42:05.448518', 1, '2024-08-19 16:15:09.535785', 1, 'false', 'yip002', '$2b$10$57Q3VhkPT14WJPnOZ8mgqOcLcZrIL/Eys4XD3OIvA96aC2edif3bC'),
	(18, 'SIT240018', 2, 'Cheung', 'Lok Yan', 'M', '95678901', '2024-08-09 17:42:05.448518', 2, '2024-08-19 16:15:09.535785', 2, 'false', 'cheung002', '$2b$10$57Q3VhkPT14WJPnOZ8mgqOcLcZrIL/Eys4XD3OIvA96aC2edif3bC'),
	(19, 'SIT240019', 3, 'Lau', 'Ching Ching', 'F', '96789012', '2024-08-09 17:42:05.448518', 3, '2024-08-19 16:15:09.535785', 3, 'false', 'lau001', '$2b$10$57Q3VhkPT14WJPnOZ8mgqOcLcZrIL/Eys4XD3OIvA96aC2edif3bC'),
	(20, 'SIT240020', 4, 'Tsang', 'Yui Ming', 'M', '97890123', '2024-08-09 17:42:05.448518', 4, '2024-08-19 16:15:09.535785', 4, 'false', 'tsang001', '$2b$10$57Q3VhkPT14WJPnOZ8mgqOcLcZrIL/Eys4XD3OIvA96aC2edif3bC'),
	(21, 'SIT240021', 1, 'Lui', 'Man Wai', 'F', '98901234', '2024-08-09 17:42:05.448518', 1, '2024-08-19 16:15:09.535785', 1, 'false', 'lui001', '$2b$10$57Q3VhkPT14WJPnOZ8mgqOcLcZrIL/Eys4XD3OIvA96aC2edif3bC'),
	(22, 'SIT240022', 2, 'Tong', 'Siu Kei', 'M', '99012345', '2024-08-09 17:42:05.448518', 2, '2024-08-19 16:15:09.535785', 2, 'false', 'tong001', '$2b$10$57Q3VhkPT14WJPnOZ8mgqOcLcZrIL/Eys4XD3OIvA96aC2edif3bC'),
	(23, 'SIT240023', 3, 'Mak', 'Hoi Ying', 'F', '90123456', '2024-08-09 17:42:05.448518', 3, '2024-08-19 16:15:09.535785', 3, 'false', 'mak001', '$2b$10$57Q3VhkPT14WJPnOZ8mgqOcLcZrIL/Eys4XD3OIvA96aC2edif3bC'),
	(24, 'SIT240024', 4, 'Kwok', 'Tsz Ching', 'F', '91234567', '2024-08-09 17:42:05.448518', 4, '2024-08-19 16:15:09.535785', 4, 'false', 'kwok001', '$2b$10$57Q3VhkPT14WJPnOZ8mgqOcLcZrIL/Eys4XD3OIvA96aC2edif3bC'),
	(25, 'SIT240025', 1, 'Chow', 'Chun Hei', 'M', '92345678', '2024-08-09 17:42:05.448518', 1, '2024-08-19 16:15:09.535785', 1, 'false', 'chow001', '$2b$10$57Q3VhkPT14WJPnOZ8mgqOcLcZrIL/Eys4XD3OIvA96aC2edif3bC'),
	(26, 'SIT240026', 2, 'Yu', 'Wai Mei', 'F', '93456789', '2024-08-09 17:42:05.448518', 2, '2024-08-19 16:15:09.535785', 2, 'false', 'yu001', '$2b$10$57Q3VhkPT14WJPnOZ8mgqOcLcZrIL/Eys4XD3OIvA96aC2edif3bC'),
	(28, 'SIT240028', 4, 'Tang', 'Siu Fan', 'F', '95678901', '2024-08-09 17:42:05.448518', 4, '2024-08-19 16:15:09.535785', 4, 'false', 'tang001', '$2b$10$57Q3VhkPT14WJPnOZ8mgqOcLcZrIL/Eys4XD3OIvA96aC2edif3bC'),
	(29, 'SIT240029', 1, 'Poon', 'Hoi Yan', 'F', '96789012', '2024-08-09 17:42:05.448518', 1, '2024-08-19 16:15:09.535785', 1, 'false', 'poon001', '$2b$10$57Q3VhkPT14WJPnOZ8mgqOcLcZrIL/Eys4XD3OIvA96aC2edif3bC'),
	(1, 'SIT240001', 1, 'LAW', 'Student', 'M', '24567111', '2024-08-09 17:42:05.448518', 1, '2024-09-02 14:31:49.594304', 1, 'false', 'student', '$2b$10$xdWkizLNbs9qZKqt3GCJbeGCy40klXv6T.l4siIq9wlUf0amVcKoK');
/*!40000 ALTER TABLE "student" ENABLE KEYS */;

-- Dumping structure for table public.subject
CREATE TABLE IF NOT EXISTS "subject" (
	"id" SERIAL NOT NULL,
	"subject_no" VARCHAR NULL DEFAULT NULL,
	"subject_name" VARCHAR NULL DEFAULT NULL,
	"create_date" TIMESTAMP NOT NULL DEFAULT now(),
	"create_id" INTEGER NULL DEFAULT NULL,
	"update_date" TIMESTAMP NOT NULL DEFAULT now(),
	"update_name" INTEGER NULL DEFAULT NULL,
	"is_deleted" BOOLEAN NOT NULL DEFAULT false,
	"number_of_lesson" INTEGER NULL DEFAULT NULL,
	"lesson_duration" INTEGER NULL DEFAULT NULL,
	PRIMARY KEY ("id")
);

-- Dumping data for table public.subject: 8 rows
DELETE FROM "subject";
/*!40000 ALTER TABLE "subject" DISABLE KEYS */;
INSERT INTO "subject" ("id", "subject_no", "subject_name", "create_date", "create_id", "update_date", "update_name", "is_deleted", "number_of_lesson", "lesson_duration") VALUES
	(5, 'CS104', 'Mathematics for Computing', '2024-09-02 12:39:48.458444', NULL, '2024-09-02 12:39:48.458444', NULL, 'false', 8, 3),
	(6, 'CS105', 'Programming', '2024-09-02 12:39:48.458444', NULL, '2024-09-02 12:39:48.458444', NULL, 'false', 8, 3),
	(7, 'CS106', 'Cyber Security for Society', '2024-09-02 12:39:48.458444', NULL, '2024-09-02 12:39:48.458444', NULL, 'false', 8, 3),
	(8, 'CS107', 'Algorithms and Data Types', '2024-09-02 12:39:48.458444', NULL, '2024-09-02 12:39:48.458444', NULL, 'false', 8, 3),
	(9, 'CS108', 'Information Systems and Databases', '2024-09-02 12:39:48.458444', NULL, '2024-09-02 12:39:48.458444', NULL, 'false', 8, 3),
	(2, 'IT0001', 'Database', '2024-08-09 17:44:33.53569', 1, '2024-09-03 03:39:29.650566', 1, 'false', 8, 3),
	(4, 'CS103', 'Computer Architecture', '2024-09-02 12:39:48.458444', NULL, '2024-09-03 03:40:46.340911', NULL, 'false', 10, 3),
	(3, 'IT0002', 'Gaming', '2024-08-09 17:45:16.478623', 1, '2024-09-03 12:20:23.571499', 1, 'false', 2, 3);
/*!40000 ALTER TABLE "subject" ENABLE KEYS */;

-- Dumping structure for table public.subject_class
CREATE TABLE IF NOT EXISTS "subject_class" (
	"id" SERIAL NOT NULL,
	"subject_id" INTEGER NULL DEFAULT NULL,
	"start_date" TIMESTAMP NULL DEFAULT NULL,
	"create_date" TIMESTAMP NOT NULL DEFAULT now(),
	"create_id" INTEGER NULL DEFAULT NULL,
	"update_date" TIMESTAMP NOT NULL DEFAULT now(),
	"update_id" INTEGER NULL DEFAULT NULL,
	"is_deleted" BOOLEAN NOT NULL DEFAULT false,
	"staff_id" INTEGER NULL DEFAULT NULL,
	PRIMARY KEY ("id")
);

-- Dumping data for table public.subject_class: 15 rows
DELETE FROM "subject_class";
/*!40000 ALTER TABLE "subject_class" DISABLE KEYS */;
INSERT INTO "subject_class" ("id", "subject_id", "start_date", "create_date", "create_id", "update_date", "update_id", "is_deleted", "staff_id") VALUES
	(3, 2, '2024-09-01 17:46:06', '2024-08-09 17:46:40.804003', 1, '2024-08-09 17:46:40.804003', 1, 'false', 1),
	(4, 3, NULL, '2024-09-03 12:20:52.961087', 1, '2024-09-03 12:20:52.961087', NULL, 'true', 8),
	(5, 3, '2024-09-01 10:30:00', '2024-09-03 12:36:14.974826', 1, '2024-09-03 12:36:14.974826', NULL, 'true', 8),
	(6, 3, '2024-09-01 10:30:00', '2024-09-03 12:37:41.566909', 1, '2024-09-03 12:37:41.566909', NULL, 'true', 8),
	(7, 3, '2024-09-01 10:30:00', '2024-09-03 12:38:25.795638', 1, '2024-09-03 12:38:25.795638', NULL, 'true', 8),
	(8, 3, '2024-09-01 10:30:00', '2024-09-03 12:39:39.205484', 1, '2024-09-03 12:39:39.205484', NULL, 'true', 8),
	(9, 3, '2024-09-01 10:30:00', '2024-09-03 12:40:16.969907', 1, '2024-09-03 12:40:16.969907', NULL, 'true', 8),
	(11, 3, '2024-09-01 18:30:00', '2024-09-03 12:46:21.019183', 1, '2024-09-03 12:46:21.019183', NULL, 'false', 8),
	(12, 3, '2024-09-02 18:30:00', '2024-09-03 12:47:19.063146', 1, '2024-09-03 12:47:19.063146', NULL, 'false', 8),
	(13, 3, '2024-09-03 18:30:00', '2024-09-03 12:47:42.624531', 1, '2024-09-03 12:47:42.624531', NULL, 'false', 8),
	(14, 3, '2024-09-04 18:30:00', '2024-09-03 12:49:45.626558', 1, '2024-09-03 12:49:45.626558', NULL, 'false', 8),
	(15, 3, '2024-09-05 18:30:00', '2024-09-03 12:51:20.8195', 1, '2024-09-03 12:51:20.8195', NULL, 'false', 8),
	(16, 3, '2024-09-06 18:30:00', '2024-09-03 12:51:42.309792', 1, '2024-09-03 12:51:42.309792', NULL, 'false', 8),
	(17, 3, '2024-09-07 18:30:00', '2024-09-03 12:53:01.917489', 1, '2024-09-03 12:53:01.917489', NULL, 'false', 8),
	(10, 3, '2024-09-01 10:30:00', '2024-09-03 12:42:35.881457', 1, '2024-09-03 13:07:38.302493', NULL, 'false', 8);
/*!40000 ALTER TABLE "subject_class" ENABLE KEYS */;

-- Dumping structure for table public.subject_class_resources
CREATE TABLE IF NOT EXISTS "subject_class_resources" (
	"id" SERIAL NOT NULL,
	"subject_class_id" INTEGER NULL DEFAULT NULL,
	"title" VARCHAR NULL DEFAULT NULL,
	"description" VARCHAR NULL DEFAULT NULL,
	"start_date" TIMESTAMP NOT NULL DEFAULT now(),
	"end_date" TIMESTAMP NULL DEFAULT NULL,
	"file_path" VARCHAR NULL DEFAULT NULL,
	"create_date" TIMESTAMP NOT NULL DEFAULT now(),
	"create_id" INTEGER NULL DEFAULT NULL,
	"update_date" TIMESTAMP NOT NULL DEFAULT now(),
	"update_id" INTEGER NULL DEFAULT NULL,
	"is_deleted" BOOLEAN NOT NULL DEFAULT false,
	PRIMARY KEY ("id")
);

-- Dumping data for table public.subject_class_resources: 0 rows
DELETE FROM "subject_class_resources";
/*!40000 ALTER TABLE "subject_class_resources" DISABLE KEYS */;
/*!40000 ALTER TABLE "subject_class_resources" ENABLE KEYS */;

-- Dumping structure for table public.subject_class_schedule
CREATE TABLE IF NOT EXISTS "subject_class_schedule" (
	"id" SERIAL NOT NULL,
	"subject_class_id" INTEGER NULL DEFAULT NULL,
	"lesson_start" TIMESTAMP NULL DEFAULT NULL,
	"lesson_end" TIMESTAMP NULL DEFAULT NULL,
	"create_date" TIMESTAMP NOT NULL DEFAULT now(),
	"create_id" INTEGER NULL DEFAULT NULL,
	"update_date" TIMESTAMP NOT NULL DEFAULT now(),
	"update_id" INTEGER NULL DEFAULT NULL,
	"is_deleted" BOOLEAN NOT NULL DEFAULT false,
	PRIMARY KEY ("id")
);

-- Dumping data for table public.subject_class_schedule: 19 rows
DELETE FROM "subject_class_schedule";
/*!40000 ALTER TABLE "subject_class_schedule" DISABLE KEYS */;
INSERT INTO "subject_class_schedule" ("id", "subject_class_id", "lesson_start", "lesson_end", "create_date", "create_id", "update_date", "update_id", "is_deleted") VALUES
	(1, 3, '2024-08-20 18:30:00', '2024-08-20 21:30:00', '2024-08-26 23:35:30.988469', 1, '2024-08-26 23:35:30.988469', 1, 'false'),
	(2, 3, '2024-08-26 18:30:00', '2024-08-26 21:30:00', '2024-08-26 23:35:30.988469', 1, '2024-08-26 23:35:30.988469', 1, 'false'),
	(3, 9, '2024-09-01 10:30:00', '2024-09-01 13:30:00', '2024-09-03 12:40:16.973226', 1, '2024-09-03 12:40:16.973226', NULL, 'false'),
	(6, 11, '2024-09-01 18:30:00', '2024-09-01 21:30:00', '2024-09-03 12:46:21.021059', 1, '2024-09-03 12:46:21.021059', NULL, 'false'),
	(7, 11, '2024-09-08 18:30:00', '2024-09-08 21:30:00', '2024-09-03 12:46:21.02185', 1, '2024-09-03 12:46:21.02185', NULL, 'false'),
	(8, 12, '2024-09-02 18:30:00', '2024-09-02 21:30:00', '2024-09-03 12:47:19.063682', 1, '2024-09-03 12:47:19.063682', NULL, 'false'),
	(9, 12, '2024-09-09 18:30:00', '2024-09-09 21:30:00', '2024-09-03 12:47:19.064264', 1, '2024-09-03 12:47:19.064264', NULL, 'false'),
	(10, 13, '2024-09-03 18:30:00', '2024-09-03 21:30:00', '2024-09-03 12:47:42.6262', 1, '2024-09-03 12:47:42.6262', NULL, 'false'),
	(11, 13, '2024-09-10 18:30:00', '2024-09-10 21:30:00', '2024-09-03 12:47:42.626639', 1, '2024-09-03 12:47:42.626639', NULL, 'false'),
	(12, 14, '2024-09-04 18:30:00', '2024-09-04 21:30:00', '2024-09-03 12:49:45.628182', 1, '2024-09-03 12:49:45.628182', NULL, 'false'),
	(13, 14, '2024-09-11 18:30:00', '2024-09-11 21:30:00', '2024-09-03 12:49:45.628595', 1, '2024-09-03 12:49:45.628595', NULL, 'false'),
	(14, 15, '2024-09-05 18:30:00', '2024-09-05 21:30:00', '2024-09-03 12:51:20.821197', 1, '2024-09-03 12:51:20.821197', NULL, 'false'),
	(15, 15, '2024-09-12 18:30:00', '2024-09-12 21:30:00', '2024-09-03 12:51:20.821695', 1, '2024-09-03 12:51:20.821695', NULL, 'false'),
	(16, 16, '2024-09-06 18:30:00', '2024-09-06 21:30:00', '2024-09-03 12:51:42.310301', 1, '2024-09-03 12:51:42.310301', NULL, 'false'),
	(17, 16, '2024-09-13 18:30:00', '2024-09-13 21:30:00', '2024-09-03 12:51:42.31067', 1, '2024-09-03 12:51:42.31067', NULL, 'false'),
	(18, 17, '2024-09-07 18:30:00', '2024-09-07 21:30:00', '2024-09-03 12:53:01.919047', 1, '2024-09-03 12:53:01.919047', NULL, 'false'),
	(19, 17, '2024-09-14 18:30:00', '2024-09-14 21:30:00', '2024-09-03 12:53:01.919482', 1, '2024-09-03 12:53:01.919482', NULL, 'false'),
	(4, 10, '2024-09-01 12:30:00', '2024-09-01 15:30:00', '2024-09-03 12:42:35.883778', 1, '2024-09-03 13:07:38.303953', NULL, 'false'),
	(5, 10, '2024-09-08 12:30:00', '2024-09-08 15:30:00', '2024-09-03 12:42:35.88442', 1, '2024-09-03 13:07:38.304844', NULL, 'false');
/*!40000 ALTER TABLE "subject_class_schedule" ENABLE KEYS */;

-- Dumping structure for table public.subject_class_student
CREATE TABLE IF NOT EXISTS "subject_class_student" (
	"id" SERIAL NOT NULL,
	"subject_class_id" INTEGER NULL DEFAULT NULL,
	"student_id" INTEGER NULL DEFAULT NULL,
	"create_date" TIMESTAMP NOT NULL DEFAULT now(),
	"create_id" INTEGER NULL DEFAULT NULL,
	"update_date" TIMESTAMP NOT NULL DEFAULT now(),
	"update_id" INTEGER NULL DEFAULT NULL,
	"is_deleted" BOOLEAN NOT NULL DEFAULT false,
	PRIMARY KEY ("id")
);

-- Dumping data for table public.subject_class_student: 29 rows
DELETE FROM "subject_class_student";
/*!40000 ALTER TABLE "subject_class_student" DISABLE KEYS */;
INSERT INTO "subject_class_student" ("id", "subject_class_id", "student_id", "create_date", "create_id", "update_date", "update_id", "is_deleted") VALUES
	(1, 3, 1, '2024-08-09 17:49:16.11785', 1, '2024-08-09 17:49:16.11785', 1, 'false'),
	(3, 11, 18, '2024-09-03 13:50:23.888491', 1, '2024-09-03 13:50:23.888491', NULL, 'false'),
	(4, 11, 25, '2024-09-03 13:50:23.888907', 1, '2024-09-03 13:50:23.888907', NULL, 'false'),
	(5, 11, 15, '2024-09-03 13:50:23.889302', 1, '2024-09-03 13:50:23.889302', NULL, 'false'),
	(6, 11, 13, '2024-09-03 13:50:23.889599', 1, '2024-09-03 13:50:23.889599', NULL, 'false'),
	(7, 11, 1, '2024-09-03 13:50:23.889945', 1, '2024-09-03 13:50:23.889945', NULL, 'false'),
	(9, 11, 19, '2024-09-03 13:51:07.017487', 1, '2024-09-03 13:51:07.017487', NULL, 'false'),
	(10, 11, 11, '2024-09-03 13:51:07.017892', 1, '2024-09-03 13:51:07.017892', NULL, 'false'),
	(11, 11, 21, '2024-09-03 13:51:07.018173', 1, '2024-09-03 13:51:07.018173', NULL, 'false'),
	(12, 3, 18, '2024-09-03 13:51:14.059736', 1, '2024-09-03 13:51:14.059736', NULL, 'false'),
	(13, 3, 24, '2024-09-03 13:51:14.061325', 1, '2024-09-03 13:51:14.061325', NULL, 'false'),
	(15, 12, 18, '2024-09-03 13:51:27.199853', 1, '2024-09-03 13:51:27.199853', NULL, 'false'),
	(16, 12, 7, '2024-09-03 13:51:27.200257', 1, '2024-09-03 13:51:27.200257', NULL, 'false'),
	(17, 12, 19, '2024-09-03 13:51:27.200531', 1, '2024-09-03 13:51:27.200531', NULL, 'false'),
	(18, 12, 6, '2024-09-03 13:51:27.200797', 1, '2024-09-03 13:51:27.200797', NULL, 'false'),
	(20, 14, 24, '2024-09-03 13:51:33.19005', 1, '2024-09-03 13:51:33.19005', NULL, 'false'),
	(21, 14, 13, '2024-09-03 13:51:33.190385', 1, '2024-09-03 13:51:33.190385', NULL, 'false'),
	(22, 14, 19, '2024-09-03 13:51:33.190649', 1, '2024-09-03 13:51:33.190649', NULL, 'false'),
	(23, 14, 1, '2024-09-03 13:51:33.190906', 1, '2024-09-03 13:51:33.190906', NULL, 'false'),
	(24, 14, 11, '2024-09-03 13:51:33.191165', 1, '2024-09-03 13:51:33.191165', NULL, 'false'),
	(26, 17, 24, '2024-09-03 13:51:38.033779', 1, '2024-09-03 13:51:38.033779', NULL, 'false'),
	(27, 17, 13, '2024-09-03 13:51:38.034146', 1, '2024-09-03 13:51:38.034146', NULL, 'false'),
	(28, 17, 15, '2024-09-03 13:51:38.034418', 1, '2024-09-03 13:51:38.034418', NULL, 'false'),
	(29, 17, 7, '2024-09-03 13:51:38.034696', 1, '2024-09-03 13:51:38.034696', NULL, 'false'),
	(2, 11, NULL, '2024-09-03 13:50:23.885542', 1, '2024-09-03 13:50:23.885542', NULL, 'true'),
	(8, 11, NULL, '2024-09-03 13:51:07.015377', 1, '2024-09-03 13:51:07.015377', NULL, 'true'),
	(14, 12, NULL, '2024-09-03 13:51:27.198245', 1, '2024-09-03 13:51:27.198245', NULL, 'true'),
	(19, 14, NULL, '2024-09-03 13:51:33.188537', 1, '2024-09-03 13:51:33.188537', NULL, 'true'),
	(25, 17, NULL, '2024-09-03 13:51:38.032238', 1, '2024-09-03 13:51:38.032238', NULL, 'true'),
	(30, 10, 24, '2024-09-03 13:54:02.809133', 1, '2024-09-03 13:54:02.809133', NULL, 'false'),
	(31, 10, 11, '2024-09-03 13:54:02.810199', 1, '2024-09-03 13:54:02.810199', NULL, 'false'),
	(32, 10, 23, '2024-09-03 13:54:02.810904', 1, '2024-09-03 13:54:02.810904', NULL, 'false'),
	(33, 10, 14, '2024-09-03 13:54:02.811414', 1, '2024-09-03 13:54:02.811414', NULL, 'false'),
	(34, 3, 15, '2024-09-03 15:25:01.248304', 1, '2024-09-03 15:25:01.248304', NULL, 'false');
/*!40000 ALTER TABLE "subject_class_student" ENABLE KEYS */;

-- Dumping structure for table public.title
CREATE TABLE IF NOT EXISTS "title" (
	"id" SERIAL NOT NULL,
	"title_name" VARCHAR NULL DEFAULT NULL,
	"create_date" TIMESTAMP NOT NULL DEFAULT now(),
	"create_id" INTEGER NULL DEFAULT NULL,
	"update_date" TIMESTAMP NOT NULL DEFAULT now(),
	"update_id" INTEGER NULL DEFAULT NULL,
	"is_deleted" BOOLEAN NOT NULL DEFAULT false,
	PRIMARY KEY ("id")
);

-- Dumping data for table public.title: -1 rows
DELETE FROM "title";
/*!40000 ALTER TABLE "title" DISABLE KEYS */;
INSERT INTO "title" ("id", "title_name", "create_date", "create_id", "update_date", "update_id", "is_deleted") VALUES
	(1, 'admin', '2024-08-09 17:38:51.93205', 1, '2024-08-09 17:38:51.93205', 1, 'false'),
	(2, 'officer', '2024-08-09 17:39:41.403621', 1, '2024-08-09 17:39:41.403621', 1, 'false'),
	(3, 'teacher', '2024-08-09 17:40:41.293221', 1, '2024-08-09 17:40:41.293221', 1, 'false');
/*!40000 ALTER TABLE "title" ENABLE KEYS */;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
