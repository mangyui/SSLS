using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.IO;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.Text;

namespace SSLS.WebUI.Models
{
    public class ValidataCode
    {
        public static byte[] GetVerifyCode(string Code)
        {
            byte[] data = null;
            //随机获取5位验证码
            //string Code = MyRandom(5);
            //创建画板，画板大小70*30，这个可以修改
            Bitmap MyBt = new Bitmap(120, 60);
            //创建画笔
            Graphics gp = Graphics.FromImage(MyBt);
            //填充画板为白色，2和-2会让验证码的图片出现边框
            gp.FillRectangle(Brushes.White, 0, 0, MyBt.Width, MyBt.Height);
            //绘制验证码
            gp.DrawString(Code, new Font("Verdana", 21), Brushes.Black, new PointF(2, 5));
            //绘制噪线
            Random rand = new Random();
            for (int i = 0; i < 5; i++)
            {
                gp.DrawLine(new Pen(RandColor()), rand.Next(MyBt.Width), rand.Next(MyBt.Height), rand.Next(MyBt.Width), rand.Next(MyBt.Height));
            }
            //绘制噪点
            for (int i = 0; i < 105; i++)
            {
                MyBt.SetPixel(rand.Next(MyBt.Width), rand.Next(MyBt.Height), RandColor());

            }
            //释放资源
            gp.Dispose();
            //保存图片
            MemoryStream ms = new MemoryStream();
        //    MyBt.Save(ms, ImageFormat.Jpeg);
            data = ms.GetBuffer();
            try
            {
                MyBt.Save(ms, ImageFormat.Gif);
                return ms.ToArray();
            }
            catch (Exception)
            {
                return null;
            }
            finally
            {
                gp.Dispose();
                MyBt.Dispose();
            }
        }
        //产生len个验证码
        public static string MyRandom(int len)
        {
            //这里是验证码出现的字符，可以更改，可以为中文。中文得修改画板的大小
            String words = "1234567890qwertyuopasdfghjklxcvbnm";
            StringBuilder sb = new StringBuilder();
            Random rand = new Random();
            for (int i = 0; i < len; i++)
            {
                int index = rand.Next(0, words.Length);
                char ch = words[index];
                sb.Append(words[index] + "");
            }
            return sb.ToString();
        }
        //随机产生颜色，为噪点和噪线。
        public static Color RandColor()
        {
            Random rand = new Random();
            int red = rand.Next(10, 200);
            int green = rand.Next(10, 200);
            int blue = rand.Next(10, 200);
            return Color.FromArgb(red, green, blue);
        }

    }
}
