#!/usr/bin/env python3
import re
import json

def preprocess_lean_content(content):
    """Removes comments from Lean code to prevent parsing errors."""
    # 1. Remove block comments /- ... -/ (non-greedy)
    content = re.sub(r'/-.*?(-/|$)', '', content, flags=re.DOTALL)
    
    # 2. Remove line comments -- ...
    content = re.sub(r'--.*', '', content)

    # 3. Remove 'import' lines (handles multi-line imports if they exist)
    content = re.sub(r'^\s*import\s+.*$', '', content, flags=re.MULTILINE)
    
    # 4. Remove 'open' lines
    content = re.sub(r'^\s*open\s+.*$', '', content, flags=re.MULTILINE)
    
    return content

def convert_lean_to_csv(input_file_path, output_file_path):
    # Regex pattern:
    # Captures the theorem name and the statement block between ':' and ':='
    theorem_pattern = re.compile(r"theorem\s+([\w\.]+)\s*:\s*(.*?)\s*:=\s*by", re.DOTALL)

    extracted_data = []

    try:
        with open(input_file_path, 'r', encoding='utf-8') as f:
            raw_content = f.read()

        # Clean the content before extraction
        clean_code = preprocess_lean_content(raw_content)

        # Find all theorem matches
        matches = theorem_pattern.findall(clean_code)

        for name, statement in matches:
            # Clean up whitespace and newlines within the statement
            flat_statement = " ".join(statement.split())
            extracted_data.append({
                "theorem_name": name,
                "statement": flat_statement
            })

        # Write to jsonl
        with open(output_file_path, 'w', newline='', encoding='utf-8') as f:
            for datum in extracted_data:
                f.write(json.dumps(datum) + '\n')
        print(f"Done! Extracted {len(extracted_data)} theorems to '{output_file_path}'.")

    except FileNotFoundError:
        print(f"Error: The file '{input_file}' was not found.")
    except Exception as e:
        print(f"An error occurred: {e}")

if __name__ == "__main__":
    # Update these filenames as needed
    convert_lean_to_csv('instcombine-merged.lean', 'lean_dataset.jsonl')

