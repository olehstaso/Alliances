using System;
using System.Collections.Generic;

namespace Alliances.Models
{
    public partial class Countries
    {
        public Guid Id { get; set; }
        public string Name { get; set; }
        public Guid ContinentId { get; set; }

        public virtual Continents Continent { get; set; }
    }
}
