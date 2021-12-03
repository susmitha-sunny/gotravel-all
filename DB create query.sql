CREATE DATABASE `gotravel` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

CREATE TABLE `admin` (
  `admin_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`admin_id`),
  UNIQUE KEY `admin_id_UNIQUE` (`admin_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `airline` (
  `airline_id` int NOT NULL AUTO_INCREMENT,
  `airline_name` varchar(45) NOT NULL,
  `iata_code` varchar(45) DEFAULT NULL,
  `airline_status` enum('ACTIVE','INACTIVE') NOT NULL DEFAULT 'ACTIVE',
  PRIMARY KEY (`airline_id`),
  UNIQUE KEY `airline_id_UNIQUE` (`airline_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `coupon` (
  `coupon_id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(45) NOT NULL,
  `discount_percent` decimal(10,0) NOT NULL,
  PRIMARY KEY (`coupon_id`),
  UNIQUE KEY `coupon_id_UNIQUE` (`coupon_id`),
  UNIQUE KEY `code_UNIQUE` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `flight` (
  `flight_id` int NOT NULL AUTO_INCREMENT,
  `airline_id` int NOT NULL,
  `flight_number` varchar(45) DEFAULT NULL,
  `business_seat_count` int DEFAULT NULL,
  `economy_seat_count` int DEFAULT NULL,
  `meal` enum('NONE','VEG','NONVEG','BOTH') DEFAULT 'NONE',
  PRIMARY KEY (`flight_id`),
  UNIQUE KEY `flight_id_UNIQUE` (`flight_id`),
  KEY `airline_id_idx` (`airline_id`),
  CONSTRAINT `airline_id` FOREIGN KEY (`airline_id`) REFERENCES `airline` (`airline_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `passenger` (
  `passenger_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(45) DEFAULT NULL,
  `middle_name` varchar(45) DEFAULT NULL,
  `last_name` varchar(45) DEFAULT NULL,
  `gender` enum('M','F','O') DEFAULT NULL,
  `passenger_type` enum('ADT','CHD','INF') DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `seat_number` int DEFAULT NULL,
  `meal_preference` enum('ANY','VEG','NONVEG') DEFAULT 'ANY',
  `ticket_number` varchar(45) NOT NULL,
  `pnr` varchar(10) NOT NULL,
  `return_seat_number` int DEFAULT NULL,
  PRIMARY KEY (`passenger_id`),
  UNIQUE KEY `passenger_id_UNIQUE` (`passenger_id`),
  KEY `pnr_idx` (`pnr`),
  CONSTRAINT `pnr` FOREIGN KEY (`pnr`) REFERENCES `reservation` (`pnr`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `reservation` (
  `booking_id` int NOT NULL AUTO_INCREMENT,
  `pnr` varchar(10) NOT NULL,
  `email_id` varchar(100) NOT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `booking_status` enum('ACTIVE','PAST','CANCELLED') DEFAULT 'ACTIVE',
  `flight_id` int DEFAULT NULL,
  `airline_name` varchar(45) DEFAULT NULL,
  `flight_number` varchar(45) DEFAULT NULL,
  `iata_code` varchar(45) DEFAULT NULL,
  `departure_airport` varchar(45) DEFAULT NULL,
  `arrival_airport` varchar(45) DEFAULT NULL,
  `departure_date` date DEFAULT NULL,
  `departure_time` time DEFAULT NULL,
  `arrival_time` time DEFAULT NULL,
  `duration` time DEFAULT NULL,
  `trip_type` enum('OW','RT') DEFAULT 'OW',
  `adult_count` int DEFAULT NULL,
  `child_count` int DEFAULT NULL,
  `infant_count` int DEFAULT NULL,
  `total_fare` decimal(10,0) DEFAULT NULL,
  `return_flight_id` int DEFAULT NULL,
  `return_airline_name` varchar(45) DEFAULT NULL,
  `return_flight_number` varchar(45) DEFAULT NULL,
  `return_iata_code` varchar(45) DEFAULT NULL,
  `return_date` date DEFAULT NULL,
  `return_departure_time` time DEFAULT NULL,
  `return_arrival_time` time DEFAULT NULL,
  `return_duration` time DEFAULT NULL,
  PRIMARY KEY (`booking_id`),
  UNIQUE KEY `booking_id_UNIQUE` (`booking_id`),
  UNIQUE KEY `pnr_UNIQUE` (`pnr`),
  KEY `flight_id_idx` (`flight_id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `schedule` (
  `schedule_id` int NOT NULL AUTO_INCREMENT,
  `flight_id` int NOT NULL,
  `departure_airport` varchar(45) DEFAULT NULL,
  `arrival_airport` varchar(45) DEFAULT NULL,
  `departure_time` time DEFAULT NULL,
  `arrival_time` time DEFAULT NULL,
  `duration` time DEFAULT NULL,
  `fare` decimal(10,0) DEFAULT NULL,
  `days` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`schedule_id`),
  UNIQUE KEY `schedule_id_UNIQUE` (`schedule_id`),
  KEY `flight_id_idx` (`flight_id`),
  CONSTRAINT `flight_id` FOREIGN KEY (`flight_id`) REFERENCES `flight` (`flight_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
