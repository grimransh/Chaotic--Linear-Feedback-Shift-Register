from PIL import Image
import os

def image_to_mem(image_path, output_prefix, size=(128, 128)):
    script_dir = os.path.dirname(os.path.abspath(__file__))
    
    image_full_path = os.path.join(script_dir, image_path)

    img = Image.open(image_full_path).convert('RGB').resize(size)
    pixels = list(img.getdata())

    R, G, B = [], [], []
    for r, g, b in pixels:
        R.append(r)
        G.append(g)
        B.append(b)

    # Save .mem files in the same folder as this .py file
    with open(os.path.join(script_dir, f'{output_prefix}R.mem'), 'w') as fR, \
         open(os.path.join(script_dir, f'{output_prefix}G.mem'), 'w') as fG, \
         open(os.path.join(script_dir, f'{output_prefix}B.mem'), 'w') as fB:
        for i in range(len(R)):
            fR.write(f"{R[i]:02X}\n")
            fG.write(f"{G[i]:02X}\n")
            fB.write(f"{B[i]:02X}\n")

    print(".mem files saved in:", script_dir)

if __name__ == "__main__":
    # Path to image is relative to this script file
    image_to_mem("../Images/antelope_128.jpg", "")
