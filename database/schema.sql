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

-- Dumping structure for table public.class
CREATE TABLE IF NOT EXISTS "class" (
	"id" SERIAL NOT NULL,
	"course_id" INTEGER NULL DEFAULT NULL,
	"start_date" TIMESTAMP NULL DEFAULT NULL,
	"create_date" TIMESTAMP NOT NULL DEFAULT now(),
	"create_id" INTEGER NULL DEFAULT NULL,
	"update_date" TIMESTAMP NOT NULL DEFAULT now(),
	"update_id" INTEGER NULL DEFAULT NULL,
	"is_deleted" BOOLEAN NOT NULL DEFAULT false,
	"class_name" VARCHAR NULL DEFAULT NULL,
	"start_year" VARCHAR NULL DEFAULT NULL,
	PRIMARY KEY ("id")
);

-- Dumping data for table public.class: -1 rows
DELETE FROM "class";
/*!40000 ALTER TABLE "class" DISABLE KEYS */;
INSERT INTO "class" ("id", "course_id", "start_date", "create_date", "create_id", "update_date", "update_id", "is_deleted", "class_name", "start_year") VALUES
	(3, 1, '2024-09-01 17:46:06', '2024-08-09 17:46:40.804003', 1, '2024-08-09 17:46:40.804003', 1, 'false', 'A', '2024');
/*!40000 ALTER TABLE "class" ENABLE KEYS */;

-- Dumping structure for table public.class_student
CREATE TABLE IF NOT EXISTS "class_student" (
	"id" SERIAL NOT NULL,
	"class_id" INTEGER NULL DEFAULT NULL,
	"student_id" INTEGER NULL DEFAULT NULL,
	"create_date" TIMESTAMP NOT NULL DEFAULT now(),
	"create_id" INTEGER NULL DEFAULT NULL,
	"update_date" TIMESTAMP NOT NULL DEFAULT now(),
	"update_id" INTEGER NULL DEFAULT NULL,
	"is_deleted" BOOLEAN NOT NULL DEFAULT false,
	PRIMARY KEY ("id")
);

-- Dumping data for table public.class_student: -1 rows
DELETE FROM "class_student";
/*!40000 ALTER TABLE "class_student" DISABLE KEYS */;
-- Dumping structure for table public.class_subject
CREATE TABLE IF NOT EXISTS "class_subject" (
	"id" SERIAL NOT NULL,
	"class_id" INTEGER NULL DEFAULT NULL,
	"subject_id" INTEGER NULL DEFAULT NULL,
	"staff_id" INTEGER NULL DEFAULT NULL,
	"create_date" TIMESTAMP NOT NULL DEFAULT now(),
	"create_id" INTEGER NULL DEFAULT NULL,
	"update_date" TIMESTAMP NOT NULL DEFAULT now(),
	"update_id" INTEGER NULL DEFAULT NULL,
	"is_deleted" BOOLEAN NOT NULL DEFAULT false,
	PRIMARY KEY ("id")
);

-- Dumping data for table public.class_subject: -1 rows
DELETE FROM "class_subject";
/*!40000 ALTER TABLE "class_subject" DISABLE KEYS */;
INSERT INTO "class_subject" ("id", "class_id", "subject_id", "staff_id", "create_date", "create_id", "update_date", "update_id", "is_deleted") VALUES
	(1, 3, 2, 1, '2024-08-09 17:49:43.137655', 1, '2024-08-09 17:49:43.137655', 1, 'false'),
	(2, 3, 3, 1, '2024-08-09 17:49:55.837868', 1, '2024-08-09 17:49:55.837868', 1, 'false');
/*!40000 ALTER TABLE "class_subject" ENABLE KEYS */;

-- Dumping structure for table public.class_subject_resources
CREATE TABLE IF NOT EXISTS "class_subject_resources" (
	"id" SERIAL NOT NULL,
	"class_subject_id" INTEGER NULL DEFAULT NULL,
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

-- Dumping data for table public.class_subject_resources: -1 rows
DELETE FROM "class_subject_resources";
/*!40000 ALTER TABLE "class_subject_resources" DISABLE KEYS */;
/*!40000 ALTER TABLE "class_subject_resources" ENABLE KEYS */;

-- Dumping structure for table public.class_subject_schedule
CREATE TABLE IF NOT EXISTS "class_subject_schedule" (
	"id" SERIAL NOT NULL,
	"class_subject_id" INTEGER NULL DEFAULT NULL,
	"lesson_start" TIMESTAMP NULL DEFAULT NULL,
	"lesson_end" TIMESTAMP NULL DEFAULT NULL,
	"create_date" TIMESTAMP NOT NULL DEFAULT now(),
	"create_id" INTEGER NULL DEFAULT NULL,
	"update_date" TIMESTAMP NOT NULL DEFAULT now(),
	"update_id" INTEGER NULL DEFAULT NULL,
	"is_deleted" BOOLEAN NOT NULL DEFAULT false,
	PRIMARY KEY ("id")
);

-- Dumping data for table public.class_subject_schedule: -1 rows
DELETE FROM "class_subject_schedule";
/*!40000 ALTER TABLE "class_subject_schedule" DISABLE KEYS */;
/*!40000 ALTER TABLE "class_subject_schedule" ENABLE KEYS */;

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

-- Dumping data for table public.course: -1 rows
DELETE FROM "course";
/*!40000 ALTER TABLE "course" DISABLE KEYS */;
INSERT INTO "course" ("id", "course_code", "course_name", "duration", "category", "create_date", "create_id", "update_date", "update_id", "is_deleted") VALUES
	(1, 'IT00001', 'Computering', '2', 'IT', '2024-08-09 17:43:26.246592', 1, '2024-08-09 17:43:26.246592', 1, 'false');
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

-- Dumping data for table public.course_subject: -1 rows
DELETE FROM "course_subject";
/*!40000 ALTER TABLE "course_subject" DISABLE KEYS */;
INSERT INTO "course_subject" ("id", "course_id", "subject_id", "create_date", "create_id", "update_date", "update_id", "is_deleted") VALUES
	(1, 1, 2, '2024-08-09 17:50:25.785656', 1, '2024-08-09 17:50:25.785656', 1, 'false'),
	(2, 1, 3, '2024-08-09 17:50:29.654435', 1, '2024-08-09 17:50:29.654435', 1, 'false');
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

-- Dumping data for table public.staff: 1 rows
DELETE FROM "staff";
/*!40000 ALTER TABLE "staff" DISABLE KEYS */;
INSERT INTO "staff" ("id", "staff_no", "surname", "sex", "tel", "onboard_date", "last_date", "create_date", "create_id", "update_date", "update_id", "is_deleted", "given_name", "username", "password") VALUES
	(1, 'T2400001', 'LAW', 'M', '24567111', '2024-01-01 00:00:00', NULL, '2024-08-09 17:33:25.388089', NULL, '2024-08-19 16:14:58.823984', NULL, 'false', 'Admin', 'admin', '$2b$10$sYMJeT3/TOf/CTEHgYx7Seyo4fmYh3JEKqJoocHmLt3cFb93P2nIq');
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

-- Dumping data for table public.staff_title: -1 rows
DELETE FROM "staff_title";
/*!40000 ALTER TABLE "staff_title" DISABLE KEYS */;
INSERT INTO "staff_title" ("id", "staff_id", "create_date", "create_id", "update_date", "update_id", "is_deleted", "title_id") VALUES
	(1, 1, '2024-08-09 17:37:56', 1, '2024-08-09 17:38:01.671531', 1, 'false', 1);
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

-- Dumping data for table public.student: -1 rows
DELETE FROM "student";
/*!40000 ALTER TABLE "student" DISABLE KEYS */;
INSERT INTO "student" ("id", "student_no", "course_id", "surname", "given_name", "sex", "tel", "create_date", "create_id", "update_date", "update_id", "is_deleted", "username", "password") VALUES
	(1, 'SIT240001', 1, 'LAW', 'Student', 'M', '2456777', '2024-08-09 17:42:05.448518', 1, '2024-08-19 16:15:09.535785', 1, 'false', 'student', '$2b$10$57Q3VhkPT14WJPnOZ8mgqOcLcZrIL/Eys4XD3OIvA96aC2edif3bC');
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

-- Dumping data for table public.subject: -1 rows
DELETE FROM "subject";
/*!40000 ALTER TABLE "subject" DISABLE KEYS */;
INSERT INTO "subject" ("id", "subject_no", "subject_name", "create_date", "create_id", "update_date", "update_name", "is_deleted", "number_of_lesson", "lesson_duration") VALUES
	(2, 'IT0001', 'Database', '2024-08-09 17:44:33.53569', 1, '2024-08-09 17:44:33.53569', 1, 'false', 7, 3),
	(3, 'IT0002', 'Gaming', '2024-08-09 17:45:16.478623', 1, '2024-08-09 17:45:16.478623', 1, 'false', 12, 3);
/*!40000 ALTER TABLE "subject" ENABLE KEYS */;

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
	(3, 'techer', '2024-08-09 17:40:41.293221', 1, '2024-08-09 17:40:41.293221', 1, 'false');
/*!40000 ALTER TABLE "title" ENABLE KEYS */;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
