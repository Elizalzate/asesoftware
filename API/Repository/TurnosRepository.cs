using Azure.Core;
using Core;
using Data;
using Microsoft.EntityFrameworkCore;

namespace Repository;

public class TurnosRepository : ITurnosRepository
{
    private readonly DatabaseConnection _db;

    public TurnosRepository(DatabaseConnection db)
    {
        _db = db;
    }

    public int CrearTurnos(ParametrosCreacionTurno parametros)
    {
        var fechaInicio = parametros.Fecha_inicio;
        var fechaFin = parametros.Fecha_fin;
        var IdServicio = parametros.IdServicio;

        var result = _db.Database
            .ExecuteSqlInterpolated(
            $"EXEC GenerarTurnos @FechaInicio={fechaInicio}, @FechaFin={fechaFin}, @IdServicio={IdServicio}");

        return result;

    }
}
