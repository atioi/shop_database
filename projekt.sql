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

 Date: 30/04/2021 17:25:59
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `order_ID` int NOT NULL AUTO_INCREMENT,
  `modified_at` timestamp NOT NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  `state` enum('pending','placed','waiting_for_payment','paid','delivered') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'pending',
  `postal_address_ID` int NOT NULL,
  PRIMARY KEY (`order_ID`) USING BTREE,
  INDEX `postal_address_ID`(`postal_address_ID`) USING BTREE,
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`postal_address_ID`) REFERENCES `postal_addresses` (`postal_address_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES (1, '2021-04-30 16:53:19', 'pending', 1);

-- ----------------------------
-- Table structure for orders_products
-- ----------------------------
DROP TABLE IF EXISTS `orders_products`;
CREATE TABLE `orders_products`  (
  `order_ID` int NOT NULL,
  `product_ID` int NOT NULL,
  INDEX `order_ID`(`order_ID`) USING BTREE,
  INDEX `product_ID`(`product_ID`) USING BTREE,
  CONSTRAINT `orders_products_ibfk_1` FOREIGN KEY (`order_ID`) REFERENCES `orders` (`order_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `orders_products_ibfk_2` FOREIGN KEY (`product_ID`) REFERENCES `products` (`product_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orders_products
-- ----------------------------

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
  `number` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `modified_at` timestamp NOT NULL DEFAULT current_timestamp ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`postal_address_ID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of postal_addresses
-- ----------------------------
INSERT INTO `postal_addresses` VALUES (1, 'Kasztanowa', 'Krakow', '12321', 'Poland', NULL, '54', '2021-04-30 16:37:46');

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
  PRIMARY KEY (`product_ID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of products
-- ----------------------------
INSERT INTO `products` VALUES (1, 'Piłka', 'Nike', 12.12, 12, '2021-04-30 16:28:59');

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
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (9, 'Łukasz', 'Grudnik', 'Grudnik123', 'G123#x1321', 'GLukas@gmail.com', '2021-04-30 17:19:46', '1999-01-14', 22);

-- ----------------------------
-- Table structure for users_orders
-- ----------------------------
DROP TABLE IF EXISTS `users_orders`;
CREATE TABLE `users_orders`  (
  `user_ID` int NOT NULL,
  `order_ID` int NOT NULL,
  INDEX `user_ID`(`user_ID`) USING BTREE,
  INDEX `order_ID`(`order_ID`) USING BTREE,
  CONSTRAINT `users_orders_ibfk_1` FOREIGN KEY (`user_ID`) REFERENCES `users` (`user_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `users_orders_ibfk_2` FOREIGN KEY (`order_ID`) REFERENCES `orders` (`order_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users_orders
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
