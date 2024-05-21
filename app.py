import tkinter as tk

class ArrowKeyApp:
    def __init__(self, root):
        self.root = root
        self.root.title("Arrow Key App")

        self.x = 0
        self.y = 0

        self.canvas = tk.Canvas(root, width=300, height=300)
        self.canvas.pack()

        self.label = tk.Label(root, text=self.update_label_text(), font=("Helvetica", 16))
        self.label.pack()

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

        # Empty labels to center the button frame
       

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

if __name__ == "__main__":
    root = tk.Tk()
    app = ArrowKeyApp(root)
    root.mainloop()
