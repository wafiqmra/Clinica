-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 19, 2025 at 03:58 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `clinica`
--

-- --------------------------------------------------------

--
-- Table structure for table `appointments`
--

CREATE TABLE `appointments` (
  `id` int(11) NOT NULL,
  `doctor_id` int(11) DEFAULT NULL,
  `patient_name` varchar(255) DEFAULT NULL,
  `patient_contact` varchar(255) DEFAULT NULL,
  `appointment_date` datetime DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `reason_for_visit` text DEFAULT NULL,
  `notes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `appointments`
--

INSERT INTO `appointments` (`id`, `doctor_id`, `patient_name`, `patient_contact`, `appointment_date`, `status`, `reason_for_visit`, `notes`) VALUES
(1, 1, 'Ahmad Fauzan', '081234567890', '2025-01-20 10:00:00', 'Scheduled', 'Pemeriksaan Rutin', 'Tidak ada catatan khusus'),
(2, 3, 'Siti Aisyah', '082345678901', '2025-01-20 11:30:00', 'Completed', 'Kontrol Pasca Operasi', 'Pasien dalam kondisi membaik'),
(3, 2, 'Budi Santoso', '083456789012', '2025-01-21 14:00:00', 'Cancelled', 'Konsultasi Umum', 'Dibatalkan karena pasien berhalangan'),
(4, 1, 'Rina Kartika', '084567890123', '2025-01-22 09:00:00', 'Scheduled', 'Pembersihan Gigi', 'Pasien memilih jadwal pagi'),
(5, 2, 'Dewi Lestari', '085678901234', '2025-01-22 15:30:00', 'No-show', 'Ruam Kulit', 'Pasien tidak hadir'),
(6, 3, 'Yusuf Maulana', '086789012345', '2025-01-23 13:00:00', 'Scheduled', 'Konsultasi Umum', 'Kunjungan pertama'),
(7, 1, 'Rahmawati Zain', '087890123456', '2025-01-24 16:45:00', 'Scheduled', 'Pemeriksaan Mata', 'Pasien melaporkan penglihatan kabur'),
(8, 1, 'Fikri Akbar', '081234123456', '2025-01-18 08:30:00', 'Scheduled', 'Pemeriksaan Jantung', 'Pasien memiliki riwayat hipertensi'),
(9, 2, 'Intan Permata', '082345234567', '2025-01-18 10:00:00', 'Scheduled', 'Kontrol Kehamilan', 'Kehamilan trimester kedua'),
(10, 3, 'Dian Lestari', '083456345678', '2025-01-18 11:30:00', 'Scheduled', 'Konsultasi Kulit', 'Pasien melaporkan jerawat membandel'),
(11, 1, 'Rahmat Hidayat', '084567456789', '2025-01-18 14:00:00', 'Scheduled', 'Pemeriksaan Mata', 'Pasien melaporkan penglihatan kabur'),
(12, 2, 'Maya Sari', '085678567890', '2025-01-18 15:30:00', 'Scheduled', 'Pembersihan Gigi', 'Tidak ada keluhan tambahan'),
(13, 2, 'Fijar Rizky Maulana', '081234567890', '2025-01-18 00:00:00', 'Scheduled', 'General Consultation', 'No specific notes'),
(14, 2, 'Fijar Rizky Maulana', '081234567890', '2025-01-18 00:00:00', 'Scheduled', 'General Consultation', 'No specific notes'),
(15, 1, 'Fijar Rizky Maulana', '081234567890', '2025-01-18 00:00:00', 'Scheduled', 'General Consultation', 'No specific notes'),
(16, 3, 'Crystal Fandya Putri', '081234567890', '2025-01-19 00:00:00', 'Scheduled', 'General Consultation', 'No specific notes'),
(17, 1, 'Crystal Fandya Putri', '081234567890', '2025-01-19 00:00:00', 'Scheduled', 'General Consultation', 'No specific notes'),
(18, 2, 'Crystal Fandya Putri', '081234567890', '2025-01-19 00:00:00', 'Scheduled', 'General Consultation', 'No specific notes'),
(19, 1, 'Crystal Fandya Putri', '081234567890', '2025-01-19 00:00:00', 'Scheduled', 'General Consultation', 'No specific notes');

-- --------------------------------------------------------

--
-- Table structure for table `doctors`
--

CREATE TABLE `doctors` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `specialization` varchar(100) NOT NULL,
  `contact` varchar(50) DEFAULT NULL,
  `availability` enum('Available','Unavailable') DEFAULT 'Available',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `doctors`
--

INSERT INTO `doctors` (`id`, `name`, `specialization`, `contact`, `availability`, `created_at`, `updated_at`) VALUES
(1, 'Dr. Andi Susanto', 'Kardiologi', '+628123456789', 'Available', '2025-01-16 22:50:30', '2025-01-16 22:50:30'),
(2, 'Dr. Budi Wijaya', 'Pediatri', '+628987654321', 'Available', '2025-01-16 22:50:30', '2025-01-16 22:50:30'),
(3, 'Dr. Clara Ayu', 'Dermatologi', '+6281122334455', 'Unavailable', '2025-01-16 22:50:30', '2025-01-16 22:50:30'),
(6, 'Gita Yunita', 'Paru', '0812345678', '', '2025-01-19 11:20:07', '2025-01-19 11:20:19');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','doctor','patient') DEFAULT 'patient',
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `role`, `created_at`, `updated_at`) VALUES
(1, 'example_user', 'example@example.com', 'hashed_password', '', '2025-01-18 21:08:22', '2025-01-18 21:08:22'),
(2, 'testes', 'tes@gmail.com', '12345678', '', '2025-01-18 21:54:29', '2025-01-18 21:54:29'),
(4, 'tes2', 'tes2@gmail.com', '123', '', '2025-01-18 21:55:31', '2025-01-18 21:55:31'),
(5, 'kray', 'crystal@gmail.com', '123', '', '2025-01-18 22:11:22', '2025-01-18 22:11:22'),
(6, 'ee', 'qq', '123', '', '2025-01-18 22:18:34', '2025-01-18 22:18:34'),
(8, 'ss', 'aa', '123', '', '2025-01-18 22:26:49', '2025-01-18 22:26:49'),
(11, 'pou', 'pou', '123', 'patient', '2025-01-18 23:06:16', '2025-01-18 23:06:16'),
(12, '123', 'poi', '123', 'patient', '2025-01-18 23:09:41', '2025-01-18 23:09:41'),
(15, 'crystal', 'crystalfndyap@gmail.com', '123', 'patient', '2025-01-18 23:44:16', '2025-01-18 23:44:16'),
(16, 'Fijar Rizky Maulana', 'fijarrizkymaulana@gmail.com', '123', 'patient', '2025-01-18 23:45:07', '2025-01-18 23:45:07'),
(19, 'Crystal Fandya Putri', 'user@gmail.com', '123', 'patient', '2025-01-18 23:50:21', '2025-01-18 23:50:21');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `appointments`
--
ALTER TABLE `appointments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `doctor_id` (`doctor_id`);

--
-- Indexes for table `doctors`
--
ALTER TABLE `doctors`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `appointments`
--
ALTER TABLE `appointments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `doctors`
--
ALTER TABLE `doctors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `appointments`
--
ALTER TABLE `appointments`
  ADD CONSTRAINT `appointments_ibfk_1` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
