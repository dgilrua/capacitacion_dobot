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
        
        
        self.create_buttons()

    def create_buttons(self):
        button_frame = tk.Frame(self.root)
        button_frame.pack(expand=True)

        button_size = {"width": 5, "height": 2, "font": ("Helvetica", 24)}

        tk.Label(button_frame, text="X").grid(row=0, column=0)
        up_button_x = tk.Button(button_frame, text="↑", command=self.increase_x, **button_size)
        up_button_x.grid(row=1, column=0)

        down_button_x = tk.Button(button_frame, text="↓", command=self.decrease_x, **button_size)
        down_button_x.grid(row=2, column=0)
        
        tk.Label(button_frame, text="Y").grid(row=0, column=1)
        up_button_y = tk.Button(button_frame, text="↑", command=self.increase_y, **button_size)
        up_button_y.grid(row=1, column=1)

        down_button_y = tk.Button(button_frame, text="↓", command=self.decrease_y, **button_size)
        down_button_y.grid(row=2, column=1)
        
        tk.Label(button_frame, text="Z").grid(row=0, column=2)
        up_button_z = tk.Button(button_frame, text="↑", command=self.increase_z, **button_size)
        up_button_z.grid(row=1, column=2)

        down_button_x = tk.Button(button_frame, text="↓", command=self.decrease_z, **button_size)
        down_button_x.grid(row=2, column=2)

        open_button = tk.Button(button_frame, text="Open", command=self.open, **button_size)
        open_button.grid(row=3, column=0)
        
        close_button = tk.Button(button_frame, text="Close", command=self.close, **button_size)
        close_button.grid(row=3, column=2)


    def update_label_text(self):
        return f"X: {self.x}, Y: {self.y}, Z: {self.z}"

    def increase_x(self):
        self.x += 10
        self.update_display()
        self.send()

    def decrease_x(self):
        self.x -= 10
        self.update_display()
        self.send()

    def increase_z(self):
        self.z += 10
        self.update_display()
        self.send()

    def decrease_z(self):
        self.z -= 10
        self.update_display()
        self.send()

    def increase_y(self):
        self.y += 10
        self.update_display()
        self.send()

    def decrease_y(self):
        self.y -= 10
        self.update_display()
        self.send()

    def update_display(self):
        self.label.config(text=self.update_label_text())
        
    def open(self):
        self.s.connect((self.ip, self.port))
        
    def close(self):
        self.s.send("close".encode())
        
    def send(self):
        self.s.send(f"{self.x},{self.y},{self.z},{0}".encode())
        
if __name__ == "__main__":
    root = tk.Tk()
    app = ArrowKeyApp(root)
    root.mainloop()
