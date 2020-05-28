struct DataSocket {
        NSString *ipAddress;
        int port;
};

DataSocket MakeDataSocket (NSString *ip, int port) {
    data DataSocket;
    data.ipAddress = ip;
    data.port = port;
    return data;
}