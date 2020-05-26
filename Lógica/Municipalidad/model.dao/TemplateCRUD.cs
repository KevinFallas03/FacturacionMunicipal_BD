using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace model.dao
{
    interface TemplateCRUD<claseGenerica> // Recibe cualquier tipo de clase 
    {
        void create(claseGenerica objeto);
        void update(claseGenerica objeto);
        void delete(claseGenerica objeto);
        bool find(claseGenerica objeto);
        List<claseGenerica> findAll();
    }
}
