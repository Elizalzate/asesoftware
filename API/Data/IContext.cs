using Core;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Data;

public interface IContext
{
    public List<Turno> Turnos { set; get; }
}
