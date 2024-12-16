-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 26, 2024 at 05:42 PM
-- Server version: 10.4.14-MariaDB
-- PHP Version: 7.4.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dbbismillah1`
--

-- --------------------------------------------------------

--
-- Table structure for table `akun`
--

CREATE TABLE `akun` (
  `no_akun` varchar(5) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nm_akun` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `akun`
--

INSERT INTO `akun` (`no_akun`, `nm_akun`) VALUES
('101', 'Kas'),
('500', 'Penjualan'),
('501', 'Retur Pengembalian');

-- --------------------------------------------------------

--
-- Table structure for table `detailpesan`
--

CREATE TABLE `detailpesan` (
  `no_pesan` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL,
  `kd_pkn` varchar(5) COLLATE utf8mb4_unicode_ci NOT NULL,
  `qty_pesan` int(11) NOT NULL,
  `Subtotal` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `detailpesan`
--

INSERT INTO `detailpesan` (`no_pesan`, `kd_pkn`, `qty_pesan`, `Subtotal`) VALUES
('001/TRX/VI/2024', 'P001', 2, 200000),
('002/TRX/VI/2024', 'P001', 2, 200000),
('003/TRX/VI/2024', 'CLN02', 5, 500000),
('004/TRX/VI/2024', 'P001', 5, 500000),
('005/TRX/VI/2024', 'CLN01', 10, 1000000),
('006/TRX/VI/2024', 'P002', 5, 450000),
('007/TRX/VI/2024', 'P001', 10, 1000000),
('008/TRX/VI/2024', 'CLN01', 12, 1200000),
('009/TRX/VI/2024', 'P001', 11, 1100000);

--
-- Triggers `detailpesan`
--
DELIMITER $$
CREATE TRIGGER `clear_tem_pesan` AFTER INSERT ON `detailpesan` FOR EACH ROW BEGIN
            DELETE FROM temp_pemesanan;
        END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `detail_penjualan`
--

CREATE TABLE `detail_penjualan` (
  `no_jual` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `kd_pkn` varchar(5) COLLATE utf8mb4_unicode_ci NOT NULL,
  `qty_jual` int(11) NOT NULL,
  `sub_jual` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `detail_penjualan`
--

INSERT INTO `detail_penjualan` (`no_jual`, `kd_pkn`, `qty_jual`, `sub_jual`) VALUES
('001/FKT/VI/2024', 'P001', 2, 200000),
('002/FKT/VI/2024', 'P001', 2, 200000),
('003/FKT/VI/2024', 'CLN02', 5, 500000),
('004/FKT/VI/2024', 'P001', 5, 500000);

--
-- Triggers `detail_penjualan`
--
DELIMITER $$
CREATE TRIGGER `update_stok` AFTER INSERT ON `detail_penjualan` FOR EACH ROW BEGIN
        UPDATE pakaian
        SET stok = stok + NEW.qty_jual
        WHERE
        kd_pkn = NEW.kd_pkn;
        END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `detail_retur`
--

CREATE TABLE `detail_retur` (
  `no_retur` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `kd_pkn` varchar(5) COLLATE utf8mb4_unicode_ci NOT NULL,
  `qty_retur` int(11) NOT NULL,
  `sub_retur` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `detail_retur`
--

INSERT INTO `detail_retur` (`no_retur`, `kd_pkn`, `qty_retur`, `sub_retur`) VALUES
('001/RTR/VI/2024', 'P001', 1, 100000),
('002/RTR/VI/2024', 'P001', 1, 100000);

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jurnal`
--

CREATE TABLE `jurnal` (
  `no_jurnal` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `keterangan` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `tgl_jurnal` date NOT NULL,
  `no_akun` varchar(5) COLLATE utf8mb4_unicode_ci NOT NULL,
  `debet` int(11) NOT NULL,
  `kredit` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `jurnal`
--

INSERT INTO `jurnal` (`no_jurnal`, `keterangan`, `tgl_jurnal`, `no_akun`, `debet`, `kredit`) VALUES
('001/JRU/VI/2024', ' Kas ', '2024-06-18', '500', 200000, 0),
('001/JRU/VI/2024', 'Penjualan', '2024-06-18', '101', 0, 200000),
('002/JRU/VI/2024', 'Retur Penjualan', '2024-06-18', '101', 100000, 0),
('002/JRU/VI/2024', 'Kas', '2024-06-18', '501', 0, 100000),
('003/JRU/VI/2024', ' Kas ', '2024-06-20', '500', 200000, 0),
('003/JRU/VI/2024', 'Penjualan', '2024-06-20', '101', 0, 200000),
('004/JRU/VI/2024', 'Retur Penjualan', '2024-06-20', '101', 100000, 0),
('004/JRU/VI/2024', 'Kas', '2024-06-20', '501', 0, 100000),
('005/JRU/VI/2024', ' Kas ', '2024-06-24', '500', 500000, 0),
('005/JRU/VI/2024', 'Penjualan', '2024-06-24', '101', 0, 500000),
('006/JRU/VI/2024', ' Kas ', '2024-06-24', '500', 500000, 0),
('006/JRU/VI/2024', 'Penjualan', '2024-06-24', '101', 0, 500000);

-- --------------------------------------------------------

--
-- Stand-in structure for view `lap_jurnal`
-- (See below for the actual view)
--
CREATE TABLE `lap_jurnal` (
`nm_akun` varchar(25)
,`tgl` date
,`debet` decimal(32,0)
,`kredit` decimal(32,0)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `lap_stok`
-- (See below for the actual view)
--
CREATE TABLE `lap_stok` (
`kd_pkn` varchar(5)
,`nm_pkn` varchar(50)
,`harga` int(11)
,`stok` int(11)
,`jual` decimal(32,0)
,`retur` decimal(32,0)
);

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2024_06_16_071323_pakaian', 1),
(5, '2024_06_16_071432_pelanggan', 1),
(6, '2024_06_16_071448_akun', 1),
(7, '2024_06_16_071505_setting', 1),
(8, '2024_06_16_071605_detailpesan', 1),
(9, '2024_06_16_071632_temp_pemesanan', 1),
(10, '2024_06_16_071647_penjualan', 1),
(11, '2024_06_16_071828_detail_penjualan', 1),
(12, '2024_06_16_071848_retur_jual', 1),
(13, '2024_06_16_071923_detail_retur', 1),
(14, '2024_06_16_071938_jurnal', 1),
(15, '2024_06_16_072618_trigger_bersih_tempesan', 1),
(16, '2024_06_16_072713_trigger_tambah', 1),
(17, '2024_06_16_080121_create_permission_tables', 1),
(18, '2024_06_16_104552_pemesanan', 1);

-- --------------------------------------------------------

--
-- Table structure for table `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `model_has_roles`
--

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
(1, 'App\\User', 1),
(2, 'App\\User', 1),
(2, 'App\\User', 2);

-- --------------------------------------------------------

--
-- Table structure for table `pakaian`
--

CREATE TABLE `pakaian` (
  `kd_pkn` varchar(5) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nm_pkn` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `harga` int(11) NOT NULL,
  `stok` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pakaian`
--

INSERT INTO `pakaian` (`kd_pkn`, `nm_pkn`, `harga`, `stok`) VALUES
('CLN01', 'Celama Abu-Abu SMA (XL)', 100000, 40),
('CLN02', 'Celama Abu-Abu SMA (L)', 100000, 45),
('CLN03', 'Celama Abu-Abu SMA (M)', 100000, 40),
('P001', 'Kemeja Putih SMA (XL)', 100000, 44),
('P002', 'Kemeja Putih SMA (L)', 90000, 40),
('P003', 'Kemeja Putih SMA (m)', 90000, 40);

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pelanggan`
--

CREATE TABLE `pelanggan` (
  `kd_plg` varchar(5) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nm_plg` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `alamat` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notelepon` varchar(13) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pelanggan`
--

INSERT INTO `pelanggan` (`kd_plg`, `nm_plg`, `alamat`, `notelepon`) VALUES
('P001', 'Armand', 'Bekasi', '092828288212'),
('P002', 'Veny', 'Bekasi', '1221212121'),
('P003', 'Ramdan', 'Bekasi', '01221212121'),
('P004', 'Kelompok Satu', 'Kaliabang', '081212121212'),
('P005', 'Kelompok Satu Jaya', 'Tambun', '081313131313');

-- --------------------------------------------------------

--
-- Table structure for table `pemesanan`
--

CREATE TABLE `pemesanan` (
  `no_pesan` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tgl_pesan` date NOT NULL,
  `total` int(11) NOT NULL,
  `kd_plg` varchar(5) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pemesanan`
--

INSERT INTO `pemesanan` (`no_pesan`, `tgl_pesan`, `total`, `kd_plg`) VALUES
('001/TRX/VI/2024', '2024-06-18', 200000, 'P001'),
('002/TRX/VI/2024', '2024-06-20', 200000, 'P001'),
('003/TRX/VI/2024', '2024-06-24', 500000, 'P003'),
('004/TRX/VI/2024', '2024-06-24', 500000, 'P004'),
('005/TRX/VI/2024', '2024-06-24', 1000000, 'P005'),
('006/TRX/VI/2024', '2024-06-24', 450000, 'P002'),
('007/TRX/VI/2024', '2024-06-24', 1000000, 'P001'),
('008/TRX/VI/2024', '2024-06-25', 1200000, 'P004'),
('009/TRX/VI/2024', '2024-06-25', 1100000, 'P001');

-- --------------------------------------------------------

--
-- Table structure for table `penjualan`
--

CREATE TABLE `penjualan` (
  `no_jual` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tgl_jual` date NOT NULL,
  `no_faktur` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jual` int(11) NOT NULL,
  `no_pesan` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `penjualan`
--

INSERT INTO `penjualan` (`no_jual`, `tgl_jual`, `no_faktur`, `total_jual`, `no_pesan`) VALUES
('001/FKT/VI/2024', '2024-06-18', '001/FKT/VI/2024', 200000, '001/TRX/VI/2024'),
('002/FKT/VI/2024', '2024-06-20', '002/FKT/VI/2024', 200000, '002/TRX/VI/2024'),
('003/FKT/VI/2024', '2024-06-24', '003/FKT/VI/2024', 500000, '003/TRX/VI/2024'),
('004/FKT/VI/2024', '2024-06-24', '004/FKT/VI/2024', 500000, '004/TRX/VI/2024');

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `retur_jual`
--

CREATE TABLE `retur_jual` (
  `no_retur` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tgl_retur` date NOT NULL,
  `total_retur` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `retur_jual`
--

INSERT INTO `retur_jual` (`no_retur`, `tgl_retur`, `total_retur`) VALUES
('001/RTR/VI/2024', '2024-06-18', 100000),
('002/RTR/VI/2024', '2024-06-20', 100000);

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'web', '2024-06-16 03:48:41', '2024-06-16 03:48:41'),
(2, 'user', 'web', '2024-06-16 03:48:41', '2024-06-16 03:48:41');

-- --------------------------------------------------------

--
-- Table structure for table `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `setting`
--

CREATE TABLE `setting` (
  `id_setting` varchar(5) COLLATE utf8mb4_unicode_ci NOT NULL,
  `no_akun` varchar(5) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama_transaksi` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `setting`
--

INSERT INTO `setting` (`id_setting`, `no_akun`, `nama_transaksi`) VALUES
('1', '501', 'Retur'),
('2', '500', 'Penjualan'),
('3', '101', 'Kas');

-- --------------------------------------------------------

--
-- Stand-in structure for view `tampil_pemesanan`
-- (See below for the actual view)
--
CREATE TABLE `tampil_pemesanan` (
`kd_pkn` varchar(5)
,`no_pesan` varchar(25)
,`nm_pkn` varchar(50)
,`qty_pesan` int(11)
,`sub_total` int(11)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `tampil_penjualan`
-- (See below for the actual view)
--
CREATE TABLE `tampil_penjualan` (
`kd_pkn` varchar(5)
,`no_jual` varchar(50)
,`nm_pkn` varchar(50)
,`harga` int(11)
,`qty_jual` int(11)
);

-- --------------------------------------------------------

--
-- Table structure for table `temp_pemesanan`
--

CREATE TABLE `temp_pemesanan` (
  `kd_pkn` varchar(5) COLLATE utf8mb4_unicode_ci NOT NULL,
  `qty_pesan` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `temp_pemesanan`
--

INSERT INTO `temp_pemesanan` (`kd_pkn`, `qty_pesan`) VALUES
('CLN01', 2),
('CLN02', 2),
('CLN03', 2),
('P001', 2),
('P002', 2);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'admin@gmail.com', NULL, '$2y$10$RvEP6ATgep7Qm3Ty2DtzB.t9EwXtzITWTF1sepGexb7PpPPRk8YMG', NULL, '2024-06-16 03:48:41', '2024-06-16 03:48:41'),
(2, 'user', 'user@gmail.com', NULL, '$2y$10$g0liBYYQLytHZibRhAXdtenhEgs1NCoRhvEXkWq7LFXiKnsSY3Ih6', NULL, '2024-06-16 03:48:42', '2024-06-16 03:48:42');

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_temp_pesan`
-- (See below for the actual view)
--
CREATE TABLE `view_temp_pesan` (
`kd_pkn` varchar(5)
,`nm_pkn` varchar(61)
,`qty_pesan` int(11)
,`sub_total` bigint(21)
);

-- --------------------------------------------------------

--
-- Structure for view `lap_jurnal`
--
DROP TABLE IF EXISTS `lap_jurnal`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `lap_jurnal`  AS  select `akun`.`nm_akun` AS `nm_akun`,`jurnal`.`tgl_jurnal` AS `tgl`,sum(`jurnal`.`debet`) AS `debet`,sum(`jurnal`.`kredit`) AS `kredit` from (`akun` join `jurnal`) where `akun`.`no_akun` = `jurnal`.`no_akun` group by `jurnal`.`no_jurnal` ;

-- --------------------------------------------------------

--
-- Structure for view `lap_stok`
--
DROP TABLE IF EXISTS `lap_stok`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `lap_stok`  AS  (select `pakaian`.`kd_pkn` AS `kd_pkn`,`pakaian`.`nm_pkn` AS `nm_pkn`,`pakaian`.`harga` AS `harga`,`pakaian`.`stok` AS `stok`,sum(`detail_penjualan`.`qty_jual`) AS `jual`,sum(`detail_retur`.`qty_retur`) AS `retur` from ((`pakaian` join `detail_retur`) join `detail_penjualan`) where `pakaian`.`kd_pkn` = `detail_retur`.`kd_pkn` and `pakaian`.`kd_pkn` = `detail_penjualan`.`kd_pkn` group by `pakaian`.`kd_pkn`) ;

-- --------------------------------------------------------

--
-- Structure for view `tampil_pemesanan`
--
DROP TABLE IF EXISTS `tampil_pemesanan`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `tampil_pemesanan`  AS  select `detailpesan`.`kd_pkn` AS `kd_pkn`,`detailpesan`.`no_pesan` AS `no_pesan`,`pakaian`.`nm_pkn` AS `nm_pkn`,`detailpesan`.`qty_pesan` AS `qty_pesan`,`detailpesan`.`Subtotal` AS `sub_total` from (`pakaian` join `detailpesan`) where `detailpesan`.`kd_pkn` = `pakaian`.`kd_pkn` ;

-- --------------------------------------------------------

--
-- Structure for view `tampil_penjualan`
--
DROP TABLE IF EXISTS `tampil_penjualan`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `tampil_penjualan`  AS  (select `pakaian`.`kd_pkn` AS `kd_pkn`,`detail_penjualan`.`no_jual` AS `no_jual`,`pakaian`.`nm_pkn` AS `nm_pkn`,`pakaian`.`harga` AS `harga`,`detail_penjualan`.`qty_jual` AS `qty_jual` from (`pakaian` join `detail_penjualan`) where `pakaian`.`kd_pkn` = `detail_penjualan`.`kd_pkn`) ;

-- --------------------------------------------------------

--
-- Structure for view `view_temp_pesan`
--
DROP TABLE IF EXISTS `view_temp_pesan`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_temp_pesan`  AS  select `temp_pemesanan`.`kd_pkn` AS `kd_pkn`,concat(`pakaian`.`nm_pkn`,`pakaian`.`harga`) AS `nm_pkn`,`temp_pemesanan`.`qty_pesan` AS `qty_pesan`,`pakaian`.`harga` * `temp_pemesanan`.`qty_pesan` AS `sub_total` from (`temp_pemesanan` join `pakaian`) where `temp_pemesanan`.`kd_pkn` = `pakaian`.`kd_pkn` ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `akun`
--
ALTER TABLE `akun`
  ADD PRIMARY KEY (`no_akun`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  ADD KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  ADD KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `pakaian`
--
ALTER TABLE `pakaian`
  ADD PRIMARY KEY (`kd_pkn`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `pelanggan`
--
ALTER TABLE `pelanggan`
  ADD PRIMARY KEY (`kd_plg`);

--
-- Indexes for table `pemesanan`
--
ALTER TABLE `pemesanan`
  ADD PRIMARY KEY (`no_pesan`);

--
-- Indexes for table `penjualan`
--
ALTER TABLE `penjualan`
  ADD PRIMARY KEY (`no_jual`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indexes for table `retur_jual`
--
ALTER TABLE `retur_jual`
  ADD PRIMARY KEY (`no_retur`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indexes for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

--
-- Indexes for table `setting`
--
ALTER TABLE `setting`
  ADD PRIMARY KEY (`id_setting`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
