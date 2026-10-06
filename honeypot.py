import socket 
import sys
import datetime
import json
import threading
from pathlib import Path

# Configuring logging directory
LOG_DIR = Path("honeypot_logs")
LOG_DIR.mkdir(exist_ok=True)

class Honeypot:
    def __init__(self, bind_ip="0.0.0.0", ports=None):
        self.bind_ip = bind_ip
        self.ports = ports if ports else [22, 80, 443]  # Default ports: SSH, HTTP, HTTPS
        self.active_connections {}
        self.log_file = LOG_DIR / f"honeypot_log_{datetime.datetime.now().strftime('%Y%m%d')}.json"

    def log_activity(self, port, remote_ip, data):
        """ Log suspicious activity with timestamp and details to a JSON file. """
        log_entry = {
            "timestamp": datetime.datetime.now().isoformat(),
            "port": port,
            "remote_ip": remote_ip,
            "data": data.decode(errors='ignore') 
        }
        with open(self.log_file, 'a') as f:
            json.dump(activity, f)
            f.write('\n')

    def handle_connection(self, client_socket, addr, port):
        """ Handle incoming connections and log the activity. """
        service_banners = {
            21: "220 FTP server ready\r\n",
            22: "SSH-2.0-OpenSSH_8.2p1 Ubuntu-4ubuntu0.1\r\n",
            80: "HTTP/1.1 200 OK\r\nServer: Apache/2.4.41 (Ubuntu)\r\n\r\n",
            443: "HTTP/1.1 200 OK\r\nServer: Apache/2.4.41 (Ubuntu)\r\n\r\n"
        }
        # Send appropriate banner for the service 
        try: 
            if port in service_banners:
                client_socket.send(service_banners[port].encode())

            # Receive data from the client/attacker
            while True:
                data = client_socket.recv(1024)
                if not data:
                    break
                self.log_activity(port, addr[0], data)

                # respond with fake message to keep attacker engaged
                client_socket.send(b"Command not recognised\r\n")

        except Exception as e:
            print(f"Error handling connection from {addr[0]} on port {port}: {e}")
        finally: 
            client_socket.close()
            print(f"Connection from {addr[0]} on port {port} closed.")

    # Implement network listener for each port
    def start_listener(self, port):
        """Start a listener on the specified port."""
        try: 
            server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            server_socket.bind((self.bind_ip, port))
            server_socket.listen(5)
            print(f"Honeypot listening on {self.bind_ip}:{port}")

            while True:
                client, addr = server_socket.accept()
                print(f"[*] Connection from {addr[0]}:{addr[1]}")

                # Handle connection in a new thread
                client_handler = threading.Thread(
                    target=self.handle_connection,
                    args=(client, addr[0], port)
                )
                client_handler.start()
        except Exception as e: 
            print(f"Error starting listener on port {port}: {e}")

# Run the Honeypot
def main():
    honeypot = Honeypot()

    # Start listeners for each port in different threads
    for port in honeypot.ports:
        listener_thread = threading.Thread(
            target=honeypot.start_listener, 
            args=(port,))
        listener_thread.daemon = True  # allow program to exit even if threads are running
        listener_thread.start()
    try: 
        # Keep main thread alive to allow listeners to run
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        print("\n[*] Shutting down honeypot...")
        sys.exit(0)

if __name__ == "__main__":
    main()