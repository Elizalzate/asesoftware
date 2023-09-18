using Core;
using Repository;
using Microsoft.AspNetCore.Mvc;

namespace Turnos.Controllers;

[ApiController]
[Route("api/[controller]")]
public class TurnosController : ControllerBase
{

    private readonly TurnosRepository _turnos;

    public TurnosController(TurnosRepository turnos)
    {
        _turnos = turnos;
    }

    // Creación de turnos
    [HttpPost("crearTurnos")]
    public async Task<ActionResult<ParametrosCreacionTurno>> GenerarTurnos([FromBody] ParametrosCreacionTurno parametros)
    {
        var result = _turnos.CrearTurnos(parametros);
        
        return result == 0 ? BadRequest("No se pudieron generar los turnos") : Ok("Turnos generados exitosamente");
       
    }
    
}
