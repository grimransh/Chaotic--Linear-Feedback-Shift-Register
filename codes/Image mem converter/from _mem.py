from PIL import Image
import os

def remove_comments_from_mem(mem_path):
    """Remove comment lines from a .mem file and overwrite it."""
    with open(mem_path, "r") as fin:
        lines = [line for line in fin if line.strip() and not line.strip().startswith("//")]
    with open(mem_path, "w") as fout:
        fout.writelines(lines)

def read_mem_file(path):
    with open(path) as f:
        return [int(line.strip(), 16) for line in f if line.strip() and not line.strip().startswith("//")]

def mem_to_image(r_path, g_path, b_path, output_image, size=(128, 128)):
    script_dir = os.path.dirname(os.path.abspath(__file__))

    r_path = os.path.join(script_dir, r_path)
    g_path = os.path.join(script_dir, g_path)
    b_path = os.path.join(script_dir, b_path)
    output_image = os.path.join(script_dir, output_image)

    # Remove comments from .mem files (in-place)
    for mem_file in [r_path, g_path, b_path]:
        remove_comments_from_mem(mem_file)

    # Read hex data from .mem files, skipping comments
    R = read_mem_file(r_path)
    G = read_mem_file(g_path)
    B = read_mem_file(b_path)

    # Sanity check
    if not (len(R) == len(G) == len(B) == size[0] * size[1]):
        raise ValueError("Mismatch in data size or image dimensions.")

    # Create image from pixel data
    pixels = list(zip(R, G, B))
    img = Image.new('RGB', size)
    img.putdata(pixels)
    img.save(output_image)
    print(f"Image reconstructed and saved as: {output_image}")

if __name__ == "__main__":
    mem_to_image("R.mem", "G.mem", "B.mem", "jhtrkktrtr" \
    "rk.png")
