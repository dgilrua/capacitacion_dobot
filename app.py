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

        self.response = "asdasd"
        
        self.label = tk.Label(root, text=self.update_label_text(), font=("Helvetica", 16))
        self.label.pack()
        
        self.label2 = tk.Label(root, text=self.response, font=("Helvetica", 16))
        self.label2.pack()
        
        self.create_buttons()

    def create_buttons(self):
        button_frame = tk.Frame(self.root)
        button_frame.pack(expand=True)

        button_size = {"width": 5, "height": 2, "font": ("Helvetica", 24)}

        up_button = tk.Button(button_frame, text="↑", command=self.increase_y, **button_size)
        up_button.grid(row=0, column=1)

        left_button = tk.Button(button_frame, text="←", command=self.decrease_x, **button_size)
        left_button.grid(row=1, column=0)

        right_button = tk.Button(button_frame, text="→", command=self.increase_x, **button_size)
        right_button.grid(row=1, column=2)

        down_button = tk.Button(button_frame, text="↓", command=self.decrease_y, **button_size)
        down_button.grid(row=2, column=1)
        
        open_button = tk.Button(button_frame, text="Open", command=self.open, **button_size)
        open_button.grid(row=3, column=0)
        
        send_button = tk.Button(button_frame, text="Send", command=self.send, **button_size)
        send_button.grid(row=3, column=1)
        
        close_button = tk.Button(button_frame, text="Close", command=self.close, **button_size)
        close_button.grid(row=3, column=2)


    def update_label_text(self):
        return f"X: {self.x}, Y: {self.y}"

    def increase_x(self):
        self.x += 1
        self.update_display()

    def decrease_x(self):
        self.x -= 1
        self.update_display()

    def increase_y(self):
        self.y += 1
        self.update_display()

    def decrease_y(self):
        self.y -= 1
        self.update_display()

    def update_display(self):
        self.label.config(text=self.update_label_text())
        
    def open(self):
        self.s.connect((self.ip, self.port))
        
    def close(self):
        self.s.send("close".encode())
        
    def send(self):
        self.s.send("go".encode())
        
if __name__ == "__main__":
    root = tk.Tk()
    app = ArrowKeyApp(root)
    root.mainloop()
