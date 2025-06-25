from PIL import Image
import os

def remove_comments_from_mem(mem_path):
    cleaned_lines = []
    with open(mem_path, "r") as f:
        for line in f:
            line = line.strip()
            if line and not line.startswith("//"):
                try:
                    val = int(line, 16)
                    if val > 255:
                        raise ValueError("Byte overflow")
                    cleaned_lines.append(f"{val:02X}\n")
                except:
                    continue
    with open(mem_path, "w") as f:
        f.writelines(cleaned_lines)

def read_mem_file(path):
    with open(path) as f:
        return [int(line.strip(), 16) for line in f if line.strip() and not line.strip().startswith("//")]

def mem_to_image(r_file, g_file, b_file, output_image, size=(128, 128)):
    script_dir = os.path.dirname(os.path.abspath(__file__))

    r_path = os.path.join(script_dir, r_file)
    g_path = os.path.join(script_dir, g_file)
    b_path = os.path.join(script_dir, b_file)
    out_path = os.path.join(script_dir, output_image)

    for path in [r_path, g_path, b_path]:
        remove_comments_from_mem(path)

    R = read_mem_file(r_path)
    G = read_mem_file(g_path)
    B = read_mem_file(b_path)

    if not (len(R) == len(G) == len(B) == size[0] * size[1]):
        raise ValueError("Mismatch in channel lengths or wrong size")

    pixels = list(zip(R, G, B))
    img = Image.new('RGB', size)
    img.putdata(pixels)
    img.save(out_path)
    print(f"Image saved as: {out_path}")

if __name__ == "__main__":
    mem_to_image("R_decrypted.mem", "G_decrypted.mem", "B_decrypted.mem", "decrypted.png")
