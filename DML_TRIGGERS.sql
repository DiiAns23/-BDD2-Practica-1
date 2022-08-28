-- -----------------------------------------------------
-- 					ROLES
-- -----------------------------------------------------
CREATE TRIGGER [practica1].[TG_Roles_Insert]
ON [practica1].[Roles]
AFTER INSERT
AS
BEGIN	
    SET NOCOUNT ON;

	DECLARE @NRol AS VARCHAR(500);
	SET @NRol = (SELECT RoleName FROM INSERTED)

	DECLARE @Nvar AS VARCHAR(500);
	SET @Nvar = 'Se insertó un nuevo rol: ' + @NRol;

    INSERT INTO HistoryLog(Date,Description) VALUES (GETDATE(),@Nvar)
END;

CREATE TRIGGER [practica1].[TG_Roles_Update]
ON [practica1].[Roles]
AFTER UPDATE
AS
BEGIN
	DECLARE @NRol AS VARCHAR(500);
	SET @NRol = (SELECT RoleName FROM DELETED)

	DECLARE @Nvar AS VARCHAR(500);
	SET @Nvar = 'Se actualizo el rol: ' + @NRol;

	INSERT INTO HistoryLog(Date, Description) VALUES (GETDATE(),@Nvar)
END;

CREATE TRIGGER [practica1].[TG_Roles_Delete]
ON [practica1].[Roles]
AFTER DELETE
AS
BEGIN
	DECLARE @NRol AS VARCHAR(500);
	SET @NRol = (SELECT RoleName FROM DELETED)

	DECLARE @Nvar AS VARCHAR(500);
	SET @Nvar = 'Se borro el rol: ' + @NRol;

	INSERT INTO HistoryLog(Date, Description) VALUES (GETDATE(),@Nvar)
END;


-- -----------------------------------------------------
-- 					NOTIFICATION
-- -----------------------------------------------------
CREATE TRIGGER [practica1].[TG_Notification_Insert]
ON [practica1].[Notification]
AFTER INSERT
AS
BEGIN	
    SET NOCOUNT ON;

	DECLARE @Nid AS VARCHAR(500);
	SET @Nid = (SELECT Id FROM INSERTED)

	DECLARE @Nvar AS VARCHAR(500);
	SET @Nvar = 'Se insertó una nueva notificación con el id: ' + @Nid;

    INSERT INTO HistoryLog(Date,Description) VALUES (GETDATE(),@Nvar)
END;

CREATE TRIGGER [practica1].[TG_Notification_Update]
ON [practica1].[Notification]
AFTER UPDATE
AS
BEGIN
	DECLARE @Nid AS VARCHAR(500);
	SET @Nid = (SELECT Id FROM DELETED)

	DECLARE @Nvar AS VARCHAR(500);
	SET @Nvar = 'Se actualizo la notificación: ' + @Nid;

	INSERT INTO HistoryLog(Date, Description) VALUES (GETDATE(),@Nvar)
END;

CREATE TRIGGER [practica1].[TG_Notification_Delete]
ON [practica1].[Notification]
AFTER DELETE
AS
BEGIN
	DECLARE @Nid AS VARCHAR(500);
	SET @Nid = (SELECT Id FROM DELETED)

	DECLARE @Nvar AS VARCHAR(500);
	SET @Nvar = 'Se borro la notificación: ' + @Nid;

	INSERT INTO HistoryLog(Date, Description) VALUES (GETDATE(),@Nvar)
END;

-- -----------------------------------------------------
-- 						COURSE
-- -----------------------------------------------------
CREATE TRIGGER [practica1].[TG_Course_Insert]
ON [practica1].[Course]
AFTER INSERT
AS
BEGIN	
    SET NOCOUNT ON;

	DECLARE @Ncourse AS VARCHAR(500);
	SET @Ncourse = (SELECT Name FROM INSERTED)

	DECLARE @Nvar AS VARCHAR(500);
	SET @Nvar = 'Se insertó un nuevo curso: ' + @Ncourse;

    INSERT INTO HistoryLog(Date,Description) VALUES (GETDATE(),@Nvar)
END;

CREATE TRIGGER [practica1].[TG_Course_Update]
ON [practica1].[Course]
AFTER UPDATE
AS
BEGIN
	DECLARE @Ncourse AS VARCHAR(500);
	SET @Ncourse = (SELECT Name FROM DELETED)

	DECLARE @Nvar AS VARCHAR(500);
	SET @Nvar = 'Se actualizo el curso: ' + @Ncourse;

	INSERT INTO HistoryLog(Date, Description) VALUES (GETDATE(),@Nvar)
END;

CREATE TRIGGER [practica1].[TG_Course_Delete]
ON [practica1].[Course]
AFTER DELETE
AS
BEGIN
	DECLARE @Ncourse AS VARCHAR(500);
	SET @Ncourse = (SELECT Name FROM DELETED)

	DECLARE @Nvar AS VARCHAR(500);
	SET @Nvar = 'Se borro el curso: ' + @Ncourse;

	INSERT INTO HistoryLog(Date, Description) VALUES (GETDATE(),@Nvar)
END;


-- -----------------------------------------------------
-- 						USUARIOS
-- -----------------------------------------------------
CREATE TRIGGER [practica1].[TG_Usuarios_Insert]
ON [practica1].[Usuarios]
AFTER INSERT
AS
BEGIN	
    SET NOCOUNT ON;

	DECLARE @Nid AS VARCHAR(500);
	SET @Nid = (SELECT Id FROM INSERTED)

	DECLARE @Nvar AS VARCHAR(500);
	SET @Nvar = 'Se insertó un nuevo usuario con el id: ' + @Nid;

    INSERT INTO HistoryLog(Date,Description) VALUES (GETDATE(),@Nvar)
END;

CREATE TRIGGER [practica1].[TG_Usuarios_Update]
ON [practica1].[Usuarios]
AFTER UPDATE
AS
BEGIN
	DECLARE @Nid AS VARCHAR(500);
	SET @Nid = (SELECT Id FROM DELETED)

	DECLARE @Nvar AS VARCHAR(500);
	SET @Nvar = 'Se actualizo el usuario: ' + @Nid;

	INSERT INTO HistoryLog(Date, Description) VALUES (GETDATE(),@Nvar)
END;

CREATE TRIGGER [practica1].[TG_Usuarios_Delete]
ON [practica1].[Usuarios]
AFTER DELETE
AS
BEGIN
	DECLARE @Nid AS VARCHAR(500);
	SET @Nid = (SELECT Id FROM DELETED)

	DECLARE @Nvar AS VARCHAR(500);
	SET @Nvar = 'Se borro el usuario: ' + @Nid;

	INSERT INTO HistoryLog(Date, Description) VALUES (GETDATE(),@Nvar)
END;


-- -----------------------------------------------------
-- 						USUARIOROLE
-- -----------------------------------------------------
CREATE TRIGGER [practica1].[TG_UsuarioRole_Insert]
ON [practica1].[UsuarioRole]
AFTER INSERT
AS
BEGIN	
    SET NOCOUNT ON;

	DECLARE @Nid AS VARCHAR(500);
	SET @Nid = (SELECT Id FROM INSERTED)

	DECLARE @Nvar AS VARCHAR(500);
	SET @Nvar = 'Se insertó un nuevo detalle usuariorole con el id: ' + @Nid;

    INSERT INTO HistoryLog(Date,Description) VALUES (GETDATE(),@Nvar)
END;

CREATE TRIGGER [practica1].[TG_UsuarioRole_Update]
ON [practica1].[UsuarioRole]
AFTER UPDATE
AS
BEGIN
	DECLARE @Nid AS VARCHAR(500);
	SET @Nid = (SELECT Id FROM DELETED)

	DECLARE @Nvar AS VARCHAR(500);
	SET @Nvar = 'Se actualizo el detalle usuariorole: ' + @Nid;

	INSERT INTO HistoryLog(Date, Description) VALUES (GETDATE(),@Nvar)
END;

CREATE TRIGGER [practica1].[TG_UsuarioRole_Delete]
ON [practica1].[UsuarioRole]
AFTER DELETE
AS
BEGIN
	DECLARE @Nid AS VARCHAR(500);
	SET @Nid = (SELECT Id FROM DELETED)

	DECLARE @Nvar AS VARCHAR(500);
	SET @Nvar = 'Se borro el detalle usuariorole: ' + @Nid;

	INSERT INTO HistoryLog(Date, Description) VALUES (GETDATE(),@Nvar)
END;


-- -----------------------------------------------------
-- 						TutorProfile
-- -----------------------------------------------------
CREATE TRIGGER [practica1].[TG_TutorProfile_Insert]
ON [practica1].[TutorProfile]
AFTER INSERT
AS
BEGIN	
    SET NOCOUNT ON;

	DECLARE @Nid AS VARCHAR(500);
	SET @Nid = (SELECT Id FROM INSERTED)

	DECLARE @Nvar AS VARCHAR(500);
	SET @Nvar = 'Se insertó un nuevo detalle TutorProfile con el id: ' + @Nid;

    INSERT INTO HistoryLog(Date,Description) VALUES (GETDATE(),@Nvar)
END;

CREATE TRIGGER [practica1].[TG_TutorProfile_Update]
ON [practica1].[TutorProfile]
AFTER UPDATE
AS
BEGIN
	DECLARE @Nid AS VARCHAR(500);
	SET @Nid = (SELECT Id FROM DELETED)

	DECLARE @Nvar AS VARCHAR(500);
	SET @Nvar = 'Se actualizo el detalle TutorProfile: ' + @Nid;

	INSERT INTO HistoryLog(Date, Description) VALUES (GETDATE(),@Nvar)
END;

CREATE TRIGGER [practica1].[TG_TutorProfile_Delete]
ON [practica1].[TutorProfile]
AFTER DELETE
AS
BEGIN
	DECLARE @Nid AS VARCHAR(500);
	SET @Nid = (SELECT Id FROM DELETED)

	DECLARE @Nvar AS VARCHAR(500);
	SET @Nvar = 'Se borro el detalle TutorProfile: ' + @Nid;

	INSERT INTO HistoryLog(Date, Description) VALUES (GETDATE(),@Nvar)
END;


-- -----------------------------------------------------
-- 						TFA
-- -----------------------------------------------------
CREATE TRIGGER [practica1].[TG_TFA_Insert]
ON [practica1].[TFA]
AFTER INSERT
AS
BEGIN	
    SET NOCOUNT ON;

	DECLARE @Nid AS VARCHAR(500);
	SET @Nid = (SELECT Id FROM INSERTED)

	DECLARE @Nvar AS VARCHAR(500);
	SET @Nvar = 'Se insertó un nuevo TFA con el id: ' + @Nid;

    INSERT INTO HistoryLog(Date,Description) VALUES (GETDATE(),@Nvar)
END;

CREATE TRIGGER [practica1].[TG_TFA_Update]
ON [practica1].[TFA]
AFTER UPDATE
AS
BEGIN
	DECLARE @Nid AS VARCHAR(500);
	SET @Nid = (SELECT Id FROM DELETED)

	DECLARE @Nvar AS VARCHAR(500);
	SET @Nvar = 'Se actualizo el TFA: ' + @Nid;

	INSERT INTO HistoryLog(Date, Description) VALUES (GETDATE(),@Nvar)
END;

CREATE TRIGGER [practica1].[TG_TFA_Delete]
ON [practica1].[TFA]
AFTER DELETE
AS
BEGIN
	DECLARE @Nid AS VARCHAR(500);
	SET @Nid = (SELECT Id FROM DELETED)

	DECLARE @Nvar AS VARCHAR(500);
	SET @Nvar = 'Se borro el TFA: ' + @Nid;

	INSERT INTO HistoryLog(Date, Description) VALUES (GETDATE(),@Nvar)
END;


-- -----------------------------------------------------
-- 						ProfileStudent
-- -----------------------------------------------------
CREATE TRIGGER [practica1].[TG_ProfileStudent_Insert]
ON [practica1].[ProfileStudent]
AFTER INSERT
AS
BEGIN	
    SET NOCOUNT ON;

	DECLARE @Nid AS VARCHAR(500);
	SET @Nid = (SELECT Id FROM INSERTED)

	DECLARE @Nvar AS VARCHAR(500);
	SET @Nvar = 'Se insertó un nuevo perfil de estudiante con el id: ' + @Nid;

    INSERT INTO HistoryLog(Date,Description) VALUES (GETDATE(),@Nvar)
END;

CREATE TRIGGER [practica1].[TG_ProfileStudent_Update]
ON [practica1].[ProfileStudent]
AFTER UPDATE
AS
BEGIN
	DECLARE @Nid AS VARCHAR(500);
	SET @Nid = (SELECT Id FROM DELETED)

	DECLARE @Nvar AS VARCHAR(500);
	SET @Nvar = 'Se actualizo el perfil de estudiante: ' + @Nid;

	INSERT INTO HistoryLog(Date, Description) VALUES (GETDATE(),@Nvar)
END;

CREATE TRIGGER [practica1].[TG_ProfileStudent_Delete]
ON [practica1].[ProfileStudent]
AFTER DELETE
AS
BEGIN
	DECLARE @Nid AS VARCHAR(500);
	SET @Nid = (SELECT Id FROM DELETED)

	DECLARE @Nvar AS VARCHAR(500);
	SET @Nvar = 'Se borro el perfil de estudiante: ' + @Nid;

	INSERT INTO HistoryLog(Date, Description) VALUES (GETDATE(),@Nvar)
END;


-- -----------------------------------------------------
-- 						CourseTutor
-- -----------------------------------------------------
CREATE TRIGGER [practica1].[TG_CourseTutor_Insert]
ON [practica1].[CourseTutor]
AFTER INSERT
AS
BEGIN	
    SET NOCOUNT ON;

	DECLARE @Nid AS VARCHAR(500);
	SET @Nid = (SELECT Id FROM INSERTED)

	DECLARE @Nvar AS VARCHAR(500);
	SET @Nvar = 'Se insertó un nuevo detalle tutor de curso: ' + @Nid;

    INSERT INTO HistoryLog(Date,Description) VALUES (GETDATE(),@Nvar)
END;

CREATE TRIGGER [practica1].[TG_CourseTutor_Update]
ON [practica1].[CourseTutor]
AFTER UPDATE
AS
BEGIN
	DECLARE @Nid AS VARCHAR(500);
	SET @Nid = (SELECT Id FROM DELETED)

	DECLARE @Nvar AS VARCHAR(500);
	SET @Nvar = 'Se actualizo el detalle tutor de curso: ' + @Nid;

	INSERT INTO HistoryLog(Date, Description) VALUES (GETDATE(),@Nvar)
END;

CREATE TRIGGER [practica1].[TG_CourseTutor_Delete]
ON [practica1].[CourseTutor]
AFTER DELETE
AS
BEGIN
	DECLARE @Nid AS VARCHAR(500);
	SET @Nid = (SELECT Id FROM DELETED)

	DECLARE @Nvar AS VARCHAR(500);
	SET @Nvar = 'Se borro el detalle tutor de curso: ' + @Nid;

	INSERT INTO HistoryLog(Date, Description) VALUES (GETDATE(),@Nvar)
END;


-- -----------------------------------------------------
-- 						CourseAssignment
-- -----------------------------------------------------
CREATE TRIGGER [practica1].[TG_CourseAssignment_Insert]
ON [practica1].[CourseAssignment]
AFTER INSERT
AS
BEGIN	
    SET NOCOUNT ON;

	DECLARE @Nid AS VARCHAR(500);
	SET @Nid = (SELECT Id FROM INSERTED)

	DECLARE @Nvar AS VARCHAR(500);
	SET @Nvar = 'Se insertó un nuevo detalle de asignación: ' + @Nid;

    INSERT INTO HistoryLog(Date,Description) VALUES (GETDATE(),@Nvar)
END;

CREATE TRIGGER [practica1].[TG_CourseAssignment_Update]
ON [practica1].[CourseAssignment]
AFTER UPDATE
AS
BEGIN
	DECLARE @Nid AS VARCHAR(500);
	SET @Nid = (SELECT Id FROM DELETED)

	DECLARE @Nvar AS VARCHAR(500);
	SET @Nvar = 'Se actualizo el detalle de asignación: ' + @Nid;

	INSERT INTO HistoryLog(Date, Description) VALUES (GETDATE(),@Nvar)
END;

CREATE TRIGGER [practica1].[TG_CourseAssignment_Delete]
ON [practica1].[CourseAssignment]
AFTER DELETE
AS
BEGIN
	DECLARE @Nid AS VARCHAR(500);
	SET @Nid = (SELECT Id FROM DELETED)

	DECLARE @Nvar AS VARCHAR(500);
	SET @Nvar = 'Se borro el detalle de asignación: ' + @Nid;

	INSERT INTO HistoryLog(Date, Description) VALUES (GETDATE(),@Nvar)
END;