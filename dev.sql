-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.11-MariaDB - Arch Linux
-- Server OS:                    Linux
-- HeidiSQL Version:             10.3.0.5781
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for oracybox
CREATE DATABASE IF NOT EXISTS `oracybox` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `oracybox`;

-- Dumping structure for table oracybox.activities
CREATE TABLE IF NOT EXISTS `activities` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `topic_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `activities_topic_id_foreign` (`topic_id`),
  CONSTRAINT `activities_topic_id_foreign` FOREIGN KEY (`topic_id`) REFERENCES `topics` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table oracybox.activities: ~1 rows (approximately)
/*!40000 ALTER TABLE `activities` DISABLE KEYS */;
INSERT INTO `activities` (`id`, `topic_id`, `name`, `description`, `type`, `created_at`, `updated_at`) VALUES
	(1, 1, 'Role of the muscles', 'Lorem..', 'Speech', '2020-01-01 21:44:06', '2020-01-01 21:44:06');
/*!40000 ALTER TABLE `activities` ENABLE KEYS */;

-- Dumping structure for table oracybox.categories
CREATE TABLE IF NOT EXISTS `categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(10) unsigned DEFAULT NULL,
  `order` int(11) NOT NULL DEFAULT 1,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `categories_slug_unique` (`slug`),
  KEY `categories_parent_id_foreign` (`parent_id`),
  CONSTRAINT `categories_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table oracybox.categories: ~1 rows (approximately)
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` (`id`, `parent_id`, `order`, `name`, `slug`, `created_at`, `updated_at`) VALUES
	(1, 1, 1, '1', '1', '2020-01-01 21:16:52', '2020-01-01 21:20:25');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;

-- Dumping structure for table oracybox.classrooms
CREATE TABLE IF NOT EXISTS `classrooms` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `order` int(11) NOT NULL DEFAULT 1,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `classrooms_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table oracybox.classrooms: ~1 rows (approximately)
/*!40000 ALTER TABLE `classrooms` DISABLE KEYS */;
INSERT INTO `classrooms` (`id`, `order`, `name`, `slug`, `created_at`, `updated_at`) VALUES
	(1, 1, 'Classroom A', 'classroom-a', '2020-01-01 21:16:37', '2020-01-01 21:16:37');
/*!40000 ALTER TABLE `classrooms` ENABLE KEYS */;

-- Dumping structure for table oracybox.completedactivities
CREATE TABLE IF NOT EXISTS `completedactivities` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `activity_id` bigint(20) unsigned NOT NULL,
  `pupil_id` bigint(20) unsigned NOT NULL,
  `classroom_id` bigint(20) unsigned NOT NULL,
  `results` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`results`)),
  `media_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `has_feedback` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `completedactivities_activity_id_foreign` (`activity_id`),
  KEY `completedactivities_pupil_id_foreign` (`pupil_id`),
  KEY `completedactivities_classroom_id_foreign` (`classroom_id`),
  CONSTRAINT `completedactivities_activity_id_foreign` FOREIGN KEY (`activity_id`) REFERENCES `activities` (`id`),
  CONSTRAINT `completedactivities_classroom_id_foreign` FOREIGN KEY (`classroom_id`) REFERENCES `classrooms` (`id`),
  CONSTRAINT `completedactivities_pupil_id_foreign` FOREIGN KEY (`pupil_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table oracybox.completedactivities: ~2 rows (approximately)
/*!40000 ALTER TABLE `completedactivities` DISABLE KEYS */;
INSERT INTO `completedactivities` (`id`, `activity_id`, `pupil_id`, `classroom_id`, `results`, `media_path`, `has_feedback`, `created_at`, `updated_at`) VALUES
	(1, 1, 3, 1, '{\r\n	"score": 100\r\n}', 'path/to/file', 1, '2020-01-01 21:46:56', '2020-01-01 21:46:57'),
	(10, 1, 5, 1, '{"score": 100}', 'test/path', 0, '2020-01-09 15:00:27', '2020-01-09 15:00:27');
/*!40000 ALTER TABLE `completedactivities` ENABLE KEYS */;

-- Dumping structure for table oracybox.data_rows
CREATE TABLE IF NOT EXISTS `data_rows` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `data_type_id` int(10) unsigned NOT NULL,
  `field` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT 0,
  `browse` tinyint(1) NOT NULL DEFAULT 1,
  `read` tinyint(1) NOT NULL DEFAULT 1,
  `edit` tinyint(1) NOT NULL DEFAULT 1,
  `add` tinyint(1) NOT NULL DEFAULT 1,
  `delete` tinyint(1) NOT NULL DEFAULT 1,
  `details` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `data_rows_data_type_id_foreign` (`data_type_id`),
  CONSTRAINT `data_rows_data_type_id_foreign` FOREIGN KEY (`data_type_id`) REFERENCES `data_types` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table oracybox.data_rows: ~84 rows (approximately)
/*!40000 ALTER TABLE `data_rows` DISABLE KEYS */;
INSERT INTO `data_rows` (`id`, `data_type_id`, `field`, `type`, `display_name`, `required`, `browse`, `read`, `edit`, `add`, `delete`, `details`, `order`) VALUES
	(1, 1, 'id', 'number', 'ID', 1, 0, 0, 0, 0, 0, '{}', 1),
	(2, 1, 'name', 'text', 'Name', 1, 1, 1, 1, 1, 1, '{}', 2),
	(3, 1, 'email', 'text', 'Email', 1, 1, 1, 1, 1, 1, '{}', 3),
	(4, 1, 'password', 'password', 'Password', 1, 0, 0, 1, 1, 0, '{}', 6),
	(5, 1, 'remember_token', 'text', 'Remember Token', 0, 0, 0, 0, 0, 0, '{}', 7),
	(6, 1, 'created_at', 'timestamp', 'Created At', 0, 1, 1, 0, 0, 0, '{}', 8),
	(7, 1, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, '{}', 9),
	(8, 1, 'avatar', 'image', 'Avatar', 0, 1, 1, 1, 1, 1, '{}', 11),
	(9, 1, 'user_belongsto_role_relationship', 'relationship', 'Role', 0, 1, 1, 1, 1, 0, '{"model":"TCG\\\\Voyager\\\\Models\\\\Role","table":"roles","type":"belongsTo","column":"role_id","key":"id","label":"display_name","pivot_table":"roles","pivot":"0","taggable":"0"}', 13),
	(10, 1, 'user_belongstomany_role_relationship', 'relationship', 'Roles', 0, 1, 1, 1, 1, 0, '{"model":"TCG\\\\Voyager\\\\Models\\\\Role","table":"roles","type":"belongsToMany","column":"id","key":"id","label":"display_name","pivot_table":"user_roles","pivot":"1","taggable":"0"}', 14),
	(11, 1, 'settings', 'hidden', 'Settings', 0, 0, 0, 0, 0, 0, '{}', 15),
	(12, 2, 'id', 'number', 'ID', 1, 0, 0, 0, 0, 0, NULL, 1),
	(13, 2, 'name', 'text', 'Name', 1, 1, 1, 1, 1, 1, NULL, 2),
	(14, 2, 'created_at', 'timestamp', 'Created At', 0, 0, 0, 0, 0, 0, NULL, 3),
	(15, 2, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, NULL, 4),
	(16, 3, 'id', 'number', 'ID', 1, 0, 0, 0, 0, 0, NULL, 1),
	(17, 3, 'name', 'text', 'Name', 1, 1, 1, 1, 1, 1, NULL, 2),
	(18, 3, 'created_at', 'timestamp', 'Created At', 0, 0, 0, 0, 0, 0, NULL, 3),
	(19, 3, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, NULL, 4),
	(20, 3, 'display_name', 'text', 'Display Name', 1, 1, 1, 1, 1, 1, NULL, 5),
	(21, 1, 'role_id', 'text', 'Role', 0, 1, 1, 1, 1, 1, '{}', 12),
	(22, 4, 'id', 'number', 'ID', 1, 0, 0, 0, 0, 0, NULL, 1),
	(23, 4, 'parent_id', 'select_dropdown', 'Parent', 0, 0, 1, 1, 1, 1, '{"default":"","null":"","options":{"":"-- None --"},"relationship":{"key":"id","label":"name"}}', 2),
	(24, 4, 'order', 'text', 'Order', 1, 1, 1, 1, 1, 1, '{"default":1}', 3),
	(25, 4, 'name', 'text', 'Name', 1, 1, 1, 1, 1, 1, NULL, 4),
	(26, 4, 'slug', 'text', 'Slug', 1, 1, 1, 1, 1, 1, '{"slugify":{"origin":"name"}}', 5),
	(27, 4, 'created_at', 'timestamp', 'Created At', 0, 0, 1, 0, 0, 0, NULL, 6),
	(28, 4, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, NULL, 7),
	(29, 5, 'id', 'number', 'ID', 1, 0, 0, 0, 0, 0, '{}', 1),
	(30, 5, 'author_id', 'text', 'Author', 1, 0, 1, 1, 0, 1, '{}', 2),
	(31, 5, 'category_id', 'text', 'Category', 0, 0, 1, 1, 1, 0, '{}', 3),
	(32, 5, 'title', 'text', 'Title', 1, 1, 1, 1, 1, 1, '{}', 4),
	(33, 5, 'excerpt', 'text_area', 'Excerpt', 0, 0, 1, 1, 1, 1, '{}', 5),
	(34, 5, 'body', 'rich_text_box', 'Body', 1, 0, 1, 1, 1, 1, '{}', 6),
	(35, 5, 'image', 'image', 'Post Image', 0, 1, 1, 1, 1, 1, '{"resize":{"width":"1000","height":"null"},"quality":"70%","upsize":true,"thumbnails":[{"name":"medium","scale":"50%"},{"name":"small","scale":"25%"},{"name":"cropped","crop":{"width":"300","height":"250"}}]}', 7),
	(36, 5, 'slug', 'text', 'Slug', 1, 0, 1, 1, 1, 1, '{"slugify":{"origin":"title","forceUpdate":true},"validation":{"rule":"unique:posts,slug"}}', 8),
	(37, 5, 'meta_description', 'text_area', 'Meta Description', 0, 0, 1, 1, 1, 1, '{}', 9),
	(38, 5, 'meta_keywords', 'text_area', 'Meta Keywords', 0, 0, 1, 1, 1, 1, '{}', 10),
	(39, 5, 'status', 'select_dropdown', 'Status', 1, 1, 1, 1, 1, 1, '{"default":"DRAFT","options":{"PUBLISHED":"published","DRAFT":"draft","PENDING":"pending"}}', 11),
	(40, 5, 'created_at', 'timestamp', 'Created At', 0, 1, 1, 0, 0, 0, '{}', 12),
	(41, 5, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, '{}', 13),
	(42, 5, 'seo_title', 'text', 'SEO Title', 0, 1, 1, 1, 1, 1, '{}', 14),
	(43, 5, 'featured', 'checkbox', 'Featured', 1, 1, 1, 1, 1, 1, '{}', 15),
	(44, 6, 'id', 'number', 'ID', 1, 0, 0, 0, 0, 0, NULL, 1),
	(45, 6, 'author_id', 'text', 'Author', 1, 0, 0, 0, 0, 0, NULL, 2),
	(46, 6, 'title', 'text', 'Title', 1, 1, 1, 1, 1, 1, NULL, 3),
	(47, 6, 'excerpt', 'text_area', 'Excerpt', 1, 0, 1, 1, 1, 1, NULL, 4),
	(48, 6, 'body', 'rich_text_box', 'Body', 1, 0, 1, 1, 1, 1, NULL, 5),
	(49, 6, 'slug', 'text', 'Slug', 1, 0, 1, 1, 1, 1, '{"slugify":{"origin":"title"},"validation":{"rule":"unique:pages,slug"}}', 6),
	(50, 6, 'meta_description', 'text', 'Meta Description', 1, 0, 1, 1, 1, 1, NULL, 7),
	(51, 6, 'meta_keywords', 'text', 'Meta Keywords', 1, 0, 1, 1, 1, 1, NULL, 8),
	(52, 6, 'status', 'select_dropdown', 'Status', 1, 1, 1, 1, 1, 1, '{"default":"INACTIVE","options":{"INACTIVE":"INACTIVE","ACTIVE":"ACTIVE"}}', 9),
	(53, 6, 'created_at', 'timestamp', 'Created At', 1, 1, 1, 0, 0, 0, NULL, 10),
	(54, 6, 'updated_at', 'timestamp', 'Updated At', 1, 0, 0, 0, 0, 0, NULL, 11),
	(55, 6, 'image', 'image', 'Page Image', 0, 1, 1, 1, 1, 1, NULL, 12),
	(72, 9, 'id', 'text', 'Id', 1, 0, 0, 0, 0, 0, '{}', 1),
	(73, 9, 'activity_id', 'text', 'Activity Id', 1, 1, 1, 1, 1, 1, '{}', 2),
	(74, 9, 'pupil_id', 'text', 'Pupil Id', 1, 1, 1, 1, 1, 1, '{}', 3),
	(75, 9, 'classroom_id', 'text', 'Classroom Id', 1, 1, 1, 1, 1, 1, '{}', 4),
	(76, 9, 'results', 'text', 'Results', 1, 1, 1, 1, 1, 1, '{}', 5),
	(77, 9, 'media_path', 'text', 'Media Path', 1, 1, 1, 1, 1, 1, '{}', 6),
	(78, 9, 'has_feedback', 'text', 'Has Feedback', 1, 1, 1, 1, 1, 1, '{}', 7),
	(79, 9, 'created_at', 'timestamp', 'Created At', 0, 1, 1, 1, 0, 1, '{}', 8),
	(80, 9, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, '{}', 9),
	(81, 9, 'completedactivity_belongsto_activity_relationship', 'relationship', 'activities', 0, 1, 1, 1, 1, 1, '{"model":"App\\\\Activity","table":"activities","type":"belongsTo","column":"activity_id","key":"id","label":"name","pivot_table":"activities","pivot":"0","taggable":"0"}', 10),
	(82, 9, 'completedactivity_belongsto_user_relationship', 'relationship', 'users', 0, 1, 1, 1, 1, 1, '{"model":"App\\\\User","table":"users","type":"belongsTo","column":"pupil_id","key":"id","label":"name","pivot_table":"activities","pivot":"0","taggable":"0"}', 11),
	(83, 9, 'completedactivity_belongsto_classroom_relationship', 'relationship', 'classrooms', 0, 1, 1, 1, 1, 1, '{"model":"App\\\\Classroom","table":"classrooms","type":"belongsTo","column":"classroom_id","key":"id","label":"name","pivot_table":"activities","pivot":"0","taggable":"0"}', 12),
	(84, 10, 'id', 'number', 'Id', 1, 0, 0, 0, 0, 0, '{}', 1),
	(85, 10, 'order', 'text', 'Order', 1, 1, 1, 1, 1, 1, '{"default":1}', 2),
	(86, 10, 'name', 'text', 'Name', 1, 1, 1, 1, 1, 1, '{}', 3),
	(87, 10, 'slug', 'text', 'Slug', 1, 1, 1, 1, 1, 1, '{"slugify":{"origin":"name"}}', 4),
	(88, 10, 'created_at', 'timestamp', 'Created At', 0, 1, 1, 1, 0, 1, '{}', 5),
	(89, 10, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, '{}', 6),
	(90, 11, 'id', 'text', 'Id', 1, 0, 0, 0, 0, 0, '{}', 1),
	(91, 11, 'topic_id', 'select_dropdown', 'Topic Id', 1, 1, 1, 1, 1, 1, '{}', 2),
	(92, 11, 'name', 'text', 'Name', 1, 1, 1, 1, 1, 1, '{}', 4),
	(93, 11, 'description', 'text', 'Description', 1, 1, 1, 1, 1, 1, '{}', 5),
	(94, 11, 'type', 'text', 'Type', 1, 1, 1, 1, 1, 1, '{}', 6),
	(95, 11, 'created_at', 'timestamp', 'Created At', 0, 1, 1, 1, 0, 1, '{}', 7),
	(96, 11, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, '{}', 8),
	(97, 11, 'activity_belongsto_topic_relationship', 'relationship', 'topics', 0, 1, 1, 1, 1, 1, '{"model":"App\\\\Topic","table":"topics","type":"belongsTo","column":"topic_id","key":"id","label":"name","pivot_table":"activities","pivot":"0","taggable":"0"}', 3),
	(98, 1, 'email_verified_at', 'timestamp', 'Email Verified At', 0, 1, 1, 1, 1, 1, '{}', 10),
	(99, 1, 'classroom_id', 'text', 'Classroom Id', 0, 1, 1, 1, 1, 1, '{}', 5),
	(100, 1, 'user_hasmany_completedactivity_relationship', 'relationship', 'completedactivities', 0, 1, 1, 1, 1, 1, '{"model":"App\\\\Completedactivity","table":"completedactivities","type":"hasMany","column":"pupil_id","key":"activity_id","label":"id","pivot_table":"activities","pivot":"0","taggable":"0"}', 4);
/*!40000 ALTER TABLE `data_rows` ENABLE KEYS */;

-- Dumping structure for table oracybox.data_types
CREATE TABLE IF NOT EXISTS `data_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name_singular` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name_plural` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `icon` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `model_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `policy_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `controller` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `generate_permissions` tinyint(1) NOT NULL DEFAULT 0,
  `server_side` tinyint(4) NOT NULL DEFAULT 0,
  `details` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `data_types_name_unique` (`name`),
  UNIQUE KEY `data_types_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table oracybox.data_types: ~9 rows (approximately)
/*!40000 ALTER TABLE `data_types` DISABLE KEYS */;
INSERT INTO `data_types` (`id`, `name`, `slug`, `display_name_singular`, `display_name_plural`, `icon`, `model_name`, `policy_name`, `controller`, `description`, `generate_permissions`, `server_side`, `details`, `created_at`, `updated_at`) VALUES
	(1, 'users', 'users', 'User', 'Users', 'voyager-person', 'TCG\\Voyager\\Models\\User', 'TCG\\Voyager\\Policies\\UserPolicy', 'TCG\\Voyager\\Http\\Controllers\\VoyagerUserController', NULL, 1, 0, '{"order_column":"classroom_id","order_display_column":"classroom_id","order_direction":"desc","default_search_key":"classroom_id","scope":null}', '2019-12-23 21:10:41', '2020-01-02 20:28:43'),
	(2, 'menus', 'menus', 'Menu', 'Menus', 'voyager-list', 'TCG\\Voyager\\Models\\Menu', NULL, '', '', 1, 0, NULL, '2019-12-23 21:10:41', '2019-12-23 21:10:41'),
	(3, 'roles', 'roles', 'Role', 'Roles', 'voyager-lock', 'TCG\\Voyager\\Models\\Role', NULL, '', '', 1, 0, NULL, '2019-12-23 21:10:41', '2019-12-23 21:10:41'),
	(4, 'categories', 'categories', 'Category', 'Categories', 'voyager-categories', 'TCG\\Voyager\\Models\\Category', NULL, '', '', 1, 0, NULL, '2019-12-23 21:10:44', '2019-12-23 21:10:44'),
	(5, 'posts', 'posts', 'Post', 'Posts', 'voyager-news', 'TCG\\Voyager\\Models\\Post', 'TCG\\Voyager\\Policies\\PostPolicy', NULL, NULL, 1, 0, '{"order_column":null,"order_display_column":null,"order_direction":"desc","default_search_key":null,"scope":null}', '2019-12-23 21:10:45', '2019-12-27 20:22:14'),
	(6, 'pages', 'pages', 'Page', 'Pages', 'voyager-file-text', 'TCG\\Voyager\\Models\\Page', NULL, '', '', 1, 0, NULL, '2019-12-23 21:10:46', '2019-12-23 21:10:46'),
	(9, 'completedactivities', 'completedactivities', 'Completed Activity', 'Completed Activities', 'voyager-activity', 'App\\Completedactivity', NULL, NULL, NULL, 1, 1, '{"order_column":"pupil_id","order_display_column":"pupil_id","order_direction":"asc","default_search_key":"pupil_id","scope":null}', '2020-01-01 21:03:09', '2020-01-02 20:06:18'),
	(10, 'classrooms', 'classrooms', 'Classroom', 'Classrooms', 'voyager-study', 'App\\Classroom', NULL, NULL, NULL, 1, 1, '{"order_column":null,"order_display_column":null,"order_direction":"asc","default_search_key":null}', '2020-01-01 21:16:21', '2020-01-01 21:16:21'),
	(11, 'activities', 'activities', 'Activity', 'Activities', 'voyager-activity', 'App\\Activity', NULL, NULL, NULL, 1, 1, '{"order_column":null,"order_display_column":null,"order_direction":"asc","default_search_key":null,"scope":null}', '2020-01-01 21:34:46', '2020-01-01 22:21:09');
/*!40000 ALTER TABLE `data_types` ENABLE KEYS */;

-- Dumping structure for table oracybox.failed_jobs
CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table oracybox.failed_jobs: ~0 rows (approximately)
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;

-- Dumping structure for table oracybox.menus
CREATE TABLE IF NOT EXISTS `menus` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `menus_name_unique` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table oracybox.menus: ~2 rows (approximately)
/*!40000 ALTER TABLE `menus` DISABLE KEYS */;
INSERT INTO `menus` (`id`, `name`, `created_at`, `updated_at`) VALUES
	(1, 'admin', '2019-12-23 21:10:41', '2019-12-23 21:10:41'),
	(2, 'main', '2019-12-27 20:23:41', '2019-12-27 20:23:41');
/*!40000 ALTER TABLE `menus` ENABLE KEYS */;

-- Dumping structure for table oracybox.menu_items
CREATE TABLE IF NOT EXISTS `menu_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `menu_id` int(10) unsigned DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `target` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '_self',
  `icon_class` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `color` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `order` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `route` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parameters` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `menu_items_menu_id_foreign` (`menu_id`),
  CONSTRAINT `menu_items_menu_id_foreign` FOREIGN KEY (`menu_id`) REFERENCES `menus` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table oracybox.menu_items: ~23 rows (approximately)
/*!40000 ALTER TABLE `menu_items` DISABLE KEYS */;
INSERT INTO `menu_items` (`id`, `menu_id`, `title`, `url`, `target`, `icon_class`, `color`, `parent_id`, `order`, `created_at`, `updated_at`, `route`, `parameters`) VALUES
	(1, 1, 'Dashboard', '', '_self', 'voyager-boat', NULL, NULL, 1, '2019-12-23 21:10:41', '2020-01-01 17:34:29', 'voyager.dashboard', NULL),
	(2, 1, 'Media', '', '_self', 'voyager-images', NULL, NULL, 4, '2019-12-23 21:10:41', '2020-01-01 22:22:29', 'voyager.media.index', NULL),
	(3, 1, 'Users', '', '_self', 'voyager-person', NULL, NULL, 3, '2019-12-23 21:10:41', '2020-01-01 22:22:29', 'voyager.users.index', NULL),
	(4, 1, 'Roles', '', '_self', 'voyager-lock', NULL, NULL, 2, '2019-12-23 21:10:41', '2020-01-01 22:22:29', 'voyager.roles.index', NULL),
	(5, 1, 'Tools', '', '_self', 'voyager-tools', NULL, NULL, 7, '2019-12-23 21:10:41', '2020-01-01 22:25:40', NULL, NULL),
	(6, 1, 'Menu Builder', '', '_self', 'voyager-list', NULL, 5, 1, '2019-12-23 21:10:41', '2020-01-01 22:25:40', 'voyager.menus.index', NULL),
	(7, 1, 'Database', '', '_self', 'voyager-data', NULL, 5, 2, '2019-12-23 21:10:41', '2020-01-01 22:25:40', 'voyager.database.index', NULL),
	(8, 1, 'Compass', '', '_self', 'voyager-compass', NULL, 5, 3, '2019-12-23 21:10:41', '2020-01-01 22:25:40', 'voyager.compass.index', NULL),
	(9, 1, 'BREAD', '', '_self', 'voyager-bread', NULL, 5, 4, '2019-12-23 21:10:41', '2020-01-01 22:25:40', 'voyager.bread.index', NULL),
	(10, 1, 'Settings', '', '_self', 'voyager-settings', NULL, NULL, 8, '2019-12-23 21:10:41', '2020-01-01 22:25:40', 'voyager.settings.index', NULL),
	(11, 1, 'Categories', '', '_self', 'voyager-categories', NULL, 26, 3, '2019-12-23 21:10:44', '2020-01-01 22:24:23', 'voyager.categories.index', NULL),
	(12, 1, 'Posts', '', '_self', 'voyager-news', NULL, 26, 2, '2019-12-23 21:10:45', '2020-01-01 22:24:21', 'voyager.posts.index', NULL),
	(13, 1, 'Pages', '', '_self', 'voyager-file-text', NULL, 26, 1, '2019-12-23 21:10:46', '2020-01-01 22:24:17', 'voyager.pages.index', NULL),
	(14, 1, 'Hooks', '', '_self', 'voyager-hook', NULL, 5, 5, '2019-12-23 21:10:47', '2020-01-01 22:25:40', 'voyager.hooks', NULL),
	(15, 2, 'Home', '/', '_self', NULL, '#000000', NULL, 15, '2019-12-27 20:23:59', '2019-12-27 20:23:59', NULL, ''),
	(16, 2, 'About', '/about', '_self', NULL, '#000000', NULL, 16, '2019-12-27 20:24:07', '2019-12-27 21:45:46', NULL, ''),
	(17, 2, 'Contact', '/contact', '_self', NULL, '#000000', NULL, 17, '2019-12-27 20:24:23', '2019-12-27 21:46:02', NULL, ''),
	(18, 2, 'Control Panel', '/admin', '_self', NULL, '#000000', NULL, 18, '2019-12-27 20:26:00', '2019-12-27 21:46:07', NULL, ''),
	(23, 1, 'Completed Activities', '', '_self', 'voyager-activity', NULL, 27, 3, '2020-01-01 21:03:09', '2020-01-01 22:25:31', 'voyager.completedactivities.index', NULL),
	(24, 1, 'Classrooms', '', '_self', 'voyager-study', NULL, 27, 1, '2020-01-01 21:16:21', '2020-01-01 22:25:26', 'voyager.classrooms.index', NULL),
	(25, 1, 'Activities', '', '_self', 'voyager-activity', '#000000', 27, 2, '2020-01-01 21:34:46', '2020-01-01 22:27:52', 'voyager.activities.index', 'null'),
	(26, 1, 'Site Tools', '', '_self', 'voyager-browser', '#000000', NULL, 6, '2020-01-01 22:23:23', '2020-01-01 22:28:27', NULL, ''),
	(27, 1, 'oracybox', '', '_self', 'voyager-chat', '#000000', NULL, 5, '2020-01-01 22:25:20', '2020-01-01 22:27:32', NULL, '');
/*!40000 ALTER TABLE `menu_items` ENABLE KEYS */;

-- Dumping structure for table oracybox.migrations
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=155 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table oracybox.migrations: ~39 rows (approximately)
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
	(1, '2014_10_12_000000_create_users_table', 1),
	(2, '2014_10_12_100000_create_password_resets_table', 1),
	(3, '2016_01_01_000000_add_voyager_user_fields', 1),
	(4, '2016_01_01_000000_create_data_types_table', 1),
	(5, '2016_05_19_173453_create_menu_table', 1),
	(6, '2016_10_21_190000_create_roles_table', 1),
	(7, '2016_10_21_190000_create_settings_table', 1),
	(8, '2016_11_30_135954_create_permission_table', 1),
	(9, '2016_11_30_141208_create_permission_role_table', 1),
	(10, '2016_12_26_201236_data_types__add__server_side', 1),
	(11, '2017_01_13_000000_add_route_to_menu_items_table', 1),
	(12, '2017_01_14_005015_create_translations_table', 1),
	(13, '2017_01_15_000000_make_table_name_nullable_in_permissions_table', 1),
	(14, '2017_03_06_000000_add_controller_to_data_types_table', 1),
	(15, '2017_04_21_000000_add_order_to_data_rows_table', 1),
	(16, '2017_07_05_210000_add_policyname_to_data_types_table', 1),
	(17, '2017_08_05_000000_add_group_to_settings_table', 1),
	(18, '2017_11_26_013050_add_user_role_relationship', 1),
	(19, '2017_11_26_015000_create_user_roles_table', 1),
	(20, '2018_03_11_000000_add_user_settings', 1),
	(21, '2018_03_14_000000_add_details_to_data_types_table', 1),
	(22, '2018_03_16_000000_make_settings_value_nullable', 1),
	(137, '2020_01_01_132726_update_users_table', 2),
	(138, '2016_01_01_000000_create_pages_table', 3),
	(139, '2016_01_01_000000_create_posts_table', 3),
	(140, '2016_02_15_204651_create_categories_table', 3),
	(141, '2017_04_11_000000_alter_post_nullable_fields_table', 3),
	(142, '2019_08_19_000000_create_failed_jobs_table', 3),
	(143, '2019_12_31_175515_create_subjects_table', 3),
	(144, '2019_12_31_175525_create_topics_table', 3),
	(145, '2019_12_31_175547_create_activities_table', 3),
	(146, '2019_12_31_175619_create_classrooms_table', 3),
	(147, '2020_01_01_125528_create_completedactivities_table', 3),
	(149, '2020_01_02_184736_update_users_table', 4),
	(150, '2016_06_01_000001_create_oauth_auth_codes_table', 5),
	(151, '2016_06_01_000002_create_oauth_access_tokens_table', 5),
	(152, '2016_06_01_000003_create_oauth_refresh_tokens_table', 5),
	(153, '2016_06_01_000004_create_oauth_clients_table', 5),
	(154, '2016_06_01_000005_create_oauth_personal_access_clients_table', 5);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;

-- Dumping structure for table oracybox.oauth_access_tokens
CREATE TABLE IF NOT EXISTS `oauth_access_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `client_id` int(10) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_access_tokens_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table oracybox.oauth_access_tokens: ~2 rows (approximately)
/*!40000 ALTER TABLE `oauth_access_tokens` DISABLE KEYS */;
INSERT INTO `oauth_access_tokens` (`id`, `user_id`, `client_id`, `name`, `scopes`, `revoked`, `created_at`, `updated_at`, `expires_at`) VALUES
	('8e07b431e0857d70ac26512da51fb6e2d94932bff20346341027a88769f68742017701aafc4fc0d7', 5, 3, 'token', '[]', 0, '2020-01-09 11:54:10', '2020-01-09 11:54:10', '2021-01-09 11:54:10'),
	('935408770e654b98f1eac5b0a55cc6e891312d2903570ab0767e416331cc3fbb735c7075e7d7650f', 5, 3, 'token', '[]', 0, '2020-01-09 14:11:51', '2020-01-09 14:11:51', '2021-01-09 14:11:51');
/*!40000 ALTER TABLE `oauth_access_tokens` ENABLE KEYS */;

-- Dumping structure for table oracybox.oauth_auth_codes
CREATE TABLE IF NOT EXISTS `oauth_auth_codes` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `client_id` int(10) unsigned NOT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table oracybox.oauth_auth_codes: ~0 rows (approximately)
/*!40000 ALTER TABLE `oauth_auth_codes` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_auth_codes` ENABLE KEYS */;

-- Dumping structure for table oracybox.oauth_clients
CREATE TABLE IF NOT EXISTS `oauth_clients` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `redirect` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_clients_user_id_index` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table oracybox.oauth_clients: ~4 rows (approximately)
/*!40000 ALTER TABLE `oauth_clients` DISABLE KEYS */;
INSERT INTO `oauth_clients` (`id`, `user_id`, `name`, `secret`, `redirect`, `personal_access_client`, `password_client`, `revoked`, `created_at`, `updated_at`) VALUES
	(1, NULL, 'oracybox Personal Access Client', 'fEPYCyA6GLk9gxIEir7dRRCiGjba3vQ21AH1B8ba', 'http://localhost', 1, 0, 0, '2020-01-09 10:45:55', '2020-01-09 10:45:55'),
	(2, NULL, 'oracybox Password Grant Client', 'DR27LmfOVpai5cskJ53gSGFoVWhjsnH2G5XyTSFD', 'http://localhost', 0, 1, 0, '2020-01-09 10:45:55', '2020-01-09 10:45:55'),
	(3, NULL, 'oracybox Personal Access Client', 'XHRq9z5H45uQvCP0XE8GhP4HZbrwztfCJdnln8Ze', 'http://localhost', 1, 0, 0, '2020-01-09 11:11:21', '2020-01-09 11:11:21'),
	(4, NULL, 'oracybox Password Grant Client', 'cQ0oq1zrKa4x1nQ8IRvoXJYrrZAqr43gw8JOjjsX', 'http://localhost', 0, 1, 0, '2020-01-09 11:11:21', '2020-01-09 11:11:21');
/*!40000 ALTER TABLE `oauth_clients` ENABLE KEYS */;

-- Dumping structure for table oracybox.oauth_personal_access_clients
CREATE TABLE IF NOT EXISTS `oauth_personal_access_clients` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `client_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_personal_access_clients_client_id_index` (`client_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table oracybox.oauth_personal_access_clients: ~2 rows (approximately)
/*!40000 ALTER TABLE `oauth_personal_access_clients` DISABLE KEYS */;
INSERT INTO `oauth_personal_access_clients` (`id`, `client_id`, `created_at`, `updated_at`) VALUES
	(1, 1, '2020-01-09 10:45:55', '2020-01-09 10:45:55'),
	(2, 3, '2020-01-09 11:11:21', '2020-01-09 11:11:21');
/*!40000 ALTER TABLE `oauth_personal_access_clients` ENABLE KEYS */;

-- Dumping structure for table oracybox.oauth_refresh_tokens
CREATE TABLE IF NOT EXISTS `oauth_refresh_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table oracybox.oauth_refresh_tokens: ~0 rows (approximately)
/*!40000 ALTER TABLE `oauth_refresh_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_refresh_tokens` ENABLE KEYS */;

-- Dumping structure for table oracybox.pages
CREATE TABLE IF NOT EXISTS `pages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `author_id` int(11) NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `excerpt` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `body` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `meta_description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_keywords` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('ACTIVE','INACTIVE') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'INACTIVE',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pages_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table oracybox.pages: ~1 rows (approximately)
/*!40000 ALTER TABLE `pages` DISABLE KEYS */;
INSERT INTO `pages` (`id`, `author_id`, `title`, `excerpt`, `body`, `image`, `slug`, `meta_description`, `meta_keywords`, `status`, `created_at`, `updated_at`) VALUES
	(1, 1, 'About', 'What we do.', '<p>Lorem Ipsum...</p>', 'pages/about-bg.jpg', 'about', 'About page', 'about', 'INACTIVE', '2020-01-01 22:33:16', '2020-01-01 22:33:16');
/*!40000 ALTER TABLE `pages` ENABLE KEYS */;

-- Dumping structure for table oracybox.password_resets
CREATE TABLE IF NOT EXISTS `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table oracybox.password_resets: ~0 rows (approximately)
/*!40000 ALTER TABLE `password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;

-- Dumping structure for table oracybox.permissions
CREATE TABLE IF NOT EXISTS `permissions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `table_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `permissions_key_index` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table oracybox.permissions: ~56 rows (approximately)
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
INSERT INTO `permissions` (`id`, `key`, `table_name`, `created_at`, `updated_at`) VALUES
	(1, 'browse_admin', NULL, '2019-12-23 21:10:41', '2019-12-23 21:10:41'),
	(2, 'browse_bread', NULL, '2019-12-23 21:10:42', '2019-12-23 21:10:42'),
	(3, 'browse_database', NULL, '2019-12-23 21:10:42', '2019-12-23 21:10:42'),
	(4, 'browse_media', NULL, '2019-12-23 21:10:42', '2019-12-23 21:10:42'),
	(5, 'browse_compass', NULL, '2019-12-23 21:10:42', '2019-12-23 21:10:42'),
	(6, 'browse_menus', 'menus', '2019-12-23 21:10:42', '2019-12-23 21:10:42'),
	(7, 'read_menus', 'menus', '2019-12-23 21:10:42', '2019-12-23 21:10:42'),
	(8, 'edit_menus', 'menus', '2019-12-23 21:10:42', '2019-12-23 21:10:42'),
	(9, 'add_menus', 'menus', '2019-12-23 21:10:42', '2019-12-23 21:10:42'),
	(10, 'delete_menus', 'menus', '2019-12-23 21:10:42', '2019-12-23 21:10:42'),
	(11, 'browse_roles', 'roles', '2019-12-23 21:10:42', '2019-12-23 21:10:42'),
	(12, 'read_roles', 'roles', '2019-12-23 21:10:42', '2019-12-23 21:10:42'),
	(13, 'edit_roles', 'roles', '2019-12-23 21:10:42', '2019-12-23 21:10:42'),
	(14, 'add_roles', 'roles', '2019-12-23 21:10:42', '2019-12-23 21:10:42'),
	(15, 'delete_roles', 'roles', '2019-12-23 21:10:42', '2019-12-23 21:10:42'),
	(16, 'browse_users', 'users', '2019-12-23 21:10:42', '2019-12-23 21:10:42'),
	(17, 'read_users', 'users', '2019-12-23 21:10:42', '2019-12-23 21:10:42'),
	(18, 'edit_users', 'users', '2019-12-23 21:10:42', '2019-12-23 21:10:42'),
	(19, 'add_users', 'users', '2019-12-23 21:10:42', '2019-12-23 21:10:42'),
	(20, 'delete_users', 'users', '2019-12-23 21:10:42', '2019-12-23 21:10:42'),
	(21, 'browse_settings', 'settings', '2019-12-23 21:10:42', '2019-12-23 21:10:42'),
	(22, 'read_settings', 'settings', '2019-12-23 21:10:42', '2019-12-23 21:10:42'),
	(23, 'edit_settings', 'settings', '2019-12-23 21:10:42', '2019-12-23 21:10:42'),
	(24, 'add_settings', 'settings', '2019-12-23 21:10:42', '2019-12-23 21:10:42'),
	(25, 'delete_settings', 'settings', '2019-12-23 21:10:42', '2019-12-23 21:10:42'),
	(26, 'browse_categories', 'categories', '2019-12-23 21:10:44', '2019-12-23 21:10:44'),
	(27, 'read_categories', 'categories', '2019-12-23 21:10:44', '2019-12-23 21:10:44'),
	(28, 'edit_categories', 'categories', '2019-12-23 21:10:45', '2019-12-23 21:10:45'),
	(29, 'add_categories', 'categories', '2019-12-23 21:10:45', '2019-12-23 21:10:45'),
	(30, 'delete_categories', 'categories', '2019-12-23 21:10:45', '2019-12-23 21:10:45'),
	(31, 'browse_posts', 'posts', '2019-12-23 21:10:45', '2019-12-23 21:10:45'),
	(32, 'read_posts', 'posts', '2019-12-23 21:10:45', '2019-12-23 21:10:45'),
	(33, 'edit_posts', 'posts', '2019-12-23 21:10:45', '2019-12-23 21:10:45'),
	(34, 'add_posts', 'posts', '2019-12-23 21:10:45', '2019-12-23 21:10:45'),
	(35, 'delete_posts', 'posts', '2019-12-23 21:10:45', '2019-12-23 21:10:45'),
	(36, 'browse_pages', 'pages', '2019-12-23 21:10:46', '2019-12-23 21:10:46'),
	(37, 'read_pages', 'pages', '2019-12-23 21:10:46', '2019-12-23 21:10:46'),
	(38, 'edit_pages', 'pages', '2019-12-23 21:10:46', '2019-12-23 21:10:46'),
	(39, 'add_pages', 'pages', '2019-12-23 21:10:46', '2019-12-23 21:10:46'),
	(40, 'delete_pages', 'pages', '2019-12-23 21:10:46', '2019-12-23 21:10:46'),
	(41, 'browse_hooks', NULL, '2019-12-23 21:10:47', '2019-12-23 21:10:47'),
	(52, 'browse_completedactivities', 'completedactivities', '2020-01-01 21:03:09', '2020-01-01 21:03:09'),
	(53, 'read_completedactivities', 'completedactivities', '2020-01-01 21:03:09', '2020-01-01 21:03:09'),
	(54, 'edit_completedactivities', 'completedactivities', '2020-01-01 21:03:09', '2020-01-01 21:03:09'),
	(55, 'add_completedactivities', 'completedactivities', '2020-01-01 21:03:09', '2020-01-01 21:03:09'),
	(56, 'delete_completedactivities', 'completedactivities', '2020-01-01 21:03:09', '2020-01-01 21:03:09'),
	(57, 'browse_classrooms', 'classrooms', '2020-01-01 21:16:21', '2020-01-01 21:16:21'),
	(58, 'read_classrooms', 'classrooms', '2020-01-01 21:16:21', '2020-01-01 21:16:21'),
	(59, 'edit_classrooms', 'classrooms', '2020-01-01 21:16:21', '2020-01-01 21:16:21'),
	(60, 'add_classrooms', 'classrooms', '2020-01-01 21:16:21', '2020-01-01 21:16:21'),
	(61, 'delete_classrooms', 'classrooms', '2020-01-01 21:16:21', '2020-01-01 21:16:21'),
	(62, 'browse_activities', 'activities', '2020-01-01 21:34:46', '2020-01-01 21:34:46'),
	(63, 'read_activities', 'activities', '2020-01-01 21:34:46', '2020-01-01 21:34:46'),
	(64, 'edit_activities', 'activities', '2020-01-01 21:34:46', '2020-01-01 21:34:46'),
	(65, 'add_activities', 'activities', '2020-01-01 21:34:46', '2020-01-01 21:34:46'),
	(66, 'delete_activities', 'activities', '2020-01-01 21:34:46', '2020-01-01 21:34:46');
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;

-- Dumping structure for table oracybox.permission_role
CREATE TABLE IF NOT EXISTS `permission_role` (
  `permission_id` bigint(20) unsigned NOT NULL,
  `role_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`),
  KEY `permission_role_permission_id_index` (`permission_id`),
  KEY `permission_role_role_id_index` (`role_id`),
  CONSTRAINT `permission_role_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `permission_role_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table oracybox.permission_role: ~77 rows (approximately)
/*!40000 ALTER TABLE `permission_role` DISABLE KEYS */;
INSERT INTO `permission_role` (`permission_id`, `role_id`) VALUES
	(1, 1),
	(1, 2),
	(1, 3),
	(2, 1),
	(3, 1),
	(4, 1),
	(5, 1),
	(6, 1),
	(7, 1),
	(8, 1),
	(9, 1),
	(10, 1),
	(11, 1),
	(12, 1),
	(13, 1),
	(14, 1),
	(15, 1),
	(16, 1),
	(16, 2),
	(17, 1),
	(17, 2),
	(18, 1),
	(18, 2),
	(19, 1),
	(19, 2),
	(20, 1),
	(20, 2),
	(21, 1),
	(22, 1),
	(23, 1),
	(24, 1),
	(25, 1),
	(26, 1),
	(27, 1),
	(28, 1),
	(29, 1),
	(30, 1),
	(31, 1),
	(32, 1),
	(33, 1),
	(34, 1),
	(35, 1),
	(36, 1),
	(37, 1),
	(38, 1),
	(39, 1),
	(40, 1),
	(52, 1),
	(52, 2),
	(53, 1),
	(53, 2),
	(54, 1),
	(54, 2),
	(55, 1),
	(55, 2),
	(56, 1),
	(56, 2),
	(57, 1),
	(57, 2),
	(58, 1),
	(58, 2),
	(59, 1),
	(59, 2),
	(60, 1),
	(60, 2),
	(61, 1),
	(61, 2),
	(62, 1),
	(62, 2),
	(63, 1),
	(63, 2),
	(64, 1),
	(64, 2),
	(65, 1),
	(65, 2),
	(66, 1),
	(66, 2);
/*!40000 ALTER TABLE `permission_role` ENABLE KEYS */;

-- Dumping structure for table oracybox.posts
CREATE TABLE IF NOT EXISTS `posts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `author_id` int(11) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `seo_title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `excerpt` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `body` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `meta_description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_keywords` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('PUBLISHED','DRAFT','PENDING') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'DRAFT',
  `featured` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `posts_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table oracybox.posts: ~1 rows (approximately)
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` (`id`, `author_id`, `category_id`, `title`, `seo_title`, `excerpt`, `body`, `image`, `slug`, `meta_description`, `meta_keywords`, `status`, `featured`, `created_at`, `updated_at`) VALUES
	(1, 1, 1, 'Post 1', NULL, 'Lorem...', '<p>Lorem Ipsum...</p>', NULL, 'post-1', NULL, NULL, 'PUBLISHED', 1, '2020-01-01 21:17:22', '2020-01-01 21:17:22');
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;

-- Dumping structure for table oracybox.roles
CREATE TABLE IF NOT EXISTS `roles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_name_unique` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table oracybox.roles: ~3 rows (approximately)
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` (`id`, `name`, `display_name`, `created_at`, `updated_at`) VALUES
	(1, 'admin', 'Administrator', '2019-12-23 21:10:41', '2019-12-23 21:10:41'),
	(2, 'teacher', 'Teacher', '2019-12-23 21:10:41', '2019-12-23 21:19:55'),
	(3, 'pupil', 'Pupil', '2019-12-23 21:20:59', '2019-12-23 21:20:59');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;

-- Dumping structure for table oracybox.settings
CREATE TABLE IF NOT EXISTS `settings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `details` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `order` int(11) NOT NULL DEFAULT 1,
  `group` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `settings_key_unique` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table oracybox.settings: ~10 rows (approximately)
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
INSERT INTO `settings` (`id`, `key`, `display_name`, `value`, `details`, `type`, `order`, `group`) VALUES
	(1, 'site.title', 'Site Title', 'oracybox', '', 'text', 1, 'Site'),
	(2, 'site.description', 'Site Description', 'Learning Oracy has never been easier', '', 'text', 2, 'Site'),
	(3, 'site.logo', 'Site Logo', '', '', 'image', 3, 'Site'),
	(4, 'site.google_analytics_tracking_id', 'Google Analytics Tracking ID', NULL, '', 'text', 4, 'Site'),
	(5, 'admin.bg_image', 'Admin Background Image', '', '', 'image', 5, 'Admin'),
	(6, 'admin.title', 'Admin Title', 'oracybox', '', 'text', 1, 'Admin'),
	(7, 'admin.description', 'Admin Description', 'Control Panel', '', 'text', 2, 'Admin'),
	(8, 'admin.loader', 'Admin Loader', '', '', 'image', 3, 'Admin'),
	(9, 'admin.icon_image', 'Admin Icon Image', '', '', 'image', 4, 'Admin'),
	(10, 'admin.google_analytics_client_id', 'Google Analytics Client ID (used for admin dashboard)', NULL, '', 'text', 1, 'Admin');
/*!40000 ALTER TABLE `settings` ENABLE KEYS */;

-- Dumping structure for table oracybox.subjects
CREATE TABLE IF NOT EXISTS `subjects` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table oracybox.subjects: ~6 rows (approximately)
/*!40000 ALTER TABLE `subjects` DISABLE KEYS */;
INSERT INTO `subjects` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES
	(1, 'Language, Literacy and Communication', 'Lorem...', '2020-01-01 21:39:16', '2020-01-01 21:39:17'),
	(2, 'Mathematics and Numeracy', 'Lorem...', '2020-01-01 21:43:15', '2020-01-01 21:43:16'),
	(3, 'Science and Technology', 'Lorem...', '2020-01-01 21:43:17', '2020-01-01 21:43:18'),
	(4, 'Humanities', 'Lorem...', '2020-01-01 21:43:18', '2020-01-01 21:43:19'),
	(5, 'Health and Wellbeing', 'Lorem...', '2020-01-01 21:43:19', '2020-01-01 21:43:20'),
	(6, 'Expressive Arts', 'Lorem...', '2020-01-01 21:43:20', '2020-01-01 21:43:21');
/*!40000 ALTER TABLE `subjects` ENABLE KEYS */;

-- Dumping structure for table oracybox.topics
CREATE TABLE IF NOT EXISTS `topics` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `subject_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `topics_subject_id_foreign` (`subject_id`),
  CONSTRAINT `topics_subject_id_foreign` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table oracybox.topics: ~1 rows (approximately)
/*!40000 ALTER TABLE `topics` DISABLE KEYS */;
INSERT INTO `topics` (`id`, `subject_id`, `name`, `description`, `created_at`, `updated_at`) VALUES
	(1, 5, 'Physical Activity', 'Lorem...', '2020-01-01 21:43:09', '2020-01-01 21:43:10');
/*!40000 ALTER TABLE `topics` ENABLE KEYS */;

-- Dumping structure for table oracybox.translations
CREATE TABLE IF NOT EXISTS `translations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `table_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `column_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `foreign_key` int(10) unsigned NOT NULL,
  `locale` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `translations_table_name_column_name_foreign_key_locale_unique` (`table_name`,`column_name`,`foreign_key`,`locale`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table oracybox.translations: ~30 rows (approximately)
/*!40000 ALTER TABLE `translations` DISABLE KEYS */;
INSERT INTO `translations` (`id`, `table_name`, `column_name`, `foreign_key`, `locale`, `value`, `created_at`, `updated_at`) VALUES
	(1, 'data_types', 'display_name_singular', 5, 'pt', 'Post', '2019-12-23 21:10:46', '2019-12-23 21:10:46'),
	(2, 'data_types', 'display_name_singular', 6, 'pt', 'Página', '2019-12-23 21:10:46', '2019-12-23 21:10:46'),
	(3, 'data_types', 'display_name_singular', 1, 'pt', 'Utilizador', '2019-12-23 21:10:46', '2019-12-23 21:10:46'),
	(4, 'data_types', 'display_name_singular', 4, 'pt', 'Categoria', '2019-12-23 21:10:46', '2019-12-23 21:10:46'),
	(5, 'data_types', 'display_name_singular', 2, 'pt', 'Menu', '2019-12-23 21:10:46', '2019-12-23 21:10:46'),
	(6, 'data_types', 'display_name_singular', 3, 'pt', 'Função', '2019-12-23 21:10:46', '2019-12-23 21:10:46'),
	(7, 'data_types', 'display_name_plural', 5, 'pt', 'Posts', '2019-12-23 21:10:46', '2019-12-23 21:10:46'),
	(8, 'data_types', 'display_name_plural', 6, 'pt', 'Páginas', '2019-12-23 21:10:46', '2019-12-23 21:10:46'),
	(9, 'data_types', 'display_name_plural', 1, 'pt', 'Utilizadores', '2019-12-23 21:10:46', '2019-12-23 21:10:46'),
	(10, 'data_types', 'display_name_plural', 4, 'pt', 'Categorias', '2019-12-23 21:10:46', '2019-12-23 21:10:46'),
	(11, 'data_types', 'display_name_plural', 2, 'pt', 'Menus', '2019-12-23 21:10:46', '2019-12-23 21:10:46'),
	(12, 'data_types', 'display_name_plural', 3, 'pt', 'Funções', '2019-12-23 21:10:46', '2019-12-23 21:10:46'),
	(13, 'categories', 'slug', 1, 'pt', 'categoria-1', '2019-12-23 21:10:46', '2019-12-23 21:10:46'),
	(14, 'categories', 'name', 1, 'pt', 'Categoria 1', '2019-12-23 21:10:46', '2019-12-23 21:10:46'),
	(15, 'categories', 'slug', 2, 'pt', 'categoria-2', '2019-12-23 21:10:46', '2019-12-23 21:10:46'),
	(16, 'categories', 'name', 2, 'pt', 'Categoria 2', '2019-12-23 21:10:46', '2019-12-23 21:10:46'),
	(17, 'pages', 'title', 1, 'pt', 'Olá Mundo', '2019-12-23 21:10:46', '2019-12-23 21:10:46'),
	(18, 'pages', 'slug', 1, 'pt', 'ola-mundo', '2019-12-23 21:10:46', '2019-12-23 21:10:46'),
	(19, 'pages', 'body', 1, 'pt', '<p>Olá Mundo. Scallywag grog swab Cat o\'nine tails scuttle rigging hardtack cable nipper Yellow Jack. Handsomely spirits knave lad killick landlubber or just lubber deadlights chantey pinnace crack Jennys tea cup. Provost long clothes black spot Yellow Jack bilged on her anchor league lateen sail case shot lee tackle.</p>\r\n<p>Ballast spirits fluke topmast me quarterdeck schooner landlubber or just lubber gabion belaying pin. Pinnace stern galleon starboard warp carouser to go on account dance the hempen jig jolly boat measured fer yer chains. Man-of-war fire in the hole nipperkin handsomely doubloon barkadeer Brethren of the Coast gibbet driver squiffy.</p>', '2019-12-23 21:10:47', '2019-12-23 21:10:47'),
	(20, 'menu_items', 'title', 1, 'pt', 'Painel de Controle', '2019-12-23 21:10:47', '2019-12-23 21:10:47'),
	(21, 'menu_items', 'title', 2, 'pt', 'Media', '2019-12-23 21:10:47', '2019-12-23 21:10:47'),
	(22, 'menu_items', 'title', 12, 'pt', 'Publicações', '2019-12-23 21:10:47', '2019-12-23 21:10:47'),
	(23, 'menu_items', 'title', 3, 'pt', 'Utilizadores', '2019-12-23 21:10:47', '2019-12-23 21:10:47'),
	(24, 'menu_items', 'title', 11, 'pt', 'Categorias', '2019-12-23 21:10:47', '2019-12-23 21:10:47'),
	(25, 'menu_items', 'title', 13, 'pt', 'Páginas', '2019-12-23 21:10:47', '2019-12-23 21:10:47'),
	(26, 'menu_items', 'title', 4, 'pt', 'Funções', '2019-12-23 21:10:47', '2019-12-23 21:10:47'),
	(27, 'menu_items', 'title', 5, 'pt', 'Ferramentas', '2019-12-23 21:10:47', '2019-12-23 21:10:47'),
	(28, 'menu_items', 'title', 6, 'pt', 'Menus', '2019-12-23 21:10:47', '2019-12-23 21:10:47'),
	(29, 'menu_items', 'title', 7, 'pt', 'Base de dados', '2019-12-23 21:10:47', '2019-12-23 21:10:47'),
	(30, 'menu_items', 'title', 10, 'pt', 'Configurações', '2019-12-23 21:10:47', '2019-12-23 21:10:47');
/*!40000 ALTER TABLE `translations` ENABLE KEYS */;

-- Dumping structure for table oracybox.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'users/default.png',
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `settings` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `classroom_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  KEY `users_role_id_foreign` (`role_id`),
  KEY `users_classroom_id_foreign` (`classroom_id`),
  CONSTRAINT `users_classroom_id_foreign` FOREIGN KEY (`classroom_id`) REFERENCES `classrooms` (`id`),
  CONSTRAINT `users_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table oracybox.users: ~5 rows (approximately)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `role_id`, `name`, `email`, `avatar`, `email_verified_at`, `password`, `remember_token`, `settings`, `created_at`, `updated_at`, `classroom_id`) VALUES
	(1, 1, 'Admin', 'admin@admin.com', 'users/default.png', NULL, '$2y$10$X0.rP3ffujXWZuYhCkCAgezmnQqqUEQ3KnXvUX8r5J6pvTuYWjOiW', 'XcZylrQ1Wl7xyXK9MRbLNAnArZhePCJtp6TwBRhKJTBPV7jNXymSnUTYEY7L', NULL, '2019-12-23 21:10:45', '2019-12-23 21:10:45', 1),
	(2, 2, 'Teacher', 'teacher@teacher.com', 'users/default.png', NULL, '$2y$10$5QBeLgga9vsE0eCInhAF8.VkJ857X2uoEUf1MaRKcRLp4TsofcUU6', NULL, '{"locale":"en"}', '2019-12-23 21:20:17', '2019-12-23 21:20:17', 1),
	(3, 3, 'Pupil', 'pupil@pupil.com', 'users/default.png', NULL, '$2y$10$WzYss6N6Vscua1S/lxrXPO184AudImj58J4gM7bt5i1iC0NayPZw6', NULL, '{"locale":"en"}', '2019-12-23 21:20:38', '2019-12-23 21:21:09', 1),
	(4, 3, 'Pupil 2', 'pupil2@pupil.com', 'users/default.png', NULL, '$2y$10$TO0gEaSdwALJbPzcGOX1BO1t.NDokktgO3XlZPhL1Y5O5ygs3Rr2y', NULL, '{"locale":"en"}', '2020-01-02 20:29:23', '2020-01-02 20:29:23', NULL),
	(5, NULL, 'API Test', 'test@api.com', 'users/default.png', NULL, '$2y$10$mtF8jjmZI5Pt22CCX6BgCe.l0N8Rjl.jNoJ1c9Ds9W5K.KkaZVw6.', NULL, NULL, '2020-01-09 11:52:28', '2020-01-09 11:52:28', 1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

-- Dumping structure for table oracybox.user_roles
CREATE TABLE IF NOT EXISTS `user_roles` (
  `user_id` bigint(20) unsigned NOT NULL,
  `role_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`),
  KEY `user_roles_user_id_index` (`user_id`),
  KEY `user_roles_role_id_index` (`role_id`),
  CONSTRAINT `user_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `user_roles_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table oracybox.user_roles: ~0 rows (approximately)
/*!40000 ALTER TABLE `user_roles` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_roles` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
