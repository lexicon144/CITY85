-- phpMyAdmin SQL Dump
-- version 4.7.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 05, 2018 at 02:58 PM
-- Server version: 5.6.26
-- PHP Version: 5.6.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `we_learndb`
--
DROP DATABASE IF EXISTS `we_learndb`;
CREATE DATABASE IF NOT EXISTS `we_learndb` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `we_learndb`;

DELIMITER $$
--
-- Procedures
--
DROP PROCEDURE IF EXISTS `CountVotes`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `CountVotes` (IN `CandidateID` INT(11))  BEGIN
/*
Use Execute Scalar for this
*/
SELECT COUNT(*) FROM tbl_ranking WHERE candidate_id = CandidateID;
END$$

DROP PROCEDURE IF EXISTS `InsertArticle`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertArticle` (IN `FileName` INT(11), IN `FileSize` INT(11), IN `FileBlob` BLOB)  BEGIN
INSERT INTO tbl_articles(file_name, file_size, file_blob, drp)
VALUES (FileName, FileSize, FileBlob, FALSE);
END$$

DROP PROCEDURE IF EXISTS `InsertDays`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertDays` (IN `DayDesc` VARCHAR(3))  BEGIN
INSERT INTO tbl_days (description) VALUES (DayDesc);
END$$

DROP PROCEDURE IF EXISTS `InsertEnrollmentRecord`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertEnrollmentRecord` (IN `StudentID` INT(11), IN `ClassRoomID` INT(11))  BEGIN
INSERT INTO link_enrollment(user_id, class_id,drp)
VALUES(StudentID, ClassRoomID,FALSE);
END$$

DROP PROCEDURE IF EXISTS `InsertGradesExam`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertGradesExam` (IN `UserID` INT(11), IN `ExamID` INT(11), IN `ExamGrade` DECIMAL, IN `ExamHits` INT(3), IN `ExamQuestions` INT(3))  BEGIN
IF NOT EXISTS(SELECT * FROM link_examgrades WHERE (UserID = user_id AND ExamID = exam_id)) THEN

INSERT INTO link_examgrades(user_id, exam_id, exam_grade, exam_hits, exam_questions, drp)
VALUES(UserID, ExamID,ExamGrade, ExamHits, ExamQuestions, FALSE);

END IF;
END$$

DROP PROCEDURE IF EXISTS `InsertGradesQuiz`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertGradesQuiz` (IN `UserID` INT(11), IN `QuizID` INT(11), IN `QuizGrade` DECIMAL(5,2), IN `Hits` INT(3), IN `Questions` INT(11))  BEGIN
INSERT INTO link_quizgrades(user_id, quiz_id, quiz_grade, quiz_hits, quiz_questions, drp) VALUES(UserID, QuizID, QuizGrade, Hits, Questions, FALSE)
;
END$$

DROP PROCEDURE IF EXISTS `InsertLinkArticleToClass`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertLinkArticleToClass` (IN `ClassroomID` INT(11), IN `ArticleID` INT(11))  BEGIN
/*
Insert Link between Article and a Class
*/
INSERT INTO link_articles(class_id, file_id, drp) VALUES (ClassroomID, ArticleID, FALSE);
END$$

DROP PROCEDURE IF EXISTS `InsertLinkExamsToClass`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertLinkExamsToClass` (IN `ClassroomID` INT(11), IN `ExamID` INT(11))  BEGIN
INSERT INTO link_exams(class_id, file_id, drp) VALUES (ClassroomID, ExamID, FALSE);
END$$

DROP PROCEDURE IF EXISTS `InsertLinkMaterialToClass`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertLinkMaterialToClass` (IN `ClassroomID` INT(11), IN `MaterialID` INT(11))  BEGIN
/*
Link a Study material to this Certain Classroom
*/
INSERT INTO link_materials(class_id, file_id, drp) VALUES (ClassroomID, MaterialID, FALSE);
END$$

DROP PROCEDURE IF EXISTS `InsertLinkQuizToClass`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertLinkQuizToClass` (IN `ClassroomID` INT(11), IN `QuizID` INT(11))  BEGIN
INSERT INTO link_quiz(quiz_id,class_id,  drp) VALUES (QuizID, ClassroomID,FALSE);
END$$

DROP PROCEDURE IF EXISTS `InsertNewArticle`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertNewArticle` (IN `FileName` VARCHAR(20), IN `FileSize` INT(11), IN `FileBlob` BLOB)  BEGIN
/*
Insert a fresh new article in the database
*/
INSERT INTO tbl_articles (file_name, file_size, file_blob, drp)
VALUES (FileName, FileSize, FileBlob, FALSE);
END$$

DROP PROCEDURE IF EXISTS `InsertNewClassroom`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertNewClassroom` (IN `ClassRoomName` VARCHAR(20), IN `ClassRoomDesc` VARCHAR(20), IN `ClassRoomType` INT(1))  BEGIN
INSERT INTO tbl_classlist(class_name, class_description, classType, drp)
VALUES(ClassRoomName, ClassRoomDesc, ClassRoomType, FALSE);
END$$

DROP PROCEDURE IF EXISTS `InsertNewMaterial`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertNewMaterial` (IN `MaterialName` VARCHAR(45), IN `MaterialDescription` VARCHAR(45), IN `SetDrop` BOOLEAN)  BEGIN
INSERT INTO tbl_materials (m_name, m_description, drp) VALUES (MaterialName, MaterialDescription, SetDrop);
END$$

DROP PROCEDURE IF EXISTS `InsertNewMessage`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertNewMessage` (IN `ReceiverID` INT(11), IN `SenderID` INT(11), IN `Payload` VARCHAR(70))  BEGIN
INSERT INTO link_feedback(id, receiver_id, sender_id, payload, viewed, voided) VALUES (NOW(), ReceiverID, SenderID, Payload, false,false	);
END$$

DROP PROCEDURE IF EXISTS `InsertNewUser`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertNewUser` (IN `userType` INT(1), IN `userFname` VARCHAR(10), IN `userMi` VARCHAR(1), IN `userLname` VARCHAR(10), IN `userName` VARCHAR(20), IN `userLOL` VARCHAR(255), IN `userHash` VARCHAR(255), IN `questionIndex` INT(1), IN `secAnswer` VARCHAR(255), IN `userGender` VARCHAR(1), IN `userCell` VARCHAR(11), IN `userLandline` VARCHAR(7), IN `userDob` DATE, IN `address` VARCHAR(255), IN `email` VARCHAR(45), IN `isActive` BOOLEAN)  BEGIN
INSERT INTO tbl_user (
user_type ,
 user_fname , 
 user_mi ,
 user_lname ,
 user_name ,
 user_leagueoflegends ,
 user_password , 
 questionIndex , 
 sec_ans , 
 user_gender , 
 user_cellularnumber ,
 user_landline , 
 user_dob , 
 address ,
 email, 
 isActive)
 
 VALUES (userType, userFname, userMi, userLname, userName, userLOL, userHash, questionIndex, secAnswer, userGender, userCell, userLandline, userDob, address, email, isActive);
END$$

DROP PROCEDURE IF EXISTS `InsertSchedule`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertSchedule` (IN `DayID` INT(11), IN `TimeID` INT(11), IN `ClassID` INT(11))  BEGIN
/*
Insert a Schedule record into Link_schedule
Creates a Schedule Object Concept in the database
*/
INSERT INTO link_schedule(dayid, timeid,classid, drp) VALUES (DayID, TimeID, ClassID, FALSE);
END$$

DROP PROCEDURE IF EXISTS `InsertTime`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertTime` (IN `TimeStart` INT(2))  BEGIN
/*
Insert a Time Value into the database (use for raw data)
*/
INSERT INTO tbl_time (timestart) values (TimeStart);
END$$

DROP PROCEDURE IF EXISTS `InsertTimeIn`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertTimeIn` (IN `UserID` INT(11), IN `ClassroomID` INT(11))  BEGIN
INSERT INTO tbl_timein VALUES(NOW(), UserID, ClassroomID, FALSE);
END$$

DROP PROCEDURE IF EXISTS `InsertTimeOut`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertTimeOut` (IN `UserID` INT(11), IN `ClassroomID` INT(11))  BEGIN
INSERT INTO tbl_timeout VALUES(NOW(), UserID, ClassroomID, FALSE);
END$$

DROP PROCEDURE IF EXISTS `InsertTimeslot`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertTimeslot` (IN `ClassroomID` INT(11), IN `TimeID` INT(11))  BEGIN
/*
Insert a Timeslot record into Link_Timeslot
Creates a Timeslot Object Concept in the database
*/
INSERT INTO link_timeslot(classid, timeid, drp) VALUES (ClassroomID, TimeID, FALSE);
END$$

DROP PROCEDURE IF EXISTS `InsertVote`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertVote` (IN `VoterID` INT(11), IN `CandidateID` INT(11), IN `State` BOOLEAN)  BEGIN
/*
If the vote record already exists Then just update the state of it
Else
Insert a new record
*/
IF EXISTS(SELECT * FROM tbl_ranking WHERE voter_id = VoterID) THEN
UPDATE tbl_professor_ranking
SET state = State WHERE VoterID = voter_id AND CandidateID = candidate_id;
ELSE
INSERT INTO tbl_ranking(voter_id, candidate_id, state)
VALUES(VoterID, CandidateID, State);
END IF;
END$$

DROP PROCEDURE IF EXISTS `MarkThisExam`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `MarkThisExam` (IN `UserID` INT(11), IN `ExamID` INT(11), OUT `Existence` BOOLEAN)  BEGIN
IF(SELECT EXISTS(SELECT * from tbl_markingexam WHERE UserID = user_id AND ExamID = exam_id limit 1)) THEN 
SET Existence = TRUE;
ELSE
INSERT INTO tbl_markingexam(exam_id, user_id, marked, mdate) VALUES (ExamID, UserID, FALSE, SYSDATE());
SET Existence = FALSE;
END IF;
END$$

DROP PROCEDURE IF EXISTS `MarkThisQuiz`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `MarkThisQuiz` (IN `QuizID` INT(11), IN `UserID` INT(11))  BEGIN
INSERT INTO tbl_markingquiz(quiz_id, user_id, marked, mdate) VALUES(QuizID, UserID, FALSE, SYSDATE());
END$$

DROP PROCEDURE IF EXISTS `SelectAllEnrolledClasses`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SelectAllEnrolledClasses` (IN `StudentID` INT(11))  BEGIN
/*
Select all Classrooms this Student is enrolled in
*/
SELECT tbl_user.user_id, tbl_user.user_name, tbl_user.user_fname, tbl_user.user_mi, tbl_user.user_lname, tbl_classroom.id, tbl_classroom.class_name
FROM link_enrollment
INNER JOIN tbl_user ON link_enrollment.user_id = tbl_user.user_id
INNER JOIN tbl_classroom ON link_enrollment.class_id = tbl_classroom.id
WHERE link_enrollment.user_id = StudentID AND link_enrollment.drp = FALSE;
END$$

DROP PROCEDURE IF EXISTS `SelectAllMaterials`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SelectAllMaterials` ()  BEGIN
SELECT * FROM tbl_materials;
END$$

DROP PROCEDURE IF EXISTS `SelectAllMessages`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SelectAllMessages` (IN `ReceiverID` INT(11))  BEGIN
SELECT
link_feedback.id,
link_feedback.receiver_id,
link_feedback.sender_id,
tbl_user.user_name,
link_feedback.payload
FROM link_feedback 
INNER JOIN tbl_user ON link_feedback.sender_id = tbl_user.user_id
WHERE link_feedback.receiver_id = ReceiverID AND voided = FALSE;
END$$

DROP PROCEDURE IF EXISTS `SelectAllRanks`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SelectAllRanks` ()  BEGIN
SELECT candidate_id, COUNT(*) FROM tbl_ranking GROUP BY candidate_id;
END$$

DROP PROCEDURE IF EXISTS `SelectAllStudents`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SelectAllStudents` ()  BEGIN
SELECT tbl_user.user_id, tbl_user.user_lname, tbl_user.user_mi, tbl_user.user_fname
FROM tbl_user
WHERE tbl_user.user_type = 2;
END$$

DROP PROCEDURE IF EXISTS `SelectArticlesFromThisClass`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SelectArticlesFromThisClass` (IN `ClassroomID` INT(11))  BEGIN
/*
Selects the article Blob, Name and size from the TblArticles table
Where the classroom = this
*/
SELECT tbl_articles.id, tbl_articles.file_name,tbl_articles.file_size,tbl_articles.file_blob
FROM link_articles

INNER JOIN tbl_articles
ON link_articles.file_id = tbl_articles.id

WHERE link_articles.class_id = ClassroomID;

END$$

DROP PROCEDURE IF EXISTS `SelectAsVerboseTimeslot`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SelectAsVerboseTimeslot` ()  BEGIN
/*
Verbosely selects ALL the timeslot rows in LINK_TIMESLOT
the Classroom id, name, description, classroom type
Timeslot ID and Starting Time
*/
SELECT tbl_classroom.id, tbl_classroom.class_name, tbl_classroom.class_description, tbl_classroom.classType, tbl_time.timeslotID, tbl_time.timestart
FROM link_timeslot
INNER JOIN tbl_classroom ON tbl_classroom.id = link_timeslot.classid
INNER JOIN tbl_time ON tbl_time.timeslotID = link_timeslot.timeid
WHERE tbl_classroom.drp = FALSE;
END$$

DROP PROCEDURE IF EXISTS `SelectClassroomMaterials`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SelectClassroomMaterials` (IN `ClassroomID` INT(11))  BEGIN
/*
Select Materials Present within this classroom (as defined)
*/
SELECT tbl_materials.id, tbl_materials.m_name, tbl_materials.m_description
FROM link_materials
INNER JOIN tbl_materials ON tbl_materials.id = link_materials.file_id
INNER JOIN tbl_classroom ON tbl_classroom.id = link_materials.class_id
WHERE link_materials.drp = FALSE AND link_materials.class_id = ClassroomID;
END$$

DROP PROCEDURE IF EXISTS `SelectClassrooms`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SelectClassrooms` ()  BEGIN
SELECT * FROM tbl_classroom WHERE drp = FALSE;
END$$

DROP PROCEDURE IF EXISTS `SelectClassroomsInnerjoin`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SelectClassroomsInnerjoin` (IN `thisid` INT(11))  BEGIN
SELECT tbl_classroom.id, tbl_classroom.class_name, tbl_user.user_name FROM link_class
INNER JOIN tbl_classroom ON tbl_classroom.id = link_class.class_id
INNER JOIN tbl_user ON tbl_user.user_id = link_class.user_id 
WHERE link_class.drp = false AND link_class.user_id = thisid;
END$$

DROP PROCEDURE IF EXISTS `SelectDays`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SelectDays` ()  BEGIN
/*
Select ALL the available Days
*/
SELECT * FROM tbl_days;
END$$

DROP PROCEDURE IF EXISTS `SelectEnrolledClassForThisStudent`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SelectEnrolledClassForThisStudent` (IN `StudentID` INT(11))  BEGIN
/*Select the Classrooms where this student is enrolled in
Use this for Classroom Dialog*/
SELECT tbl_classroom.id, tbl_classroom.class_name, tbl_classroom.class_descrpition, tbl_classroom.classType
FROM link_enrollment
INNER JOIN tbl_classroom ON tbl_classroom.id = link_enrollment.class_id
INNER JOIN tbl_user ON tbl_user.user_id = link_enrollment.user_id
WHERE link_enrollment.drp = FALSE AND link_enrollment.user_id = StudentID;

END$$

DROP PROCEDURE IF EXISTS `SelectEnrolledStudentsInThisClass`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SelectEnrolledStudentsInThisClass` (IN `ClassID` INT(11))  BEGIN
/*
Select all the Enrolled students to THIS class (define which class)
*/
SELECT tbl_classroom.id, tbl_classroom.class_name, tbl_user.user_name
FROM link_enrollment
INNER JOIN tbl_classroom ON tbl_classroom.id = link_enrollment.class_id
INNER JOIN tbl_user ON tbl_user.user_id = link_enrollment.user_id
WHERE link_enrollment.drp = FALSE AND link_enrollment.class_id = ClassID;

END$$

DROP PROCEDURE IF EXISTS `SelectExamsFromThisClass`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SelectExamsFromThisClass` (IN `ClassroomID` INT(11))  BEGIN
/*
Select EXAMS from this relevant Class
*/
SELECT 
tbl_exams.id,
tbl_exams.exam_name, 
tbl_exams.xml_base 
FROM
link_quiz
INNER JOIN tbl_exams ON tbl_exams.id = link_exams.id
WHERE link_exams.class_id = ClassroomID;
END$$

DROP PROCEDURE IF EXISTS `SelectFullClassroom`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SelectFullClassroom` ()  BEGIN
/*
Select all the full data from Tbl_Classroom
USe this for Classroom Dialog
*/
SELECT id, class_name, class_description, classType FROM tbl_classroom;
END$$

DROP PROCEDURE IF EXISTS `SelectGradesExam`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SelectGradesExam` (IN `UserID` INT(11), `ClassID` INT(11))  BEGIN
SELECT * FROM link_examgrades WHERE class_id = ClassID AND user_id = UserID AND drp = FALSE;
END$$

DROP PROCEDURE IF EXISTS `SelectGradesQuizes`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SelectGradesQuizes` (IN `UserID` INT(11), IN `ClassID` INT(11))  BEGIN
SELECT * FROM link_quizgrades WHERE class_id = ClassID AND user_id = UserID AND drp = FALSE;
END$$

DROP PROCEDURE IF EXISTS `SelectInstructorClassroom`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SelectInstructorClassroom` (IN `ProfessorID` INT(11))  BEGIN
/*
Select the Professor and the Classroom they are related to
*/
SELECT tbl_user.user_id, tbl_user.user_name, tbl_user.user_fname, tbl_user.user_mi, tbl_user.user_lname, tbl_classroom.id, tbl_classroom.class_name
FROM link_professors
INNER JOIN tbl_user ON link_professors.professor_id = tbl_user.user_id
INNER JOIN tbl_classroom ON link_professor.class_id = tbl_classroom.id
WHERE link_professors.professor_id = ProfessorID AND link_professors.drp = FALSE;
END$$

DROP PROCEDURE IF EXISTS `SelectProfessorsNoDrp`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SelectProfessorsNoDrp` ()  BEGIN
/*
Select all available registered users as Professors from database
*/
SELECT tbl_user.user_id, tbl_user.user_name FROM tbl_user WHERE isActive = TRUE AND user_type = 1;
END$$

DROP PROCEDURE IF EXISTS `SelectQuizesFromThisClass`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SelectQuizesFromThisClass` (IN `ClassroomID` INT(11))  BEGIN
/*
Select all the relvant QUizes to this classroom
*/
SELECT tbl_quizes.id, tbl_quizes.quest_name, tbl_quizes.xml_base, tbl_quizes.state_long FROM
link_quiz
INNER JOIN tbl_quizes ON tbl_quizes.id = link_quiz.id
WHERE link_quiz.class_id = ClassroomID;
END$$

DROP PROCEDURE IF EXISTS `SelectSchedulesClassroom`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SelectSchedulesClassroom` (IN `ClassID` INT(11))  BEGIN
SELECT 
tbl_classroom.class_name,
tbl_classroom.id,
tbl_classroom.class_description,
tbl_classroom.classType,
tbl_time.timedesc,
tbl_time.timeslotID,
tbl_time.timestart,
tbl_days.description,
tbl_days.id
FROM 
link_schedule
INNER JOIN tbl_classroom ON link_schedule.classid = tbl_classroom.id
INNER JOIN tbl_time ON link_schedule.timeid = tbl_time.timeslotID
INNER JOIN tbl_days ON link_schedule.dayid = tbl_days.id
WHERE link_schedule.classid = ClassID
;
END$$

DROP PROCEDURE IF EXISTS `SelectSchedulesDetailed`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SelectSchedulesDetailed` ()  BEGIN
SELECT 
tbl_classroom.class_name,
tbl_classroom.id,
tbl_classroom.class_description,
tbl_classroom.classType,
tbl_time.timedesc,
tbl_time.timeslotID,
tbl_time.timestart,
tbl_days.description,
tbl_days.id
FROM 
link_schedule
INNER JOIN tbl_classroom ON link_schedule.classid = tbl_classroom.id
INNER JOIN tbl_time ON link_schedule.timeid = tbl_time.timeslotID
INNER JOIN tbl_days ON link_schedule.dayid = tbl_days.id
;
END$$

DROP PROCEDURE IF EXISTS `SelectTime`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SelectTime` ()  BEGIN
SELECT * FROM tbl_time;
END$$

DROP PROCEDURE IF EXISTS `SelectUserChallenge`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SelectUserChallenge` (IN `UserID` INT(11))  BEGIN
SELECT
tbl_squestions.sqTEXT, tbl_user.sec_ans
FROM tbl_user
INNER JOIN tbl_squestions ON tbl_squestions.sqID = tbl_user.questionIndex
WHERE tbl_user.user_id = UserID;
END$$

DROP PROCEDURE IF EXISTS `SetUserOnline`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SetUserOnline` (IN `UserID` INT(11), IN `UserState` BOOLEAN)  BEGIN
/*
Set defined User AS ONLINE/OFFLINE (userstate)
*/
UPDATE tbl_user SET isOnline = UserState WHERE user_id = UserID;
END$$

DROP PROCEDURE IF EXISTS `UpdateUserPassword`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateUserPassword` (IN `UserID` INT(11), IN `Salt` VARCHAR(255), IN `SaltedPassword` VARCHAR(255))  BEGIN
UPDATE tbl_user SET user_leagueoflegends = Salt, user_password = SaltedPassword WHERE user_name = UserID;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `lim_gender`
--

DROP TABLE IF EXISTS `lim_gender`;
CREATE TABLE `lim_gender` (
  `genderID` int(1) NOT NULL,
  `gender` varchar(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `lim_gender`
--

INSERT INTO `lim_gender` (`genderID`, `gender`) VALUES
(0, 'MALE'),
(1, 'FEMALE');

-- --------------------------------------------------------

--
-- Table structure for table `lim_usertype`
--

DROP TABLE IF EXISTS `lim_usertype`;
CREATE TABLE `lim_usertype` (
  `userTypeInt` int(1) NOT NULL,
  `userType` varchar(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='types of available users';

--
-- Dumping data for table `lim_usertype`
--

INSERT INTO `lim_usertype` (`userTypeInt`, `userType`) VALUES
(1, 'ADM'),
(2, 'PRO'),
(3, 'STU');

-- --------------------------------------------------------

--
-- Table structure for table `link_articles`
--

DROP TABLE IF EXISTS `link_articles`;
CREATE TABLE `link_articles` (
  `id` int(11) NOT NULL,
  `class_id` int(11) DEFAULT NULL,
  `file_id` int(11) DEFAULT NULL,
  `drp` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Links the Articles and their corresponding Classes';

--
-- Dumping data for table `link_articles`
--

INSERT INTO `link_articles` (`id`, `class_id`, `file_id`, `drp`) VALUES
(1, 2, 2, 0),
(2, 2, 3, 0),
(3, 3, 4, 0);

-- --------------------------------------------------------

--
-- Table structure for table `link_class`
--

DROP TABLE IF EXISTS `link_class`;
CREATE TABLE `link_class` (
  `id` int(11) NOT NULL,
  `class_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `drp` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='merge table CLASS X USER';

-- --------------------------------------------------------

--
-- Table structure for table `link_classroomgrades`
--

DROP TABLE IF EXISTS `link_classroomgrades`;
CREATE TABLE `link_classroomgrades` (
  `id_classroomgrades` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `class_id` int(11) DEFAULT NULL,
  `class_grade` decimal(5,2) DEFAULT NULL,
  `drp` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `link_enrollment`
--

DROP TABLE IF EXISTS `link_enrollment`;
CREATE TABLE `link_enrollment` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `class_id` int(11) DEFAULT NULL,
  `drp` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `link_enrollment`
--

INSERT INTO `link_enrollment` (`id`, `user_id`, `class_id`, `drp`) VALUES
(1, 10, 3, 0),
(2, 10, 2, 0),
(3, 10, 3, 0);

-- --------------------------------------------------------

--
-- Table structure for table `link_examgrades`
--

DROP TABLE IF EXISTS `link_examgrades`;
CREATE TABLE `link_examgrades` (
  `idlink_examgrades` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `exam_id` int(11) NOT NULL,
  `exam_grade` decimal(5,2) NOT NULL,
  `exam_hits` int(3) NOT NULL,
  `exam_questions` int(3) NOT NULL,
  `drp` tinyint(4) NOT NULL,
  `class_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `link_exams`
--

DROP TABLE IF EXISTS `link_exams`;
CREATE TABLE `link_exams` (
  `id` int(11) NOT NULL,
  `class_id` int(11) NOT NULL,
  `file_id` int(11) NOT NULL,
  `drp` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `link_feedback`
--

DROP TABLE IF EXISTS `link_feedback`;
CREATE TABLE `link_feedback` (
  `id` datetime NOT NULL,
  `receiver_id` int(11) DEFAULT NULL,
  `sender_id` int(11) DEFAULT NULL,
  `payload` varchar(70) DEFAULT NULL,
  `viewed` tinyint(4) DEFAULT NULL,
  `voided` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='use LINUX MILLISECONDS TIME STAMP FOR VB.NET';

-- --------------------------------------------------------

--
-- Table structure for table `link_materials`
--

DROP TABLE IF EXISTS `link_materials`;
CREATE TABLE `link_materials` (
  `id` int(11) NOT NULL,
  `class_id` int(11) DEFAULT NULL,
  `file_id` int(11) DEFAULT NULL,
  `drp` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `link_professors`
--

DROP TABLE IF EXISTS `link_professors`;
CREATE TABLE `link_professors` (
  `id` int(11) NOT NULL,
  `class_id` int(11) NOT NULL,
  `professor_id` int(11) NOT NULL,
  `drp` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='relationship between Professors and Classes';

-- --------------------------------------------------------

--
-- Table structure for table `link_quiz`
--

DROP TABLE IF EXISTS `link_quiz`;
CREATE TABLE `link_quiz` (
  `id` int(11) NOT NULL,
  `quiz_id` int(11) NOT NULL,
  `class_id` int(11) NOT NULL,
  `drp` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Link between Quiz X Class';

--
-- Dumping data for table `link_quiz`
--

INSERT INTO `link_quiz` (`id`, `quiz_id`, `class_id`, `drp`) VALUES
(1, 3, 2, 0),
(2, 3, 3, 0),
(3, 5, 3, 0);

-- --------------------------------------------------------

--
-- Table structure for table `link_quizgrades`
--

DROP TABLE IF EXISTS `link_quizgrades`;
CREATE TABLE `link_quizgrades` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `quiz_id` int(11) NOT NULL,
  `quiz_grade` decimal(5,2) NOT NULL,
  `quiz_hits` int(3) NOT NULL,
  `quiz_questions` int(3) NOT NULL,
  `drp` tinyint(1) NOT NULL,
  `class_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `link_quizgrades`
--

INSERT INTO `link_quizgrades` (`id`, `user_id`, `quiz_id`, `quiz_grade`, `quiz_hits`, `quiz_questions`, `drp`, `class_id`) VALUES
(1, 0, 3, '40.00', 40, 100, 0, 0),
(2, 0, 2, '80.00', 80, 100, 0, 0),
(3, 0, 3, '67.00', 67, 100, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `link_schedule`
--

DROP TABLE IF EXISTS `link_schedule`;
CREATE TABLE `link_schedule` (
  `id` int(11) NOT NULL,
  `dayid` int(11) DEFAULT NULL,
  `timeid` int(11) DEFAULT NULL,
  `classid` int(11) DEFAULT NULL,
  `drp` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `link_schedule`
--

INSERT INTO `link_schedule` (`id`, `dayid`, `timeid`, `classid`, `drp`) VALUES
(1, 4, 3, 3, 0);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_articles`
--

DROP TABLE IF EXISTS `tbl_articles`;
CREATE TABLE `tbl_articles` (
  `id` int(11) NOT NULL,
  `file_name` varchar(20) NOT NULL,
  `file_size` int(11) NOT NULL,
  `file_blob` blob NOT NULL,
  `drp` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_articles`
--

INSERT INTO `tbl_articles` (`id`, `file_name`, `file_size`, `file_blob`, `drp`) VALUES
(1, 'living', 0, 0x7b5c727466315c616e73695c616e7369637067313235325c64656666305c6465666c616e67313033337b5c666f6e7474626c7b5c66305c666e696c5c666368617273657430204d6963726f736f66742053616e732053657269663b7d7d0d0a5c766965776b696e64345c7563315c706172645c66305c667331372068617070696e65737320616e64206574635c7061720d0a746869732069732066756e5c7061720d0a70726f6261626c793f5c7061720d0a7d0d0a, 0),
(2, 'batman', 0, 0x7b5c727466315c616e73695c616e7369637067313235325c64656666305c6465666c616e67313033337b5c666f6e7474626c7b5c66305c666e696c5c666368617273657430204d6963726f736f66742053616e732053657269663b7d7d0d0a5c766965776b696e64345c7563315c706172645c66305c667331372062616e6520666561747572656420736f6d6520737475666620696e206261746d616e5c7061720d0a7d0d0a, 0),
(3, 'crazebraze', 0, 0x7b5c727466315c616e73695c616e7369637067313235325c64656666305c6465666c616e67313033337b5c666f6e7474626c7b5c66305c666e696c5c666368617273657430204d6963726f736f66742053616e732053657269663b7d7d0d0a5c766965776b696e64345c7563315c706172645c66305c66733137206372617a79207468696e6773206172652077656972642e2e2079656168215c7061720d0a7d0d0a, 0),
(4, 'brownfox', 0, 0x7b5c727466315c616e73695c616e7369637067313235325c64656666305c6465666c616e67313033337b5c666f6e7474626c7b5c66305c666e696c5c6663686172736574302043616c696272693b7d7b5c66315c666e696c5c666368617273657430204d6963726f736f66742053616e732053657269663b7d7d0d0a5c766965776b696e64345c7563315c706172645c6c616e67395c66305c6673323220546865205c6220717569636b205c62305c692062726f776e205c756c5c693020666f78205c756c6e6f6e65206a756d706564206f76657220746865206c617a7920646f675c7061720d0a546865205c6220717569636b205c62305c692062726f776e205c756c5c693020666f78205c756c6e6f6e65206a756d706564206f76657220746865206c617a7920646f675c7061720d0a546865205c6220717569636b205c62305c692062726f776e205c756c5c693020666f78205c756c6e6f6e65206a756d706564206f76657220746865206c617a7920646f675c6c616e67313033335c66315c667331375c7061720d0a7d0d0a, 0),
(5, 'batman', 0, 0x7b5c727466315c616e73695c616e7369637067313235325c64656666305c6465666c616e67313033337b5c666f6e7474626c7b5c66305c666e696c5c666368617273657430204d6963726f736f66742053616e732053657269663b7d7d0d0a5c766965776b696e64345c7563315c706172645c66305c6673313720626174206d616e2069732070726574747920636f6f6c20696620796f752061736b206d655c7061720d0a7d0d0a, 0),
(6, 'batman', 0, 0x7b5c727466315c616e73695c616e7369637067313235325c64656666305c6465666c616e67313033337b5c666f6e7474626c7b5c66305c666e696c5c666368617273657430204d6963726f736f66742053616e732053657269663b7d7d0d0a7b5c636f6c6f7274626c203b5c726564305c677265656e305c626c7565303b7d0d0a5c766965776b696e64345c7563315c706172645c6366315c625c66305c66733137202254686520717569636b2062726f776e20666f78206a756d7073206f76657220746865206c617a7920646f6722205c6366305c62305c7061720d0a7d0d0a, 0);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_classroom`
--

DROP TABLE IF EXISTS `tbl_classroom`;
CREATE TABLE `tbl_classroom` (
  `id` int(11) NOT NULL,
  `class_name` varchar(20) NOT NULL,
  `class_description` varchar(20) NOT NULL,
  `classType` int(1) NOT NULL,
  `drp` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='this is where the classes are stored';

--
-- Dumping data for table `tbl_classroom`
--

INSERT INTO `tbl_classroom` (`id`, `class_name`, `class_description`, `classType`, `drp`) VALUES
(1, 'test', 'testing class', 0, 0),
(2, 'Yolo202', 'live once', 0, 0),
(3, 'CS330', 'MORE PROGRAMMING', 0, 0),
(4, 'Psychology 101', 'Psychology 101 class', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_days`
--

DROP TABLE IF EXISTS `tbl_days`;
CREATE TABLE `tbl_days` (
  `id` int(1) NOT NULL,
  `description` varchar(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='contains the days for the whole week';

--
-- Dumping data for table `tbl_days`
--

INSERT INTO `tbl_days` (`id`, `description`) VALUES
(1, 'SUN'),
(2, 'MON'),
(3, 'TUE'),
(4, 'WED'),
(5, 'THU'),
(6, 'FRI'),
(7, 'SAT');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_exams`
--

DROP TABLE IF EXISTS `tbl_exams`;
CREATE TABLE `tbl_exams` (
  `id` int(11) NOT NULL,
  `exam_name` varchar(45) NOT NULL,
  `xml_base` mediumtext NOT NULL,
  `drp` tinyint(4) NOT NULL,
  `exam_pin` varchar(8) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='this is where all the raw exams are stored for REFERENCE';

-- --------------------------------------------------------

--
-- Table structure for table `tbl_grades`
--

DROP TABLE IF EXISTS `tbl_grades`;
CREATE TABLE `tbl_grades` (
  `id` int(11) NOT NULL,
  `mark` varchar(3) NOT NULL,
  `alphabetical` varchar(2) NOT NULL,
  `description` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_loggedstatus`
--

DROP TABLE IF EXISTS `tbl_loggedstatus`;
CREATE TABLE `tbl_loggedstatus` (
  `case_id` int(11) NOT NULL,
  `userid` int(11) DEFAULT NULL,
  `loggedstate` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='View for whoever is logged in and logged out';

-- --------------------------------------------------------

--
-- Table structure for table `tbl_markingexam`
--

DROP TABLE IF EXISTS `tbl_markingexam`;
CREATE TABLE `tbl_markingexam` (
  `id` int(11) NOT NULL,
  `exam_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `marked` tinyint(4) DEFAULT NULL,
  `mdate` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_markingquiz`
--

DROP TABLE IF EXISTS `tbl_markingquiz`;
CREATE TABLE `tbl_markingquiz` (
  `id` int(11) NOT NULL,
  `quiz_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `marked` tinyint(4) DEFAULT NULL,
  `mdate` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_markingquiz`
--

INSERT INTO `tbl_markingquiz` (`id`, `quiz_id`, `user_id`, `marked`, `mdate`) VALUES
(1, 3, 0, 0, '2018-02-05 10:37:37'),
(2, 2, 0, 0, '2018-02-05 21:15:48'),
(3, 3, 0, 0, '2018-02-05 21:52:08');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_materials`
--

DROP TABLE IF EXISTS `tbl_materials`;
CREATE TABLE `tbl_materials` (
  `id` int(11) NOT NULL,
  `m_name` varchar(45) NOT NULL,
  `m_description` varchar(45) NOT NULL,
  `drp` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='this is where all the default MATERIALS are stored for reference';

--
-- Dumping data for table `tbl_materials`
--

INSERT INTO `tbl_materials` (`id`, `m_name`, `m_description`, `drp`) VALUES
(1, 'Chocolate', 'hello = )', 0),
(2, 'Pencils', 'Some pencils', 0),
(3, 'Pen', 'you know the drill', 0),
(4, 'A Cellphone', 'well, it is something', 0),
(5, 'Chocolate', 'well... gotta have the energy', 0),
(6, 'pencils', 'some more pencils!!', 0),
(7, 'cake', 'because everyday is a good day to eat cake', 0),
(8, 'batarangs', 'they are used by batman', 0);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_quizes`
--

DROP TABLE IF EXISTS `tbl_quizes`;
CREATE TABLE `tbl_quizes` (
  `id` int(11) NOT NULL,
  `quest_name` varchar(20) NOT NULL,
  `xml_base` mediumtext NOT NULL,
  `state_long` tinyint(3) NOT NULL,
  `drp` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='This is where all the present quizes are stored in the system';

--
-- Dumping data for table `tbl_quizes`
--

INSERT INTO `tbl_quizes` (`id`, `quest_name`, `xml_base`, `state_long`, `drp`) VALUES
(1, 'Quest0', '<?xml version=\"1.0\" encoding=\"utf-16\"?>\n<ArrayOfC_SmallQuestion xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\">\n  <c_SmallQuestion>\n    <QuestionNumber>1</QuestionNumber>\n    <QuestionBase>correct answer is : 0</QuestionBase>\n    <Distractor1>THGCQR1Q</Distractor1>\n    <Distractor2>THGCQR1Q</Distractor2>\n    <Distractor3>THGCQR1Q</Distractor3>\n    <Distractor4>0</Distractor4>\n    <TrueAnswer>0</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>2</QuestionNumber>\n    <QuestionBase>correct answer is : 1</QuestionBase>\n    <Distractor1>THGCQR1Q</Distractor1>\n    <Distractor2>THGCQR1Q</Distractor2>\n    <Distractor3>THGCQR1Q</Distractor3>\n    <Distractor4>1</Distractor4>\n    <TrueAnswer>1</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>3</QuestionNumber>\n    <QuestionBase>correct answer is : 2</QuestionBase>\n    <Distractor1>THGCQR1Q</Distractor1>\n    <Distractor2>THGCQR1Q</Distractor2>\n    <Distractor3>THGCQR1Q</Distractor3>\n    <Distractor4>2</Distractor4>\n    <TrueAnswer>2</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>4</QuestionNumber>\n    <QuestionBase>correct answer is : 3</QuestionBase>\n    <Distractor1>NVXJIVSA</Distractor1>\n    <Distractor2>NVXJIVSA</Distractor2>\n    <Distractor3>NVXJIVSA</Distractor3>\n    <Distractor4>3</Distractor4>\n    <TrueAnswer>3</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>5</QuestionNumber>\n    <QuestionBase>correct answer is : 4</QuestionBase>\n    <Distractor1>NVXJIVSA</Distractor1>\n    <Distractor2>NVXJIVSA</Distractor2>\n    <Distractor3>NVXJIVSA</Distractor3>\n    <Distractor4>4</Distractor4>\n    <TrueAnswer>4</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>6</QuestionNumber>\n    <QuestionBase>correct answer is : 5</QuestionBase>\n    <Distractor1>NVXJIVSA</Distractor1>\n    <Distractor2>NVXJIVSA</Distractor2>\n    <Distractor3>NVXJIVSA</Distractor3>\n    <Distractor4>5</Distractor4>\n    <TrueAnswer>5</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>7</QuestionNumber>\n    <QuestionBase>correct answer is : 6</QuestionBase>\n    <Distractor1>NVXJIVSA</Distractor1>\n    <Distractor2>NVXJIVSA</Distractor2>\n    <Distractor3>NVXJIVSA</Distractor3>\n    <Distractor4>6</Distractor4>\n    <TrueAnswer>6</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>8</QuestionNumber>\n    <QuestionBase>correct answer is : 7</QuestionBase>\n    <Distractor1>NVXJIVSA</Distractor1>\n    <Distractor2>NVXJIVSA</Distractor2>\n    <Distractor3>NVXJIVSA</Distractor3>\n    <Distractor4>7</Distractor4>\n    <TrueAnswer>7</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>9</QuestionNumber>\n    <QuestionBase>correct answer is : 8</QuestionBase>\n    <Distractor1>NVXJIVSA</Distractor1>\n    <Distractor2>NVXJIVSA</Distractor2>\n    <Distractor3>NVXJIVSA</Distractor3>\n    <Distractor4>8</Distractor4>\n    <TrueAnswer>8</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>10</QuestionNumber>\n    <QuestionBase>correct answer is : 9</QuestionBase>\n    <Distractor1>NVXJIVSA</Distractor1>\n    <Distractor2>NVXJIVSA</Distractor2>\n    <Distractor3>NVXJIVSA</Distractor3>\n    <Distractor4>9</Distractor4>\n    <TrueAnswer>9</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>11</QuestionNumber>\n    <QuestionBase>correct answer is : 10</QuestionBase>\n    <Distractor1>NVXJIVSA</Distractor1>\n    <Distractor2>NVXJIVSA</Distractor2>\n    <Distractor3>NVXJIVSA</Distractor3>\n    <Distractor4>10</Distractor4>\n    <TrueAnswer>10</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>12</QuestionNumber>\n    <QuestionBase>correct answer is : 11</QuestionBase>\n    <Distractor1>NVXJIVSA</Distractor1>\n    <Distractor2>NVXJIVSA</Distractor2>\n    <Distractor3>NVXJIVSA</Distractor3>\n    <Distractor4>11</Distractor4>\n    <TrueAnswer>11</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>13</QuestionNumber>\n    <QuestionBase>correct answer is : 12</QuestionBase>\n    <Distractor1>NVXJIVSA</Distractor1>\n    <Distractor2>NVXJIVSA</Distractor2>\n    <Distractor3>NVXJIVSA</Distractor3>\n    <Distractor4>12</Distractor4>\n    <TrueAnswer>12</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>14</QuestionNumber>\n    <QuestionBase>correct answer is : 13</QuestionBase>\n    <Distractor1>NVXJIVSA</Distractor1>\n    <Distractor2>NVXJIVSA</Distractor2>\n    <Distractor3>NVXJIVSA</Distractor3>\n    <Distractor4>13</Distractor4>\n    <TrueAnswer>13</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>15</QuestionNumber>\n    <QuestionBase>correct answer is : 14</QuestionBase>\n    <Distractor1>NVXJIVSA</Distractor1>\n    <Distractor2>NVXJIVSA</Distractor2>\n    <Distractor3>NVXJIVSA</Distractor3>\n    <Distractor4>14</Distractor4>\n    <TrueAnswer>14</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>16</QuestionNumber>\n    <QuestionBase>correct answer is : 15</QuestionBase>\n    <Distractor1>0K4XQUYB</Distractor1>\n    <Distractor2>0K4XQUYB</Distractor2>\n    <Distractor3>0K4XQUYB</Distractor3>\n    <Distractor4>15</Distractor4>\n    <TrueAnswer>15</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>17</QuestionNumber>\n    <QuestionBase>correct answer is : 16</QuestionBase>\n    <Distractor1>0K4XQUYB</Distractor1>\n    <Distractor2>0K4XQUYB</Distractor2>\n    <Distractor3>0K4XQUYB</Distractor3>\n    <Distractor4>16</Distractor4>\n    <TrueAnswer>16</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>18</QuestionNumber>\n    <QuestionBase>correct answer is : 17</QuestionBase>\n    <Distractor1>0K4XQUYB</Distractor1>\n    <Distractor2>0K4XQUYB</Distractor2>\n    <Distractor3>0K4XQUYB</Distractor3>\n    <Distractor4>17</Distractor4>\n    <TrueAnswer>17</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>19</QuestionNumber>\n    <QuestionBase>correct answer is : 18</QuestionBase>\n    <Distractor1>0K4XQUYB</Distractor1>\n    <Distractor2>0K4XQUYB</Distractor2>\n    <Distractor3>0K4XQUYB</Distractor3>\n    <Distractor4>18</Distractor4>\n    <TrueAnswer>18</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>20</QuestionNumber>\n    <QuestionBase>correct answer is : 19</QuestionBase>\n    <Distractor1>0K4XQUYB</Distractor1>\n    <Distractor2>0K4XQUYB</Distractor2>\n    <Distractor3>0K4XQUYB</Distractor3>\n    <Distractor4>19</Distractor4>\n    <TrueAnswer>19</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>21</QuestionNumber>\n    <QuestionBase>correct answer is : 20</QuestionBase>\n    <Distractor1>0K4XQUYB</Distractor1>\n    <Distractor2>0K4XQUYB</Distractor2>\n    <Distractor3>0K4XQUYB</Distractor3>\n    <Distractor4>20</Distractor4>\n    <TrueAnswer>20</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>22</QuestionNumber>\n    <QuestionBase>correct answer is : 21</QuestionBase>\n    <Distractor1>0K4XQUYB</Distractor1>\n    <Distractor2>0K4XQUYB</Distractor2>\n    <Distractor3>0K4XQUYB</Distractor3>\n    <Distractor4>21</Distractor4>\n    <TrueAnswer>21</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>23</QuestionNumber>\n    <QuestionBase>correct answer is : 22</QuestionBase>\n    <Distractor1>0K4XQUYB</Distractor1>\n    <Distractor2>0K4XQUYB</Distractor2>\n    <Distractor3>0K4XQUYB</Distractor3>\n    <Distractor4>22</Distractor4>\n    <TrueAnswer>22</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>24</QuestionNumber>\n    <QuestionBase>correct answer is : 23</QuestionBase>\n    <Distractor1>0K4XQUYB</Distractor1>\n    <Distractor2>0K4XQUYB</Distractor2>\n    <Distractor3>0K4XQUYB</Distractor3>\n    <Distractor4>23</Distractor4>\n    <TrueAnswer>23</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>25</QuestionNumber>\n    <QuestionBase>correct answer is : 24</QuestionBase>\n    <Distractor1>0K4XQUYB</Distractor1>\n    <Distractor2>0K4XQUYB</Distractor2>\n    <Distractor3>0K4XQUYB</Distractor3>\n    <Distractor4>24</Distractor4>\n    <TrueAnswer>24</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>26</QuestionNumber>\n    <QuestionBase>correct answer is : 25</QuestionBase>\n    <Distractor1>0K4XQUYB</Distractor1>\n    <Distractor2>0K4XQUYB</Distractor2>\n    <Distractor3>0K4XQUYB</Distractor3>\n    <Distractor4>25</Distractor4>\n    <TrueAnswer>25</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>27</QuestionNumber>\n    <QuestionBase>correct answer is : 26</QuestionBase>\n    <Distractor1>0K4XQUYB</Distractor1>\n    <Distractor2>0K4XQUYB</Distractor2>\n    <Distractor3>0K4XQUYB</Distractor3>\n    <Distractor4>26</Distractor4>\n    <TrueAnswer>26</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>28</QuestionNumber>\n    <QuestionBase>correct answer is : 27</QuestionBase>\n    <Distractor1>0K4XQUYB</Distractor1>\n    <Distractor2>0K4XQUYB</Distractor2>\n    <Distractor3>0K4XQUYB</Distractor3>\n    <Distractor4>27</Distractor4>\n    <TrueAnswer>27</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>29</QuestionNumber>\n    <QuestionBase>correct answer is : 28</QuestionBase>\n    <Distractor1>DABDYU4C</Distractor1>\n    <Distractor2>DABDYU4C</Distractor2>\n    <Distractor3>DABDYU4C</Distractor3>\n    <Distractor4>28</Distractor4>\n    <TrueAnswer>28</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>30</QuestionNumber>\n    <QuestionBase>correct answer is : 29</QuestionBase>\n    <Distractor1>DABDYU4C</Distractor1>\n    <Distractor2>DABDYU4C</Distractor2>\n    <Distractor3>DABDYU4C</Distractor3>\n    <Distractor4>29</Distractor4>\n    <TrueAnswer>29</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>31</QuestionNumber>\n    <QuestionBase>correct answer is : 30</QuestionBase>\n    <Distractor1>DABDYU4C</Distractor1>\n    <Distractor2>DABDYU4C</Distractor2>\n    <Distractor3>DABDYU4C</Distractor3>\n    <Distractor4>30</Distractor4>\n    <TrueAnswer>30</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>32</QuestionNumber>\n    <QuestionBase>correct answer is : 31</QuestionBase>\n    <Distractor1>DABDYU4C</Distractor1>\n    <Distractor2>DABDYU4C</Distractor2>\n    <Distractor3>DABDYU4C</Distractor3>\n    <Distractor4>31</Distractor4>\n    <TrueAnswer>31</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>33</QuestionNumber>\n    <QuestionBase>correct answer is : 32</QuestionBase>\n    <Distractor1>DABDYU4C</Distractor1>\n    <Distractor2>DABDYU4C</Distractor2>\n    <Distractor3>DABDYU4C</Distractor3>\n    <Distractor4>32</Distractor4>\n    <TrueAnswer>32</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>34</QuestionNumber>\n    <QuestionBase>correct answer is : 33</QuestionBase>\n    <Distractor1>DABDYU4C</Distractor1>\n    <Distractor2>DABDYU4C</Distractor2>\n    <Distractor3>DABDYU4C</Distractor3>\n    <Distractor4>33</Distractor4>\n    <TrueAnswer>33</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>35</QuestionNumber>\n    <QuestionBase>correct answer is : 34</QuestionBase>\n    <Distractor1>DABDYU4C</Distractor1>\n    <Distractor2>DABDYU4C</Distractor2>\n    <Distractor3>DABDYU4C</Distractor3>\n    <Distractor4>34</Distractor4>\n    <TrueAnswer>34</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>36</QuestionNumber>\n    <QuestionBase>correct answer is : 35</QuestionBase>\n    <Distractor1>DABDYU4C</Distractor1>\n    <Distractor2>DABDYU4C</Distractor2>\n    <Distractor3>DABDYU4C</Distractor3>\n    <Distractor4>35</Distractor4>\n    <TrueAnswer>35</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>37</QuestionNumber>\n    <QuestionBase>correct answer is : 36</QuestionBase>\n    <Distractor1>DABDYU4C</Distractor1>\n    <Distractor2>DABDYU4C</Distractor2>\n    <Distractor3>DABDYU4C</Distractor3>\n    <Distractor4>36</Distractor4>\n    <TrueAnswer>36</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>38</QuestionNumber>\n    <QuestionBase>correct answer is : 37</QuestionBase>\n    <Distractor1>DABDYU4C</Distractor1>\n    <Distractor2>DABDYU4C</Distractor2>\n    <Distractor3>DABDYU4C</Distractor3>\n    <Distractor4>37</Distractor4>\n    <TrueAnswer>37</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>39</QuestionNumber>\n    <QuestionBase>correct answer is : 38</QuestionBase>\n    <Distractor1>DABDYU4C</Distractor1>\n    <Distractor2>DABDYU4C</Distractor2>\n    <Distractor3>DABDYU4C</Distractor3>\n    <Distractor4>38</Distractor4>\n    <TrueAnswer>38</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>40</QuestionNumber>\n    <QuestionBase>correct answer is : 39</QuestionBase>\n    <Distractor1>DABDYU4C</Distractor1>\n    <Distractor2>DABDYU4C</Distractor2>\n    <Distractor3>DABDYU4C</Distractor3>\n    <Distractor4>39</Distractor4>\n    <TrueAnswer>39</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>41</QuestionNumber>\n    <QuestionBase>correct answer is : 40</QuestionBase>\n    <Distractor1>DABDYU4C</Distractor1>\n    <Distractor2>DABDYU4C</Distractor2>\n    <Distractor3>DABDYU4C</Distractor3>\n    <Distractor4>40</Distractor4>\n    <TrueAnswer>40</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>42</QuestionNumber>\n    <QuestionBase>correct answer is : 41</QuestionBase>\n    <Distractor1>7OSKQYUU</Distractor1>\n    <Distractor2>7OSKQYUU</Distractor2>\n    <Distractor3>7OSKQYUU</Distractor3>\n    <Distractor4>41</Distractor4>\n    <TrueAnswer>41</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>43</QuestionNumber>\n    <QuestionBase>correct answer is : 42</QuestionBase>\n    <Distractor1>7OSKQYUU</Distractor1>\n    <Distractor2>7OSKQYUU</Distractor2>\n    <Distractor3>7OSKQYUU</Distractor3>\n    <Distractor4>42</Distractor4>\n    <TrueAnswer>42</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>44</QuestionNumber>\n    <QuestionBase>correct answer is : 43</QuestionBase>\n    <Distractor1>7OSKQYUU</Distractor1>\n    <Distractor2>7OSKQYUU</Distractor2>\n    <Distractor3>7OSKQYUU</Distractor3>\n    <Distractor4>43</Distractor4>\n    <TrueAnswer>43</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>45</QuestionNumber>\n    <QuestionBase>correct answer is : 44</QuestionBase>\n    <Distractor1>7OSKQYUU</Distractor1>\n    <Distractor2>7OSKQYUU</Distractor2>\n    <Distractor3>7OSKQYUU</Distractor3>\n    <Distractor4>44</Distractor4>\n    <TrueAnswer>44</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>46</QuestionNumber>\n    <QuestionBase>correct answer is : 45</QuestionBase>\n    <Distractor1>7OSKQYUU</Distractor1>\n    <Distractor2>7OSKQYUU</Distractor2>\n    <Distractor3>7OSKQYUU</Distractor3>\n    <Distractor4>45</Distractor4>\n    <TrueAnswer>45</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>47</QuestionNumber>\n    <QuestionBase>correct answer is : 46</QuestionBase>\n    <Distractor1>7OSKQYUU</Distractor1>\n    <Distractor2>7OSKQYUU</Distractor2>\n    <Distractor3>7OSKQYUU</Distractor3>\n    <Distractor4>46</Distractor4>\n    <TrueAnswer>46</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>48</QuestionNumber>\n    <QuestionBase>correct answer is : 47</QuestionBase>\n    <Distractor1>7OSKQYUU</Distractor1>\n    <Distractor2>7OSKQYUU</Distractor2>\n    <Distractor3>7OSKQYUU</Distractor3>\n    <Distractor4>47</Distractor4>\n    <TrueAnswer>47</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>49</QuestionNumber>\n    <QuestionBase>correct answer is : 48</QuestionBase>\n    <Distractor1>7OSKQYUU</Distractor1>\n    <Distractor2>7OSKQYUU</Distractor2>\n    <Distractor3>7OSKQYUU</Distractor3>\n    <Distractor4>48</Distractor4>\n    <TrueAnswer>48</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>50</QuestionNumber>\n    <QuestionBase>correct answer is : 49</QuestionBase>\n    <Distractor1>7OSKQYUU</Distractor1>\n    <Distractor2>7OSKQYUU</Distractor2>\n    <Distractor3>7OSKQYUU</Distractor3>\n    <Distractor4>49</Distractor4>\n    <TrueAnswer>49</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>51</QuestionNumber>\n    <QuestionBase>correct answer is : 50</QuestionBase>\n    <Distractor1>7OSKQYUU</Distractor1>\n    <Distractor2>7OSKQYUU</Distractor2>\n    <Distractor3>7OSKQYUU</Distractor3>\n    <Distractor4>50</Distractor4>\n    <TrueAnswer>50</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>52</QuestionNumber>\n    <QuestionBase>correct answer is : 51</QuestionBase>\n    <Distractor1>7OSKQYUU</Distractor1>\n    <Distractor2>7OSKQYUU</Distractor2>\n    <Distractor3>7OSKQYUU</Distractor3>\n    <Distractor4>51</Distractor4>\n    <TrueAnswer>51</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>53</QuestionNumber>\n    <QuestionBase>correct answer is : 52</QuestionBase>\n    <Distractor1>7OSKQYUU</Distractor1>\n    <Distractor2>7OSKQYUU</Distractor2>\n    <Distractor3>7OSKQYUU</Distractor3>\n    <Distractor4>52</Distractor4>\n    <TrueAnswer>52</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>54</QuestionNumber>\n    <QuestionBase>correct answer is : 53</QuestionBase>\n    <Distractor1>7OSKQYUU</Distractor1>\n    <Distractor2>7OSKQYUU</Distractor2>\n    <Distractor3>7OSKQYUU</Distractor3>\n    <Distractor4>53</Distractor4>\n    <TrueAnswer>53</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>55</QuestionNumber>\n    <QuestionBase>correct answer is : 54</QuestionBase>\n    <Distractor1>7OSKQYUU</Distractor1>\n    <Distractor2>7OSKQYUU</Distractor2>\n    <Distractor3>7OSKQYUU</Distractor3>\n    <Distractor4>54</Distractor4>\n    <TrueAnswer>54</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>56</QuestionNumber>\n    <QuestionBase>correct answer is : 55</QuestionBase>\n    <Distractor1>7OSKQYUU</Distractor1>\n    <Distractor2>7OSKQYUU</Distractor2>\n    <Distractor3>7OSKQYUU</Distractor3>\n    <Distractor4>55</Distractor4>\n    <TrueAnswer>55</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>57</QuestionNumber>\n    <QuestionBase>correct answer is : 56</QuestionBase>\n    <Distractor1>7OSKQYUU</Distractor1>\n    <Distractor2>7OSKQYUU</Distractor2>\n    <Distractor3>7OSKQYUU</Distractor3>\n    <Distractor4>56</Distractor4>\n    <TrueAnswer>56</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>58</QuestionNumber>\n    <QuestionBase>correct answer is : 57</QuestionBase>\n    <Distractor1>KDYYYX0V</Distractor1>\n    <Distractor2>KDYYYX0V</Distractor2>\n    <Distractor3>KDYYYX0V</Distractor3>\n    <Distractor4>57</Distractor4>\n    <TrueAnswer>57</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>59</QuestionNumber>\n    <QuestionBase>correct answer is : 58</QuestionBase>\n    <Distractor1>KDYYYX0V</Distractor1>\n    <Distractor2>KDYYYX0V</Distractor2>\n    <Distractor3>KDYYYX0V</Distractor3>\n    <Distractor4>58</Distractor4>\n    <TrueAnswer>58</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>60</QuestionNumber>\n    <QuestionBase>correct answer is : 59</QuestionBase>\n    <Distractor1>KDYYYX0V</Distractor1>\n    <Distractor2>KDYYYX0V</Distractor2>\n    <Distractor3>KDYYYX0V</Distractor3>\n    <Distractor4>59</Distractor4>\n    <TrueAnswer>59</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>61</QuestionNumber>\n    <QuestionBase>correct answer is : 60</QuestionBase>\n    <Distractor1>KDYYYX0V</Distractor1>\n    <Distractor2>KDYYYX0V</Distractor2>\n    <Distractor3>KDYYYX0V</Distractor3>\n    <Distractor4>60</Distractor4>\n    <TrueAnswer>60</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>62</QuestionNumber>\n    <QuestionBase>correct answer is : 61</QuestionBase>\n    <Distractor1>KDYYYX0V</Distractor1>\n    <Distractor2>KDYYYX0V</Distractor2>\n    <Distractor3>KDYYYX0V</Distractor3>\n    <Distractor4>61</Distractor4>\n    <TrueAnswer>61</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>63</QuestionNumber>\n    <QuestionBase>correct answer is : 62</QuestionBase>\n    <Distractor1>KDYYYX0V</Distractor1>\n    <Distractor2>KDYYYX0V</Distractor2>\n    <Distractor3>KDYYYX0V</Distractor3>\n    <Distractor4>62</Distractor4>\n    <TrueAnswer>62</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>64</QuestionNumber>\n    <QuestionBase>correct answer is : 63</QuestionBase>\n    <Distractor1>KDYYYX0V</Distractor1>\n    <Distractor2>KDYYYX0V</Distractor2>\n    <Distractor3>KDYYYX0V</Distractor3>\n    <Distractor4>63</Distractor4>\n    <TrueAnswer>63</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>65</QuestionNumber>\n    <QuestionBase>correct answer is : 64</QuestionBase>\n    <Distractor1>KDYYYX0V</Distractor1>\n    <Distractor2>KDYYYX0V</Distractor2>\n    <Distractor3>KDYYYX0V</Distractor3>\n    <Distractor4>64</Distractor4>\n    <TrueAnswer>64</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>66</QuestionNumber>\n    <QuestionBase>correct answer is : 65</QuestionBase>\n    <Distractor1>KDYYYX0V</Distractor1>\n    <Distractor2>KDYYYX0V</Distractor2>\n    <Distractor3>KDYYYX0V</Distractor3>\n    <Distractor4>65</Distractor4>\n    <TrueAnswer>65</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>67</QuestionNumber>\n    <QuestionBase>correct answer is : 66</QuestionBase>\n    <Distractor1>KDYYYX0V</Distractor1>\n    <Distractor2>KDYYYX0V</Distractor2>\n    <Distractor3>KDYYYX0V</Distractor3>\n    <Distractor4>66</Distractor4>\n    <TrueAnswer>66</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>68</QuestionNumber>\n    <QuestionBase>correct answer is : 67</QuestionBase>\n    <Distractor1>KDYYYX0V</Distractor1>\n    <Distractor2>KDYYYX0V</Distractor2>\n    <Distractor3>KDYYYX0V</Distractor3>\n    <Distractor4>67</Distractor4>\n    <TrueAnswer>67</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>69</QuestionNumber>\n    <QuestionBase>correct answer is : 68</QuestionBase>\n    <Distractor1>FRG5Q1QE</Distractor1>\n    <Distractor2>FRG5Q1QE</Distractor2>\n    <Distractor3>FRG5Q1QE</Distractor3>\n    <Distractor4>68</Distractor4>\n    <TrueAnswer>68</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>70</QuestionNumber>\n    <QuestionBase>correct answer is : 69</QuestionBase>\n    <Distractor1>FRG5Q1QE</Distractor1>\n    <Distractor2>FRG5Q1QE</Distractor2>\n    <Distractor3>FRG5Q1QE</Distractor3>\n    <Distractor4>69</Distractor4>\n    <TrueAnswer>69</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>71</QuestionNumber>\n    <QuestionBase>correct answer is : 70</QuestionBase>\n    <Distractor1>FRG5Q1QE</Distractor1>\n    <Distractor2>FRG5Q1QE</Distractor2>\n    <Distractor3>FRG5Q1QE</Distractor3>\n    <Distractor4>70</Distractor4>\n    <TrueAnswer>70</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>72</QuestionNumber>\n    <QuestionBase>correct answer is : 71</QuestionBase>\n    <Distractor1>FRG5Q1QE</Distractor1>\n    <Distractor2>FRG5Q1QE</Distractor2>\n    <Distractor3>FRG5Q1QE</Distractor3>\n    <Distractor4>71</Distractor4>\n    <TrueAnswer>71</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>73</QuestionNumber>\n    <QuestionBase>correct answer is : 72</QuestionBase>\n    <Distractor1>FRG5Q1QE</Distractor1>\n    <Distractor2>FRG5Q1QE</Distractor2>\n    <Distractor3>FRG5Q1QE</Distractor3>\n    <Distractor4>72</Distractor4>\n    <TrueAnswer>72</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>74</QuestionNumber>\n    <QuestionBase>correct answer is : 73</QuestionBase>\n    <Distractor1>FRG5Q1QE</Distractor1>\n    <Distractor2>FRG5Q1QE</Distractor2>\n    <Distractor3>FRG5Q1QE</Distractor3>\n    <Distractor4>73</Distractor4>\n    <TrueAnswer>73</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>75</QuestionNumber>\n    <QuestionBase>correct answer is : 74</QuestionBase>\n    <Distractor1>FRG5Q1QE</Distractor1>\n    <Distractor2>FRG5Q1QE</Distractor2>\n    <Distractor3>FRG5Q1QE</Distractor3>\n    <Distractor4>74</Distractor4>\n    <TrueAnswer>74</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>76</QuestionNumber>\n    <QuestionBase>correct answer is : 75</QuestionBase>\n    <Distractor1>FRG5Q1QE</Distractor1>\n    <Distractor2>FRG5Q1QE</Distractor2>\n    <Distractor3>FRG5Q1QE</Distractor3>\n    <Distractor4>75</Distractor4>\n    <TrueAnswer>75</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>77</QuestionNumber>\n    <QuestionBase>correct answer is : 76</QuestionBase>\n    <Distractor1>FRG5Q1QE</Distractor1>\n    <Distractor2>FRG5Q1QE</Distractor2>\n    <Distractor3>FRG5Q1QE</Distractor3>\n    <Distractor4>76</Distractor4>\n    <TrueAnswer>76</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>78</QuestionNumber>\n    <QuestionBase>correct answer is : 77</QuestionBase>\n    <Distractor1>FRG5Q1QE</Distractor1>\n    <Distractor2>FRG5Q1QE</Distractor2>\n    <Distractor3>FRG5Q1QE</Distractor3>\n    <Distractor4>77</Distractor4>\n    <TrueAnswer>77</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>79</QuestionNumber>\n    <QuestionBase>correct answer is : 78</QuestionBase>\n    <Distractor1>FRG5Q1QE</Distractor1>\n    <Distractor2>FRG5Q1QE</Distractor2>\n    <Distractor3>FRG5Q1QE</Distractor3>\n    <Distractor4>78</Distractor4>\n    <TrueAnswer>78</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>80</QuestionNumber>\n    <QuestionBase>correct answer is : 79</QuestionBase>\n    <Distractor1>FRG5Q1QE</Distractor1>\n    <Distractor2>FRG5Q1QE</Distractor2>\n    <Distractor3>FRG5Q1QE</Distractor3>\n    <Distractor4>79</Distractor4>\n    <TrueAnswer>79</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>81</QuestionNumber>\n    <QuestionBase>correct answer is : 80</QuestionBase>\n    <Distractor1>FRG5Q1QE</Distractor1>\n    <Distractor2>FRG5Q1QE</Distractor2>\n    <Distractor3>FRG5Q1QE</Distractor3>\n    <Distractor4>80</Distractor4>\n    <TrueAnswer>80</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>82</QuestionNumber>\n    <QuestionBase>correct answer is : 81</QuestionBase>\n    <Distractor1>FRG5Q1QE</Distractor1>\n    <Distractor2>FRG5Q1QE</Distractor2>\n    <Distractor3>FRG5Q1QE</Distractor3>\n    <Distractor4>81</Distractor4>\n    <TrueAnswer>81</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>83</QuestionNumber>\n    <QuestionBase>correct answer is : 82</QuestionBase>\n    <Distractor1>FRG5Q1QE</Distractor1>\n    <Distractor2>FRG5Q1QE</Distractor2>\n    <Distractor3>FRG5Q1QE</Distractor3>\n    <Distractor4>82</Distractor4>\n    <TrueAnswer>82</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>84</QuestionNumber>\n    <QuestionBase>correct answer is : 83</QuestionBase>\n    <Distractor1>FRG5Q1QE</Distractor1>\n    <Distractor2>RGNLX0WF</Distractor2>\n    <Distractor3>RGNLX0WF</Distractor3>\n    <Distractor4>83</Distractor4>\n    <TrueAnswer>83</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>85</QuestionNumber>\n    <QuestionBase>correct answer is : 84</QuestionBase>\n    <Distractor1>RGNLX0WF</Distractor1>\n    <Distractor2>RGNLX0WF</Distractor2>\n    <Distractor3>RGNLX0WF</Distractor3>\n    <Distractor4>84</Distractor4>\n    <TrueAnswer>84</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>86</QuestionNumber>\n    <QuestionBase>correct answer is : 85</QuestionBase>\n    <Distractor1>RGNLX0WF</Distractor1>\n    <Distractor2>RGNLX0WF</Distractor2>\n    <Distractor3>RGNLX0WF</Distractor3>\n    <Distractor4>85</Distractor4>\n    <TrueAnswer>85</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>87</QuestionNumber>\n    <QuestionBase>correct answer is : 86</QuestionBase>\n    <Distractor1>RGNLX0WF</Distractor1>\n    <Distractor2>RGNLX0WF</Distractor2>\n    <Distractor3>RGNLX0WF</Distractor3>\n    <Distractor4>86</Distractor4>\n    <TrueAnswer>86</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>88</QuestionNumber>\n    <QuestionBase>correct answer is : 87</QuestionBase>\n    <Distractor1>RGNLX0WF</Distractor1>\n    <Distractor2>RGNLX0WF</Distractor2>\n    <Distractor3>RGNLX0WF</Distractor3>\n    <Distractor4>87</Distractor4>\n    <TrueAnswer>87</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>89</QuestionNumber>\n    <QuestionBase>correct answer is : 88</QuestionBase>\n    <Distractor1>RGNLX0WF</Distractor1>\n    <Distractor2>RGNLX0WF</Distractor2>\n    <Distractor3>RGNLX0WF</Distractor3>\n    <Distractor4>88</Distractor4>\n    <TrueAnswer>88</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>90</QuestionNumber>\n    <QuestionBase>correct answer is : 89</QuestionBase>\n    <Distractor1>RGNLX0WF</Distractor1>\n    <Distractor2>RGNLX0WF</Distractor2>\n    <Distractor3>RGNLX0WF</Distractor3>\n    <Distractor4>89</Distractor4>\n    <TrueAnswer>89</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>91</QuestionNumber>\n    <QuestionBase>correct answer is : 90</QuestionBase>\n    <Distractor1>RGNLX0WF</Distractor1>\n    <Distractor2>RGNLX0WF</Distractor2>\n    <Distractor3>RGNLX0WF</Distractor3>\n    <Distractor4>90</Distractor4>\n    <TrueAnswer>90</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>92</QuestionNumber>\n    <QuestionBase>correct answer is : 91</QuestionBase>\n    <Distractor1>RGNLX0WF</Distractor1>\n    <Distractor2>RGNLX0WF</Distractor2>\n    <Distractor3>RGNLX0WF</Distractor3>\n    <Distractor4>91</Distractor4>\n    <TrueAnswer>91</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>93</QuestionNumber>\n    <QuestionBase>correct answer is : 92</QuestionBase>\n    <Distractor1>RGNLX0WF</Distractor1>\n    <Distractor2>RGNLX0WF</Distractor2>\n    <Distractor3>RGNLX0WF</Distractor3>\n    <Distractor4>92</Distractor4>\n    <TrueAnswer>92</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>94</QuestionNumber>\n    <QuestionBase>correct answer is : 93</QuestionBase>\n    <Distractor1>RGNLX0WF</Distractor1>\n    <Distractor2>RGNLX0WF</Distractor2>\n    <Distractor3>RGNLX0WF</Distractor3>\n    <Distractor4>93</Distractor4>\n    <TrueAnswer>93</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>95</QuestionNumber>\n    <QuestionBase>correct answer is : 94</QuestionBase>\n    <Distractor1>45T0502G</Distractor1>\n    <Distractor2>45T0502G</Distractor2>\n    <Distractor3>45T0502G</Distractor3>\n    <Distractor4>94</Distractor4>\n    <TrueAnswer>94</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>96</QuestionNumber>\n    <QuestionBase>correct answer is : 95</QuestionBase>\n    <Distractor1>45T0502G</Distractor1>\n    <Distractor2>45T0502G</Distractor2>\n    <Distractor3>45T0502G</Distractor3>\n    <Distractor4>95</Distractor4>\n    <TrueAnswer>95</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>97</QuestionNumber>\n    <QuestionBase>correct answer is : 96</QuestionBase>\n    <Distractor1>45T0502G</Distractor1>\n    <Distractor2>45T0502G</Distractor2>\n    <Distractor3>45T0502G</Distractor3>\n    <Distractor4>96</Distractor4>\n    <TrueAnswer>96</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>98</QuestionNumber>\n    <QuestionBase>correct answer is : 97</QuestionBase>\n    <Distractor1>45T0502G</Distractor1>\n    <Distractor2>45T0502G</Distractor2>\n    <Distractor3>45T0502G</Distractor3>\n    <Distractor4>97</Distractor4>\n    <TrueAnswer>97</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>99</QuestionNumber>\n    <QuestionBase>correct answer is : 98</QuestionBase>\n    <Distractor1>45T0502G</Distractor1>\n    <Distractor2>45T0502G</Distractor2>\n    <Distractor3>45T0502G</Distractor3>\n    <Distractor4>98</Distractor4>\n    <TrueAnswer>98</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>100</QuestionNumber>\n    <QuestionBase>correct answer is : 99</QuestionBase>\n    <Distractor1>45T0502G</Distractor1>\n    <Distractor2>45T0502G</Distractor2>\n    <Distractor3>45T0502G</Distractor3>\n    <Distractor4>99</Distractor4>\n    <TrueAnswer>99</TrueAnswer>\n  </c_SmallQuestion>\n</ArrayOfC_SmallQuestion>', 0, 0);
INSERT INTO `tbl_quizes` (`id`, `quest_name`, `xml_base`, `state_long`, `drp`) VALUES
(2, 'Quest1', '<?xml version=\"1.0\" encoding=\"utf-16\"?>\n<ArrayOfC_SmallQuestion xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\">\n  <c_SmallQuestion>\n    <QuestionNumber>1</QuestionNumber>\n    <QuestionBase>correct answer is : 0</QuestionBase>\n    <Distractor1>8HE5RLPG</Distractor1>\n    <Distractor2>8HE5RLPG</Distractor2>\n    <Distractor3>8HE5RLPG</Distractor3>\n    <Distractor4>0</Distractor4>\n    <TrueAnswer>0</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>2</QuestionNumber>\n    <QuestionBase>correct answer is : 1</QuestionBase>\n    <Distractor1>8HE5RLPG</Distractor1>\n    <Distractor2>8HE5RLPG</Distractor2>\n    <Distractor3>8HE5RLPG</Distractor3>\n    <Distractor4>1</Distractor4>\n    <TrueAnswer>1</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>3</QuestionNumber>\n    <QuestionBase>correct answer is : 2</QuestionBase>\n    <Distractor1>M6LLZKVH</Distractor1>\n    <Distractor2>M6LLZKVH</Distractor2>\n    <Distractor3>M6LLZKVH</Distractor3>\n    <Distractor4>2</Distractor4>\n    <TrueAnswer>2</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>4</QuestionNumber>\n    <QuestionBase>correct answer is : 3</QuestionBase>\n    <Distractor1>M6LLZKVH</Distractor1>\n    <Distractor2>M6LLZKVH</Distractor2>\n    <Distractor3>M6LLZKVH</Distractor3>\n    <Distractor4>3</Distractor4>\n    <TrueAnswer>3</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>5</QuestionNumber>\n    <QuestionBase>correct answer is : 4</QuestionBase>\n    <Distractor1>M6LLZKVH</Distractor1>\n    <Distractor2>M6LLZKVH</Distractor2>\n    <Distractor3>M6LLZKVH</Distractor3>\n    <Distractor4>4</Distractor4>\n    <TrueAnswer>4</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>6</QuestionNumber>\n    <QuestionBase>correct answer is : 5</QuestionBase>\n    <Distractor1>M6LLZKVH</Distractor1>\n    <Distractor2>M6LLZKVH</Distractor2>\n    <Distractor3>M6LLZKVH</Distractor3>\n    <Distractor4>5</Distractor4>\n    <TrueAnswer>5</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>7</QuestionNumber>\n    <QuestionBase>correct answer is : 6</QuestionBase>\n    <Distractor1>M6LLZKVH</Distractor1>\n    <Distractor2>M6LLZKVH</Distractor2>\n    <Distractor3>M6LLZKVH</Distractor3>\n    <Distractor4>6</Distractor4>\n    <TrueAnswer>6</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>8</QuestionNumber>\n    <QuestionBase>correct answer is : 7</QuestionBase>\n    <Distractor1>M6LLZKVH</Distractor1>\n    <Distractor2>M6LLZKVH</Distractor2>\n    <Distractor3>M6LLZKVH</Distractor3>\n    <Distractor4>7</Distractor4>\n    <TrueAnswer>7</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>9</QuestionNumber>\n    <QuestionBase>correct answer is : 8</QuestionBase>\n    <Distractor1>M6LLZKVH</Distractor1>\n    <Distractor2>M6LLZKVH</Distractor2>\n    <Distractor3>M6LLZKVH</Distractor3>\n    <Distractor4>8</Distractor4>\n    <TrueAnswer>8</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>10</QuestionNumber>\n    <QuestionBase>correct answer is : 9</QuestionBase>\n    <Distractor1>M6LLZKVH</Distractor1>\n    <Distractor2>M6LLZKVH</Distractor2>\n    <Distractor3>M6LLZKVH</Distractor3>\n    <Distractor4>9</Distractor4>\n    <TrueAnswer>9</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>11</QuestionNumber>\n    <QuestionBase>correct answer is : 10</QuestionBase>\n    <Distractor1>M6LLZKVH</Distractor1>\n    <Distractor2>M6LLZKVH</Distractor2>\n    <Distractor3>M6LLZKVH</Distractor3>\n    <Distractor4>10</Distractor4>\n    <TrueAnswer>10</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>12</QuestionNumber>\n    <QuestionBase>correct answer is : 11</QuestionBase>\n    <Distractor1>M6LLZKVH</Distractor1>\n    <Distractor2>M6LLZKVH</Distractor2>\n    <Distractor3>M6LLZKVH</Distractor3>\n    <Distractor4>11</Distractor4>\n    <TrueAnswer>11</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>13</QuestionNumber>\n    <QuestionBase>correct answer is : 12</QuestionBase>\n    <Distractor1>M6LLZKVH</Distractor1>\n    <Distractor2>M6LLZKVH</Distractor2>\n    <Distractor3>M6LLZKVH</Distractor3>\n    <Distractor4>12</Distractor4>\n    <TrueAnswer>12</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>14</QuestionNumber>\n    <QuestionBase>correct answer is : 13</QuestionBase>\n    <Distractor1>M6LLZKVH</Distractor1>\n    <Distractor2>M6LLZKVH</Distractor2>\n    <Distractor3>M6LLZKVH</Distractor3>\n    <Distractor4>13</Distractor4>\n    <TrueAnswer>13</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>15</QuestionNumber>\n    <QuestionBase>correct answer is : 14</QuestionBase>\n    <Distractor1>M6LLZKVH</Distractor1>\n    <Distractor2>M6LLZKVH</Distractor2>\n    <Distractor3>M6LLZKVH</Distractor3>\n    <Distractor4>14</Distractor4>\n    <TrueAnswer>14</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>16</QuestionNumber>\n    <QuestionBase>correct answer is : 15</QuestionBase>\n    <Distractor1>M6LLZKVH</Distractor1>\n    <Distractor2>M6LLZKVH</Distractor2>\n    <Distractor3>M6LLZKVH</Distractor3>\n    <Distractor4>15</Distractor4>\n    <TrueAnswer>15</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>17</QuestionNumber>\n    <QuestionBase>correct answer is : 16</QuestionBase>\n    <Distractor1>GL2SROLZ</Distractor1>\n    <Distractor2>GL2SROLZ</Distractor2>\n    <Distractor3>GL2SROLZ</Distractor3>\n    <Distractor4>16</Distractor4>\n    <TrueAnswer>16</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>18</QuestionNumber>\n    <QuestionBase>correct answer is : 17</QuestionBase>\n    <Distractor1>GL2SROLZ</Distractor1>\n    <Distractor2>GL2SROLZ</Distractor2>\n    <Distractor3>GL2SROLZ</Distractor3>\n    <Distractor4>17</Distractor4>\n    <TrueAnswer>17</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>19</QuestionNumber>\n    <QuestionBase>correct answer is : 18</QuestionBase>\n    <Distractor1>GL2SROLZ</Distractor1>\n    <Distractor2>GL2SROLZ</Distractor2>\n    <Distractor3>GL2SROLZ</Distractor3>\n    <Distractor4>18</Distractor4>\n    <TrueAnswer>18</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>20</QuestionNumber>\n    <QuestionBase>correct answer is : 19</QuestionBase>\n    <Distractor1>GL2SROLZ</Distractor1>\n    <Distractor2>GL2SROLZ</Distractor2>\n    <Distractor3>GL2SROLZ</Distractor3>\n    <Distractor4>19</Distractor4>\n    <TrueAnswer>19</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>21</QuestionNumber>\n    <QuestionBase>correct answer is : 20</QuestionBase>\n    <Distractor1>GL2SROLZ</Distractor1>\n    <Distractor2>GL2SROLZ</Distractor2>\n    <Distractor3>GL2SROLZ</Distractor3>\n    <Distractor4>20</Distractor4>\n    <TrueAnswer>20</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>22</QuestionNumber>\n    <QuestionBase>correct answer is : 21</QuestionBase>\n    <Distractor1>GL2SROLZ</Distractor1>\n    <Distractor2>GL2SROLZ</Distractor2>\n    <Distractor3>GL2SROLZ</Distractor3>\n    <Distractor4>21</Distractor4>\n    <TrueAnswer>21</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>23</QuestionNumber>\n    <QuestionBase>correct answer is : 22</QuestionBase>\n    <Distractor1>GL2SROLZ</Distractor1>\n    <Distractor2>GL2SROLZ</Distractor2>\n    <Distractor3>GL2SROLZ</Distractor3>\n    <Distractor4>22</Distractor4>\n    <TrueAnswer>22</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>24</QuestionNumber>\n    <QuestionBase>correct answer is : 23</QuestionBase>\n    <Distractor1>GL2SROLZ</Distractor1>\n    <Distractor2>GL2SROLZ</Distractor2>\n    <Distractor3>GL2SROLZ</Distractor3>\n    <Distractor4>23</Distractor4>\n    <TrueAnswer>23</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>25</QuestionNumber>\n    <QuestionBase>correct answer is : 24</QuestionBase>\n    <Distractor1>GL2SROLZ</Distractor1>\n    <Distractor2>GL2SROLZ</Distractor2>\n    <Distractor3>GL2SROLZ</Distractor3>\n    <Distractor4>24</Distractor4>\n    <TrueAnswer>24</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>26</QuestionNumber>\n    <QuestionBase>correct answer is : 25</QuestionBase>\n    <Distractor1>GL2SROLZ</Distractor1>\n    <Distractor2>GL2SROLZ</Distractor2>\n    <Distractor3>GL2SROLZ</Distractor3>\n    <Distractor4>25</Distractor4>\n    <TrueAnswer>25</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>27</QuestionNumber>\n    <QuestionBase>correct answer is : 26</QuestionBase>\n    <Distractor1>GL2SROLZ</Distractor1>\n    <Distractor2>GL2SROLZ</Distractor2>\n    <Distractor3>GL2SROLZ</Distractor3>\n    <Distractor4>26</Distractor4>\n    <TrueAnswer>26</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>28</QuestionNumber>\n    <QuestionBase>correct answer is : 27</QuestionBase>\n    <Distractor1>GL2SROLZ</Distractor1>\n    <Distractor2>GL2SROLZ</Distractor2>\n    <Distractor3>GL2SROLZ</Distractor3>\n    <Distractor4>27</Distractor4>\n    <TrueAnswer>27</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>29</QuestionNumber>\n    <QuestionBase>correct answer is : 28</QuestionBase>\n    <Distractor1>GL2SROLZ</Distractor1>\n    <Distractor2>GL2SROLZ</Distractor2>\n    <Distractor3>GL2SROLZ</Distractor3>\n    <Distractor4>28</Distractor4>\n    <TrueAnswer>28</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>30</QuestionNumber>\n    <QuestionBase>correct answer is : 29</QuestionBase>\n    <Distractor1>SA87YNR0</Distractor1>\n    <Distractor2>SA87YNR0</Distractor2>\n    <Distractor3>SA87YNR0</Distractor3>\n    <Distractor4>29</Distractor4>\n    <TrueAnswer>29</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>31</QuestionNumber>\n    <QuestionBase>correct answer is : 30</QuestionBase>\n    <Distractor1>SA87YNR0</Distractor1>\n    <Distractor2>SA87YNR0</Distractor2>\n    <Distractor3>SA87YNR0</Distractor3>\n    <Distractor4>30</Distractor4>\n    <TrueAnswer>30</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>32</QuestionNumber>\n    <QuestionBase>correct answer is : 31</QuestionBase>\n    <Distractor1>SA87YNR0</Distractor1>\n    <Distractor2>SA87YNR0</Distractor2>\n    <Distractor3>SA87YNR0</Distractor3>\n    <Distractor4>31</Distractor4>\n    <TrueAnswer>31</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>33</QuestionNumber>\n    <QuestionBase>correct answer is : 32</QuestionBase>\n    <Distractor1>SA87YNR0</Distractor1>\n    <Distractor2>SA87YNR0</Distractor2>\n    <Distractor3>SA87YNR0</Distractor3>\n    <Distractor4>32</Distractor4>\n    <TrueAnswer>32</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>34</QuestionNumber>\n    <QuestionBase>correct answer is : 33</QuestionBase>\n    <Distractor1>SA87YNR0</Distractor1>\n    <Distractor2>SA87YNR0</Distractor2>\n    <Distractor3>SA87YNR0</Distractor3>\n    <Distractor4>33</Distractor4>\n    <TrueAnswer>33</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>35</QuestionNumber>\n    <QuestionBase>correct answer is : 34</QuestionBase>\n    <Distractor1>SA87YNR0</Distractor1>\n    <Distractor2>SA87YNR0</Distractor2>\n    <Distractor3>SA87YNR0</Distractor3>\n    <Distractor4>34</Distractor4>\n    <TrueAnswer>34</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>36</QuestionNumber>\n    <QuestionBase>correct answer is : 35</QuestionBase>\n    <Distractor1>SA87YNR0</Distractor1>\n    <Distractor2>SA87YNR0</Distractor2>\n    <Distractor3>SA87YNR0</Distractor3>\n    <Distractor4>35</Distractor4>\n    <TrueAnswer>35</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>37</QuestionNumber>\n    <QuestionBase>correct answer is : 36</QuestionBase>\n    <Distractor1>SA87YNR0</Distractor1>\n    <Distractor2>SA87YNR0</Distractor2>\n    <Distractor3>SA87YNR0</Distractor3>\n    <Distractor4>36</Distractor4>\n    <TrueAnswer>36</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>38</QuestionNumber>\n    <QuestionBase>correct answer is : 37</QuestionBase>\n    <Distractor1>SA87YNR0</Distractor1>\n    <Distractor2>SA87YNR0</Distractor2>\n    <Distractor3>SA87YNR0</Distractor3>\n    <Distractor4>37</Distractor4>\n    <TrueAnswer>37</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>39</QuestionNumber>\n    <QuestionBase>correct answer is : 38</QuestionBase>\n    <Distractor1>SA87YNR0</Distractor1>\n    <Distractor2>SA87YNR0</Distractor2>\n    <Distractor3>SA87YNR0</Distractor3>\n    <Distractor4>38</Distractor4>\n    <TrueAnswer>38</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>40</QuestionNumber>\n    <QuestionBase>correct answer is : 39</QuestionBase>\n    <Distractor1>SA87YNR0</Distractor1>\n    <Distractor2>SA87YNR0</Distractor2>\n    <Distractor3>SA87YNR0</Distractor3>\n    <Distractor4>39</Distractor4>\n    <TrueAnswer>39</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>41</QuestionNumber>\n    <QuestionBase>correct answer is : 40</QuestionBase>\n    <Distractor1>SA87YNR0</Distractor1>\n    <Distractor2>SA87YNR0</Distractor2>\n    <Distractor3>SA87YNR0</Distractor3>\n    <Distractor4>40</Distractor4>\n    <TrueAnswer>40</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>42</QuestionNumber>\n    <QuestionBase>correct answer is : 41</QuestionBase>\n    <Distractor1>5YFM6MX1</Distractor1>\n    <Distractor2>5YFM6MX1</Distractor2>\n    <Distractor3>5YFM6MX1</Distractor3>\n    <Distractor4>41</Distractor4>\n    <TrueAnswer>41</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>43</QuestionNumber>\n    <QuestionBase>correct answer is : 42</QuestionBase>\n    <Distractor1>5YFM6MX1</Distractor1>\n    <Distractor2>5YFM6MX1</Distractor2>\n    <Distractor3>5YFM6MX1</Distractor3>\n    <Distractor4>42</Distractor4>\n    <TrueAnswer>42</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>44</QuestionNumber>\n    <QuestionBase>correct answer is : 43</QuestionBase>\n    <Distractor1>5YFM6MX1</Distractor1>\n    <Distractor2>5YFM6MX1</Distractor2>\n    <Distractor3>5YFM6MX1</Distractor3>\n    <Distractor4>43</Distractor4>\n    <TrueAnswer>43</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>45</QuestionNumber>\n    <QuestionBase>correct answer is : 44</QuestionBase>\n    <Distractor1>5YFM6MX1</Distractor1>\n    <Distractor2>5YFM6MX1</Distractor2>\n    <Distractor3>5YFM6MX1</Distractor3>\n    <Distractor4>44</Distractor4>\n    <TrueAnswer>44</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>46</QuestionNumber>\n    <QuestionBase>correct answer is : 45</QuestionBase>\n    <Distractor1>5YFM6MX1</Distractor1>\n    <Distractor2>5YFM6MX1</Distractor2>\n    <Distractor3>5YFM6MX1</Distractor3>\n    <Distractor4>45</Distractor4>\n    <TrueAnswer>45</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>47</QuestionNumber>\n    <QuestionBase>correct answer is : 46</QuestionBase>\n    <Distractor1>5YFM6MX1</Distractor1>\n    <Distractor2>5YFM6MX1</Distractor2>\n    <Distractor3>5YFM6MX1</Distractor3>\n    <Distractor4>46</Distractor4>\n    <TrueAnswer>46</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>48</QuestionNumber>\n    <QuestionBase>correct answer is : 47</QuestionBase>\n    <Distractor1>5YFM6MX1</Distractor1>\n    <Distractor2>5YFM6MX1</Distractor2>\n    <Distractor3>5YFM6MX1</Distractor3>\n    <Distractor4>47</Distractor4>\n    <TrueAnswer>47</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>49</QuestionNumber>\n    <QuestionBase>correct answer is : 48</QuestionBase>\n    <Distractor1>5YFM6MX1</Distractor1>\n    <Distractor2>5YFM6MX1</Distractor2>\n    <Distractor3>5YFM6MX1</Distractor3>\n    <Distractor4>48</Distractor4>\n    <TrueAnswer>48</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>50</QuestionNumber>\n    <QuestionBase>correct answer is : 49</QuestionBase>\n    <Distractor1>5YFM6MX1</Distractor1>\n    <Distractor2>5YFM6MX1</Distractor2>\n    <Distractor3>5YFM6MX1</Distractor3>\n    <Distractor4>49</Distractor4>\n    <TrueAnswer>49</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>51</QuestionNumber>\n    <QuestionBase>correct answer is : 50</QuestionBase>\n    <Distractor1>5YFM6MX1</Distractor1>\n    <Distractor2>5YFM6MX1</Distractor2>\n    <Distractor3>5YFM6MX1</Distractor3>\n    <Distractor4>50</Distractor4>\n    <TrueAnswer>50</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>52</QuestionNumber>\n    <QuestionBase>correct answer is : 51</QuestionBase>\n    <Distractor1>5YFM6MX1</Distractor1>\n    <Distractor2>5YFM6MX1</Distractor2>\n    <Distractor3>5YFM6MX1</Distractor3>\n    <Distractor4>51</Distractor4>\n    <TrueAnswer>51</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>53</QuestionNumber>\n    <QuestionBase>correct answer is : 52</QuestionBase>\n    <Distractor1>5YFM6MX1</Distractor1>\n    <Distractor2>5YFM6MX1</Distractor2>\n    <Distractor3>5YFM6MX1</Distractor3>\n    <Distractor4>52</Distractor4>\n    <TrueAnswer>52</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>54</QuestionNumber>\n    <QuestionBase>correct answer is : 53</QuestionBase>\n    <Distractor1>5YFM6MX1</Distractor1>\n    <Distractor2>5YFM6MX1</Distractor2>\n    <Distractor3>5YFM6MX1</Distractor3>\n    <Distractor4>53</Distractor4>\n    <TrueAnswer>53</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>55</QuestionNumber>\n    <QuestionBase>correct answer is : 54</QuestionBase>\n    <Distractor1>ZDWTYQNK</Distractor1>\n    <Distractor2>ZDWTYQNK</Distractor2>\n    <Distractor3>ZDWTYQNK</Distractor3>\n    <Distractor4>54</Distractor4>\n    <TrueAnswer>54</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>56</QuestionNumber>\n    <QuestionBase>correct answer is : 55</QuestionBase>\n    <Distractor1>ZDWTYQNK</Distractor1>\n    <Distractor2>ZDWTYQNK</Distractor2>\n    <Distractor3>ZDWTYQNK</Distractor3>\n    <Distractor4>55</Distractor4>\n    <TrueAnswer>55</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>57</QuestionNumber>\n    <QuestionBase>correct answer is : 56</QuestionBase>\n    <Distractor1>ZDWTYQNK</Distractor1>\n    <Distractor2>ZDWTYQNK</Distractor2>\n    <Distractor3>ZDWTYQNK</Distractor3>\n    <Distractor4>56</Distractor4>\n    <TrueAnswer>56</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>58</QuestionNumber>\n    <QuestionBase>correct answer is : 57</QuestionBase>\n    <Distractor1>ZDWTYQNK</Distractor1>\n    <Distractor2>ZDWTYQNK</Distractor2>\n    <Distractor3>ZDWTYQNK</Distractor3>\n    <Distractor4>57</Distractor4>\n    <TrueAnswer>57</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>59</QuestionNumber>\n    <QuestionBase>correct answer is : 58</QuestionBase>\n    <Distractor1>ZDWTYQNK</Distractor1>\n    <Distractor2>ZDWTYQNK</Distractor2>\n    <Distractor3>ZDWTYQNK</Distractor3>\n    <Distractor4>58</Distractor4>\n    <TrueAnswer>58</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>60</QuestionNumber>\n    <QuestionBase>correct answer is : 59</QuestionBase>\n    <Distractor1>ZDWTYQNK</Distractor1>\n    <Distractor2>ZDWTYQNK</Distractor2>\n    <Distractor3>ZDWTYQNK</Distractor3>\n    <Distractor4>59</Distractor4>\n    <TrueAnswer>59</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>61</QuestionNumber>\n    <QuestionBase>correct answer is : 60</QuestionBase>\n    <Distractor1>ZDWTYQNK</Distractor1>\n    <Distractor2>ZDWTYQNK</Distractor2>\n    <Distractor3>ZDWTYQNK</Distractor3>\n    <Distractor4>60</Distractor4>\n    <TrueAnswer>60</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>62</QuestionNumber>\n    <QuestionBase>correct answer is : 61</QuestionBase>\n    <Distractor1>ZDWTYQNK</Distractor1>\n    <Distractor2>ZDWTYQNK</Distractor2>\n    <Distractor3>ZDWTYQNK</Distractor3>\n    <Distractor4>61</Distractor4>\n    <TrueAnswer>61</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>63</QuestionNumber>\n    <QuestionBase>correct answer is : 62</QuestionBase>\n    <Distractor1>ZDWTYQNK</Distractor1>\n    <Distractor2>ZDWTYQNK</Distractor2>\n    <Distractor3>ZDWTYQNK</Distractor3>\n    <Distractor4>62</Distractor4>\n    <TrueAnswer>62</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>64</QuestionNumber>\n    <QuestionBase>correct answer is : 63</QuestionBase>\n    <Distractor1>ZDWTYQNK</Distractor1>\n    <Distractor2>ZDWTYQNK</Distractor2>\n    <Distractor3>ZDWTYQNK</Distractor3>\n    <Distractor4>63</Distractor4>\n    <TrueAnswer>63</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>65</QuestionNumber>\n    <QuestionBase>correct answer is : 64</QuestionBase>\n    <Distractor1>ZDWTYQNK</Distractor1>\n    <Distractor2>ZDWTYQNK</Distractor2>\n    <Distractor3>ZDWTYQNK</Distractor3>\n    <Distractor4>64</Distractor4>\n    <TrueAnswer>64</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>66</QuestionNumber>\n    <QuestionBase>correct answer is : 65</QuestionBase>\n    <Distractor1>ZDWTYQNK</Distractor1>\n    <Distractor2>ZDWTYQNK</Distractor2>\n    <Distractor3>ZDWTYQNK</Distractor3>\n    <Distractor4>65</Distractor4>\n    <TrueAnswer>65</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>67</QuestionNumber>\n    <QuestionBase>correct answer is : 66</QuestionBase>\n    <Distractor1>ZDWTYQNK</Distractor1>\n    <Distractor2>ZDWTYQNK</Distractor2>\n    <Distractor3>ZDWTYQNK</Distractor3>\n    <Distractor4>66</Distractor4>\n    <TrueAnswer>66</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>68</QuestionNumber>\n    <QuestionBase>correct answer is : 67</QuestionBase>\n    <Distractor1>ZDWTYQNK</Distractor1>\n    <Distractor2>ZDWTYQNK</Distractor2>\n    <Distractor3>ZDWTYQNK</Distractor3>\n    <Distractor4>67</Distractor4>\n    <TrueAnswer>67</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>69</QuestionNumber>\n    <QuestionBase>correct answer is : 68</QuestionBase>\n    <Distractor1>D2386QTL</Distractor1>\n    <Distractor2>D2386QTL</Distractor2>\n    <Distractor3>D2386QTL</Distractor3>\n    <Distractor4>68</Distractor4>\n    <TrueAnswer>68</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>70</QuestionNumber>\n    <QuestionBase>correct answer is : 69</QuestionBase>\n    <Distractor1>D2386QTL</Distractor1>\n    <Distractor2>D2386QTL</Distractor2>\n    <Distractor3>D2386QTL</Distractor3>\n    <Distractor4>69</Distractor4>\n    <TrueAnswer>69</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>71</QuestionNumber>\n    <QuestionBase>correct answer is : 70</QuestionBase>\n    <Distractor1>D2386QTL</Distractor1>\n    <Distractor2>D2386QTL</Distractor2>\n    <Distractor3>D2386QTL</Distractor3>\n    <Distractor4>70</Distractor4>\n    <TrueAnswer>70</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>72</QuestionNumber>\n    <QuestionBase>correct answer is : 71</QuestionBase>\n    <Distractor1>D2386QTL</Distractor1>\n    <Distractor2>D2386QTL</Distractor2>\n    <Distractor3>D2386QTL</Distractor3>\n    <Distractor4>71</Distractor4>\n    <TrueAnswer>71</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>73</QuestionNumber>\n    <QuestionBase>correct answer is : 72</QuestionBase>\n    <Distractor1>D2386QTL</Distractor1>\n    <Distractor2>D2386QTL</Distractor2>\n    <Distractor3>D2386QTL</Distractor3>\n    <Distractor4>72</Distractor4>\n    <TrueAnswer>72</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>74</QuestionNumber>\n    <QuestionBase>correct answer is : 73</QuestionBase>\n    <Distractor1>D2386QTL</Distractor1>\n    <Distractor2>D2386QTL</Distractor2>\n    <Distractor3>D2386QTL</Distractor3>\n    <Distractor4>73</Distractor4>\n    <TrueAnswer>73</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>75</QuestionNumber>\n    <QuestionBase>correct answer is : 74</QuestionBase>\n    <Distractor1>D2386QTL</Distractor1>\n    <Distractor2>D2386QTL</Distractor2>\n    <Distractor3>D2386QTL</Distractor3>\n    <Distractor4>74</Distractor4>\n    <TrueAnswer>74</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>76</QuestionNumber>\n    <QuestionBase>correct answer is : 75</QuestionBase>\n    <Distractor1>D2386QTL</Distractor1>\n    <Distractor2>D2386QTL</Distractor2>\n    <Distractor3>D2386QTL</Distractor3>\n    <Distractor4>75</Distractor4>\n    <TrueAnswer>75</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>77</QuestionNumber>\n    <QuestionBase>correct answer is : 76</QuestionBase>\n    <Distractor1>D2386QTL</Distractor1>\n    <Distractor2>D2386QTL</Distractor2>\n    <Distractor3>D2386QTL</Distractor3>\n    <Distractor4>76</Distractor4>\n    <TrueAnswer>76</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>78</QuestionNumber>\n    <QuestionBase>correct answer is : 77</QuestionBase>\n    <Distractor1>D2386QTL</Distractor1>\n    <Distractor2>D2386QTL</Distractor2>\n    <Distractor3>D2386QTL</Distractor3>\n    <Distractor4>77</Distractor4>\n    <TrueAnswer>77</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>79</QuestionNumber>\n    <QuestionBase>correct answer is : 78</QuestionBase>\n    <Distractor1>D2386QTL</Distractor1>\n    <Distractor2>D2386QTL</Distractor2>\n    <Distractor3>D2386QTL</Distractor3>\n    <Distractor4>78</Distractor4>\n    <TrueAnswer>78</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>80</QuestionNumber>\n    <QuestionBase>correct answer is : 79</QuestionBase>\n    <Distractor1>D2386QTL</Distractor1>\n    <Distractor2>D2386QTL</Distractor2>\n    <Distractor3>D2386QTL</Distractor3>\n    <Distractor4>79</Distractor4>\n    <TrueAnswer>79</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>81</QuestionNumber>\n    <QuestionBase>correct answer is : 80</QuestionBase>\n    <Distractor1>D2386QTL</Distractor1>\n    <Distractor2>D2386QTL</Distractor2>\n    <Distractor3>D2386QTL</Distractor3>\n    <Distractor4>80</Distractor4>\n    <TrueAnswer>80</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>82</QuestionNumber>\n    <QuestionBase>correct answer is : 81</QuestionBase>\n    <Distractor1>PRANFPZM</Distractor1>\n    <Distractor2>PRANFPZM</Distractor2>\n    <Distractor3>PRANFPZM</Distractor3>\n    <Distractor4>81</Distractor4>\n    <TrueAnswer>81</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>83</QuestionNumber>\n    <QuestionBase>correct answer is : 82</QuestionBase>\n    <Distractor1>PRANFPZM</Distractor1>\n    <Distractor2>PRANFPZM</Distractor2>\n    <Distractor3>PRANFPZM</Distractor3>\n    <Distractor4>82</Distractor4>\n    <TrueAnswer>82</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>84</QuestionNumber>\n    <QuestionBase>correct answer is : 83</QuestionBase>\n    <Distractor1>PRANFPZM</Distractor1>\n    <Distractor2>PRANFPZM</Distractor2>\n    <Distractor3>PRANFPZM</Distractor3>\n    <Distractor4>83</Distractor4>\n    <TrueAnswer>83</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>85</QuestionNumber>\n    <QuestionBase>correct answer is : 84</QuestionBase>\n    <Distractor1>PRANFPZM</Distractor1>\n    <Distractor2>PRANFPZM</Distractor2>\n    <Distractor3>PRANFPZM</Distractor3>\n    <Distractor4>84</Distractor4>\n    <TrueAnswer>84</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>86</QuestionNumber>\n    <QuestionBase>correct answer is : 85</QuestionBase>\n    <Distractor1>PRANFPZM</Distractor1>\n    <Distractor2>PRANFPZM</Distractor2>\n    <Distractor3>PRANFPZM</Distractor3>\n    <Distractor4>85</Distractor4>\n    <TrueAnswer>85</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>87</QuestionNumber>\n    <QuestionBase>correct answer is : 86</QuestionBase>\n    <Distractor1>PRANFPZM</Distractor1>\n    <Distractor2>PRANFPZM</Distractor2>\n    <Distractor3>PRANFPZM</Distractor3>\n    <Distractor4>86</Distractor4>\n    <TrueAnswer>86</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>88</QuestionNumber>\n    <QuestionBase>correct answer is : 87</QuestionBase>\n    <Distractor1>PRANFPZM</Distractor1>\n    <Distractor2>PRANFPZM</Distractor2>\n    <Distractor3>PRANFPZM</Distractor3>\n    <Distractor4>87</Distractor4>\n    <TrueAnswer>87</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>89</QuestionNumber>\n    <QuestionBase>correct answer is : 88</QuestionBase>\n    <Distractor1>PRANFPZM</Distractor1>\n    <Distractor2>PRANFPZM</Distractor2>\n    <Distractor3>PRANFPZM</Distractor3>\n    <Distractor4>88</Distractor4>\n    <TrueAnswer>88</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>90</QuestionNumber>\n    <QuestionBase>correct answer is : 89</QuestionBase>\n    <Distractor1>PRANFPZM</Distractor1>\n    <Distractor2>PRANFPZM</Distractor2>\n    <Distractor3>PRANFPZM</Distractor3>\n    <Distractor4>89</Distractor4>\n    <TrueAnswer>89</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>91</QuestionNumber>\n    <QuestionBase>correct answer is : 90</QuestionBase>\n    <Distractor1>PRANFPZM</Distractor1>\n    <Distractor2>PRANFPZM</Distractor2>\n    <Distractor3>PRANFPZM</Distractor3>\n    <Distractor4>90</Distractor4>\n    <TrueAnswer>90</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>92</QuestionNumber>\n    <QuestionBase>correct answer is : 91</QuestionBase>\n    <Distractor1>PRANFPZM</Distractor1>\n    <Distractor2>PRANFPZM</Distractor2>\n    <Distractor3>PRANFPZM</Distractor3>\n    <Distractor4>91</Distractor4>\n    <TrueAnswer>91</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>93</QuestionNumber>\n    <QuestionBase>correct answer is : 92</QuestionBase>\n    <Distractor1>PRANFPZM</Distractor1>\n    <Distractor2>PRANFPZM</Distractor2>\n    <Distractor3>PRANFPZM</Distractor3>\n    <Distractor4>92</Distractor4>\n    <TrueAnswer>92</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>94</QuestionNumber>\n    <QuestionBase>correct answer is : 93</QuestionBase>\n    <Distractor1>PRANFPZM</Distractor1>\n    <Distractor2>PRANFPZM</Distractor2>\n    <Distractor3>PRANFPZM</Distractor3>\n    <Distractor4>93</Distractor4>\n    <TrueAnswer>93</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>95</QuestionNumber>\n    <QuestionBase>correct answer is : 94</QuestionBase>\n    <Distractor1>K5RU6TP4</Distractor1>\n    <Distractor2>K5RU6TP4</Distractor2>\n    <Distractor3>K5RU6TP4</Distractor3>\n    <Distractor4>94</Distractor4>\n    <TrueAnswer>94</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>96</QuestionNumber>\n    <QuestionBase>correct answer is : 95</QuestionBase>\n    <Distractor1>K5RU6TP4</Distractor1>\n    <Distractor2>K5RU6TP4</Distractor2>\n    <Distractor3>K5RU6TP4</Distractor3>\n    <Distractor4>95</Distractor4>\n    <TrueAnswer>95</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>97</QuestionNumber>\n    <QuestionBase>correct answer is : 96</QuestionBase>\n    <Distractor1>K5RU6TP4</Distractor1>\n    <Distractor2>K5RU6TP4</Distractor2>\n    <Distractor3>K5RU6TP4</Distractor3>\n    <Distractor4>96</Distractor4>\n    <TrueAnswer>96</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>98</QuestionNumber>\n    <QuestionBase>correct answer is : 97</QuestionBase>\n    <Distractor1>K5RU6TP4</Distractor1>\n    <Distractor2>K5RU6TP4</Distractor2>\n    <Distractor3>K5RU6TP4</Distractor3>\n    <Distractor4>97</Distractor4>\n    <TrueAnswer>97</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>99</QuestionNumber>\n    <QuestionBase>correct answer is : 98</QuestionBase>\n    <Distractor1>K5RU6TP4</Distractor1>\n    <Distractor2>K5RU6TP4</Distractor2>\n    <Distractor3>K5RU6TP4</Distractor3>\n    <Distractor4>98</Distractor4>\n    <TrueAnswer>98</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>100</QuestionNumber>\n    <QuestionBase>correct answer is : 99</QuestionBase>\n    <Distractor1>K5RU6TP4</Distractor1>\n    <Distractor2>K5RU6TP4</Distractor2>\n    <Distractor3>K5RU6TP4</Distractor3>\n    <Distractor4>99</Distractor4>\n    <TrueAnswer>99</TrueAnswer>\n  </c_SmallQuestion>\n</ArrayOfC_SmallQuestion>', 100, 0);
INSERT INTO `tbl_quizes` (`id`, `quest_name`, `xml_base`, `state_long`, `drp`) VALUES
(3, 'Quest2', '<?xml version=\"1.0\" encoding=\"utf-16\"?>\n<ArrayOfC_SmallQuestion xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\">\n  <c_SmallQuestion>\n    <QuestionNumber>1</QuestionNumber>\n    <QuestionBase>correct answer is : 0</QuestionBase>\n    <Distractor1>IWOPIDA8</Distractor1>\n    <Distractor2>IWOPIDA8</Distractor2>\n    <Distractor3>IWOPIDA8</Distractor3>\n    <Distractor4>0</Distractor4>\n    <TrueAnswer>0</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>2</QuestionNumber>\n    <QuestionBase>correct answer is : 1</QuestionBase>\n    <Distractor1>VMU4QCGA</Distractor1>\n    <Distractor2>VMU4QCGA</Distractor2>\n    <Distractor3>VMU4QCGA</Distractor3>\n    <Distractor4>1</Distractor4>\n    <TrueAnswer>1</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>3</QuestionNumber>\n    <QuestionBase>correct answer is : 2</QuestionBase>\n    <Distractor1>VMU4QCGA</Distractor1>\n    <Distractor2>VMU4QCGA</Distractor2>\n    <Distractor3>VMU4QCGA</Distractor3>\n    <Distractor4>2</Distractor4>\n    <TrueAnswer>2</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>4</QuestionNumber>\n    <QuestionBase>correct answer is : 3</QuestionBase>\n    <Distractor1>VMU4QCGA</Distractor1>\n    <Distractor2>VMU4QCGA</Distractor2>\n    <Distractor3>VMU4QCGA</Distractor3>\n    <Distractor4>3</Distractor4>\n    <TrueAnswer>3</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>5</QuestionNumber>\n    <QuestionBase>correct answer is : 4</QuestionBase>\n    <Distractor1>VMU4QCGA</Distractor1>\n    <Distractor2>VMU4QCGA</Distractor2>\n    <Distractor3>VMU4QCGA</Distractor3>\n    <Distractor4>4</Distractor4>\n    <TrueAnswer>4</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>6</QuestionNumber>\n    <QuestionBase>correct answer is : 5</QuestionBase>\n    <Distractor1>VMU4QCGA</Distractor1>\n    <Distractor2>VMU4QCGA</Distractor2>\n    <Distractor3>VMU4QCGA</Distractor3>\n    <Distractor4>5</Distractor4>\n    <TrueAnswer>5</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>7</QuestionNumber>\n    <QuestionBase>correct answer is : 6</QuestionBase>\n    <Distractor1>VMU4QCGA</Distractor1>\n    <Distractor2>VMU4QCGA</Distractor2>\n    <Distractor3>VMU4QCGA</Distractor3>\n    <Distractor4>6</Distractor4>\n    <TrueAnswer>6</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>8</QuestionNumber>\n    <QuestionBase>correct answer is : 7</QuestionBase>\n    <Distractor1>VMU4QCGA</Distractor1>\n    <Distractor2>VMU4QCGA</Distractor2>\n    <Distractor3>VMU4QCGA</Distractor3>\n    <Distractor4>7</Distractor4>\n    <TrueAnswer>7</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>9</QuestionNumber>\n    <QuestionBase>correct answer is : 8</QuestionBase>\n    <Distractor1>VMU4QCGA</Distractor1>\n    <Distractor2>VMU4QCGA</Distractor2>\n    <Distractor3>VMU4QCGA</Distractor3>\n    <Distractor4>8</Distractor4>\n    <TrueAnswer>8</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>10</QuestionNumber>\n    <QuestionBase>correct answer is : 9</QuestionBase>\n    <Distractor1>VMU4QCGA</Distractor1>\n    <Distractor2>VMU4QCGA</Distractor2>\n    <Distractor3>VMU4QCGA</Distractor3>\n    <Distractor4>9</Distractor4>\n    <TrueAnswer>9</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>11</QuestionNumber>\n    <QuestionBase>correct answer is : 10</QuestionBase>\n    <Distractor1>VMU4QCGA</Distractor1>\n    <Distractor2>VMU4QCGA</Distractor2>\n    <Distractor3>VMU4QCGA</Distractor3>\n    <Distractor4>10</Distractor4>\n    <TrueAnswer>10</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>12</QuestionNumber>\n    <QuestionBase>correct answer is : 11</QuestionBase>\n    <Distractor1>VMU4QCGA</Distractor1>\n    <Distractor2>VMU4QCGA</Distractor2>\n    <Distractor3>VMU4QCGA</Distractor3>\n    <Distractor4>11</Distractor4>\n    <TrueAnswer>11</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>13</QuestionNumber>\n    <QuestionBase>correct answer is : 12</QuestionBase>\n    <Distractor1>VMU4QCGA</Distractor1>\n    <Distractor2>VMU4QCGA</Distractor2>\n    <Distractor3>VMU4QCGA</Distractor3>\n    <Distractor4>12</Distractor4>\n    <TrueAnswer>12</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>14</QuestionNumber>\n    <QuestionBase>correct answer is : 13</QuestionBase>\n    <Distractor1>P0CCIG5T</Distractor1>\n    <Distractor2>P0CCIG5T</Distractor2>\n    <Distractor3>P0CCIG5T</Distractor3>\n    <Distractor4>13</Distractor4>\n    <TrueAnswer>13</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>15</QuestionNumber>\n    <QuestionBase>correct answer is : 14</QuestionBase>\n    <Distractor1>P0CCIG5T</Distractor1>\n    <Distractor2>P0CCIG5T</Distractor2>\n    <Distractor3>P0CCIG5T</Distractor3>\n    <Distractor4>14</Distractor4>\n    <TrueAnswer>14</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>16</QuestionNumber>\n    <QuestionBase>correct answer is : 15</QuestionBase>\n    <Distractor1>P0CCIG5T</Distractor1>\n    <Distractor2>P0CCIG5T</Distractor2>\n    <Distractor3>P0CCIG5T</Distractor3>\n    <Distractor4>15</Distractor4>\n    <TrueAnswer>15</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>17</QuestionNumber>\n    <QuestionBase>correct answer is : 16</QuestionBase>\n    <Distractor1>P0CCIG5T</Distractor1>\n    <Distractor2>P0CCIG5T</Distractor2>\n    <Distractor3>P0CCIG5T</Distractor3>\n    <Distractor4>16</Distractor4>\n    <TrueAnswer>16</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>18</QuestionNumber>\n    <QuestionBase>correct answer is : 17</QuestionBase>\n    <Distractor1>P0CCIG5T</Distractor1>\n    <Distractor2>P0CCIG5T</Distractor2>\n    <Distractor3>P0CCIG5T</Distractor3>\n    <Distractor4>17</Distractor4>\n    <TrueAnswer>17</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>19</QuestionNumber>\n    <QuestionBase>correct answer is : 18</QuestionBase>\n    <Distractor1>P0CCIG5T</Distractor1>\n    <Distractor2>P0CCIG5T</Distractor2>\n    <Distractor3>P0CCIG5T</Distractor3>\n    <Distractor4>18</Distractor4>\n    <TrueAnswer>18</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>20</QuestionNumber>\n    <QuestionBase>correct answer is : 19</QuestionBase>\n    <Distractor1>P0CCIG5T</Distractor1>\n    <Distractor2>P0CCIG5T</Distractor2>\n    <Distractor3>P0CCIG5T</Distractor3>\n    <Distractor4>19</Distractor4>\n    <TrueAnswer>19</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>21</QuestionNumber>\n    <QuestionBase>correct answer is : 20</QuestionBase>\n    <Distractor1>P0CCIG5T</Distractor1>\n    <Distractor2>P0CCIG5T</Distractor2>\n    <Distractor3>P0CCIG5T</Distractor3>\n    <Distractor4>20</Distractor4>\n    <TrueAnswer>20</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>22</QuestionNumber>\n    <QuestionBase>correct answer is : 21</QuestionBase>\n    <Distractor1>P0CCIG5T</Distractor1>\n    <Distractor2>P0CCIG5T</Distractor2>\n    <Distractor3>P0CCIG5T</Distractor3>\n    <Distractor4>21</Distractor4>\n    <TrueAnswer>21</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>23</QuestionNumber>\n    <QuestionBase>correct answer is : 22</QuestionBase>\n    <Distractor1>P0CCIG5T</Distractor1>\n    <Distractor2>P0CCIG5T</Distractor2>\n    <Distractor3>P0CCIG5T</Distractor3>\n    <Distractor4>22</Distractor4>\n    <TrueAnswer>22</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>24</QuestionNumber>\n    <QuestionBase>correct answer is : 23</QuestionBase>\n    <Distractor1>P0CCIG5T</Distractor1>\n    <Distractor2>P0CCIG5T</Distractor2>\n    <Distractor3>P0CCIG5T</Distractor3>\n    <Distractor4>23</Distractor4>\n    <TrueAnswer>23</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>25</QuestionNumber>\n    <QuestionBase>correct answer is : 24</QuestionBase>\n    <Distractor1>P0CCIG5T</Distractor1>\n    <Distractor2>P0CCIG5T</Distractor2>\n    <Distractor3>P0CCIG5T</Distractor3>\n    <Distractor4>24</Distractor4>\n    <TrueAnswer>24</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>26</QuestionNumber>\n    <QuestionBase>correct answer is : 25</QuestionBase>\n    <Distractor1>P0CCIG5T</Distractor1>\n    <Distractor2>P0CCIG5T</Distractor2>\n    <Distractor3>P0CCIG5T</Distractor3>\n    <Distractor4>25</Distractor4>\n    <TrueAnswer>25</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>27</QuestionNumber>\n    <QuestionBase>correct answer is : 26</QuestionBase>\n    <Distractor1>P0CCIG5T</Distractor1>\n    <Distractor2>P0CCIG5T</Distractor2>\n    <Distractor3>P0CCIG5T</Distractor3>\n    <Distractor4>26</Distractor4>\n    <TrueAnswer>26</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>28</QuestionNumber>\n    <QuestionBase>correct answer is : 27</QuestionBase>\n    <Distractor1>1PJQQFCU</Distractor1>\n    <Distractor2>1PJQQFCU</Distractor2>\n    <Distractor3>1PJQQFCU</Distractor3>\n    <Distractor4>27</Distractor4>\n    <TrueAnswer>27</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>29</QuestionNumber>\n    <QuestionBase>correct answer is : 28</QuestionBase>\n    <Distractor1>1PJQQFCU</Distractor1>\n    <Distractor2>1PJQQFCU</Distractor2>\n    <Distractor3>1PJQQFCU</Distractor3>\n    <Distractor4>28</Distractor4>\n    <TrueAnswer>28</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>30</QuestionNumber>\n    <QuestionBase>correct answer is : 29</QuestionBase>\n    <Distractor1>1PJQQFCU</Distractor1>\n    <Distractor2>1PJQQFCU</Distractor2>\n    <Distractor3>1PJQQFCU</Distractor3>\n    <Distractor4>29</Distractor4>\n    <TrueAnswer>29</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>31</QuestionNumber>\n    <QuestionBase>correct answer is : 30</QuestionBase>\n    <Distractor1>1PJQQFCU</Distractor1>\n    <Distractor2>1PJQQFCU</Distractor2>\n    <Distractor3>1PJQQFCU</Distractor3>\n    <Distractor4>30</Distractor4>\n    <TrueAnswer>30</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>32</QuestionNumber>\n    <QuestionBase>correct answer is : 31</QuestionBase>\n    <Distractor1>1PJQQFCU</Distractor1>\n    <Distractor2>1PJQQFCU</Distractor2>\n    <Distractor3>1PJQQFCU</Distractor3>\n    <Distractor4>31</Distractor4>\n    <TrueAnswer>31</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>33</QuestionNumber>\n    <QuestionBase>correct answer is : 32</QuestionBase>\n    <Distractor1>1PJQQFCU</Distractor1>\n    <Distractor2>1PJQQFCU</Distractor2>\n    <Distractor3>1PJQQFCU</Distractor3>\n    <Distractor4>32</Distractor4>\n    <TrueAnswer>32</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>34</QuestionNumber>\n    <QuestionBase>correct answer is : 33</QuestionBase>\n    <Distractor1>1PJQQFCU</Distractor1>\n    <Distractor2>1PJQQFCU</Distractor2>\n    <Distractor3>1PJQQFCU</Distractor3>\n    <Distractor4>33</Distractor4>\n    <TrueAnswer>33</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>35</QuestionNumber>\n    <QuestionBase>correct answer is : 34</QuestionBase>\n    <Distractor1>1PJQQFCU</Distractor1>\n    <Distractor2>1PJQQFCU</Distractor2>\n    <Distractor3>1PJQQFCU</Distractor3>\n    <Distractor4>34</Distractor4>\n    <TrueAnswer>34</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>36</QuestionNumber>\n    <QuestionBase>correct answer is : 35</QuestionBase>\n    <Distractor1>1PJQQFCU</Distractor1>\n    <Distractor2>1PJQQFCU</Distractor2>\n    <Distractor3>1PJQQFCU</Distractor3>\n    <Distractor4>35</Distractor4>\n    <TrueAnswer>35</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>37</QuestionNumber>\n    <QuestionBase>correct answer is : 36</QuestionBase>\n    <Distractor1>1PJQQFCU</Distractor1>\n    <Distractor2>1PJQQFCU</Distractor2>\n    <Distractor3>1PJQQFCU</Distractor3>\n    <Distractor4>36</Distractor4>\n    <TrueAnswer>36</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>38</QuestionNumber>\n    <QuestionBase>correct answer is : 37</QuestionBase>\n    <Distractor1>1PJQQFCU</Distractor1>\n    <Distractor2>1PJQQFCU</Distractor2>\n    <Distractor3>1PJQQFCU</Distractor3>\n    <Distractor4>37</Distractor4>\n    <TrueAnswer>37</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>39</QuestionNumber>\n    <QuestionBase>correct answer is : 38</QuestionBase>\n    <Distractor1>W30YIJ1D</Distractor1>\n    <Distractor2>W30YIJ1D</Distractor2>\n    <Distractor3>W30YIJ1D</Distractor3>\n    <Distractor4>38</Distractor4>\n    <TrueAnswer>38</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>40</QuestionNumber>\n    <QuestionBase>correct answer is : 39</QuestionBase>\n    <Distractor1>W30YIJ1D</Distractor1>\n    <Distractor2>W30YIJ1D</Distractor2>\n    <Distractor3>W30YIJ1D</Distractor3>\n    <Distractor4>39</Distractor4>\n    <TrueAnswer>39</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>41</QuestionNumber>\n    <QuestionBase>correct answer is : 40</QuestionBase>\n    <Distractor1>W30YIJ1D</Distractor1>\n    <Distractor2>W30YIJ1D</Distractor2>\n    <Distractor3>W30YIJ1D</Distractor3>\n    <Distractor4>40</Distractor4>\n    <TrueAnswer>40</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>42</QuestionNumber>\n    <QuestionBase>correct answer is : 41</QuestionBase>\n    <Distractor1>W30YIJ1D</Distractor1>\n    <Distractor2>W30YIJ1D</Distractor2>\n    <Distractor3>W30YIJ1D</Distractor3>\n    <Distractor4>41</Distractor4>\n    <TrueAnswer>41</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>43</QuestionNumber>\n    <QuestionBase>correct answer is : 42</QuestionBase>\n    <Distractor1>W30YIJ1D</Distractor1>\n    <Distractor2>W30YIJ1D</Distractor2>\n    <Distractor3>W30YIJ1D</Distractor3>\n    <Distractor4>42</Distractor4>\n    <TrueAnswer>42</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>44</QuestionNumber>\n    <QuestionBase>correct answer is : 43</QuestionBase>\n    <Distractor1>W30YIJ1D</Distractor1>\n    <Distractor2>W30YIJ1D</Distractor2>\n    <Distractor3>W30YIJ1D</Distractor3>\n    <Distractor4>43</Distractor4>\n    <TrueAnswer>43</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>45</QuestionNumber>\n    <QuestionBase>correct answer is : 44</QuestionBase>\n    <Distractor1>W30YIJ1D</Distractor1>\n    <Distractor2>W30YIJ1D</Distractor2>\n    <Distractor3>W30YIJ1D</Distractor3>\n    <Distractor4>44</Distractor4>\n    <TrueAnswer>44</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>46</QuestionNumber>\n    <QuestionBase>correct answer is : 45</QuestionBase>\n    <Distractor1>W30YIJ1D</Distractor1>\n    <Distractor2>W30YIJ1D</Distractor2>\n    <Distractor3>W30YIJ1D</Distractor3>\n    <Distractor4>45</Distractor4>\n    <TrueAnswer>45</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>47</QuestionNumber>\n    <QuestionBase>correct answer is : 46</QuestionBase>\n    <Distractor1>W30YIJ1D</Distractor1>\n    <Distractor2>W30YIJ1D</Distractor2>\n    <Distractor3>W30YIJ1D</Distractor3>\n    <Distractor4>46</Distractor4>\n    <TrueAnswer>46</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>48</QuestionNumber>\n    <QuestionBase>correct answer is : 47</QuestionBase>\n    <Distractor1>W30YIJ1D</Distractor1>\n    <Distractor2>W30YIJ1D</Distractor2>\n    <Distractor3>W30YIJ1D</Distractor3>\n    <Distractor4>47</Distractor4>\n    <TrueAnswer>47</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>49</QuestionNumber>\n    <QuestionBase>correct answer is : 48</QuestionBase>\n    <Distractor1>W30YIJ1D</Distractor1>\n    <Distractor2>W30YIJ1D</Distractor2>\n    <Distractor3>W30YIJ1D</Distractor3>\n    <Distractor4>48</Distractor4>\n    <TrueAnswer>48</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>50</QuestionNumber>\n    <QuestionBase>correct answer is : 49</QuestionBase>\n    <Distractor1>W30YIJ1D</Distractor1>\n    <Distractor2>W30YIJ1D</Distractor2>\n    <Distractor3>W30YIJ1D</Distractor3>\n    <Distractor4>49</Distractor4>\n    <TrueAnswer>49</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>51</QuestionNumber>\n    <QuestionBase>correct answer is : 50</QuestionBase>\n    <Distractor1>W30YIJ1D</Distractor1>\n    <Distractor2>W30YIJ1D</Distractor2>\n    <Distractor3>W30YIJ1D</Distractor3>\n    <Distractor4>50</Distractor4>\n    <TrueAnswer>50</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>52</QuestionNumber>\n    <QuestionBase>correct answer is : 51</QuestionBase>\n    <Distractor1>W30YIJ1D</Distractor1>\n    <Distractor2>W30YIJ1D</Distractor2>\n    <Distractor3>W30YIJ1D</Distractor3>\n    <Distractor4>51</Distractor4>\n    <TrueAnswer>51</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>53</QuestionNumber>\n    <QuestionBase>correct answer is : 52</QuestionBase>\n    <Distractor1>W30YIJ1D</Distractor1>\n    <Distractor2>W30YIJ1D</Distractor2>\n    <Distractor3>W30YIJ1D</Distractor3>\n    <Distractor4>52</Distractor4>\n    <TrueAnswer>52</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>54</QuestionNumber>\n    <QuestionBase>correct answer is : 53</QuestionBase>\n    <Distractor1>W30YIJ1D</Distractor1>\n    <Distractor2>W30YIJ1D</Distractor2>\n    <Distractor3>W30YIJ1D</Distractor3>\n    <Distractor4>53</Distractor4>\n    <TrueAnswer>53</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>55</QuestionNumber>\n    <QuestionBase>correct answer is : 54</QuestionBase>\n    <Distractor1>8S6DQI7E</Distractor1>\n    <Distractor2>8S6DQI7E</Distractor2>\n    <Distractor3>8S6DQI7E</Distractor3>\n    <Distractor4>54</Distractor4>\n    <TrueAnswer>54</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>56</QuestionNumber>\n    <QuestionBase>correct answer is : 55</QuestionBase>\n    <Distractor1>8S6DQI7E</Distractor1>\n    <Distractor2>8S6DQI7E</Distractor2>\n    <Distractor3>8S6DQI7E</Distractor3>\n    <Distractor4>55</Distractor4>\n    <TrueAnswer>55</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>57</QuestionNumber>\n    <QuestionBase>correct answer is : 56</QuestionBase>\n    <Distractor1>8S6DQI7E</Distractor1>\n    <Distractor2>8S6DQI7E</Distractor2>\n    <Distractor3>8S6DQI7E</Distractor3>\n    <Distractor4>56</Distractor4>\n    <TrueAnswer>56</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>58</QuestionNumber>\n    <QuestionBase>correct answer is : 57</QuestionBase>\n    <Distractor1>8S6DQI7E</Distractor1>\n    <Distractor2>8S6DQI7E</Distractor2>\n    <Distractor3>8S6DQI7E</Distractor3>\n    <Distractor4>57</Distractor4>\n    <TrueAnswer>57</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>59</QuestionNumber>\n    <QuestionBase>correct answer is : 58</QuestionBase>\n    <Distractor1>8S6DQI7E</Distractor1>\n    <Distractor2>8S6DQI7E</Distractor2>\n    <Distractor3>8S6DQI7E</Distractor3>\n    <Distractor4>58</Distractor4>\n    <TrueAnswer>58</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>60</QuestionNumber>\n    <QuestionBase>correct answer is : 59</QuestionBase>\n    <Distractor1>8S6DQI7E</Distractor1>\n    <Distractor2>8S6DQI7E</Distractor2>\n    <Distractor3>8S6DQI7E</Distractor3>\n    <Distractor4>59</Distractor4>\n    <TrueAnswer>59</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>61</QuestionNumber>\n    <QuestionBase>correct answer is : 60</QuestionBase>\n    <Distractor1>8S6DQI7E</Distractor1>\n    <Distractor2>8S6DQI7E</Distractor2>\n    <Distractor3>8S6DQI7E</Distractor3>\n    <Distractor4>60</Distractor4>\n    <TrueAnswer>60</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>62</QuestionNumber>\n    <QuestionBase>correct answer is : 61</QuestionBase>\n    <Distractor1>8S6DQI7E</Distractor1>\n    <Distractor2>8S6DQI7E</Distractor2>\n    <Distractor3>8S6DQI7E</Distractor3>\n    <Distractor4>61</Distractor4>\n    <TrueAnswer>61</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>63</QuestionNumber>\n    <QuestionBase>correct answer is : 62</QuestionBase>\n    <Distractor1>8S6DQI7E</Distractor1>\n    <Distractor2>8S6DQI7E</Distractor2>\n    <Distractor3>8S6DQI7E</Distractor3>\n    <Distractor4>62</Distractor4>\n    <TrueAnswer>62</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>64</QuestionNumber>\n    <QuestionBase>correct answer is : 63</QuestionBase>\n    <Distractor1>8S6DQI7E</Distractor1>\n    <Distractor2>8S6DQI7E</Distractor2>\n    <Distractor3>8S6DQI7E</Distractor3>\n    <Distractor4>63</Distractor4>\n    <TrueAnswer>63</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>65</QuestionNumber>\n    <QuestionBase>correct answer is : 64</QuestionBase>\n    <Distractor1>8S6DQI7E</Distractor1>\n    <Distractor2>8S6DQI7E</Distractor2>\n    <Distractor3>8S6DQI7E</Distractor3>\n    <Distractor4>64</Distractor4>\n    <TrueAnswer>64</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>66</QuestionNumber>\n    <QuestionBase>correct answer is : 65</QuestionBase>\n    <Distractor1>8S6DQI7E</Distractor1>\n    <Distractor2>8S6DQI7E</Distractor2>\n    <Distractor3>8S6DQI7E</Distractor3>\n    <Distractor4>65</Distractor4>\n    <TrueAnswer>65</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>67</QuestionNumber>\n    <QuestionBase>correct answer is : 66</QuestionBase>\n    <Distractor1>8S6DQI7E</Distractor1>\n    <Distractor2>8S6DQI7E</Distractor2>\n    <Distractor3>8S6DQI7E</Distractor3>\n    <Distractor4>66</Distractor4>\n    <TrueAnswer>66</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>68</QuestionNumber>\n    <QuestionBase>correct answer is : 67</QuestionBase>\n    <Distractor1>8S6DQI7E</Distractor1>\n    <Distractor2>8S6DQI7E</Distractor2>\n    <Distractor3>8S6DQI7E</Distractor3>\n    <Distractor4>67</Distractor4>\n    <TrueAnswer>67</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>69</QuestionNumber>\n    <QuestionBase>correct answer is : 68</QuestionBase>\n    <Distractor1>MIDSYIEF</Distractor1>\n    <Distractor2>MIDSYIEF</Distractor2>\n    <Distractor3>MIDSYIEF</Distractor3>\n    <Distractor4>68</Distractor4>\n    <TrueAnswer>68</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>70</QuestionNumber>\n    <QuestionBase>correct answer is : 69</QuestionBase>\n    <Distractor1>MIDSYIEF</Distractor1>\n    <Distractor2>MIDSYIEF</Distractor2>\n    <Distractor3>MIDSYIEF</Distractor3>\n    <Distractor4>69</Distractor4>\n    <TrueAnswer>69</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>71</QuestionNumber>\n    <QuestionBase>correct answer is : 70</QuestionBase>\n    <Distractor1>MIDSYIEF</Distractor1>\n    <Distractor2>MIDSYIEF</Distractor2>\n    <Distractor3>MIDSYIEF</Distractor3>\n    <Distractor4>70</Distractor4>\n    <TrueAnswer>70</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>72</QuestionNumber>\n    <QuestionBase>correct answer is : 71</QuestionBase>\n    <Distractor1>MIDSYIEF</Distractor1>\n    <Distractor2>MIDSYIEF</Distractor2>\n    <Distractor3>MIDSYIEF</Distractor3>\n    <Distractor4>71</Distractor4>\n    <TrueAnswer>71</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>73</QuestionNumber>\n    <QuestionBase>correct answer is : 72</QuestionBase>\n    <Distractor1>MIDSYIEF</Distractor1>\n    <Distractor2>MIDSYIEF</Distractor2>\n    <Distractor3>MIDSYIEF</Distractor3>\n    <Distractor4>72</Distractor4>\n    <TrueAnswer>72</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>74</QuestionNumber>\n    <QuestionBase>correct answer is : 73</QuestionBase>\n    <Distractor1>MIDSYIEF</Distractor1>\n    <Distractor2>MIDSYIEF</Distractor2>\n    <Distractor3>MIDSYIEF</Distractor3>\n    <Distractor4>73</Distractor4>\n    <TrueAnswer>73</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>75</QuestionNumber>\n    <QuestionBase>correct answer is : 74</QuestionBase>\n    <Distractor1>MIDSYIEF</Distractor1>\n    <Distractor2>MIDSYIEF</Distractor2>\n    <Distractor3>MIDSYIEF</Distractor3>\n    <Distractor4>74</Distractor4>\n    <TrueAnswer>74</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>76</QuestionNumber>\n    <QuestionBase>correct answer is : 75</QuestionBase>\n    <Distractor1>MIDSYIEF</Distractor1>\n    <Distractor2>MIDSYIEF</Distractor2>\n    <Distractor3>MIDSYIEF</Distractor3>\n    <Distractor4>75</Distractor4>\n    <TrueAnswer>75</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>77</QuestionNumber>\n    <QuestionBase>correct answer is : 76</QuestionBase>\n    <Distractor1>MIDSYIEF</Distractor1>\n    <Distractor2>MIDSYIEF</Distractor2>\n    <Distractor3>MIDSYIEF</Distractor3>\n    <Distractor4>76</Distractor4>\n    <TrueAnswer>76</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>78</QuestionNumber>\n    <QuestionBase>correct answer is : 77</QuestionBase>\n    <Distractor1>MIDSYIEF</Distractor1>\n    <Distractor2>MIDSYIEF</Distractor2>\n    <Distractor3>MIDSYIEF</Distractor3>\n    <Distractor4>77</Distractor4>\n    <TrueAnswer>77</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>79</QuestionNumber>\n    <QuestionBase>correct answer is : 78</QuestionBase>\n    <Distractor1>MIDSYIEF</Distractor1>\n    <Distractor2>MIDSYIEF</Distractor2>\n    <Distractor3>MIDSYIEF</Distractor3>\n    <Distractor4>78</Distractor4>\n    <TrueAnswer>78</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>80</QuestionNumber>\n    <QuestionBase>correct answer is : 79</QuestionBase>\n    <Distractor1>MIDSYIEF</Distractor1>\n    <Distractor2>MIDSYIEF</Distractor2>\n    <Distractor3>MIDSYIEF</Distractor3>\n    <Distractor4>79</Distractor4>\n    <TrueAnswer>79</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>81</QuestionNumber>\n    <QuestionBase>correct answer is : 80</QuestionBase>\n    <Distractor1>MIDSYIEF</Distractor1>\n    <Distractor2>MIDSYIEF</Distractor2>\n    <Distractor3>MIDSYIEF</Distractor3>\n    <Distractor4>80</Distractor4>\n    <TrueAnswer>80</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>82</QuestionNumber>\n    <QuestionBase>correct answer is : 81</QuestionBase>\n    <Distractor1>MIDSYIEF</Distractor1>\n    <Distractor2>MIDSYIEF</Distractor2>\n    <Distractor3>MIDSYIEF</Distractor3>\n    <Distractor4>81</Distractor4>\n    <TrueAnswer>81</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>83</QuestionNumber>\n    <QuestionBase>correct answer is : 82</QuestionBase>\n    <Distractor1>GWUZQM4X</Distractor1>\n    <Distractor2>GWUZQM4X</Distractor2>\n    <Distractor3>GWUZQM4X</Distractor3>\n    <Distractor4>82</Distractor4>\n    <TrueAnswer>82</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>84</QuestionNumber>\n    <QuestionBase>correct answer is : 83</QuestionBase>\n    <Distractor1>GWUZQM4X</Distractor1>\n    <Distractor2>GWUZQM4X</Distractor2>\n    <Distractor3>GWUZQM4X</Distractor3>\n    <Distractor4>83</Distractor4>\n    <TrueAnswer>83</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>85</QuestionNumber>\n    <QuestionBase>correct answer is : 84</QuestionBase>\n    <Distractor1>GWUZQM4X</Distractor1>\n    <Distractor2>GWUZQM4X</Distractor2>\n    <Distractor3>GWUZQM4X</Distractor3>\n    <Distractor4>84</Distractor4>\n    <TrueAnswer>84</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>86</QuestionNumber>\n    <QuestionBase>correct answer is : 85</QuestionBase>\n    <Distractor1>GWUZQM4X</Distractor1>\n    <Distractor2>GWUZQM4X</Distractor2>\n    <Distractor3>GWUZQM4X</Distractor3>\n    <Distractor4>85</Distractor4>\n    <TrueAnswer>85</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>87</QuestionNumber>\n    <QuestionBase>correct answer is : 86</QuestionBase>\n    <Distractor1>GWUZQM4X</Distractor1>\n    <Distractor2>GWUZQM4X</Distractor2>\n    <Distractor3>GWUZQM4X</Distractor3>\n    <Distractor4>86</Distractor4>\n    <TrueAnswer>86</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>88</QuestionNumber>\n    <QuestionBase>correct answer is : 87</QuestionBase>\n    <Distractor1>GWUZQM4X</Distractor1>\n    <Distractor2>GWUZQM4X</Distractor2>\n    <Distractor3>GWUZQM4X</Distractor3>\n    <Distractor4>87</Distractor4>\n    <TrueAnswer>87</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>89</QuestionNumber>\n    <QuestionBase>correct answer is : 88</QuestionBase>\n    <Distractor1>GWUZQM4X</Distractor1>\n    <Distractor2>GWUZQM4X</Distractor2>\n    <Distractor3>GWUZQM4X</Distractor3>\n    <Distractor4>88</Distractor4>\n    <TrueAnswer>88</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>90</QuestionNumber>\n    <QuestionBase>correct answer is : 89</QuestionBase>\n    <Distractor1>GWUZQM4X</Distractor1>\n    <Distractor2>GWUZQM4X</Distractor2>\n    <Distractor3>GWUZQM4X</Distractor3>\n    <Distractor4>89</Distractor4>\n    <TrueAnswer>89</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>91</QuestionNumber>\n    <QuestionBase>correct answer is : 90</QuestionBase>\n    <Distractor1>GWUZQM4X</Distractor1>\n    <Distractor2>GWUZQM4X</Distractor2>\n    <Distractor3>GWUZQM4X</Distractor3>\n    <Distractor4>90</Distractor4>\n    <TrueAnswer>90</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>92</QuestionNumber>\n    <QuestionBase>correct answer is : 91</QuestionBase>\n    <Distractor1>GWUZQM4X</Distractor1>\n    <Distractor2>GWUZQM4X</Distractor2>\n    <Distractor3>GWUZQM4X</Distractor3>\n    <Distractor4>91</Distractor4>\n    <TrueAnswer>91</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>93</QuestionNumber>\n    <QuestionBase>correct answer is : 92</QuestionBase>\n    <Distractor1>GWUZQM4X</Distractor1>\n    <Distractor2>GWUZQM4X</Distractor2>\n    <Distractor3>GWUZQM4X</Distractor3>\n    <Distractor4>92</Distractor4>\n    <TrueAnswer>92</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>94</QuestionNumber>\n    <QuestionBase>correct answer is : 93</QuestionBase>\n    <Distractor1>GWUZQM4X</Distractor1>\n    <Distractor2>GWUZQM4X</Distractor2>\n    <Distractor3>GWUZQM4X</Distractor3>\n    <Distractor4>93</Distractor4>\n    <TrueAnswer>93</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>95</QuestionNumber>\n    <QuestionBase>correct answer is : 94</QuestionBase>\n    <Distractor1>GWUZQM4X</Distractor1>\n    <Distractor2>GWUZQM4X</Distractor2>\n    <Distractor3>GWUZQM4X</Distractor3>\n    <Distractor4>94</Distractor4>\n    <TrueAnswer>94</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>96</QuestionNumber>\n    <QuestionBase>correct answer is : 95</QuestionBase>\n    <Distractor1>GWUZQM4X</Distractor1>\n    <Distractor2>GWUZQM4X</Distractor2>\n    <Distractor3>GWUZQM4X</Distractor3>\n    <Distractor4>95</Distractor4>\n    <TrueAnswer>95</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>97</QuestionNumber>\n    <QuestionBase>correct answer is : 96</QuestionBase>\n    <Distractor1>GWUZQM4X</Distractor1>\n    <Distractor2>GWUZQM4X</Distractor2>\n    <Distractor3>GWUZQM4X</Distractor3>\n    <Distractor4>96</Distractor4>\n    <TrueAnswer>96</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>98</QuestionNumber>\n    <QuestionBase>correct answer is : 97</QuestionBase>\n    <Distractor1>TL1EYLAY</Distractor1>\n    <Distractor2>TL1EYLAY</Distractor2>\n    <Distractor3>TL1EYLAY</Distractor3>\n    <Distractor4>97</Distractor4>\n    <TrueAnswer>97</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>99</QuestionNumber>\n    <QuestionBase>correct answer is : 98</QuestionBase>\n    <Distractor1>TL1EYLAY</Distractor1>\n    <Distractor2>TL1EYLAY</Distractor2>\n    <Distractor3>TL1EYLAY</Distractor3>\n    <Distractor4>98</Distractor4>\n    <TrueAnswer>98</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>100</QuestionNumber>\n    <QuestionBase>correct answer is : 99</QuestionBase>\n    <Distractor1>TL1EYLAY</Distractor1>\n    <Distractor2>TL1EYLAY</Distractor2>\n    <Distractor3>TL1EYLAY</Distractor3>\n    <Distractor4>99</Distractor4>\n    <TrueAnswer>99</TrueAnswer>\n  </c_SmallQuestion>\n</ArrayOfC_SmallQuestion>', 100, 0);
INSERT INTO `tbl_quizes` (`id`, `quest_name`, `xml_base`, `state_long`, `drp`) VALUES
(4, 'asdf', '<?xml version=\"1.0\" encoding=\"utf-16\"?>\n<ArrayOfC_SmallQuestion xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\">\n  <c_SmallQuestion>\n    <QuestionNumber>1</QuestionNumber>\n    <QuestionBase>correct answer is : 0</QuestionBase>\n    <Distractor1>0MRVQLFN</Distractor1>\n    <Distractor2>0MRVQLFN</Distractor2>\n    <Distractor3>0MRVQLFN</Distractor3>\n    <Distractor4>0</Distractor4>\n    <TrueAnswer>0</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>2</QuestionNumber>\n    <QuestionBase>correct answer is : 1</QuestionBase>\n    <Distractor1>0MRVQLFN</Distractor1>\n    <Distractor2>0MRVQLFN</Distractor2>\n    <Distractor3>0MRVQLFN</Distractor3>\n    <Distractor4>1</Distractor4>\n    <TrueAnswer>1</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>3</QuestionNumber>\n    <QuestionBase>correct answer is : 2</QuestionBase>\n    <Distractor1>0MRVQLFN</Distractor1>\n    <Distractor2>0MRVQLFN</Distractor2>\n    <Distractor3>0MRVQLFN</Distractor3>\n    <Distractor4>2</Distractor4>\n    <TrueAnswer>2</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>4</QuestionNumber>\n    <QuestionBase>correct answer is : 3</QuestionBase>\n    <Distractor1>0MRVQLFN</Distractor1>\n    <Distractor2>0MRVQLFN</Distractor2>\n    <Distractor3>0MRVQLFN</Distractor3>\n    <Distractor4>3</Distractor4>\n    <TrueAnswer>3</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>5</QuestionNumber>\n    <QuestionBase>correct answer is : 4</QuestionBase>\n    <Distractor1>0MRVQLFN</Distractor1>\n    <Distractor2>0MRVQLFN</Distractor2>\n    <Distractor3>0MRVQLFN</Distractor3>\n    <Distractor4>4</Distractor4>\n    <TrueAnswer>4</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>6</QuestionNumber>\n    <QuestionBase>correct answer is : 5</QuestionBase>\n    <Distractor1>0MRVQLFN</Distractor1>\n    <Distractor2>0MRVQLFN</Distractor2>\n    <Distractor3>0MRVQLFN</Distractor3>\n    <Distractor4>5</Distractor4>\n    <TrueAnswer>5</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>7</QuestionNumber>\n    <QuestionBase>correct answer is : 6</QuestionBase>\n    <Distractor1>0MRVQLFN</Distractor1>\n    <Distractor2>0MRVQLFN</Distractor2>\n    <Distractor3>0MRVQLFN</Distractor3>\n    <Distractor4>6</Distractor4>\n    <TrueAnswer>6</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>8</QuestionNumber>\n    <QuestionBase>correct answer is : 7</QuestionBase>\n    <Distractor1>0MRVQLFN</Distractor1>\n    <Distractor2>0MRVQLFN</Distractor2>\n    <Distractor3>0MRVQLFN</Distractor3>\n    <Distractor4>7</Distractor4>\n    <TrueAnswer>7</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>9</QuestionNumber>\n    <QuestionBase>correct answer is : 8</QuestionBase>\n    <Distractor1>0MRVQLFN</Distractor1>\n    <Distractor2>0MRVQLFN</Distractor2>\n    <Distractor3>0MRVQLFN</Distractor3>\n    <Distractor4>8</Distractor4>\n    <TrueAnswer>8</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>10</QuestionNumber>\n    <QuestionBase>correct answer is : 9</QuestionBase>\n    <Distractor1>0MRVQLFN</Distractor1>\n    <Distractor2>0MRVQLFN</Distractor2>\n    <Distractor3>0MRVQLFN</Distractor3>\n    <Distractor4>9</Distractor4>\n    <TrueAnswer>9</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>11</QuestionNumber>\n    <QuestionBase>correct answer is : 10</QuestionBase>\n    <Distractor1>0MRVQLFN</Distractor1>\n    <Distractor2>U082IP55</Distractor2>\n    <Distractor3>U082IP55</Distractor3>\n    <Distractor4>10</Distractor4>\n    <TrueAnswer>10</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>12</QuestionNumber>\n    <QuestionBase>correct answer is : 11</QuestionBase>\n    <Distractor1>U082IP55</Distractor1>\n    <Distractor2>U082IP55</Distractor2>\n    <Distractor3>U082IP55</Distractor3>\n    <Distractor4>11</Distractor4>\n    <TrueAnswer>11</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>13</QuestionNumber>\n    <QuestionBase>correct answer is : 12</QuestionBase>\n    <Distractor1>U082IP55</Distractor1>\n    <Distractor2>U082IP55</Distractor2>\n    <Distractor3>U082IP55</Distractor3>\n    <Distractor4>12</Distractor4>\n    <TrueAnswer>12</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>14</QuestionNumber>\n    <QuestionBase>correct answer is : 13</QuestionBase>\n    <Distractor1>U082IP55</Distractor1>\n    <Distractor2>U082IP55</Distractor2>\n    <Distractor3>U082IP55</Distractor3>\n    <Distractor4>13</Distractor4>\n    <TrueAnswer>13</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>15</QuestionNumber>\n    <QuestionBase>correct answer is : 14</QuestionBase>\n    <Distractor1>U082IP55</Distractor1>\n    <Distractor2>U082IP55</Distractor2>\n    <Distractor3>U082IP55</Distractor3>\n    <Distractor4>14</Distractor4>\n    <TrueAnswer>14</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>16</QuestionNumber>\n    <QuestionBase>correct answer is : 15</QuestionBase>\n    <Distractor1>U082IP55</Distractor1>\n    <Distractor2>U082IP55</Distractor2>\n    <Distractor3>U082IP55</Distractor3>\n    <Distractor4>15</Distractor4>\n    <TrueAnswer>15</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>17</QuestionNumber>\n    <QuestionBase>correct answer is : 16</QuestionBase>\n    <Distractor1>U082IP55</Distractor1>\n    <Distractor2>U082IP55</Distractor2>\n    <Distractor3>U082IP55</Distractor3>\n    <Distractor4>16</Distractor4>\n    <TrueAnswer>16</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>18</QuestionNumber>\n    <QuestionBase>correct answer is : 17</QuestionBase>\n    <Distractor1>U082IP55</Distractor1>\n    <Distractor2>U082IP55</Distractor2>\n    <Distractor3>U082IP55</Distractor3>\n    <Distractor4>17</Distractor4>\n    <TrueAnswer>17</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>19</QuestionNumber>\n    <QuestionBase>correct answer is : 18</QuestionBase>\n    <Distractor1>U082IP55</Distractor1>\n    <Distractor2>U082IP55</Distractor2>\n    <Distractor3>U082IP55</Distractor3>\n    <Distractor4>18</Distractor4>\n    <TrueAnswer>18</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>20</QuestionNumber>\n    <QuestionBase>correct answer is : 19</QuestionBase>\n    <Distractor1>U082IP55</Distractor1>\n    <Distractor2>U082IP55</Distractor2>\n    <Distractor3>U082IP55</Distractor3>\n    <Distractor4>19</Distractor4>\n    <TrueAnswer>19</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>21</QuestionNumber>\n    <QuestionBase>correct answer is : 20</QuestionBase>\n    <Distractor1>U082IP55</Distractor1>\n    <Distractor2>U082IP55</Distractor2>\n    <Distractor3>U082IP55</Distractor3>\n    <Distractor4>20</Distractor4>\n    <TrueAnswer>20</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>22</QuestionNumber>\n    <QuestionBase>correct answer is : 21</QuestionBase>\n    <Distractor1>U082IP55</Distractor1>\n    <Distractor2>U082IP55</Distractor2>\n    <Distractor3>U082IP55</Distractor3>\n    <Distractor4>21</Distractor4>\n    <TrueAnswer>21</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>23</QuestionNumber>\n    <QuestionBase>correct answer is : 22</QuestionBase>\n    <Distractor1>U082IP55</Distractor1>\n    <Distractor2>U082IP55</Distractor2>\n    <Distractor3>U082IP55</Distractor3>\n    <Distractor4>22</Distractor4>\n    <TrueAnswer>22</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>24</QuestionNumber>\n    <QuestionBase>correct answer is : 23</QuestionBase>\n    <Distractor1>U082IP55</Distractor1>\n    <Distractor2>U082IP55</Distractor2>\n    <Distractor3>U082IP55</Distractor3>\n    <Distractor4>23</Distractor4>\n    <TrueAnswer>23</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>25</QuestionNumber>\n    <QuestionBase>correct answer is : 24</QuestionBase>\n    <Distractor1>U082IP55</Distractor1>\n    <Distractor2>U082IP55</Distractor2>\n    <Distractor3>U082IP55</Distractor3>\n    <Distractor4>24</Distractor4>\n    <TrueAnswer>24</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>26</QuestionNumber>\n    <QuestionBase>correct answer is : 25</QuestionBase>\n    <Distractor1>U082IP55</Distractor1>\n    <Distractor2>7QFHQPB6</Distractor2>\n    <Distractor3>7QFHQPB6</Distractor3>\n    <Distractor4>25</Distractor4>\n    <TrueAnswer>25</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>27</QuestionNumber>\n    <QuestionBase>correct answer is : 26</QuestionBase>\n    <Distractor1>7QFHQPB6</Distractor1>\n    <Distractor2>7QFHQPB6</Distractor2>\n    <Distractor3>7QFHQPB6</Distractor3>\n    <Distractor4>26</Distractor4>\n    <TrueAnswer>26</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>28</QuestionNumber>\n    <QuestionBase>correct answer is : 27</QuestionBase>\n    <Distractor1>7QFHQPB6</Distractor1>\n    <Distractor2>7QFHQPB6</Distractor2>\n    <Distractor3>7QFHQPB6</Distractor3>\n    <Distractor4>27</Distractor4>\n    <TrueAnswer>27</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>29</QuestionNumber>\n    <QuestionBase>correct answer is : 28</QuestionBase>\n    <Distractor1>7QFHQPB6</Distractor1>\n    <Distractor2>7QFHQPB6</Distractor2>\n    <Distractor3>7QFHQPB6</Distractor3>\n    <Distractor4>28</Distractor4>\n    <TrueAnswer>28</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>30</QuestionNumber>\n    <QuestionBase>correct answer is : 29</QuestionBase>\n    <Distractor1>7QFHQPB6</Distractor1>\n    <Distractor2>7QFHQPB6</Distractor2>\n    <Distractor3>7QFHQPB6</Distractor3>\n    <Distractor4>29</Distractor4>\n    <TrueAnswer>29</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>31</QuestionNumber>\n    <QuestionBase>correct answer is : 30</QuestionBase>\n    <Distractor1>7QFHQPB6</Distractor1>\n    <Distractor2>7QFHQPB6</Distractor2>\n    <Distractor3>7QFHQPB6</Distractor3>\n    <Distractor4>30</Distractor4>\n    <TrueAnswer>30</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>32</QuestionNumber>\n    <QuestionBase>correct answer is : 31</QuestionBase>\n    <Distractor1>7QFHQPB6</Distractor1>\n    <Distractor2>7QFHQPB6</Distractor2>\n    <Distractor3>7QFHQPB6</Distractor3>\n    <Distractor4>31</Distractor4>\n    <TrueAnswer>31</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>33</QuestionNumber>\n    <QuestionBase>correct answer is : 32</QuestionBase>\n    <Distractor1>7QFHQPB6</Distractor1>\n    <Distractor2>7QFHQPB6</Distractor2>\n    <Distractor3>7QFHQPB6</Distractor3>\n    <Distractor4>32</Distractor4>\n    <TrueAnswer>32</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>34</QuestionNumber>\n    <QuestionBase>correct answer is : 33</QuestionBase>\n    <Distractor1>7QFHQPB6</Distractor1>\n    <Distractor2>7QFHQPB6</Distractor2>\n    <Distractor3>7QFHQPB6</Distractor3>\n    <Distractor4>33</Distractor4>\n    <TrueAnswer>33</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>35</QuestionNumber>\n    <QuestionBase>correct answer is : 34</QuestionBase>\n    <Distractor1>7QFHQPB6</Distractor1>\n    <Distractor2>7QFHQPB6</Distractor2>\n    <Distractor3>7QFHQPB6</Distractor3>\n    <Distractor4>34</Distractor4>\n    <TrueAnswer>34</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>36</QuestionNumber>\n    <QuestionBase>correct answer is : 35</QuestionBase>\n    <Distractor1>7QFHQPB6</Distractor1>\n    <Distractor2>7QFHQPB6</Distractor2>\n    <Distractor3>7QFHQPB6</Distractor3>\n    <Distractor4>35</Distractor4>\n    <TrueAnswer>35</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>37</QuestionNumber>\n    <QuestionBase>correct answer is : 36</QuestionBase>\n    <Distractor1>7QFHQPB6</Distractor1>\n    <Distractor2>7QFHQPB6</Distractor2>\n    <Distractor3>7QFHQPB6</Distractor3>\n    <Distractor4>36</Distractor4>\n    <TrueAnswer>36</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>38</QuestionNumber>\n    <QuestionBase>correct answer is : 37</QuestionBase>\n    <Distractor1>7QFHQPB6</Distractor1>\n    <Distractor2>7QFHQPB6</Distractor2>\n    <Distractor3>7QFHQPB6</Distractor3>\n    <Distractor4>37</Distractor4>\n    <TrueAnswer>37</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>39</QuestionNumber>\n    <QuestionBase>correct answer is : 38</QuestionBase>\n    <Distractor1>7QFHQPB6</Distractor1>\n    <Distractor2>7QFHQPB6</Distractor2>\n    <Distractor3>7QFHQPB6</Distractor3>\n    <Distractor4>38</Distractor4>\n    <TrueAnswer>38</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>40</QuestionNumber>\n    <QuestionBase>correct answer is : 39</QuestionBase>\n    <Distractor1>7QFHQPB6</Distractor1>\n    <Distractor2>7QFHQPB6</Distractor2>\n    <Distractor3>7QFHQPB6</Distractor3>\n    <Distractor4>39</Distractor4>\n    <TrueAnswer>39</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>41</QuestionNumber>\n    <QuestionBase>correct answer is : 40</QuestionBase>\n    <Distractor1>7QFHQPB6</Distractor1>\n    <Distractor2>7QFHQPB6</Distractor2>\n    <Distractor3>7QFHQPB6</Distractor3>\n    <Distractor4>40</Distractor4>\n    <TrueAnswer>40</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>42</QuestionNumber>\n    <QuestionBase>correct answer is : 41</QuestionBase>\n    <Distractor1>14WOIS1Q</Distractor1>\n    <Distractor2>14WOIS1Q</Distractor2>\n    <Distractor3>14WOIS1Q</Distractor3>\n    <Distractor4>41</Distractor4>\n    <TrueAnswer>41</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>43</QuestionNumber>\n    <QuestionBase>correct answer is : 42</QuestionBase>\n    <Distractor1>14WOIS1Q</Distractor1>\n    <Distractor2>14WOIS1Q</Distractor2>\n    <Distractor3>14WOIS1Q</Distractor3>\n    <Distractor4>42</Distractor4>\n    <TrueAnswer>42</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>44</QuestionNumber>\n    <QuestionBase>correct answer is : 43</QuestionBase>\n    <Distractor1>14WOIS1Q</Distractor1>\n    <Distractor2>14WOIS1Q</Distractor2>\n    <Distractor3>14WOIS1Q</Distractor3>\n    <Distractor4>43</Distractor4>\n    <TrueAnswer>43</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>45</QuestionNumber>\n    <QuestionBase>correct answer is : 44</QuestionBase>\n    <Distractor1>14WOIS1Q</Distractor1>\n    <Distractor2>14WOIS1Q</Distractor2>\n    <Distractor3>14WOIS1Q</Distractor3>\n    <Distractor4>44</Distractor4>\n    <TrueAnswer>44</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>46</QuestionNumber>\n    <QuestionBase>correct answer is : 45</QuestionBase>\n    <Distractor1>14WOIS1Q</Distractor1>\n    <Distractor2>14WOIS1Q</Distractor2>\n    <Distractor3>14WOIS1Q</Distractor3>\n    <Distractor4>45</Distractor4>\n    <TrueAnswer>45</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>47</QuestionNumber>\n    <QuestionBase>correct answer is : 46</QuestionBase>\n    <Distractor1>14WOIS1Q</Distractor1>\n    <Distractor2>14WOIS1Q</Distractor2>\n    <Distractor3>14WOIS1Q</Distractor3>\n    <Distractor4>46</Distractor4>\n    <TrueAnswer>46</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>48</QuestionNumber>\n    <QuestionBase>correct answer is : 47</QuestionBase>\n    <Distractor1>14WOIS1Q</Distractor1>\n    <Distractor2>14WOIS1Q</Distractor2>\n    <Distractor3>14WOIS1Q</Distractor3>\n    <Distractor4>47</Distractor4>\n    <TrueAnswer>47</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>49</QuestionNumber>\n    <QuestionBase>correct answer is : 48</QuestionBase>\n    <Distractor1>14WOIS1Q</Distractor1>\n    <Distractor2>14WOIS1Q</Distractor2>\n    <Distractor3>14WOIS1Q</Distractor3>\n    <Distractor4>48</Distractor4>\n    <TrueAnswer>48</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>50</QuestionNumber>\n    <QuestionBase>correct answer is : 49</QuestionBase>\n    <Distractor1>14WOIS1Q</Distractor1>\n    <Distractor2>14WOIS1Q</Distractor2>\n    <Distractor3>14WOIS1Q</Distractor3>\n    <Distractor4>49</Distractor4>\n    <TrueAnswer>49</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>51</QuestionNumber>\n    <QuestionBase>correct answer is : 50</QuestionBase>\n    <Distractor1>14WOIS1Q</Distractor1>\n    <Distractor2>14WOIS1Q</Distractor2>\n    <Distractor3>14WOIS1Q</Distractor3>\n    <Distractor4>50</Distractor4>\n    <TrueAnswer>50</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>52</QuestionNumber>\n    <QuestionBase>correct answer is : 51</QuestionBase>\n    <Distractor1>14WOIS1Q</Distractor1>\n    <Distractor2>14WOIS1Q</Distractor2>\n    <Distractor3>14WOIS1Q</Distractor3>\n    <Distractor4>51</Distractor4>\n    <TrueAnswer>51</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>53</QuestionNumber>\n    <QuestionBase>correct answer is : 52</QuestionBase>\n    <Distractor1>14WOIS1Q</Distractor1>\n    <Distractor2>14WOIS1Q</Distractor2>\n    <Distractor3>14WOIS1Q</Distractor3>\n    <Distractor4>52</Distractor4>\n    <TrueAnswer>52</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>54</QuestionNumber>\n    <QuestionBase>correct answer is : 53</QuestionBase>\n    <Distractor1>14WOIS1Q</Distractor1>\n    <Distractor2>14WOIS1Q</Distractor2>\n    <Distractor3>14WOIS1Q</Distractor3>\n    <Distractor4>53</Distractor4>\n    <TrueAnswer>53</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>55</QuestionNumber>\n    <QuestionBase>correct answer is : 54</QuestionBase>\n    <Distractor1>14WOIS1Q</Distractor1>\n    <Distractor2>14WOIS1Q</Distractor2>\n    <Distractor3>14WOIS1Q</Distractor3>\n    <Distractor4>54</Distractor4>\n    <TrueAnswer>54</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>56</QuestionNumber>\n    <QuestionBase>correct answer is : 55</QuestionBase>\n    <Distractor1>14WOIS1Q</Distractor1>\n    <Distractor2>14WOIS1Q</Distractor2>\n    <Distractor3>14WOIS1Q</Distractor3>\n    <Distractor4>55</Distractor4>\n    <TrueAnswer>55</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>57</QuestionNumber>\n    <QuestionBase>correct answer is : 56</QuestionBase>\n    <Distractor1>FT33QS7R</Distractor1>\n    <Distractor2>FT33QS7R</Distractor2>\n    <Distractor3>FT33QS7R</Distractor3>\n    <Distractor4>56</Distractor4>\n    <TrueAnswer>56</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>58</QuestionNumber>\n    <QuestionBase>correct answer is : 57</QuestionBase>\n    <Distractor1>FT33QS7R</Distractor1>\n    <Distractor2>FT33QS7R</Distractor2>\n    <Distractor3>FT33QS7R</Distractor3>\n    <Distractor4>57</Distractor4>\n    <TrueAnswer>57</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>59</QuestionNumber>\n    <QuestionBase>correct answer is : 58</QuestionBase>\n    <Distractor1>FT33QS7R</Distractor1>\n    <Distractor2>FT33QS7R</Distractor2>\n    <Distractor3>FT33QS7R</Distractor3>\n    <Distractor4>58</Distractor4>\n    <TrueAnswer>58</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>60</QuestionNumber>\n    <QuestionBase>correct answer is : 59</QuestionBase>\n    <Distractor1>FT33QS7R</Distractor1>\n    <Distractor2>FT33QS7R</Distractor2>\n    <Distractor3>FT33QS7R</Distractor3>\n    <Distractor4>59</Distractor4>\n    <TrueAnswer>59</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>61</QuestionNumber>\n    <QuestionBase>correct answer is : 60</QuestionBase>\n    <Distractor1>FT33QS7R</Distractor1>\n    <Distractor2>FT33QS7R</Distractor2>\n    <Distractor3>FT33QS7R</Distractor3>\n    <Distractor4>60</Distractor4>\n    <TrueAnswer>60</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>62</QuestionNumber>\n    <QuestionBase>correct answer is : 61</QuestionBase>\n    <Distractor1>FT33QS7R</Distractor1>\n    <Distractor2>FT33QS7R</Distractor2>\n    <Distractor3>FT33QS7R</Distractor3>\n    <Distractor4>61</Distractor4>\n    <TrueAnswer>61</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>63</QuestionNumber>\n    <QuestionBase>correct answer is : 62</QuestionBase>\n    <Distractor1>FT33QS7R</Distractor1>\n    <Distractor2>FT33QS7R</Distractor2>\n    <Distractor3>FT33QS7R</Distractor3>\n    <Distractor4>62</Distractor4>\n    <TrueAnswer>62</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>64</QuestionNumber>\n    <QuestionBase>correct answer is : 63</QuestionBase>\n    <Distractor1>FT33QS7R</Distractor1>\n    <Distractor2>FT33QS7R</Distractor2>\n    <Distractor3>FT33QS7R</Distractor3>\n    <Distractor4>63</Distractor4>\n    <TrueAnswer>63</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>65</QuestionNumber>\n    <QuestionBase>correct answer is : 64</QuestionBase>\n    <Distractor1>FT33QS7R</Distractor1>\n    <Distractor2>FT33QS7R</Distractor2>\n    <Distractor3>FT33QS7R</Distractor3>\n    <Distractor4>64</Distractor4>\n    <TrueAnswer>64</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>66</QuestionNumber>\n    <QuestionBase>correct answer is : 65</QuestionBase>\n    <Distractor1>FT33QS7R</Distractor1>\n    <Distractor2>FT33QS7R</Distractor2>\n    <Distractor3>FT33QS7R</Distractor3>\n    <Distractor4>65</Distractor4>\n    <TrueAnswer>65</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>67</QuestionNumber>\n    <QuestionBase>correct answer is : 66</QuestionBase>\n    <Distractor1>FT33QS7R</Distractor1>\n    <Distractor2>FT33QS7R</Distractor2>\n    <Distractor3>FT33QS7R</Distractor3>\n    <Distractor4>66</Distractor4>\n    <TrueAnswer>66</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>68</QuestionNumber>\n    <QuestionBase>correct answer is : 67</QuestionBase>\n    <Distractor1>FT33QS7R</Distractor1>\n    <Distractor2>FT33QS7R</Distractor2>\n    <Distractor3>FT33QS7R</Distractor3>\n    <Distractor4>67</Distractor4>\n    <TrueAnswer>67</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>69</QuestionNumber>\n    <QuestionBase>correct answer is : 68</QuestionBase>\n    <Distractor1>FT33QS7R</Distractor1>\n    <Distractor2>FT33QS7R</Distractor2>\n    <Distractor3>FT33QS7R</Distractor3>\n    <Distractor4>68</Distractor4>\n    <TrueAnswer>68</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>70</QuestionNumber>\n    <QuestionBase>correct answer is : 69</QuestionBase>\n    <Distractor1>FT33QS7R</Distractor1>\n    <Distractor2>FT33QS7R</Distractor2>\n    <Distractor3>FT33QS7R</Distractor3>\n    <Distractor4>69</Distractor4>\n    <TrueAnswer>69</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>71</QuestionNumber>\n    <QuestionBase>correct answer is : 70</QuestionBase>\n    <Distractor1>FT33QS7R</Distractor1>\n    <Distractor2>FT33QS7R</Distractor2>\n    <Distractor3>FT33QS7R</Distractor3>\n    <Distractor4>70</Distractor4>\n    <TrueAnswer>70</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>72</QuestionNumber>\n    <QuestionBase>correct answer is : 71</QuestionBase>\n    <Distractor1>FT33QS7R</Distractor1>\n    <Distractor2>FT33QS7R</Distractor2>\n    <Distractor3>FT33QS7R</Distractor3>\n    <Distractor4>71</Distractor4>\n    <TrueAnswer>71</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>73</QuestionNumber>\n    <QuestionBase>correct answer is : 72</QuestionBase>\n    <Distractor1>RIAIXRDS</Distractor1>\n    <Distractor2>RIAIXRDS</Distractor2>\n    <Distractor3>RIAIXRDS</Distractor3>\n    <Distractor4>72</Distractor4>\n    <TrueAnswer>72</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>74</QuestionNumber>\n    <QuestionBase>correct answer is : 73</QuestionBase>\n    <Distractor1>RIAIXRDS</Distractor1>\n    <Distractor2>RIAIXRDS</Distractor2>\n    <Distractor3>RIAIXRDS</Distractor3>\n    <Distractor4>73</Distractor4>\n    <TrueAnswer>73</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>75</QuestionNumber>\n    <QuestionBase>correct answer is : 74</QuestionBase>\n    <Distractor1>RIAIXRDS</Distractor1>\n    <Distractor2>RIAIXRDS</Distractor2>\n    <Distractor3>RIAIXRDS</Distractor3>\n    <Distractor4>74</Distractor4>\n    <TrueAnswer>74</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>76</QuestionNumber>\n    <QuestionBase>correct answer is : 75</QuestionBase>\n    <Distractor1>RIAIXRDS</Distractor1>\n    <Distractor2>RIAIXRDS</Distractor2>\n    <Distractor3>RIAIXRDS</Distractor3>\n    <Distractor4>75</Distractor4>\n    <TrueAnswer>75</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>77</QuestionNumber>\n    <QuestionBase>correct answer is : 76</QuestionBase>\n    <Distractor1>RIAIXRDS</Distractor1>\n    <Distractor2>RIAIXRDS</Distractor2>\n    <Distractor3>RIAIXRDS</Distractor3>\n    <Distractor4>76</Distractor4>\n    <TrueAnswer>76</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>78</QuestionNumber>\n    <QuestionBase>correct answer is : 77</QuestionBase>\n    <Distractor1>RIAIXRDS</Distractor1>\n    <Distractor2>RIAIXRDS</Distractor2>\n    <Distractor3>RIAIXRDS</Distractor3>\n    <Distractor4>77</Distractor4>\n    <TrueAnswer>77</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>79</QuestionNumber>\n    <QuestionBase>correct answer is : 78</QuestionBase>\n    <Distractor1>RIAIXRDS</Distractor1>\n    <Distractor2>RIAIXRDS</Distractor2>\n    <Distractor3>RIAIXRDS</Distractor3>\n    <Distractor4>78</Distractor4>\n    <TrueAnswer>78</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>80</QuestionNumber>\n    <QuestionBase>correct answer is : 79</QuestionBase>\n    <Distractor1>RIAIXRDS</Distractor1>\n    <Distractor2>RIAIXRDS</Distractor2>\n    <Distractor3>RIAIXRDS</Distractor3>\n    <Distractor4>79</Distractor4>\n    <TrueAnswer>79</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>81</QuestionNumber>\n    <QuestionBase>correct answer is : 80</QuestionBase>\n    <Distractor1>RIAIXRDS</Distractor1>\n    <Distractor2>RIAIXRDS</Distractor2>\n    <Distractor3>RIAIXRDS</Distractor3>\n    <Distractor4>80</Distractor4>\n    <TrueAnswer>80</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>82</QuestionNumber>\n    <QuestionBase>correct answer is : 81</QuestionBase>\n    <Distractor1>LXRPPV3B</Distractor1>\n    <Distractor2>LXRPPV3B</Distractor2>\n    <Distractor3>LXRPPV3B</Distractor3>\n    <Distractor4>81</Distractor4>\n    <TrueAnswer>81</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>83</QuestionNumber>\n    <QuestionBase>correct answer is : 82</QuestionBase>\n    <Distractor1>LXRPPV3B</Distractor1>\n    <Distractor2>LXRPPV3B</Distractor2>\n    <Distractor3>LXRPPV3B</Distractor3>\n    <Distractor4>82</Distractor4>\n    <TrueAnswer>82</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>84</QuestionNumber>\n    <QuestionBase>correct answer is : 83</QuestionBase>\n    <Distractor1>LXRPPV3B</Distractor1>\n    <Distractor2>LXRPPV3B</Distractor2>\n    <Distractor3>LXRPPV3B</Distractor3>\n    <Distractor4>83</Distractor4>\n    <TrueAnswer>83</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>85</QuestionNumber>\n    <QuestionBase>correct answer is : 84</QuestionBase>\n    <Distractor1>LXRPPV3B</Distractor1>\n    <Distractor2>LXRPPV3B</Distractor2>\n    <Distractor3>LXRPPV3B</Distractor3>\n    <Distractor4>84</Distractor4>\n    <TrueAnswer>84</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>86</QuestionNumber>\n    <QuestionBase>correct answer is : 85</QuestionBase>\n    <Distractor1>LXRPPV3B</Distractor1>\n    <Distractor2>LXRPPV3B</Distractor2>\n    <Distractor3>LXRPPV3B</Distractor3>\n    <Distractor4>85</Distractor4>\n    <TrueAnswer>85</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>87</QuestionNumber>\n    <QuestionBase>correct answer is : 86</QuestionBase>\n    <Distractor1>LXRPPV3B</Distractor1>\n    <Distractor2>LXRPPV3B</Distractor2>\n    <Distractor3>LXRPPV3B</Distractor3>\n    <Distractor4>86</Distractor4>\n    <TrueAnswer>86</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>88</QuestionNumber>\n    <QuestionBase>correct answer is : 87</QuestionBase>\n    <Distractor1>LXRPPV3B</Distractor1>\n    <Distractor2>LXRPPV3B</Distractor2>\n    <Distractor3>LXRPPV3B</Distractor3>\n    <Distractor4>87</Distractor4>\n    <TrueAnswer>87</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>89</QuestionNumber>\n    <QuestionBase>correct answer is : 88</QuestionBase>\n    <Distractor1>LXRPPV3B</Distractor1>\n    <Distractor2>LXRPPV3B</Distractor2>\n    <Distractor3>LXRPPV3B</Distractor3>\n    <Distractor4>88</Distractor4>\n    <TrueAnswer>88</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>90</QuestionNumber>\n    <QuestionBase>correct answer is : 89</QuestionBase>\n    <Distractor1>LXRPPV3B</Distractor1>\n    <Distractor2>LXRPPV3B</Distractor2>\n    <Distractor3>LXRPPV3B</Distractor3>\n    <Distractor4>89</Distractor4>\n    <TrueAnswer>89</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>91</QuestionNumber>\n    <QuestionBase>correct answer is : 90</QuestionBase>\n    <Distractor1>LXRPPV3B</Distractor1>\n    <Distractor2>LXRPPV3B</Distractor2>\n    <Distractor3>LXRPPV3B</Distractor3>\n    <Distractor4>90</Distractor4>\n    <TrueAnswer>90</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>92</QuestionNumber>\n    <QuestionBase>correct answer is : 91</QuestionBase>\n    <Distractor1>LXRPPV3B</Distractor1>\n    <Distractor2>LXRPPV3B</Distractor2>\n    <Distractor3>LXRPPV3B</Distractor3>\n    <Distractor4>91</Distractor4>\n    <TrueAnswer>91</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>93</QuestionNumber>\n    <QuestionBase>correct answer is : 92</QuestionBase>\n    <Distractor1>LXRPPV3B</Distractor1>\n    <Distractor2>LXRPPV3B</Distractor2>\n    <Distractor3>LXRPPV3B</Distractor3>\n    <Distractor4>92</Distractor4>\n    <TrueAnswer>92</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>94</QuestionNumber>\n    <QuestionBase>correct answer is : 93</QuestionBase>\n    <Distractor1>LXRPPV3B</Distractor1>\n    <Distractor2>LXRPPV3B</Distractor2>\n    <Distractor3>LXRPPV3B</Distractor3>\n    <Distractor4>93</Distractor4>\n    <TrueAnswer>93</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>95</QuestionNumber>\n    <QuestionBase>correct answer is : 94</QuestionBase>\n    <Distractor1>LXRPPV3B</Distractor1>\n    <Distractor2>LXRPPV3B</Distractor2>\n    <Distractor3>LXRPPV3B</Distractor3>\n    <Distractor4>94</Distractor4>\n    <TrueAnswer>94</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>96</QuestionNumber>\n    <QuestionBase>correct answer is : 95</QuestionBase>\n    <Distractor1>LXRPPV3B</Distractor1>\n    <Distractor2>LXRPPV3B</Distractor2>\n    <Distractor3>LXRPPV3B</Distractor3>\n    <Distractor4>95</Distractor4>\n    <TrueAnswer>95</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>97</QuestionNumber>\n    <QuestionBase>correct answer is : 96</QuestionBase>\n    <Distractor1>LXRPPV3B</Distractor1>\n    <Distractor2>LXRPPV3B</Distractor2>\n    <Distractor3>LXRPPV3B</Distractor3>\n    <Distractor4>96</Distractor4>\n    <TrueAnswer>96</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>98</QuestionNumber>\n    <QuestionBase>correct answer is : 97</QuestionBase>\n    <Distractor1>YMX4XUAC</Distractor1>\n    <Distractor2>YMX4XUAC</Distractor2>\n    <Distractor3>YMX4XUAC</Distractor3>\n    <Distractor4>97</Distractor4>\n    <TrueAnswer>97</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>99</QuestionNumber>\n    <QuestionBase>correct answer is : 98</QuestionBase>\n    <Distractor1>YMX4XUAC</Distractor1>\n    <Distractor2>YMX4XUAC</Distractor2>\n    <Distractor3>YMX4XUAC</Distractor3>\n    <Distractor4>98</Distractor4>\n    <TrueAnswer>98</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>100</QuestionNumber>\n    <QuestionBase>correct answer is : 99</QuestionBase>\n    <Distractor1>YMX4XUAC</Distractor1>\n    <Distractor2>YMX4XUAC</Distractor2>\n    <Distractor3>YMX4XUAC</Distractor3>\n    <Distractor4>99</Distractor4>\n    <TrueAnswer>99</TrueAnswer>\n  </c_SmallQuestion>\n</ArrayOfC_SmallQuestion>', 100, 0);
INSERT INTO `tbl_quizes` (`id`, `quest_name`, `xml_base`, `state_long`, `drp`) VALUES
(5, 'QuestER', '<?xml version=\"1.0\" encoding=\"utf-16\"?>\n<ArrayOfC_SmallQuestion xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\">\n  <c_SmallQuestion>\n    <QuestionNumber>1</QuestionNumber>\n    <QuestionBase>correct answer is : 0</QuestionBase>\n    <Distractor1>02OJ2CYF</Distractor1>\n    <Distractor2>02OJ2CYF</Distractor2>\n    <Distractor3>02OJ2CYF</Distractor3>\n    <Distractor4>0</Distractor4>\n    <TrueAnswer>0</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>2</QuestionNumber>\n    <QuestionBase>correct answer is : 1</QuestionBase>\n    <Distractor1>02OJ2CYF</Distractor1>\n    <Distractor2>02OJ2CYF</Distractor2>\n    <Distractor3>02OJ2CYF</Distractor3>\n    <Distractor4>1</Distractor4>\n    <TrueAnswer>1</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>3</QuestionNumber>\n    <QuestionBase>correct answer is : 2</QuestionBase>\n    <Distractor1>02OJ2CYF</Distractor1>\n    <Distractor2>02OJ2CYF</Distractor2>\n    <Distractor3>02OJ2CYF</Distractor3>\n    <Distractor4>2</Distractor4>\n    <TrueAnswer>2</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>4</QuestionNumber>\n    <QuestionBase>correct answer is : 3</QuestionBase>\n    <Distractor1>DRVYBB4G</Distractor1>\n    <Distractor2>DRVYBB4G</Distractor2>\n    <Distractor3>DRVYBB4G</Distractor3>\n    <Distractor4>3</Distractor4>\n    <TrueAnswer>3</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>5</QuestionNumber>\n    <QuestionBase>correct answer is : 4</QuestionBase>\n    <Distractor1>DRVYBB4G</Distractor1>\n    <Distractor2>DRVYBB4G</Distractor2>\n    <Distractor3>DRVYBB4G</Distractor3>\n    <Distractor4>4</Distractor4>\n    <TrueAnswer>4</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>6</QuestionNumber>\n    <QuestionBase>correct answer is : 5</QuestionBase>\n    <Distractor1>DRVYBB4G</Distractor1>\n    <Distractor2>DRVYBB4G</Distractor2>\n    <Distractor3>DRVYBB4G</Distractor3>\n    <Distractor4>5</Distractor4>\n    <TrueAnswer>5</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>7</QuestionNumber>\n    <QuestionBase>correct answer is : 6</QuestionBase>\n    <Distractor1>DRVYBB4G</Distractor1>\n    <Distractor2>DRVYBB4G</Distractor2>\n    <Distractor3>DRVYBB4G</Distractor3>\n    <Distractor4>6</Distractor4>\n    <TrueAnswer>6</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>8</QuestionNumber>\n    <QuestionBase>correct answer is : 7</QuestionBase>\n    <Distractor1>DRVYBB4G</Distractor1>\n    <Distractor2>DRVYBB4G</Distractor2>\n    <Distractor3>DRVYBB4G</Distractor3>\n    <Distractor4>7</Distractor4>\n    <TrueAnswer>7</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>9</QuestionNumber>\n    <QuestionBase>correct answer is : 8</QuestionBase>\n    <Distractor1>DRVYBB4G</Distractor1>\n    <Distractor2>DRVYBB4G</Distractor2>\n    <Distractor3>DRVYBB4G</Distractor3>\n    <Distractor4>8</Distractor4>\n    <TrueAnswer>8</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>10</QuestionNumber>\n    <QuestionBase>correct answer is : 9</QuestionBase>\n    <Distractor1>DRVYBB4G</Distractor1>\n    <Distractor2>DRVYBB4G</Distractor2>\n    <Distractor3>DRVYBB4G</Distractor3>\n    <Distractor4>9</Distractor4>\n    <TrueAnswer>9</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>11</QuestionNumber>\n    <QuestionBase>correct answer is : 10</QuestionBase>\n    <Distractor1>DRVYBB4G</Distractor1>\n    <Distractor2>DRVYBB4G</Distractor2>\n    <Distractor3>DRVYBB4G</Distractor3>\n    <Distractor4>10</Distractor4>\n    <TrueAnswer>10</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>12</QuestionNumber>\n    <QuestionBase>correct answer is : 11</QuestionBase>\n    <Distractor1>DRVYBB4G</Distractor1>\n    <Distractor2>DRVYBB4G</Distractor2>\n    <Distractor3>DRVYBB4G</Distractor3>\n    <Distractor4>11</Distractor4>\n    <TrueAnswer>11</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>13</QuestionNumber>\n    <QuestionBase>correct answer is : 12</QuestionBase>\n    <Distractor1>DRVYBB4G</Distractor1>\n    <Distractor2>DRVYBB4G</Distractor2>\n    <Distractor3>DRVYBB4G</Distractor3>\n    <Distractor4>12</Distractor4>\n    <TrueAnswer>12</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>14</QuestionNumber>\n    <QuestionBase>correct answer is : 13</QuestionBase>\n    <Distractor1>DRVYBB4G</Distractor1>\n    <Distractor2>DRVYBB4G</Distractor2>\n    <Distractor3>DRVYBB4G</Distractor3>\n    <Distractor4>13</Distractor4>\n    <TrueAnswer>13</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>15</QuestionNumber>\n    <QuestionBase>correct answer is : 14</QuestionBase>\n    <Distractor1>DRVYBB4G</Distractor1>\n    <Distractor2>DRVYBB4G</Distractor2>\n    <Distractor3>DRVYBB4G</Distractor3>\n    <Distractor4>14</Distractor4>\n    <TrueAnswer>14</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>16</QuestionNumber>\n    <QuestionBase>correct answer is : 15</QuestionBase>\n    <Distractor1>DRVYBB4G</Distractor1>\n    <Distractor2>DRVYBB4G</Distractor2>\n    <Distractor3>DRVYBB4G</Distractor3>\n    <Distractor4>15</Distractor4>\n    <TrueAnswer>15</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>17</QuestionNumber>\n    <QuestionBase>correct answer is : 16</QuestionBase>\n    <Distractor1>DRVYBB4G</Distractor1>\n    <Distractor2>DRVYBB4G</Distractor2>\n    <Distractor3>DRVYBB4G</Distractor3>\n    <Distractor4>16</Distractor4>\n    <TrueAnswer>16</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>18</QuestionNumber>\n    <QuestionBase>correct answer is : 17</QuestionBase>\n    <Distractor1>DRVYBB4G</Distractor1>\n    <Distractor2>DRVYBB4G</Distractor2>\n    <Distractor3>DRVYBB4G</Distractor3>\n    <Distractor4>17</Distractor4>\n    <TrueAnswer>17</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>19</QuestionNumber>\n    <QuestionBase>correct answer is : 18</QuestionBase>\n    <Distractor1>DRVYBB4G</Distractor1>\n    <Distractor2>DRVYBB4G</Distractor2>\n    <Distractor3>DRVYBB4G</Distractor3>\n    <Distractor4>18</Distractor4>\n    <TrueAnswer>18</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>20</QuestionNumber>\n    <QuestionBase>correct answer is : 19</QuestionBase>\n    <Distractor1>DRVYBB4G</Distractor1>\n    <Distractor2>DRVYBB4G</Distractor2>\n    <Distractor3>DRVYBB4G</Distractor3>\n    <Distractor4>19</Distractor4>\n    <TrueAnswer>19</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>21</QuestionNumber>\n    <QuestionBase>correct answer is : 20</QuestionBase>\n    <Distractor1>DRVYBB4G</Distractor1>\n    <Distractor2>DRVYBB4G</Distractor2>\n    <Distractor3>DRVYBB4G</Distractor3>\n    <Distractor4>20</Distractor4>\n    <TrueAnswer>20</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>22</QuestionNumber>\n    <QuestionBase>correct answer is : 21</QuestionBase>\n    <Distractor1>QG1DIBBH</Distractor1>\n    <Distractor2>QG1DIBBH</Distractor2>\n    <Distractor3>QG1DIBBH</Distractor3>\n    <Distractor4>21</Distractor4>\n    <TrueAnswer>21</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>23</QuestionNumber>\n    <QuestionBase>correct answer is : 22</QuestionBase>\n    <Distractor1>QG1DIBBH</Distractor1>\n    <Distractor2>QG1DIBBH</Distractor2>\n    <Distractor3>QG1DIBBH</Distractor3>\n    <Distractor4>22</Distractor4>\n    <TrueAnswer>22</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>24</QuestionNumber>\n    <QuestionBase>correct answer is : 23</QuestionBase>\n    <Distractor1>QG1DIBBH</Distractor1>\n    <Distractor2>QG1DIBBH</Distractor2>\n    <Distractor3>QG1DIBBH</Distractor3>\n    <Distractor4>23</Distractor4>\n    <TrueAnswer>23</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>25</QuestionNumber>\n    <QuestionBase>correct answer is : 24</QuestionBase>\n    <Distractor1>QG1DIBBH</Distractor1>\n    <Distractor2>QG1DIBBH</Distractor2>\n    <Distractor3>QG1DIBBH</Distractor3>\n    <Distractor4>24</Distractor4>\n    <TrueAnswer>24</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>26</QuestionNumber>\n    <QuestionBase>correct answer is : 25</QuestionBase>\n    <Distractor1>QG1DIBBH</Distractor1>\n    <Distractor2>QG1DIBBH</Distractor2>\n    <Distractor3>QG1DIBBH</Distractor3>\n    <Distractor4>25</Distractor4>\n    <TrueAnswer>25</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>27</QuestionNumber>\n    <QuestionBase>correct answer is : 26</QuestionBase>\n    <Distractor1>QG1DIBBH</Distractor1>\n    <Distractor2>QG1DIBBH</Distractor2>\n    <Distractor3>QG1DIBBH</Distractor3>\n    <Distractor4>26</Distractor4>\n    <TrueAnswer>26</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>28</QuestionNumber>\n    <QuestionBase>correct answer is : 27</QuestionBase>\n    <Distractor1>QG1DIBBH</Distractor1>\n    <Distractor2>QG1DIBBH</Distractor2>\n    <Distractor3>QG1DIBBH</Distractor3>\n    <Distractor4>27</Distractor4>\n    <TrueAnswer>27</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>29</QuestionNumber>\n    <QuestionBase>correct answer is : 28</QuestionBase>\n    <Distractor1>QG1DIBBH</Distractor1>\n    <Distractor2>QG1DIBBH</Distractor2>\n    <Distractor3>QG1DIBBH</Distractor3>\n    <Distractor4>28</Distractor4>\n    <TrueAnswer>28</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>30</QuestionNumber>\n    <QuestionBase>correct answer is : 29</QuestionBase>\n    <Distractor1>QG1DIBBH</Distractor1>\n    <Distractor2>QG1DIBBH</Distractor2>\n    <Distractor3>QG1DIBBH</Distractor3>\n    <Distractor4>29</Distractor4>\n    <TrueAnswer>29</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>31</QuestionNumber>\n    <QuestionBase>correct answer is : 30</QuestionBase>\n    <Distractor1>QG1DIBBH</Distractor1>\n    <Distractor2>QG1DIBBH</Distractor2>\n    <Distractor3>QG1DIBBH</Distractor3>\n    <Distractor4>30</Distractor4>\n    <TrueAnswer>30</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>32</QuestionNumber>\n    <QuestionBase>correct answer is : 31</QuestionBase>\n    <Distractor1>QG1DIBBH</Distractor1>\n    <Distractor2>QG1DIBBH</Distractor2>\n    <Distractor3>QG1DIBBH</Distractor3>\n    <Distractor4>31</Distractor4>\n    <TrueAnswer>31</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>33</QuestionNumber>\n    <QuestionBase>correct answer is : 32</QuestionBase>\n    <Distractor1>QG1DIBBH</Distractor1>\n    <Distractor2>QG1DIBBH</Distractor2>\n    <Distractor3>QG1DIBBH</Distractor3>\n    <Distractor4>32</Distractor4>\n    <TrueAnswer>32</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>34</QuestionNumber>\n    <QuestionBase>correct answer is : 33</QuestionBase>\n    <Distractor1>QG1DIBBH</Distractor1>\n    <Distractor2>QG1DIBBH</Distractor2>\n    <Distractor3>QG1DIBBH</Distractor3>\n    <Distractor4>33</Distractor4>\n    <TrueAnswer>33</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>35</QuestionNumber>\n    <QuestionBase>correct answer is : 34</QuestionBase>\n    <Distractor1>QG1DIBBH</Distractor1>\n    <Distractor2>QG1DIBBH</Distractor2>\n    <Distractor3>QG1DIBBH</Distractor3>\n    <Distractor4>34</Distractor4>\n    <TrueAnswer>34</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>36</QuestionNumber>\n    <QuestionBase>correct answer is : 35</QuestionBase>\n    <Distractor1>QG1DIBBH</Distractor1>\n    <Distractor2>QG1DIBBH</Distractor2>\n    <Distractor3>QG1DIBBH</Distractor3>\n    <Distractor4>35</Distractor4>\n    <TrueAnswer>35</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>37</QuestionNumber>\n    <QuestionBase>correct answer is : 36</QuestionBase>\n    <Distractor1>QG1DIBBH</Distractor1>\n    <Distractor2>QG1DIBBH</Distractor2>\n    <Distractor3>QG1DIBBH</Distractor3>\n    <Distractor4>36</Distractor4>\n    <TrueAnswer>36</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>38</QuestionNumber>\n    <QuestionBase>correct answer is : 37</QuestionBase>\n    <Distractor1>QG1DIBBH</Distractor1>\n    <Distractor2>QG1DIBBH</Distractor2>\n    <Distractor3>QG1DIBBH</Distractor3>\n    <Distractor4>37</Distractor4>\n    <TrueAnswer>37</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>39</QuestionNumber>\n    <QuestionBase>correct answer is : 38</QuestionBase>\n    <Distractor1>KUJKAF10</Distractor1>\n    <Distractor2>KUJKAF10</Distractor2>\n    <Distractor3>KUJKAF10</Distractor3>\n    <Distractor4>38</Distractor4>\n    <TrueAnswer>38</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>40</QuestionNumber>\n    <QuestionBase>correct answer is : 39</QuestionBase>\n    <Distractor1>KUJKAF10</Distractor1>\n    <Distractor2>KUJKAF10</Distractor2>\n    <Distractor3>KUJKAF10</Distractor3>\n    <Distractor4>39</Distractor4>\n    <TrueAnswer>39</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>41</QuestionNumber>\n    <QuestionBase>correct answer is : 40</QuestionBase>\n    <Distractor1>KUJKAF10</Distractor1>\n    <Distractor2>KUJKAF10</Distractor2>\n    <Distractor3>KUJKAF10</Distractor3>\n    <Distractor4>40</Distractor4>\n    <TrueAnswer>40</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>42</QuestionNumber>\n    <QuestionBase>correct answer is : 41</QuestionBase>\n    <Distractor1>KUJKAF10</Distractor1>\n    <Distractor2>KUJKAF10</Distractor2>\n    <Distractor3>KUJKAF10</Distractor3>\n    <Distractor4>41</Distractor4>\n    <TrueAnswer>41</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>43</QuestionNumber>\n    <QuestionBase>correct answer is : 42</QuestionBase>\n    <Distractor1>KUJKAF10</Distractor1>\n    <Distractor2>KUJKAF10</Distractor2>\n    <Distractor3>KUJKAF10</Distractor3>\n    <Distractor4>42</Distractor4>\n    <TrueAnswer>42</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>44</QuestionNumber>\n    <QuestionBase>correct answer is : 43</QuestionBase>\n    <Distractor1>KUJKAF10</Distractor1>\n    <Distractor2>KUJKAF10</Distractor2>\n    <Distractor3>KUJKAF10</Distractor3>\n    <Distractor4>43</Distractor4>\n    <TrueAnswer>43</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>45</QuestionNumber>\n    <QuestionBase>correct answer is : 44</QuestionBase>\n    <Distractor1>KUJKAF10</Distractor1>\n    <Distractor2>KUJKAF10</Distractor2>\n    <Distractor3>KUJKAF10</Distractor3>\n    <Distractor4>44</Distractor4>\n    <TrueAnswer>44</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>46</QuestionNumber>\n    <QuestionBase>correct answer is : 45</QuestionBase>\n    <Distractor1>KUJKAF10</Distractor1>\n    <Distractor2>KUJKAF10</Distractor2>\n    <Distractor3>KUJKAF10</Distractor3>\n    <Distractor4>45</Distractor4>\n    <TrueAnswer>45</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>47</QuestionNumber>\n    <QuestionBase>correct answer is : 46</QuestionBase>\n    <Distractor1>KUJKAF10</Distractor1>\n    <Distractor2>KUJKAF10</Distractor2>\n    <Distractor3>KUJKAF10</Distractor3>\n    <Distractor4>46</Distractor4>\n    <TrueAnswer>46</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>48</QuestionNumber>\n    <QuestionBase>correct answer is : 47</QuestionBase>\n    <Distractor1>KUJKAF10</Distractor1>\n    <Distractor2>KUJKAF10</Distractor2>\n    <Distractor3>KUJKAF10</Distractor3>\n    <Distractor4>47</Distractor4>\n    <TrueAnswer>47</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>49</QuestionNumber>\n    <QuestionBase>correct answer is : 48</QuestionBase>\n    <Distractor1>KUJKAF10</Distractor1>\n    <Distractor2>KUJKAF10</Distractor2>\n    <Distractor3>KUJKAF10</Distractor3>\n    <Distractor4>48</Distractor4>\n    <TrueAnswer>48</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>50</QuestionNumber>\n    <QuestionBase>correct answer is : 49</QuestionBase>\n    <Distractor1>KUJKAF10</Distractor1>\n    <Distractor2>KUJKAF10</Distractor2>\n    <Distractor3>KUJKAF10</Distractor3>\n    <Distractor4>49</Distractor4>\n    <TrueAnswer>49</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>51</QuestionNumber>\n    <QuestionBase>correct answer is : 50</QuestionBase>\n    <Distractor1>KUJKAF10</Distractor1>\n    <Distractor2>KUJKAF10</Distractor2>\n    <Distractor3>KUJKAF10</Distractor3>\n    <Distractor4>50</Distractor4>\n    <TrueAnswer>50</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>52</QuestionNumber>\n    <QuestionBase>correct answer is : 51</QuestionBase>\n    <Distractor1>KUJKAF10</Distractor1>\n    <Distractor2>KUJKAF10</Distractor2>\n    <Distractor3>KUJKAF10</Distractor3>\n    <Distractor4>51</Distractor4>\n    <TrueAnswer>51</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>53</QuestionNumber>\n    <QuestionBase>correct answer is : 52</QuestionBase>\n    <Distractor1>KUJKAF10</Distractor1>\n    <Distractor2>KUJKAF10</Distractor2>\n    <Distractor3>KUJKAF10</Distractor3>\n    <Distractor4>52</Distractor4>\n    <TrueAnswer>52</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>54</QuestionNumber>\n    <QuestionBase>correct answer is : 53</QuestionBase>\n    <Distractor1>KUJKAF10</Distractor1>\n    <Distractor2>KUJKAF10</Distractor2>\n    <Distractor3>KUJKAF10</Distractor3>\n    <Distractor4>53</Distractor4>\n    <TrueAnswer>53</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>55</QuestionNumber>\n    <QuestionBase>correct answer is : 54</QuestionBase>\n    <Distractor1>KUJKAF10</Distractor1>\n    <Distractor2>KUJKAF10</Distractor2>\n    <Distractor3>KUJKAF10</Distractor3>\n    <Distractor4>54</Distractor4>\n    <TrueAnswer>54</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>56</QuestionNumber>\n    <QuestionBase>correct answer is : 55</QuestionBase>\n    <Distractor1>XKQZIE60</Distractor1>\n    <Distractor2>XKQZIE60</Distractor2>\n    <Distractor3>XKQZIE60</Distractor3>\n    <Distractor4>55</Distractor4>\n    <TrueAnswer>55</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>57</QuestionNumber>\n    <QuestionBase>correct answer is : 56</QuestionBase>\n    <Distractor1>XKQZIE60</Distractor1>\n    <Distractor2>XKQZIE60</Distractor2>\n    <Distractor3>XKQZIE60</Distractor3>\n    <Distractor4>56</Distractor4>\n    <TrueAnswer>56</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>58</QuestionNumber>\n    <QuestionBase>correct answer is : 57</QuestionBase>\n    <Distractor1>XKQZIE60</Distractor1>\n    <Distractor2>XKQZIE60</Distractor2>\n    <Distractor3>XKQZIE60</Distractor3>\n    <Distractor4>57</Distractor4>\n    <TrueAnswer>57</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>59</QuestionNumber>\n    <QuestionBase>correct answer is : 58</QuestionBase>\n    <Distractor1>XKQZIE60</Distractor1>\n    <Distractor2>XKQZIE60</Distractor2>\n    <Distractor3>XKQZIE60</Distractor3>\n    <Distractor4>58</Distractor4>\n    <TrueAnswer>58</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>60</QuestionNumber>\n    <QuestionBase>correct answer is : 59</QuestionBase>\n    <Distractor1>XKQZIE60</Distractor1>\n    <Distractor2>XKQZIE60</Distractor2>\n    <Distractor3>XKQZIE60</Distractor3>\n    <Distractor4>59</Distractor4>\n    <TrueAnswer>59</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>61</QuestionNumber>\n    <QuestionBase>correct answer is : 60</QuestionBase>\n    <Distractor1>XKQZIE60</Distractor1>\n    <Distractor2>XKQZIE60</Distractor2>\n    <Distractor3>XKQZIE60</Distractor3>\n    <Distractor4>60</Distractor4>\n    <TrueAnswer>60</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>62</QuestionNumber>\n    <QuestionBase>correct answer is : 61</QuestionBase>\n    <Distractor1>XKQZIE60</Distractor1>\n    <Distractor2>XKQZIE60</Distractor2>\n    <Distractor3>XKQZIE60</Distractor3>\n    <Distractor4>61</Distractor4>\n    <TrueAnswer>61</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>63</QuestionNumber>\n    <QuestionBase>correct answer is : 62</QuestionBase>\n    <Distractor1>XKQZIE60</Distractor1>\n    <Distractor2>XKQZIE60</Distractor2>\n    <Distractor3>XKQZIE60</Distractor3>\n    <Distractor4>62</Distractor4>\n    <TrueAnswer>62</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>64</QuestionNumber>\n    <QuestionBase>correct answer is : 63</QuestionBase>\n    <Distractor1>XKQZIE60</Distractor1>\n    <Distractor2>XKQZIE60</Distractor2>\n    <Distractor3>XKQZIE60</Distractor3>\n    <Distractor4>63</Distractor4>\n    <TrueAnswer>63</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>65</QuestionNumber>\n    <QuestionBase>correct answer is : 64</QuestionBase>\n    <Distractor1>XKQZIE60</Distractor1>\n    <Distractor2>XKQZIE60</Distractor2>\n    <Distractor3>XKQZIE60</Distractor3>\n    <Distractor4>64</Distractor4>\n    <TrueAnswer>64</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>66</QuestionNumber>\n    <QuestionBase>correct answer is : 65</QuestionBase>\n    <Distractor1>XKQZIE60</Distractor1>\n    <Distractor2>XKQZIE60</Distractor2>\n    <Distractor3>XKQZIE60</Distractor3>\n    <Distractor4>65</Distractor4>\n    <TrueAnswer>65</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>67</QuestionNumber>\n    <QuestionBase>correct answer is : 66</QuestionBase>\n    <Distractor1>XKQZIE60</Distractor1>\n    <Distractor2>XKQZIE60</Distractor2>\n    <Distractor3>XKQZIE60</Distractor3>\n    <Distractor4>66</Distractor4>\n    <TrueAnswer>66</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>68</QuestionNumber>\n    <QuestionBase>correct answer is : 67</QuestionBase>\n    <Distractor1>XKQZIE60</Distractor1>\n    <Distractor2>XKQZIE60</Distractor2>\n    <Distractor3>XKQZIE60</Distractor3>\n    <Distractor4>67</Distractor4>\n    <TrueAnswer>67</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>69</QuestionNumber>\n    <QuestionBase>correct answer is : 68</QuestionBase>\n    <Distractor1>XKQZIE60</Distractor1>\n    <Distractor2>XKQZIE60</Distractor2>\n    <Distractor3>XKQZIE60</Distractor3>\n    <Distractor4>68</Distractor4>\n    <TrueAnswer>68</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>70</QuestionNumber>\n    <QuestionBase>correct answer is : 69</QuestionBase>\n    <Distractor1>A8WEQDD1</Distractor1>\n    <Distractor2>A8WEQDD1</Distractor2>\n    <Distractor3>A8WEQDD1</Distractor3>\n    <Distractor4>69</Distractor4>\n    <TrueAnswer>69</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>71</QuestionNumber>\n    <QuestionBase>correct answer is : 70</QuestionBase>\n    <Distractor1>A8WEQDD1</Distractor1>\n    <Distractor2>A8WEQDD1</Distractor2>\n    <Distractor3>A8WEQDD1</Distractor3>\n    <Distractor4>70</Distractor4>\n    <TrueAnswer>70</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>72</QuestionNumber>\n    <QuestionBase>correct answer is : 71</QuestionBase>\n    <Distractor1>A8WEQDD1</Distractor1>\n    <Distractor2>A8WEQDD1</Distractor2>\n    <Distractor3>A8WEQDD1</Distractor3>\n    <Distractor4>71</Distractor4>\n    <TrueAnswer>71</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>73</QuestionNumber>\n    <QuestionBase>correct answer is : 72</QuestionBase>\n    <Distractor1>A8WEQDD1</Distractor1>\n    <Distractor2>A8WEQDD1</Distractor2>\n    <Distractor3>A8WEQDD1</Distractor3>\n    <Distractor4>72</Distractor4>\n    <TrueAnswer>72</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>74</QuestionNumber>\n    <QuestionBase>correct answer is : 73</QuestionBase>\n    <Distractor1>A8WEQDD1</Distractor1>\n    <Distractor2>A8WEQDD1</Distractor2>\n    <Distractor3>A8WEQDD1</Distractor3>\n    <Distractor4>73</Distractor4>\n    <TrueAnswer>73</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>75</QuestionNumber>\n    <QuestionBase>correct answer is : 74</QuestionBase>\n    <Distractor1>A8WEQDD1</Distractor1>\n    <Distractor2>A8WEQDD1</Distractor2>\n    <Distractor3>A8WEQDD1</Distractor3>\n    <Distractor4>74</Distractor4>\n    <TrueAnswer>74</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>76</QuestionNumber>\n    <QuestionBase>correct answer is : 75</QuestionBase>\n    <Distractor1>A8WEQDD1</Distractor1>\n    <Distractor2>A8WEQDD1</Distractor2>\n    <Distractor3>A8WEQDD1</Distractor3>\n    <Distractor4>75</Distractor4>\n    <TrueAnswer>75</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>77</QuestionNumber>\n    <QuestionBase>correct answer is : 76</QuestionBase>\n    <Distractor1>A8WEQDD1</Distractor1>\n    <Distractor2>A8WEQDD1</Distractor2>\n    <Distractor3>A8WEQDD1</Distractor3>\n    <Distractor4>76</Distractor4>\n    <TrueAnswer>76</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>78</QuestionNumber>\n    <QuestionBase>correct answer is : 77</QuestionBase>\n    <Distractor1>A8WEQDD1</Distractor1>\n    <Distractor2>A8WEQDD1</Distractor2>\n    <Distractor3>A8WEQDD1</Distractor3>\n    <Distractor4>77</Distractor4>\n    <TrueAnswer>77</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>79</QuestionNumber>\n    <QuestionBase>correct answer is : 78</QuestionBase>\n    <Distractor1>A8WEQDD1</Distractor1>\n    <Distractor2>A8WEQDD1</Distractor2>\n    <Distractor3>A8WEQDD1</Distractor3>\n    <Distractor4>78</Distractor4>\n    <TrueAnswer>78</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>80</QuestionNumber>\n    <QuestionBase>correct answer is : 79</QuestionBase>\n    <Distractor1>A8WEQDD1</Distractor1>\n    <Distractor2>A8WEQDD1</Distractor2>\n    <Distractor3>A8WEQDD1</Distractor3>\n    <Distractor4>79</Distractor4>\n    <TrueAnswer>79</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>81</QuestionNumber>\n    <QuestionBase>correct answer is : 80</QuestionBase>\n    <Distractor1>A8WEQDD1</Distractor1>\n    <Distractor2>A8WEQDD1</Distractor2>\n    <Distractor3>A8WEQDD1</Distractor3>\n    <Distractor4>80</Distractor4>\n    <TrueAnswer>80</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>82</QuestionNumber>\n    <QuestionBase>correct answer is : 81</QuestionBase>\n    <Distractor1>A8WEQDD1</Distractor1>\n    <Distractor2>A8WEQDD1</Distractor2>\n    <Distractor3>A8WEQDD1</Distractor3>\n    <Distractor4>81</Distractor4>\n    <TrueAnswer>81</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>83</QuestionNumber>\n    <QuestionBase>correct answer is : 82</QuestionBase>\n    <Distractor1>A8WEQDD1</Distractor1>\n    <Distractor2>A8WEQDD1</Distractor2>\n    <Distractor3>A8WEQDD1</Distractor3>\n    <Distractor4>82</Distractor4>\n    <TrueAnswer>82</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>84</QuestionNumber>\n    <QuestionBase>correct answer is : 83</QuestionBase>\n    <Distractor1>A8WEQDD1</Distractor1>\n    <Distractor2>A8WEQDD1</Distractor2>\n    <Distractor3>A8WEQDD1</Distractor3>\n    <Distractor4>83</Distractor4>\n    <TrueAnswer>83</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>85</QuestionNumber>\n    <QuestionBase>correct answer is : 84</QuestionBase>\n    <Distractor1>A8WEQDD1</Distractor1>\n    <Distractor2>A8WEQDD1</Distractor2>\n    <Distractor3>A8WEQDD1</Distractor3>\n    <Distractor4>84</Distractor4>\n    <TrueAnswer>84</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>86</QuestionNumber>\n    <QuestionBase>correct answer is : 85</QuestionBase>\n    <Distractor1>A8WEQDD1</Distractor1>\n    <Distractor2>A8WEQDD1</Distractor2>\n    <Distractor3>A8WEQDD1</Distractor3>\n    <Distractor4>85</Distractor4>\n    <TrueAnswer>85</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>87</QuestionNumber>\n    <QuestionBase>correct answer is : 86</QuestionBase>\n    <Distractor1>A8WEQDD1</Distractor1>\n    <Distractor2>A8WEQDD1</Distractor2>\n    <Distractor3>A8WEQDD1</Distractor3>\n    <Distractor4>86</Distractor4>\n    <TrueAnswer>86</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>88</QuestionNumber>\n    <QuestionBase>correct answer is : 87</QuestionBase>\n    <Distractor1>A8WEQDD1</Distractor1>\n    <Distractor2>A8WEQDD1</Distractor2>\n    <Distractor3>A8WEQDD1</Distractor3>\n    <Distractor4>87</Distractor4>\n    <TrueAnswer>87</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>89</QuestionNumber>\n    <QuestionBase>correct answer is : 88</QuestionBase>\n    <Distractor1>3NELIH3L</Distractor1>\n    <Distractor2>3NELIH3L</Distractor2>\n    <Distractor3>3NELIH3L</Distractor3>\n    <Distractor4>88</Distractor4>\n    <TrueAnswer>88</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>90</QuestionNumber>\n    <QuestionBase>correct answer is : 89</QuestionBase>\n    <Distractor1>3NELIH3L</Distractor1>\n    <Distractor2>3NELIH3L</Distractor2>\n    <Distractor3>3NELIH3L</Distractor3>\n    <Distractor4>89</Distractor4>\n    <TrueAnswer>89</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>91</QuestionNumber>\n    <QuestionBase>correct answer is : 90</QuestionBase>\n    <Distractor1>3NELIH3L</Distractor1>\n    <Distractor2>3NELIH3L</Distractor2>\n    <Distractor3>3NELIH3L</Distractor3>\n    <Distractor4>90</Distractor4>\n    <TrueAnswer>90</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>92</QuestionNumber>\n    <QuestionBase>correct answer is : 91</QuestionBase>\n    <Distractor1>3NELIH3L</Distractor1>\n    <Distractor2>3NELIH3L</Distractor2>\n    <Distractor3>3NELIH3L</Distractor3>\n    <Distractor4>91</Distractor4>\n    <TrueAnswer>91</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>93</QuestionNumber>\n    <QuestionBase>correct answer is : 92</QuestionBase>\n    <Distractor1>3NELIH3L</Distractor1>\n    <Distractor2>3NELIH3L</Distractor2>\n    <Distractor3>3NELIH3L</Distractor3>\n    <Distractor4>92</Distractor4>\n    <TrueAnswer>92</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>94</QuestionNumber>\n    <QuestionBase>correct answer is : 93</QuestionBase>\n    <Distractor1>3NELIH3L</Distractor1>\n    <Distractor2>3NELIH3L</Distractor2>\n    <Distractor3>3NELIH3L</Distractor3>\n    <Distractor4>93</Distractor4>\n    <TrueAnswer>93</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>95</QuestionNumber>\n    <QuestionBase>correct answer is : 94</QuestionBase>\n    <Distractor1>3NELIH3L</Distractor1>\n    <Distractor2>3NELIH3L</Distractor2>\n    <Distractor3>3NELIH3L</Distractor3>\n    <Distractor4>94</Distractor4>\n    <TrueAnswer>94</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>96</QuestionNumber>\n    <QuestionBase>correct answer is : 95</QuestionBase>\n    <Distractor1>3NELIH3L</Distractor1>\n    <Distractor2>3NELIH3L</Distractor2>\n    <Distractor3>3NELIH3L</Distractor3>\n    <Distractor4>95</Distractor4>\n    <TrueAnswer>95</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>97</QuestionNumber>\n    <QuestionBase>correct answer is : 96</QuestionBase>\n    <Distractor1>3NELIH3L</Distractor1>\n    <Distractor2>3NELIH3L</Distractor2>\n    <Distractor3>3NELIH3L</Distractor3>\n    <Distractor4>96</Distractor4>\n    <TrueAnswer>96</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>98</QuestionNumber>\n    <QuestionBase>correct answer is : 97</QuestionBase>\n    <Distractor1>3NELIH3L</Distractor1>\n    <Distractor2>3NELIH3L</Distractor2>\n    <Distractor3>3NELIH3L</Distractor3>\n    <Distractor4>97</Distractor4>\n    <TrueAnswer>97</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>99</QuestionNumber>\n    <QuestionBase>correct answer is : 98</QuestionBase>\n    <Distractor1>3NELIH3L</Distractor1>\n    <Distractor2>3NELIH3L</Distractor2>\n    <Distractor3>3NELIH3L</Distractor3>\n    <Distractor4>98</Distractor4>\n    <TrueAnswer>98</TrueAnswer>\n  </c_SmallQuestion>\n  <c_SmallQuestion>\n    <QuestionNumber>100</QuestionNumber>\n    <QuestionBase>correct answer is : 99</QuestionBase>\n    <Distractor1>3NELIH3L</Distractor1>\n    <Distractor2>3NELIH3L</Distractor2>\n    <Distractor3>3NELIH3L</Distractor3>\n    <Distractor4>99</Distractor4>\n    <TrueAnswer>99</TrueAnswer>\n  </c_SmallQuestion>\n</ArrayOfC_SmallQuestion>', 100, 0);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_ranking`
--

DROP TABLE IF EXISTS `tbl_ranking`;
CREATE TABLE `tbl_ranking` (
  `vote_id` int(11) NOT NULL,
  `voter_id` int(11) DEFAULT NULL,
  `candidate_id` int(11) DEFAULT NULL,
  `state` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_ranking`
--

INSERT INTO `tbl_ranking` (`vote_id`, `voter_id`, `candidate_id`, `state`) VALUES
(1, NULL, 3, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_squestions`
--

DROP TABLE IF EXISTS `tbl_squestions`;
CREATE TABLE `tbl_squestions` (
  `sqID` int(11) NOT NULL,
  `sqTEXT` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_squestions`
--

INSERT INTO `tbl_squestions` (`sqID`, `sqTEXT`) VALUES
(0, 'Who was your childhood hero?'),
(1, 'What is life to you?'),
(2, 'What was your childhood nickname?'),
(3, 'Who is your daddy?'),
(4, 'What was your favorite memory with the colour blue?'),
(5, 'What is the best thing you did in college?'),
(6, 'Who was your meme daddy?');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_time`
--

DROP TABLE IF EXISTS `tbl_time`;
CREATE TABLE `tbl_time` (
  `timeslotID` int(4) NOT NULL,
  `timestart` int(2) DEFAULT NULL,
  `timedesc` varchar(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_time`
--

INSERT INTO `tbl_time` (`timeslotID`, `timestart`, `timedesc`) VALUES
(0, 1, '01-02'),
(1, 2, '02-03'),
(2, 3, '03-04'),
(3, 4, '04-05'),
(4, 5, '05-06'),
(5, 6, '06-07'),
(6, 7, '07-08'),
(7, 8, '08-09'),
(8, 9, '09-10'),
(9, 10, '10-11'),
(10, 11, '11-12'),
(11, 12, '12-13'),
(12, 13, '13-14'),
(13, 14, '14-15'),
(14, 15, '15-16'),
(15, 16, '16-17'),
(16, 17, '17-18'),
(17, 18, '18-19'),
(18, 19, '19-20'),
(19, 20, '20-21'),
(20, 21, '21-22'),
(21, 22, '22-23'),
(22, 23, '23-00'),
(23, 0, '00-01');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_timein`
--

DROP TABLE IF EXISTS `tbl_timein`;
CREATE TABLE `tbl_timein` (
  `id_date` datetime NOT NULL,
  `user_id` int(11) NOT NULL,
  `class_id` int(11) NOT NULL,
  `drp` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_timeout`
--

DROP TABLE IF EXISTS `tbl_timeout`;
CREATE TABLE `tbl_timeout` (
  `id_date` datetime NOT NULL,
  `user_id` int(11) NOT NULL,
  `class_id` int(11) NOT NULL,
  `drp` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_user`
--

DROP TABLE IF EXISTS `tbl_user`;
CREATE TABLE `tbl_user` (
  `user_id` int(11) NOT NULL,
  `user_type` int(1) NOT NULL,
  `user_fname` varchar(10) NOT NULL,
  `user_mi` varchar(1) NOT NULL,
  `user_lname` varchar(10) NOT NULL,
  `user_name` varchar(20) NOT NULL,
  `user_leagueoflegends` varchar(255) NOT NULL,
  `user_password` varchar(255) NOT NULL,
  `questionIndex` int(1) NOT NULL,
  `sec_ans` varchar(255) NOT NULL,
  `user_gender` varchar(1) NOT NULL,
  `user_cellularnumber` varchar(11) NOT NULL,
  `user_landline` varchar(7) NOT NULL,
  `user_dob` date NOT NULL,
  `address` varchar(255) NOT NULL,
  `email` varchar(45) NOT NULL,
  `isOnline` tinyint(1) NOT NULL,
  `isActive` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_user`
--

INSERT INTO `tbl_user` (`user_id`, `user_type`, `user_fname`, `user_mi`, `user_lname`, `user_name`, `user_leagueoflegends`, `user_password`, `questionIndex`, `sec_ans`, `user_gender`, `user_cellularnumber`, `user_landline`, `user_dob`, `address`, `email`, `isOnline`, `isActive`) VALUES
(0, 0, 'i', 'a', 'admin', 'admin', ')zEk)q*yXe4l&fy+qDO}(40<fvk&dC*[1f2wNJa{v[rDJl<Hb=Hx{jqO{EEXGAUUp7@l5C7h4Pd+Nw(+wdpj]T{S&nxIED_u4Wqe', 'aYEV1fg8+eZkJb7ytMaVoLfK+jYBkR/090dA0DgcTEw3vt25soWm478dWXg4KIC/Y36YyoswlJUaFrmfG3Bpdw==', 0, 'admin', '0', '00916584223', '6689574', '0001-01-01', 'Overthere', 'admin@admin.com', 0, 1),
(1, 2, 'user1', 'u', 'users', 'user1', 'G#)T_n}[qdvQgwNS%Fh8F7S}h}yQW!}yBolJe_!kAmj<<mQv)$YQPv4bu=$]*818g}P)KE&=X}7vXS}]8CYll8ii#KrkG%vU#3vC', 'BUeW0629YqBbrPTUCgNrGC6KBHhpGcaIvFTYYQ00Osa8hNAy8UZyAPdERxgTKEEfS8km8kayHJ5GodPBwpj1iw==', 0, 'batman', '0', '09568599856', '5589856', '1988-10-27', 'over there', 'user1@userdomain.com', 0, 1),
(2, 0, 'user3', 'u', 'users', 'user3', 'iNpm[1@MQu5Ww+D4j[NuInN$U&b35tR[WSk3EUcWAznpp0ELE)wbhB4]A3RHaIiyc8Adlc0Pw(ul<0Xw#Py%}(rVqp3cCU])Q*N9', 'D/8gPiGyD5jEx8osmxuGQciFnQ3UFlzm839emzeQVb093vmAqL9dBX8b6DoGp9Pxg4QzGrdooNFSZvT8KXLLMA==', 0, 'batman', '0', '09855899856', '5589632', '0001-01-01', 'over there', 'user3@userdomain.com', 0, 1),
(3, 2, 'user4', 'u', 'users', 'user4', 'iNpm[1@MQu5Ww+D4j[NuInN$U&b35tR[WSk3EUcWAznpp0ELE)wbhB4]A3RHaIiyc8Adlc0Pw(ul<0Xw#Py%}(rVqp3cCU])Q*N9', '/X0Df2+6dzhbXFaQz/hbDDT3p9WyiRFUMXmFoZ7piefC8GPt+6+qfbgdik95PBDrp91z7TP071pUpJyUeN4nnQ==', 0, 'batman', '0', '09855899856', '5589632', '1988-12-26', 'over there', 'user4@userdomain.com', 0, 1),
(4, 2, 'user4', 'u', 'users', 'user5', 'iNpm[1@MQu5Ww+D4j[NuInN$U&b35tR[WSk3EUcWAznpp0ELE)wbhB4]A3RHaIiyc8Adlc0Pw(ul<0Xw#Py%}(rVqp3cCU])Q*N9', 'Yr04y3ukoHQKm40FpqqTkH0kEpTdhgAlAbc/wlhzW5NUujX65Jl0sbuwFSkvMpkJKzYKUyuiyuzPumSdeczTRg==', 0, 'batman', '0', '09855899856', '5589632', '1988-12-26', 'over there', 'user5@userdomain.com', 0, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `lim_gender`
--
ALTER TABLE `lim_gender`
  ADD PRIMARY KEY (`genderID`);

--
-- Indexes for table `lim_usertype`
--
ALTER TABLE `lim_usertype`
  ADD PRIMARY KEY (`userTypeInt`);

--
-- Indexes for table `link_articles`
--
ALTER TABLE `link_articles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `class_id` (`class_id`),
  ADD KEY `file_id` (`file_id`);

--
-- Indexes for table `link_class`
--
ALTER TABLE `link_class`
  ADD PRIMARY KEY (`id`),
  ADD KEY `class_id` (`class_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `link_classroomgrades`
--
ALTER TABLE `link_classroomgrades`
  ADD PRIMARY KEY (`id_classroomgrades`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `class_id` (`class_id`);

--
-- Indexes for table `link_enrollment`
--
ALTER TABLE `link_enrollment`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `link_examgrades`
--
ALTER TABLE `link_examgrades`
  ADD PRIMARY KEY (`idlink_examgrades`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `exam_id` (`exam_id`),
  ADD KEY `class_id` (`class_id`);

--
-- Indexes for table `link_exams`
--
ALTER TABLE `link_exams`
  ADD PRIMARY KEY (`id`),
  ADD KEY `class_id` (`class_id`),
  ADD KEY `file_id` (`file_id`);

--
-- Indexes for table `link_feedback`
--
ALTER TABLE `link_feedback`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_UNIQUE` (`id`);

--
-- Indexes for table `link_materials`
--
ALTER TABLE `link_materials`
  ADD PRIMARY KEY (`id`),
  ADD KEY `class_id` (`class_id`),
  ADD KEY `file_id` (`file_id`);

--
-- Indexes for table `link_professors`
--
ALTER TABLE `link_professors`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_fk_professor` (`professor_id`),
  ADD KEY `idx_fx_classroom` (`class_id`);

--
-- Indexes for table `link_quiz`
--
ALTER TABLE `link_quiz`
  ADD PRIMARY KEY (`id`),
  ADD KEY `quiz_id` (`quiz_id`),
  ADD KEY `class_id` (`class_id`);

--
-- Indexes for table `link_quizgrades`
--
ALTER TABLE `link_quizgrades`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `quiz_id` (`quiz_id`),
  ADD KEY `class_id` (`class_id`);

--
-- Indexes for table `link_schedule`
--
ALTER TABLE `link_schedule`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_day_idx` (`dayid`),
  ADD KEY `fk_timeslot_idx` (`timeid`),
  ADD KEY `fk_classid_idx` (`classid`);

--
-- Indexes for table `tbl_articles`
--
ALTER TABLE `tbl_articles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_classroom`
--
ALTER TABLE `tbl_classroom`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_days`
--
ALTER TABLE `tbl_days`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_exams`
--
ALTER TABLE `tbl_exams`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_grades`
--
ALTER TABLE `tbl_grades`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_loggedstatus`
--
ALTER TABLE `tbl_loggedstatus`
  ADD PRIMARY KEY (`case_id`),
  ADD KEY `userid` (`userid`);

--
-- Indexes for table `tbl_markingexam`
--
ALTER TABLE `tbl_markingexam`
  ADD PRIMARY KEY (`id`),
  ADD KEY `thisexamid_idx` (`exam_id`),
  ADD KEY `thisuserid_idx` (`user_id`);

--
-- Indexes for table `tbl_markingquiz`
--
ALTER TABLE `tbl_markingquiz`
  ADD PRIMARY KEY (`id`),
  ADD KEY `quiz_id_idx` (`quiz_id`),
  ADD KEY `user_id_idx` (`user_id`);

--
-- Indexes for table `tbl_materials`
--
ALTER TABLE `tbl_materials`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_quizes`
--
ALTER TABLE `tbl_quizes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_ranking`
--
ALTER TABLE `tbl_ranking`
  ADD PRIMARY KEY (`vote_id`),
  ADD KEY `fk_voterid_idx` (`voter_id`),
  ADD KEY `fk_candidateid_idx` (`candidate_id`);

--
-- Indexes for table `tbl_squestions`
--
ALTER TABLE `tbl_squestions`
  ADD PRIMARY KEY (`sqID`);

--
-- Indexes for table `tbl_time`
--
ALTER TABLE `tbl_time`
  ADD PRIMARY KEY (`timeslotID`);

--
-- Indexes for table `tbl_timein`
--
ALTER TABLE `tbl_timein`
  ADD PRIMARY KEY (`id_date`);

--
-- Indexes for table `tbl_timeout`
--
ALTER TABLE `tbl_timeout`
  ADD PRIMARY KEY (`id_date`);

--
-- Indexes for table `tbl_user`
--
ALTER TABLE `tbl_user`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `user_name` (`user_name`),
  ADD KEY `user_type` (`user_type`),
  ADD KEY `questionIndex` (`questionIndex`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `link_articles`
--
ALTER TABLE `link_articles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `link_class`
--
ALTER TABLE `link_class`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `link_enrollment`
--
ALTER TABLE `link_enrollment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `link_examgrades`
--
ALTER TABLE `link_examgrades`
  MODIFY `idlink_examgrades` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `link_exams`
--
ALTER TABLE `link_exams`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `link_materials`
--
ALTER TABLE `link_materials`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `link_quiz`
--
ALTER TABLE `link_quiz`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `link_quizgrades`
--
ALTER TABLE `link_quizgrades`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `link_schedule`
--
ALTER TABLE `link_schedule`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `tbl_articles`
--
ALTER TABLE `tbl_articles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `tbl_classroom`
--
ALTER TABLE `tbl_classroom`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `tbl_days`
--
ALTER TABLE `tbl_days`
  MODIFY `id` int(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `tbl_grades`
--
ALTER TABLE `tbl_grades`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tbl_loggedstatus`
--
ALTER TABLE `tbl_loggedstatus`
  MODIFY `case_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tbl_markingexam`
--
ALTER TABLE `tbl_markingexam`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tbl_markingquiz`
--
ALTER TABLE `tbl_markingquiz`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `tbl_materials`
--
ALTER TABLE `tbl_materials`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `tbl_quizes`
--
ALTER TABLE `tbl_quizes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `tbl_ranking`
--
ALTER TABLE `tbl_ranking`
  MODIFY `vote_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `tbl_squestions`
--
ALTER TABLE `tbl_squestions`
  MODIFY `sqID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `tbl_user`
--
ALTER TABLE `tbl_user`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `link_articles`
--
ALTER TABLE `link_articles`
  ADD CONSTRAINT `link_articles_ibfk_1` FOREIGN KEY (`file_id`) REFERENCES `tbl_articles` (`id`) ON UPDATE NO ACTION,
  ADD CONSTRAINT `link_articles_ibfk_2` FOREIGN KEY (`class_id`) REFERENCES `tbl_classroom` (`id`);

--
-- Constraints for table `link_class`
--
ALTER TABLE `link_class`
  ADD CONSTRAINT `link_class_ibfk_1` FOREIGN KEY (`class_id`) REFERENCES `tbl_classroom` (`id`),
  ADD CONSTRAINT `link_class_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `tbl_user` (`user_id`);

--
-- Constraints for table `link_classroomgrades`
--
ALTER TABLE `link_classroomgrades`
  ADD CONSTRAINT `link_classroomgrades_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `tbl_user` (`user_id`),
  ADD CONSTRAINT `link_classroomgrades_ibfk_2` FOREIGN KEY (`class_id`) REFERENCES `tbl_classroom` (`id`);

--
-- Constraints for table `link_exams`
--
ALTER TABLE `link_exams`
  ADD CONSTRAINT `link_exams_ibfk_1` FOREIGN KEY (`file_id`) REFERENCES `tbl_exams` (`id`),
  ADD CONSTRAINT `link_exams_ibfk_2` FOREIGN KEY (`class_id`) REFERENCES `tbl_classroom` (`id`);

--
-- Constraints for table `link_materials`
--
ALTER TABLE `link_materials`
  ADD CONSTRAINT `link_materials_ibfk_2` FOREIGN KEY (`class_id`) REFERENCES `tbl_classroom` (`id`),
  ADD CONSTRAINT `link_materials_ibfk_3` FOREIGN KEY (`file_id`) REFERENCES `tbl_materials` (`id`);

--
-- Constraints for table `link_professors`
--
ALTER TABLE `link_professors`
  ADD CONSTRAINT `fk_classroomid` FOREIGN KEY (`class_id`) REFERENCES `tbl_classroom` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_professorid` FOREIGN KEY (`professor_id`) REFERENCES `tbl_user` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `link_quiz`
--
ALTER TABLE `link_quiz`
  ADD CONSTRAINT `link_quiz_ibfk_2` FOREIGN KEY (`class_id`) REFERENCES `tbl_classroom` (`id`),
  ADD CONSTRAINT `link_quiz_ibfk_3` FOREIGN KEY (`quiz_id`) REFERENCES `tbl_quizes` (`id`);

--
-- Constraints for table `link_quizgrades`
--
ALTER TABLE `link_quizgrades`
  ADD CONSTRAINT `link_quizgrades_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `tbl_user` (`user_id`),
  ADD CONSTRAINT `link_quizgrades_ibfk_2` FOREIGN KEY (`quiz_id`) REFERENCES `tbl_quizes` (`id`);

--
-- Constraints for table `link_schedule`
--
ALTER TABLE `link_schedule`
  ADD CONSTRAINT `fk_classid` FOREIGN KEY (`classid`) REFERENCES `tbl_classroom` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_dayid` FOREIGN KEY (`dayid`) REFERENCES `tbl_days` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_timeid` FOREIGN KEY (`timeid`) REFERENCES `tbl_time` (`timeslotID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `tbl_loggedstatus`
--
ALTER TABLE `tbl_loggedstatus`
  ADD CONSTRAINT `userid` FOREIGN KEY (`userid`) REFERENCES `tbl_user` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `tbl_markingexam`
--
ALTER TABLE `tbl_markingexam`
  ADD CONSTRAINT `examid` FOREIGN KEY (`exam_id`) REFERENCES `tbl_exams` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `thisuserid` FOREIGN KEY (`user_id`) REFERENCES `tbl_user` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `tbl_markingquiz`
--
ALTER TABLE `tbl_markingquiz`
  ADD CONSTRAINT `user_id` FOREIGN KEY (`user_id`) REFERENCES `tbl_user` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `tbl_ranking`
--
ALTER TABLE `tbl_ranking`
  ADD CONSTRAINT `fk_candidateid` FOREIGN KEY (`candidate_id`) REFERENCES `tbl_user` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_voterid` FOREIGN KEY (`voter_id`) REFERENCES `tbl_user` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
