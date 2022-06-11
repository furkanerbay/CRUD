using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace CRUD
{
    static class Program
    {
        /// <summary>
        ///  The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main()
        {
            Application.SetHighDpiMode(HighDpiMode.SystemAware);
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            Application.Run(new Kategoriler());
            Application.Run(new Iller());
            Application.Run(new Firmalar());
            Application.Run(new Musteriler());
            Application.Run(new Calisanlar());
            Application.Run(new Saticilat());
            Application.Run(new Urunler());
            Application.Run(new Kargolar());
        }
    }
}
