using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Management;
using System.Net;
using System.Net.Sockets;
using System.Text;


namespace XianThiDesktopServer.Sockets
{
    public class Listener
    {
        Socket _Socket;
        int _Port;
        int _MaxConnectionQueue;

        public string GetProcessOwner(int processId)
        {
            string query = "Select * From Win32_Process Where ProcessID = " + processId;
            ManagementObjectSearcher searcher = new ManagementObjectSearcher(query);
            ManagementObjectCollection processList = searcher.Get();

            foreach (ManagementObject obj in processList)
            {
                string[] argList = new string[] { string.Empty, string.Empty };
                int returnVal = Convert.ToInt32(obj.InvokeMethod("GetOwner", argList));
                if (returnVal == 0)
                {
                    // return DOMAIN\user
                    return argList[1] + "\\" + argList[0];
                }
            }

            return "NO OWNER";
        }

        public Listener(int port, int maxConnectionQueue)
        {
            _Port = port;
            _MaxConnectionQueue = maxConnectionQueue;
            _Socket = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);
        }

        public void Start()
        {
            IPEndPoint ipEndPoint = new IPEndPoint(IPAddress.Any, _Port);
            _Socket.Bind(ipEndPoint);
            _Socket.Listen(_MaxConnectionQueue);
            _Socket.BeginAccept(OnBeginAccept, _Socket);
        }
        void OnBeginAccept(IAsyncResult asyncResult)
        {
            Socket socket = _Socket.EndAccept(asyncResult);
            Client client = new Client(socket);
            client._OnDataReceived += new OnDataReceived(OnDataReceived);
            client.Start();
            _Socket.BeginAccept(OnBeginAccept, null);
        }

        void OnDataReceived(String gelenveri)
        {
            string[] command = gelenveri.Split(':');
            if (command[0] == ".volume")
            {
                int value = Convert.ToInt32(command[1]);
                VolumeManager.setVolume(value);
            }
            if(command[0] == ".kill")
            {
                bool found = false;
                foreach (System.Diagnostics.Process p in System.Diagnostics.Process.GetProcesses())
                {
                    if (p.MainWindowTitle.StartsWith(command[1], StringComparison.InvariantCultureIgnoreCase))
                    {
                        found = true;
                    }
                    if (p.ProcessName.StartsWith(command[1], StringComparison.InvariantCultureIgnoreCase)){
                        found = true;
                    }
                    if (found.Equals(true))
                    {
                        if (GetProcessOwner(p.Id) == GetProcessOwner(Process.GetCurrentProcess().Id))
                        {
                            p.Kill();
                        }
                    }
                    found = false;
                }
            }
        }
    }
}
