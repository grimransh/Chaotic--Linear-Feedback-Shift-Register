from PIL import Image
import os

def mem_to_image(r_path, g_path, b_path, output_image, size=(128, 128)):
    script_dir = os.path.dirname(os.path.abspath(__file__))

    r_path = os.path.join(script_dir, r_path)
    g_path = os.path.join(script_dir, g_path)
    b_path = os.path.join(script_dir, b_path)
    output_image = os.path.join(script_dir, output_image)

    # Read hex data from .mem files
    with open(r_path) as fR, open(g_path) as fG, open(b_path) as fB:
        R = [int(line.strip(), 16) for line in fR]
        G = [int(line.strip(), 16) for line in fG]
        B = [int(line.strip(), 16) for line in fB]

    # Sanity check
    if not (len(R) == len(G) == len(B) == size[0] * size[1]):
        raise ValueError("Mismatch in data size or image dimensions.")

    # Create image from pixel data
    pixels = list(zip(R, G, B))
    img = Image.new('RGB', size)
    img.putdata(pixels)
    img.save(output_image)
    print(f" Image reconstructed and saved as: {output_image}")

if __name__ == "__main__":
    mem_to_image("antelope_R.mem", "antelope_G.mem", "antelope_B.mem", "reconstructed_antelope.png")
