using System;
using System.IO;
using System.Net.Sockets;
using System.Text;

namespace XianThiDesktopServer.Sockets
{
    public delegate void OnDataReceived(String gelenveri);
    public class Client
    {
        public OnDataReceived _OnDataReceived;
        Socket _Socket;
        SocketError socketError;
        byte[] tempBuffer = new byte[1024];
        public Client(Socket socket)
        {
            _Socket = socket;
        }
        public void Start()
        {
            Console.WriteLine("client connected : " + _Socket.RemoteEndPoint.ToString());
            _Socket.BeginReceive(tempBuffer, 0, tempBuffer.Length, SocketFlags.None, OnBeginReceiveCallback, null);
        }
        void OnBeginReceiveCallback(IAsyncResult asyncResult)
        {
            int receivedDataLength = _Socket.EndReceive(asyncResult, out socketError);
            if (receivedDataLength <= 0 && socketError != SocketError.Success)
            {
                Console.WriteLine("client disconnected : " + _Socket.RemoteEndPoint.ToString());
                return;
            }
            byte[] resizedBuffer = new byte[receivedDataLength];

            Array.Copy(tempBuffer, 0, resizedBuffer, 0, resizedBuffer.Length);
            HandleReceivedData(resizedBuffer);
            _Socket.BeginReceive(tempBuffer, 0, tempBuffer.Length, SocketFlags.None, OnBeginReceiveCallback, null);
        }
        void HandleReceivedData(byte[] resizedBuffer)
        {
            if (_OnDataReceived != null)
            {
                using (var ms = new MemoryStream(resizedBuffer))
                {
                    if (ms.Length > 0)
                    {
                        String gelenveri = Encoding.ASCII.GetString(ms.ToArray());
                        _OnDataReceived(gelenveri);
                    }
                }
            }
        }
    }
}
