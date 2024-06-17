import json
import os
import hashlib
import argparse

def get_file_info(file_path):
    # Mendapatkan ukuran file dalam bytes
    size = os.path.getsize(file_path)
    
    # Mendapatkan waktu pembuatan file (epoch time)
    datetime = int(os.path.getmtime(file_path))
    
    # Menghitung SHA256 hash dari file untuk menghasilkan ID
    hash_sha256 = hashlib.sha256()
    with open(file_path, "rb") as f:
        for chunk in iter(lambda: f.read(4096), b""):
            hash_sha256.update(chunk)
    file_id = hash_sha256.hexdigest()
    
    return datetime, size, file_id

def main():
    parser = argparse.ArgumentParser(description='Generate file information in JSON format.')
    parser.add_argument('file_path', type=str, help='Path to the file')
    args = parser.parse_args()
    
    # Mengambil informasi file
    datetime, size, file_id = get_file_info(args.file_path)
    
    # Mengatur data dalam format yang diinginkan
    data = {
        "response": [
            {
                "datetime": datetime,
                "filename": os.path.basename(args.file_path),
                "id": file_id,
                "romtype": "Community",  # Contoh value, bisa disesuaikan
                "size": size,
                "url": "",  # Contoh value, bisa disesuaikan
                "version": "14"  # Contoh value, bisa disesuaikan
            }
        ]
    }
    
    # Menyimpan data ke file JSON
    output_file = 'output.json'
    with open(output_file, 'w') as json_file:
        json.dump(data, json_file, indent=4)
    
    print(f"File '{output_file}' telah dibuat dengan sukses.")

if __name__ == "__main__":
    main()
