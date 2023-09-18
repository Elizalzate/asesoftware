using Core;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Repository;

public interface ITurnosRepository
{
    int CrearTurnos(ParametrosCreacionTurno parametros);
}
