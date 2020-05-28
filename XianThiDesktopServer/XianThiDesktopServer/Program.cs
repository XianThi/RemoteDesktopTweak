using System;
using System.Linq.Expressions;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Threading;
using XianThiDesktopServer.Sockets;

namespace XianThiDesktopServer
{
    class Program
    {
        public static void Main(String[] args){
            int port = 2525;
            Console.WriteLine(string.Format("Server Başlatıldı. Port: {0}", port));
            Console.WriteLine("-----------------------------");
            Listener listener = new Listener(port, 50);
            listener.Start();
            Console.ReadLine();
        }
    }
}