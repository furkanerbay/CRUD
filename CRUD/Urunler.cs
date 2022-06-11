using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

namespace CRUD
{
    public partial class Urunler : Form
    {
        public Urunler()
        {
            InitializeComponent();
        }

        SqlConnection con = new SqlConnection(@"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=Turkiye_Kargo_Takip;Integrated Security=True;Connect Timeout=30;Encrypt=False;TrustServerCertificate=False;ApplicationIntent=ReadWrite;MultiSubnetFailover=False");

        private void button1_Click(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand com = new SqlCommand("exec dbo.UrunEkle '" + textBox2.Text +  "','" + int.Parse(textBox3.Text) + "','" + int.Parse(textBox4.Text) + "','" + textBox5.Text + "'", con);
            com.ExecuteNonQuery();
            con.Close();
            MessageBox.Show("Ekleme basarili.");
            LoadAllRecords();
        }

        void LoadAllRecords()
        {
            SqlCommand com = new SqlCommand("exec dbo.UrunlerinHepsi", con);
            SqlDataAdapter da = new SqlDataAdapter(com);
            DataTable dt = new DataTable();
            da.Fill(dt);
            dataGridView1.DataSource = dt;
        }

        private void button2_Click(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand com = new SqlCommand("exec dbo.UrunlerinHepsi ", con);
            con.Close();
            MessageBox.Show("Kayitlari getirme islemi basarili.");
            LoadAllRecords();
        }

        private void button4_Click(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand com = new SqlCommand("exec dbo.UrunSil '" + int.Parse(textBox1.Text) + "'", con);
            com.ExecuteNonQuery();
            con.Close();
            MessageBox.Show("Silme islemi basarili.");
            LoadAllRecords();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand com = new SqlCommand("exec dbo.UrunGuncelle'" + int.Parse(textBox1.Text) + "','" + textBox2.Text + "','" + int.Parse(textBox3.Text) + "','" + int.Parse(textBox4.Text) + "','" + textBox5.Text + "'", con);
            com.ExecuteNonQuery();
            con.Close();
            MessageBox.Show("Guncelleme basarili.");
            LoadAllRecords();
        }
    }
}
