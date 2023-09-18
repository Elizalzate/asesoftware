USE asesoft;
CREATE TABLE Comercios (
    id_comercio INT PRIMARY KEY IDENTITY(1,1),
    nom_comercio NVARCHAR(255),
    aforo_maximo INT
);

CREATE TABLE Servicios (
    id_servicio INT PRIMARY KEY IDENTITY(1,1),
	id_comercio INT,	
    nom_servicio NVARCHAR(255),
    hora_apertura TIME,
	hora_cierre TIME,
	duracion FLOAT
	FOREIGN KEY (id_comercio) REFERENCES Comercios(id_comercio)
);

CREATE TABLE Turnos (
    id_turno INT PRIMARY KEY IDENTITY(1,1),
	id_servicio INT,	
    fecha_turno DATE,
    hora_inicio DATETIME,
	hora_fin DATETIME,
	estado NVARCHAR(255)
	FOREIGN KEY (id_servicio) REFERENCES Servicios(id_servicio)
);

INSERT INTO Comercios (nom_comercio, aforo_maximo)
VALUES
    ('Peluquer�a Estilos', 25),
    ('Cafeter�a Carambolo', 50),
    ('Banco Ahorritos', 100)


INSERT INTO Servicios (id_comercio, nom_servicio, hora_apertura, hora_cierre, duracion)
VALUES
    (3, 'Transacciones en caja', '08:00:00', '17:00:00', 15),
	(3, 'Tr�mites generales', '08:00:00', '17:00:00', 30),
    (3, 'Solicitud de documentos', '08:00:00', '17:00:00', 40),
    (3, 'Asesor�a', '08:00:00', '17:00:00', 60)


CREATE PROCEDURE GenerarTurnos
    @FechaInicio DATE,
    @FechaFin DATE,
    @IdServicio INT
AS
BEGIN
    DECLARE @HoraApertura TIME;
    DECLARE @HoraCierre TIME;
    DECLARE @DuracionServicio INT;
    DECLARE @FechaActual DATE;
    DECLARE @HoraActual TIME;

    -- Obtener la hora de apertura, hora de cierre y duraci�n del servicio
    SELECT @HoraApertura = hora_apertura, @HoraCierre = hora_cierre, @DuracionServicio = duracion
    FROM Servicios
    WHERE id_servicio = @IdServicio;

    -- Inicializar la fecha actual con la fecha de inicio
    SET @FechaActual = @FechaInicio;

    -- Bucle para generar los turnos diarios
    WHILE @FechaActual <= @FechaFin
    BEGIN
        SET @HoraActual = @HoraApertura;

        -- Generar los turnos durante el d�a
        WHILE @HoraActual < @HoraCierre
        BEGIN
            -- Insertar el turno en la tabla de turnos
            INSERT INTO Turnos (fecha_turno, hora_inicio, hora_fin)
            VALUES (@FechaActual, @HoraActual, DATEADD(MINUTE, @DuracionServicio, @HoraActual));

            -- Incrementar la hora actual por la duraci�n del servicio
            SET @HoraActual = DATEADD(MINUTE, @DuracionServicio, @HoraActual);
        END;

        -- Incrementar la fecha actual en 1 d�a
        SET @FechaActual = DATEADD(DAY, 1, @FechaActual);
    END;
END;
