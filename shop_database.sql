/*
 Navicat Premium Data Transfer

 Source Server         : PK
 Source Server Type    : MySQL
 Source Server Version : 100509
 Source Host           : localhost:3306
 Source Schema         : projekt

 Target Server Type    : MySQL
 Target Server Version : 100509
 File Encoding         : 65001

 Date: 01/05/2021 00:08:13
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for images
-- ----------------------------
DROP TABLE IF EXISTS `images`;
CREATE TABLE `images`  (
  `image_ID` int NOT NULL AUTO_INCREMENT,
  `image` blob NULL,
  PRIMARY KEY (`image_ID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of images
-- ----------------------------

-- ----------------------------
-- Table structure for opinions
-- ----------------------------
DROP TABLE IF EXISTS `opinions`;
CREATE TABLE `opinions`  (
  `opinion_ID` int NOT NULL AUTO_INCREMENT,
  `user_ID` int NOT NULL,
  `product_ID` int NOT NULL,
  `rate` float UNSIGNED NOT NULL,
  `modified_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `comment` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `added_at` timestamp NOT NULL DEFAULT current_timestamp,
  PRIMARY KEY (`opinion_ID`) USING BTREE,
  INDEX `user_ID`(`user_ID`) USING BTREE,
  INDEX `product_ID`(`product_ID`) USING BTREE,
  CONSTRAINT `opinions_ibfk_1` FOREIGN KEY (`user_ID`) REFERENCES `users` (`user_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `opinions_ibfk_2` FOREIGN KEY (`product_ID`) REFERENCES `products` (`product_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of opinions
-- ----------------------------
INSERT INTO `opinions` VALUES (1, 13, 8, 0.4, '0000-00-00 00:00:00', 'Piłka nike jest bardzo wytrzymała, kopałem nią trzy dni i trzy noce.', '2021-05-01 00:03:09');
INSERT INTO `opinions` VALUES (2, 13, 9, 0.4, '0000-00-00 00:00:00', 'Rower typu górski fimy KROSS jest meeegaaaa!', '2021-05-01 00:05:40');
INSERT INTO `opinions` VALUES (3, 14, 10, 0.4, '0000-00-00 00:00:00', 'Hulajnoga się złamała! PROSZE O ZWROT PIENIĘDZY!', '2021-05-01 00:05:40');
INSERT INTO `opinions` VALUES (4, 15, 8, 0.4, '0000-00-00 00:00:00', 'Czas oczekiwania na kuriera dłuży się niesamowicie ! Zmieńcie doręczyciela ! Pozatym jest okej.', '2021-05-01 00:05:40');

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `order_ID` int NOT NULL AUTO_INCREMENT,
  `modified_at` timestamp NOT NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  `state` enum('pending','placed','waiting_for_payment','paid','delivered') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'pending',
  `postal_address_ID` int NOT NULL,
  `user_ID` int NOT NULL,
  PRIMARY KEY (`order_ID`) USING BTREE,
  INDEX `orders_ibfk_1`(`postal_address_ID`) USING BTREE,
  INDEX `user_ID`(`user_ID`) USING BTREE,
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`postal_address_ID`) REFERENCES `postal_addresses` (`postal_address_ID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`user_ID`) REFERENCES `users` (`user_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES (2, '2021-04-30 23:18:47', 'pending', 2, 13);
INSERT INTO `orders` VALUES (3, '2021-04-30 23:20:02', 'pending', 3, 14);
INSERT INTO `orders` VALUES (4, '2021-04-30 23:20:14', 'pending', 4, 15);

-- ----------------------------
-- Table structure for orders_products
-- ----------------------------
DROP TABLE IF EXISTS `orders_products`;
CREATE TABLE `orders_products`  (
  `order_ID` int NOT NULL,
  `product_ID` int NOT NULL,
  `quantity` int UNSIGNED NOT NULL,
  INDEX `orders_products_ibfk_1`(`order_ID`) USING BTREE,
  INDEX `orders_products_ibfk_2`(`product_ID`) USING BTREE,
  CONSTRAINT `orders_products_ibfk_1` FOREIGN KEY (`order_ID`) REFERENCES `orders` (`order_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `orders_products_ibfk_2` FOREIGN KEY (`product_ID`) REFERENCES `products` (`product_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orders_products
-- ----------------------------
INSERT INTO `orders_products` VALUES (2, 8, 2);
INSERT INTO `orders_products` VALUES (2, 9, 1);
INSERT INTO `orders_products` VALUES (3, 10, 5);
INSERT INTO `orders_products` VALUES (3, 8, 11);
INSERT INTO `orders_products` VALUES (4, 10, 2);
INSERT INTO `orders_products` VALUES (4, 9, 2);
INSERT INTO `orders_products` VALUES (4, 8, 2);

-- ----------------------------
-- Table structure for postal_addresses
-- ----------------------------
DROP TABLE IF EXISTS `postal_addresses`;
CREATE TABLE `postal_addresses`  (
  `postal_address_ID` int NOT NULL AUTO_INCREMENT,
  `street_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `city` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `zip_code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `country` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `state` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `building_number` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `modified_at` timestamp NOT NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`postal_address_ID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of postal_addresses
-- ----------------------------
INSERT INTO `postal_addresses` VALUES (2, 'Krakowska', 'Krakow', '23-231', 'Poland', NULL, '42/24', '2021-04-30 21:05:42');
INSERT INTO `postal_addresses` VALUES (3, 'Venice Blvd', 'Los Angeles', '90291', 'USA', 'California', '808', '2021-04-30 21:05:42');
INSERT INTO `postal_addresses` VALUES (4, 'Jagodowa', 'Warszawa', '123-123', 'Polska', NULL, '42', '2021-04-30 21:05:42');
INSERT INTO `postal_addresses` VALUES (5, 'Kluczwoda', 'Wierzchowie', '32-231', 'Poland', NULL, '2', '2021-04-30 23:07:34');
INSERT INTO `postal_addresses` VALUES (6, 'Exeter Street', 'Abbotsford', '9018', 'New Zeland', NULL, '13', '2021-04-30 23:10:12');

-- ----------------------------
-- Table structure for products
-- ----------------------------
DROP TABLE IF EXISTS `products`;
CREATE TABLE `products`  (
  `product_ID` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `brand` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `price` decimal(10, 2) UNSIGNED NOT NULL,
  `available_quantity` int UNSIGNED NOT NULL,
  `modified_at` timestamp NOT NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  `descripiton` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `rating` float NULL DEFAULT 0,
  `model` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`product_ID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of products
-- ----------------------------
INSERT INTO `products` VALUES (8, 'Piłka', 'STR124', 50.99, 100, '2021-04-30 20:58:40', 'Piłka ta jest odpowiednia na każdym poziomie sportowym', 0, 'Nike');
INSERT INTO `products` VALUES (9, 'Rower', 'LT2y', 50.99, 100, '2021-04-30 20:58:40', 'Rower przeznaczony do jazdy wysokogórskiej', 0, 'Kross');
INSERT INTO `products` VALUES (10, 'Hulajnoga', 'DECSKATE', 50.99, 100, '2021-04-30 20:58:40', 'Hulajnoga przeznaczona dla prawdziwych skate-erów', 0, 'H102');

-- ----------------------------
-- Table structure for products_images
-- ----------------------------
DROP TABLE IF EXISTS `products_images`;
CREATE TABLE `products_images`  (
  `image_ID` int NOT NULL,
  `product_ID` int NOT NULL,
  INDEX `image_ID`(`image_ID`) USING BTREE,
  INDEX `product_ID`(`product_ID`) USING BTREE,
  CONSTRAINT `products_images_ibfk_1` FOREIGN KEY (`image_ID`) REFERENCES `images` (`image_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `products_images_ibfk_2` FOREIGN KEY (`product_ID`) REFERENCES `products` (`product_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of products_images
-- ----------------------------

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `user_ID` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `surname` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `login` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `email` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `modified_at` timestamp NOT NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  `birth_date` date NOT NULL,
  `age` int NULL DEFAULT (year(curdate()) - year(`birth_date`)),
  PRIMARY KEY (`user_ID`) USING BTREE,
  UNIQUE INDEX `login`(`login`) USING BTREE,
  UNIQUE INDEX `email`(`email`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (13, 'Bruno', 'Żurek', 'żuregogórek', '6f8027f236cbd101f70db9b4bf17549cf42ed9f8', 'bruno.żurek@pk.edu.pl', '2021-04-30 19:58:27', '1995-12-01', 26);
INSERT INTO `users` VALUES (14, 'Łukasz', 'Grudnik', 'Lukas123', 'e77d611634de30e125b58f6fa530ac6d7cce732e', 'lukas@gmail.com', '2021-04-30 19:59:48', '1999-02-14', 22);
INSERT INTO `users` VALUES (15, 'Kamil', 'Kowalski', 'KOWAL999', '97cc4f3a26879a9bd645dd768049b24a9fc8d096', 'kowal.kamil@pk.edu.pl', '2021-04-30 19:59:48', '1995-03-14', 26);
INSERT INTO `users` VALUES (16, 'Małgosia', 'Tracz', 'zcart', 'bc9778d15604697b705835990779137a8016fe7e', 'tracz.gosia@pk.edu.pl', '2021-04-30 19:59:48', '1987-12-01', 34);

-- ----------------------------
-- Table structure for users_postal_addresses
-- ----------------------------
DROP TABLE IF EXISTS `users_postal_addresses`;
CREATE TABLE `users_postal_addresses`  (
  `user_ID` int NOT NULL,
  `postal_address_ID` int NOT NULL,
  INDEX `user_ID`(`user_ID`) USING BTREE,
  INDEX `postal_address_ID`(`postal_address_ID`) USING BTREE,
  CONSTRAINT `users_postal_addresses_ibfk_1` FOREIGN KEY (`user_ID`) REFERENCES `users` (`user_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `users_postal_addresses_ibfk_2` FOREIGN KEY (`postal_address_ID`) REFERENCES `postal_addresses` (`postal_address_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users_postal_addresses
-- ----------------------------
INSERT INTO `users_postal_addresses` VALUES (13, 2);
INSERT INTO `users_postal_addresses` VALUES (14, 3);
INSERT INTO `users_postal_addresses` VALUES (15, 4);
INSERT INTO `users_postal_addresses` VALUES (16, 5);
INSERT INTO `users_postal_addresses` VALUES (14, 6);

-- ----------------------------
-- Procedure structure for add_user
-- ----------------------------
DROP PROCEDURE IF EXISTS `add_user`;
delimiter ;;
CREATE PROCEDURE `add_user`(IN `vimie` VARCHAR(100), IN `vsurname` VARCHAR(100), IN `vlogin` VARCHAR(100), IN `vpassword` VARCHAR(100), IN `vemail` VARCHAR(100), IN `vbirth_date` VARCHAR(100))
BEGIN
	#Routine body goes here...
	INSERT IGNORE INTO users(name, surname, login, password, email, birth_date) VALUES (vname, vsurname, vlogin, vpassword, vemail, vbirth_date);
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for create_product
-- ----------------------------
DROP PROCEDURE IF EXISTS `create_product`;
delimiter ;;
CREATE PROCEDURE `create_product`(IN `vname` VARCHAR(100), IN `vbrand` VARCHAR(100), IN `vprice` DECIMAL(10,2), IN `vavailable_quantity` INT(10), IN `vdescripiton` TEXT)
BEGIN
	#Routine body goes here...
		INSERT INTO products(name, brand, price, available_quantity, descripiton) VALUES (vname, vbrand, vprice, vavailable_quantity, vdescripiton);
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
