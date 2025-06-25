from PIL import Image
import os

def image_to_mem(relative_image_path, output_prefix="", size=(128, 128)):
    script_dir = os.path.dirname(os.path.abspath(__file__))
    image_full_path = os.path.join(script_dir, relative_image_path)

    img = Image.open(image_full_path).convert('RGB').resize(size)
    pixels = list(img.getdata())
    R, G, B = zip(*pixels)

    with open(os.path.join(script_dir, f'{output_prefix}R.mem'), 'w') as fR, \
         open(os.path.join(script_dir, f'{output_prefix}G.mem'), 'w') as fG, \
         open(os.path.join(script_dir, f'{output_prefix}B.mem'), 'w') as fB:
        for r, g, b in zip(R, G, B):
            fR.write(f"{r:02X}\n")
            fG.write(f"{g:02X}\n")
            fB.write(f"{b:02X}\n")

    print(".mem files saved in:", script_dir)

if __name__ == "__main__":
    image_to_mem("../../Images/antelope_128.jpg")
