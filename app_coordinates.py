import tkinter as tk
import socket 

class ArrowKeyApp:
    def __init__(self, root):
        self.root = root
        self.root.title("Arrow Key App")

        self.x = 278
        self.y = 155
        self.z = -12.05
        
        self.ip = "192.168.1.6"
        self.port = 6601
        
        self.s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        
        self.canvas = tk.Canvas(root, width=300, height=300)
        self.canvas.pack()
        
        self.label = tk.Label(root, text=self.update_label_text(), font=("Helvetica", 16))
        self.label.pack()
        
        self.create_entrys()
        
        self.create_buttons()

    def create_entrys(self):
        entry_frame = tk.Frame(self.root)
        entry_frame.pack(expand=True)
        
        tk.Label(entry_frame, text="Valor X").grid(row=0, column=0, padx=10, pady=10)
        self.entry1 = tk.Entry(entry_frame)
        self.entry1.grid(row=0, column=1, padx=10, pady=10)
        
        tk.Label(entry_frame, text="Valor Y").grid(row=1, column=0, padx=10, pady=10)
        self.entry2 = tk.Entry(entry_frame)
        self.entry2.grid(row=1, column=1, padx=10, pady=10)
        
        tk.Label(entry_frame, text="Valor Z").grid(row=2, column=0, padx=10, pady=10)
        self.entry3 = tk.Entry(entry_frame)
        self.entry3.grid(row=2, column=1, padx=10, pady=10)
        
        tk.Label(entry_frame, text="Valor R").grid(row=3, column=0, padx=10, pady=10)
        self.entry4 = tk.Entry(entry_frame)
        self.entry4.grid(row=3, column=1, padx=10, pady=10)
    
    def create_buttons(self):
        button_frame = tk.Frame(self.root)
        button_frame.pack(expand=True)

        button_size = {"width": 5, "height": 2, "font": ("Helvetica", 24)}
        
        open_button = tk.Button(button_frame, text="Open", command=self.open, **button_size)
        open_button.grid(row=3, column=0)
        
        send_button = tk.Button(button_frame, text="Send", command=self.send, **button_size)
        send_button.grid(row=3, column=1)
        
        close_button = tk.Button(button_frame, text="Close", command=self.close, **button_size)
        close_button.grid(row=3, column=2)


    def update_label_text(self):
        return f"X: {self.x}, Y: {self.y}"

    def update_display(self):
        self.label.config(text=self.update_label_text())
        
    def open(self):
        self.s.connect((self.ip, self.port))
        
    def close(self):
        self.s.send("close".encode())
        
    def send(self):
        x = int(self.entry1.get())
        y = int(self.entry2.get())
        z = int(self.entry3.get())
        r = int(self.entry4.get())
        print(x, y, z, r)
        self.s.send(f"{x},{y},{z},{r}".encode())
        
if __name__ == "__main__":
    root = tk.Tk()
    app = ArrowKeyApp(root)
    root.mainloop()
