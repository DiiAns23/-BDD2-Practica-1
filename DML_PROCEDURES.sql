USE [BD2]
GO
DROP PROCEDURE IF EXISTS practica1.EMAIL
GO
DROP PROCEDURE IF EXISTS practica1.TR1;
GO
DROP PROCEDURE IF EXISTS practica1.TR2;
GO
DROP PROCEDURE IF EXISTS practica1.TR3;
GO
DROP PROCEDURE IF EXISTS practica1.TR4;
GO
DROP PROCEDURE IF EXISTS practica1.TR5;
GO
DROP PROCEDURE IF EXISTS practica1.TR6;
GO
-------------------------------------
--- ENVIAR CORREOS Y ALMACENARLOS ---
-------------------------------------

CREATE PROCEDURE practica1.EMAIL_
@userID UNIQUEIDENTIFIER,
@message VARCHAR(200)
AS
BEGIN TRY

	DECLARE @email VARCHAR(100);
	SET @email = (
		SELECT Email FROM practica1.Usuarios WHERE Id = @userID
	);
	INSERT INTO practica1.Notification (UserId, Message, [Date])
	VALUES (@userID, @message, GETDATE());
	
	EXEC msdb.dbo.sp_send_dbmail
		@profile_name = 'Diego',
		@recipients = @email,
		@body = @message,
		@subject = 'FIUSAC';

END TRY
BEGIN CATCH
    SELECT   
		ERROR_NUMBER() AS ErrorNumber,
		ERROR_MESSAGE() AS ErrorMessage;  
END CATCH
GO

-------------------------------------
--- CREACION DE UN ESTUDIANTE (TR1)--
-------------------------------------

CREATE PROCEDURE practica1.TR1
	@Firstname VARCHAR(25),
	@Lastname VARCHAR(25),
	@Email VARCHAR(100),
	@DateOfBirth DATETIME,
	@Password VARCHAR(25),
	@Credits INT
AS
BEGIN TRY
	IF NOT EXISTS (SELECT * FROM practica1.Usuarios U WHERE U.Email = @Email)
		BEGIN
			DECLARE @userID UNIQUEIDENTIFIER;
			SET @userID = NEWID();

			INSERT INTO practica1.Usuarios 
				(
					Id, 
					Firstname, 
					Lastname, 
					Email, 
					DateOfBirth, 
					Password,
					LastChanges,
					EmailConfirmed
				)
				VALUES
				(
					@userID,
					@Firstname,
					@Lastname,
					@Email,
					@DateOfBirth,
					@Password, 
					GETDATE(),
					0
				);
			
			INSERT INTO practica1.UsuarioRole
				(
					RoleId,
					UserId,
					IsLatestVersion
				)
				VALUES
				(
					'F4E6D8FB-DF45-4C91-9794-38E043FD5ACD',
					@userID,
					0
				);
			

			INSERT INTO practica1.ProfileStudent (UserId, Credits)
				VALUES (@userID, @Credits);

			INSERT INTO practica1.TFA (UserId, Status, LastUpdate)
				VALUES (@userID, 0, GETDATE());

			PRINT 'Registro creado con exito';
			EXEC practica1.EMAIL_ @userID, 'Usuario creado con exito. Validar Correo'
			RETURN 0;
		END
	ELSE
		BEGIN
			PRINT 'No se puede registrar, este correo ya esta en uso';
			RETURN -1;
		END
END TRY
BEGIN CATCH
	INSERT INTO HistoryLog(Date,Description) VALUES (GETDATE(),'Fallo creación de estudiante TR1');
	SELECT
		ERROR_NUMBER() AS ErrorNumber,
		ERROR_MESSAGE()  AS ErrorMessage;
END CATCH
GO

-----------------------------
--- CAMBIO DE ROLES (TR2) ---
-----------------------------

CREATE PROCEDURE practica1.TR2
	@Email VARCHAR(100),
	@CodCourse VARCHAR(100)
AS
BEGIN TRY
	IF NOT EXISTS (SELECT * FROM practica1.Usuarios U WHERE U.Email = @Email AND U.EmailConfirmed = 1)
		BEGIN
			PRINT 'Correo no registrado';
			RETURN -1
		END
	ELSE
		BEGIN 
			DECLARE @userID UNIQUEIDENTIFIER;
			SET @userID = 
			(
				SELECT U.Id FROM practica1.Usuarios U WHERE U.Email = @Email
			);
			IF (
				SELECT COUNT(*) 
				FROM practica1.CourseTutor CT 
				WHERE 
					CT.TutorId = @userID AND 
					CT.CourseCodCourse = @CodCourse
				) > 0
				BEGIN
					PRINT 'Tutor ya ingresado';
					RETURN -1;
			END

			INSERT INTO practica1.CourseTutor (TutorId, CourseCodCourse)
				VALUES (@userID, @CodCourse);

			INSERT INTO practica1.UsuarioRole ( RoleId, UserId, IsLatestVersion)
				VALUES ('2CF8E1CF-3CD6-44F3-8F86-1386B7C17657', @userID, 0);

			INSERT INTO practica1.TutorProfile (UserId, TutorCode)
				VALUES (@userID, 'Tutor');

			PRINT 'Usuario con permisos elevados a tutor'
			EXEC practica1.EMAIL_ @userID, 'Usuario con permisos elevados a tutor'
		END
END TRY
BEGIN CATCH
	INSERT INTO HistoryLog(Date,Description) VALUES (GETDATE(),'Fallo cambio de roles TR2');
	SELECT 
		ERROR_NUMBER() AS ErrorNumber,
		ERROR_MESSAGE() AS Errormessage;
END CATCH
GO

---------------------------------
--- ASIGNACION DE CURSO (TR3) ---
---------------------------------

CREATE PROCEDURE practica1.TR3
	@Email VARCHAR(100),
	@CodCourse VARCHAR(100)
AS
BEGIN TRY
	IF NOT EXISTS (SELECT * FROM practica1.Usuarios U WHERE U.Email = @Email AND U.EmailConfirmed = 1)
		BEGIN
			PRINT 'Correo no registrado'
			RETURN -1
		END
	ELSE
		BEGIN
			DECLARE @userID UNIQUEIDENTIFIER, @tutorID UNIQUEIDENTIFIER;
			DECLARE @creditsRequired INT, @creditsStudent INT, @assigment INT;

			SET @userID = (
				SELECT U.Id FROM practica1.Usuarios U WHERE U.Email = @Email
			);
			IF NOT EXISTS (SELECT * FROM practica1.Course C WHERE C.CodCourse = @CodCourse)
				BEGIN
					PRINT 'Codigo Invalido'
					RETURN -1;
				END
			IF NOT EXISTS (SELECT * FROM practica1.CourseTutor CT WHERE CT.CourseCodCourse = @CodCourse)
				BEGIN
					PRINT 'Sin tutor registrado'
					RETURN -1;
				END
			SET @creditsRequired = 
				(
					SELECT C.CreditsRequired 
					FROM practica1.Course C 
					WHERE C.CodCourse = @CodCourse
				)
			SET @creditsStudent = 
				(
					SELECT PR.Credits 
					FROM practica1.ProfileStudent PR 
					WHERE PR.UserId = @userID
				)
			IF @creditsRequired > @creditsStudent
				BEGIN
					PRINT 'Falta de creditos'
					RETURN -1;
				END

			SET @assigment = 
				(
					SELECT COUNT(*) 
					FROM practica1.CourseAssignment CA 
					WHERE 
						CA.StudentId = @userID AND 
						CA.CourseCodCourse = @CodCourse
				)
			IF @assigment > 0
				BEGIN
					PRINT 'Usuario ya asignado'
					RETURN -1
				END
			SET @tutorID = (
				SELECT CT.TutorId
				FROM practica1.CourseTutor CT
				WHERE CT.CourseCodCourse = @CodCourse

			);

			INSERT INTO practica1.CourseAssignment (StudentId, CourseCodCourse)
				VALUES (@userID, @CodCourse)

			PRINT 'Asignacion completada existosamente :3'
			EXEC practica1.EMAIL_ @tutorID, 'Asignacion realizada con exito'
			EXEC practica1.EMAIL_ @tutorID, 'Asignacion realizada con exito'
			RETURN 0;
		END
END TRY
BEGIN CATCH
	INSERT INTO HistoryLog(Date,Description) VALUES (GETDATE(),'Fallo asignación de curso TR3');
	SELECT
		ERROR_NUMBER() AS ErrorNumber,
		ERROR_MESSAGE() AS ErrorMessage;
END CATCH
GO


---------------------------------------
--- NUEVO ROL PARA ESTUDIANTE (TR4) ---
---------------------------------------


CREATE PROCEDURE practica1.TR4
	@RoleName VARCHAR(25)
AS 
BEGIN TRY
	IF NOT EXISTS (SELECT * FROM practica1.Roles WHERE RoleName = @RoleName)
		BEGIN
			DECLARE @newID UNIQUEIDENTIFIER = NEWID();

			INSERT INTO practica1.Roles (Id, RoleName)
				VALUES (@newID, @RoleName);
		END
	ELSE
		BEGIN	
			PRINT 'Rol ya existente'
			RETURN -1;
		END
END TRY
BEGIN CATCH
	INSERT INTO HistoryLog(Date,Description) VALUES (GETDATE(),'Fallo nuevo rol para estudiante TR4');
	SELECT
		ERROR_NUMBER() AS ErrorNumber,
		ERROR_MESSAGE() AS ErrorMessage;
END CATCH
GO

--------------------------------
--- CREACION DE CURSOS (TR5) ---
--------------------------------

CREATE PROCEDURE practica1.TR5
	@Name VARCHAR(25),
	@CreditsRequired INT
AS
BEGIN TRY
	IF NOT EXISTS (SELECT * FROM practica1.Course c WHERE c.Name  = @Name)
		BEGIN
			DECLARE @codGenerated INT;
			SET @codGenerated = (
				SELECT COALESCE(MAX(CodCourse), 0) + 1
				FROM practica1.Course
			);

			INSERT INTO practica1.Course (CodCourse, Name, CreditsRequired)
				VALUES (@codGenerated, @Name, @CreditsRequired);
		END
	ELSE
		BEGIN
			PRINT 'Este usuario ya se encuentra creado'
			RETURN -1;
		END
END TRY
BEGIN CATCH
	INSERT INTO HistoryLog(Date,Description) VALUES (GETDATE(),'Fallo creación de cursos TR5');
	SELECT 
		ERROR_NUMBER() AS ErrorNumber,
		ERROR_MESSAGE() AS ErrorMessage;
END CATCH


---------------------------------
--- VALIDACION DE DATOS (TR6) ---
---------------------------------

CREATE PROCEDURE practica1.TR6
AS 
BEGIN
	ALTER TABLE practica1.Usuarios
	ADD CONSTRAINT Check_FirstName CHECK (FirstName NOT LIKE '%[^A-Z]%');
	
	ALTER TABLE practica1.Usuarios
	ADD CONSTRAINT Check_LastName CHECK (LastName NOT LIKE '%[^A-Z]%');

	ALTER TABLE practica1.Course 
	ADD CONSTRAINT Check_Name  CHECK (Name NOT LIKE '%[^A-Z]%');

	ALTER TABLE practica1.Course
	ADD CONSTRAINT Check_CreditsRequired CHECK (CreditsRequired NOT LIKE '%[^0-9]%');

END
GO

