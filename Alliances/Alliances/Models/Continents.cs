using System;
using System.Collections.Generic;

namespace Alliances.Models
{
    public partial class Continents
    {
        public Continents()
        {
            Countries = new HashSet<Countries>();
        }

        public Guid Id { get; set; }
        public string Name { get; set; }

        public virtual ICollection<Countries> Countries { get; set; }
    }
}
