-- CreateSchema
CREATE SCHEMA IF NOT EXISTS "public";

-- CreateEnum
CREATE TYPE "Role" AS ENUM ('ADMIN', 'ASDOS', 'CALON_ASDOS', 'DOSEN', 'GUEST', 'LABORAN');

-- CreateTable
CREATE TABLE "Absensi" (
    "id" TEXT NOT NULL,
    "classAsdosId" TEXT NOT NULL,
    "pertemuanKe" INTEGER,
    "waktuKehadiran" TIMESTAMP(3),
    "materi" TEXT DEFAULT 'materi...',
    "ruangan" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "fileId" TEXT NOT NULL,

    CONSTRAINT "Absensi_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ActiveAbsensi" (
    "id" TEXT NOT NULL,
    "pertemuanActive" INTEGER[],
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ActiveAbsensi_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Asdos" (
    "npm" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "alasan" TEXT,
    "domisili" TEXT,
    "fileId" TEXT,
    "whatsapp" TEXT,

    CONSTRAINT "Asdos_pkey" PRIMARY KEY ("npm")
);

-- CreateTable
CREATE TABLE "AsdosApplication" (
    "id" TEXT NOT NULL,
    "fileId" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "npm" TEXT NOT NULL,
    "whatsapp" TEXT NOT NULL,
    "domisili" TEXT NOT NULL,
    "wawancara" TEXT NOT NULL DEFAULT 'offline',
    "alasanOnline" TEXT,
    "alasan" TEXT NOT NULL,
    "status" TEXT DEFAULT 'processing',
    "bersediaDuaMatkul" BOOLEAN NOT NULL,
    "pengalamanAsdos" BOOLEAN NOT NULL,
    "bersediaDitempatkanLain" BOOLEAN NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "jadwalWawancaraId" TEXT,

    CONSTRAINT "AsdosApplication_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Class" (
    "id" TEXT NOT NULL,
    "courseId" TEXT,
    "name" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "jadwalPraktikumId" TEXT,

    CONSTRAINT "Class_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ClassAsdos" (
    "id" TEXT NOT NULL,
    "classId" TEXT NOT NULL,
    "asdosNpm" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ClassAsdos_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ClassDosen" (
    "id" TEXT NOT NULL,
    "classId" TEXT NOT NULL,
    "dosenNip" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ClassDosen_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Course" (
    "id" TEXT NOT NULL,
    "code" TEXT NOT NULL,
    "semesterId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "sks" INTEGER DEFAULT 3,
    "kuota" INTEGER DEFAULT 2,
    "status" TEXT DEFAULT 'aktif',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Course_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CourseApplication" (
    "id" TEXT NOT NULL,
    "asdosApplicationId" TEXT NOT NULL,
    "courseId" TEXT NOT NULL,

    CONSTRAINT "CourseApplication_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DataRepositori" (
    "id" TEXT NOT NULL,
    "dosenNip" TEXT,
    "thumbnail" TEXT,
    "namaDataset" TEXT NOT NULL,
    "namaPemilik" TEXT NOT NULL,
    "jenisDataset" TEXT NOT NULL,
    "linkPublikasi" TEXT NOT NULL,
    "linkRepositori" TEXT NOT NULL,
    "deskripsiDataset" TEXT,
    "status" TEXT NOT NULL DEFAULT 'pending',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "DataRepositori_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Dosen" (
    "nip" TEXT NOT NULL,
    "userId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "namaDosen" TEXT,

    CONSTRAINT "Dosen_pkey" PRIMARY KEY ("nip")
);

-- CreateTable
CREATE TABLE "File" (
    "id" TEXT NOT NULL,
    "folderId" TEXT,
    "namaFile" TEXT NOT NULL,
    "linkView" TEXT NOT NULL,
    "linkDownload" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "File_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Folder" (
    "id" TEXT NOT NULL,
    "parentId" TEXT,
    "namaFolder" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Folder_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "GoogleRefreshToken" (
    "id" TEXT NOT NULL,
    "token" TEXT NOT NULL,

    CONSTRAINT "GoogleRefreshToken_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Image" (
    "id" TEXT NOT NULL,
    "userId" TEXT,
    "namaFoto" TEXT NOT NULL,
    "gambar" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Image_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "JadwalPraktikum" (
    "id" TEXT NOT NULL,
    "hari" TEXT,
    "mulai" TEXT,
    "selesai" TEXT,
    "ruangan" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "JadwalPraktikum_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "JadwalWawancara" (
    "id" TEXT NOT NULL,
    "tanggal" TEXT DEFAULT 'Belum Diatur',
    "hari" TEXT DEFAULT 'Belum Diatur',
    "jam" TEXT DEFAULT 'Belum Diatur',
    "lokasi" TEXT DEFAULT 'LAB LT3',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "JadwalWawancara_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PasswordResetToken" (
    "id" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "token" TEXT NOT NULL,
    "expires" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "PasswordResetToken_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Penilaian" (
    "id" TEXT NOT NULL,
    "asdosApplicationId" TEXT NOT NULL,
    "ketepatanMenjawabSoal" INTEGER DEFAULT 0,
    "penjelasanJawaban" INTEGER DEFAULT 0,
    "wawancara" INTEGER DEFAULT 0,
    "nilaiTotal" INTEGER DEFAULT 0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Penilaian_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Prodi" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Prodi_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Semester" (
    "id" TEXT NOT NULL,
    "semesterNumber" INTEGER NOT NULL,
    "prodiId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Semester_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "User" (
    "id" TEXT NOT NULL,
    "name" TEXT,
    "email" TEXT NOT NULL,
    "emailVerified" TIMESTAMP(3),
    "password" TEXT NOT NULL,
    "role" "Role" NOT NULL DEFAULT 'GUEST',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "VerificationToken" (
    "id" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "token" TEXT NOT NULL,
    "expires" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "VerificationToken_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Absensi_fileId_key" ON "Absensi"("fileId");

-- CreateIndex
CREATE UNIQUE INDEX "Absensi_classAsdosId_pertemuanKe_key" ON "Absensi"("classAsdosId", "pertemuanKe");

-- CreateIndex
CREATE UNIQUE INDEX "Asdos_userId_key" ON "Asdos"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "Asdos_fileId_key" ON "Asdos"("fileId");

-- CreateIndex
CREATE UNIQUE INDEX "AsdosApplication_fileId_key" ON "AsdosApplication"("fileId");

-- CreateIndex
CREATE UNIQUE INDEX "AsdosApplication_userId_key" ON "AsdosApplication"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "AsdosApplication_npm_key" ON "AsdosApplication"("npm");

-- CreateIndex
CREATE UNIQUE INDEX "Class_jadwalPraktikumId_key" ON "Class"("jadwalPraktikumId");

-- CreateIndex
CREATE UNIQUE INDEX "Class_courseId_name_key" ON "Class"("courseId", "name");

-- CreateIndex
CREATE UNIQUE INDEX "ClassAsdos_classId_asdosNpm_key" ON "ClassAsdos"("classId", "asdosNpm");

-- CreateIndex
CREATE UNIQUE INDEX "ClassDosen_classId_dosenNip_key" ON "ClassDosen"("classId", "dosenNip");

-- CreateIndex
CREATE UNIQUE INDEX "CourseApplication_asdosApplicationId_courseId_key" ON "CourseApplication"("asdosApplicationId", "courseId");

-- CreateIndex
CREATE UNIQUE INDEX "Dosen_userId_key" ON "Dosen"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "Image_userId_key" ON "Image"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "PasswordResetToken_token_key" ON "PasswordResetToken"("token");

-- CreateIndex
CREATE UNIQUE INDEX "PasswordResetToken_email_token_key" ON "PasswordResetToken"("email", "token");

-- CreateIndex
CREATE UNIQUE INDEX "Penilaian_asdosApplicationId_key" ON "Penilaian"("asdosApplicationId");

-- CreateIndex
CREATE UNIQUE INDEX "Prodi_name_key" ON "Prodi"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Semester_semesterNumber_prodiId_key" ON "Semester"("semesterNumber", "prodiId");

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "VerificationToken_token_key" ON "VerificationToken"("token");

-- CreateIndex
CREATE UNIQUE INDEX "VerificationToken_email_token_key" ON "VerificationToken"("email", "token");

-- AddForeignKey
ALTER TABLE "Absensi" ADD CONSTRAINT "Absensi_classAsdosId_fkey" FOREIGN KEY ("classAsdosId") REFERENCES "ClassAsdos"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Absensi" ADD CONSTRAINT "Absensi_fileId_fkey" FOREIGN KEY ("fileId") REFERENCES "File"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Asdos" ADD CONSTRAINT "Asdos_fileId_fkey" FOREIGN KEY ("fileId") REFERENCES "File"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Asdos" ADD CONSTRAINT "Asdos_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AsdosApplication" ADD CONSTRAINT "AsdosApplication_fileId_fkey" FOREIGN KEY ("fileId") REFERENCES "File"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AsdosApplication" ADD CONSTRAINT "AsdosApplication_jadwalWawancaraId_fkey" FOREIGN KEY ("jadwalWawancaraId") REFERENCES "JadwalWawancara"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AsdosApplication" ADD CONSTRAINT "AsdosApplication_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Class" ADD CONSTRAINT "Class_courseId_fkey" FOREIGN KEY ("courseId") REFERENCES "Course"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Class" ADD CONSTRAINT "Class_jadwalPraktikumId_fkey" FOREIGN KEY ("jadwalPraktikumId") REFERENCES "JadwalPraktikum"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ClassAsdos" ADD CONSTRAINT "ClassAsdos_asdosNpm_fkey" FOREIGN KEY ("asdosNpm") REFERENCES "Asdos"("npm") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ClassAsdos" ADD CONSTRAINT "ClassAsdos_classId_fkey" FOREIGN KEY ("classId") REFERENCES "Class"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ClassDosen" ADD CONSTRAINT "ClassDosen_classId_fkey" FOREIGN KEY ("classId") REFERENCES "Class"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ClassDosen" ADD CONSTRAINT "ClassDosen_dosenNip_fkey" FOREIGN KEY ("dosenNip") REFERENCES "Dosen"("nip") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Course" ADD CONSTRAINT "Course_semesterId_fkey" FOREIGN KEY ("semesterId") REFERENCES "Semester"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CourseApplication" ADD CONSTRAINT "CourseApplication_asdosApplicationId_fkey" FOREIGN KEY ("asdosApplicationId") REFERENCES "AsdosApplication"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CourseApplication" ADD CONSTRAINT "CourseApplication_courseId_fkey" FOREIGN KEY ("courseId") REFERENCES "Course"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DataRepositori" ADD CONSTRAINT "DataRepositori_dosenNip_fkey" FOREIGN KEY ("dosenNip") REFERENCES "Dosen"("nip") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Dosen" ADD CONSTRAINT "Dosen_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "File" ADD CONSTRAINT "File_folderId_fkey" FOREIGN KEY ("folderId") REFERENCES "Folder"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Image" ADD CONSTRAINT "Image_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Penilaian" ADD CONSTRAINT "Penilaian_asdosApplicationId_fkey" FOREIGN KEY ("asdosApplicationId") REFERENCES "AsdosApplication"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Semester" ADD CONSTRAINT "Semester_prodiId_fkey" FOREIGN KEY ("prodiId") REFERENCES "Prodi"("id") ON DELETE CASCADE ON UPDATE CASCADE;

