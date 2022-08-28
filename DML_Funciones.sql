use BD2;

CREATE FUNCTION practica1.F1(@codCourse int) --Func_course_usuarios(CodCourse)
RETURNS TABLE 
AS
RETURN
(
	select u.Firstname, u.Lastname 
	from practica1.CourseAssignment ca
	inner join practica1.Course c on c.CodCourse = ca.CourseCodCourse 
	inner join practica1.Usuarios u on u.Id = ca.StudentId
	where (c.CodCourse = @codCourse)
)

CREATE FUNCTION practica1.F2(@idTutorProfile int) --Func_tutor_course(IdTutorProfile)
RETURNS TABLE 
AS
RETURN
(
	select c.Name as 'Curso' 
	from practica1.CourseTutor ct 
	inner join practica1.Course c on c.CodCourse = ct.CourseCodCourse 
	inner join practica1.Usuarios u on u.Id = ct.TutorId 
	inner join practica1.TutorProfile tp on tp.UserId  = u.Id 
	where tp.Id = @idTutorProfile
)

CREATE FUNCTION practica1.F3(@idUsuario uniqueidentifier) --Func_notification_usuario(IdUsuario)
RETURNS TABLE 
AS
RETURN
(
	select n.Message 
	from practica1.Notification n 
	inner join practica1.Usuarios u on u.Id = n.UserId
	where u.Id = @idUsuario
)

CREATE FUNCTION practica1.F4() --Func_logger()
RETURNS TABLE 
AS
RETURN
(
	select * from practica1.HistoryLog
)

CREATE FUNCTION practica1.F5 (@idUsuario uniqueidentifier) --Func_usuarios(IdUsuario) 
RETURNS TABLE 
AS
RETURN
(
	select u.Firstname, u.Lastname, u.Email, u.DateOfBirth, ps.Credits, r.RoleName  
	from practica1.Usuarios u 
	inner join practica1.ProfileStudent ps on ps.UserId = u.Id 
	inner join practica1.UsuarioRole ur on ur.RoleId = u.Id 
	inner join practica1.Roles r on r.Id = ur.RoleId 
	where u.Id = @idUsuario
)

-----------------------LLAMAR FUNCIONES--------------------------------------------

--select * from practica1.F1(772);

--select * from practica1.F2(2);

--select * from practica1.F3('4B1599A9-6A5A-46E6-B6C9-4E6E901E60D9');

--select * from practica1.F4();

--select * from practica1.F5('4B1599A9-6A5A-46E6-B6C9-4E6E901E60D9');

