import os
import re
import subprocess # Import the subprocess module to run external commands

def extract_mlir_functions(input_filepath, output_dir="extracted_mlir_functions", max_functions=200):
    """
    Extracts individual MLIR module blocks (functions) from a large input file
    and saves each into a separate file.
    Additionally, runs `mlir-opt -convert-arith-to-llvm` on each generated file,
    saving the converted output to a new file.

    Args:
        input_filepath (str): The path to the large MLIR input file.
        output_dir (str): The directory where the extracted function files will be saved.
                          Defaults to "extracted_mlir_functions".
        max_functions (int): The maximum number of functions to extract. Defaults to 200.
    """
    if not os.path.exists(output_dir):
        # Create the output directory if it doesn't exist
        os.makedirs(output_dir)
        print(f"Created output directory: '{output_dir}'")

    try:
        with open(input_filepath, 'r') as f:
            content = f.read()
    except FileNotFoundError:
        print(f"Error: Input file '{input_filepath}' not found.")
        return
    except Exception as e:
        print(f"Error reading input file: {e}")
        return

    # The delimiter pattern: newline, then "// -", then at least three more hyphens,
    # followed by any characters (non-greedily) until the next newline.
    # This handles both "// -----" and "// ----- some text" as separators.
    # re.DOTALL ensures '.' matches newlines if there were unexpected multi-line separators,
    # though for this specific format, it's mostly for robustness.
    delimiter_pattern = r'\n// -{5,}.*?\n'
    
    # Split the content using the regex delimiter.
    # This will give us a list of strings, where each string is a block of content
    # that was between two delimiters.
    blocks = re.split(delimiter_pattern, content, flags=re.DOTALL)

    function_count = 0
    # Iterate through the extracted blocks.
    # The first block might contain a header comment before the first module.
    for i, block_content in enumerate(blocks):
        if function_count >= max_functions:
            print(f"Reached maximum of {max_functions} functions. Stopping extraction.")
            break

        # Strip leading/trailing whitespace (including newlines) from the block content.
        clean_block = block_content.strip()

        # Check if the cleaned block contains the start of an MLIR module.
        # This is how we identify a "function" (or program) block.
        if clean_block and 'module {' in clean_block:
            function_count += 1
            
            # Construct the output filename for the original extracted MLIR
            original_mlir_filename = os.path.join(output_dir, f"function_{function_count}.mlir")
            
            try:
                with open(original_mlir_filename, 'w') as out_f:
                    out_f.write(clean_block)
                    out_f.write('\n') # Add a newline at the end for standard file formatting
                print(f"Extracted function {function_count} to '{original_mlir_filename}'")

                # --- NEW: Run mlir-opt for conversion to LLVM dialect ---
                llvm_mlir_filename = os.path.join(output_dir, f"function_{function_count}_llvm.mlir")
                print(f"  Converting '{original_mlir_filename}' to LLVM dialect...")
                
                # The command to run mlir-opt
                # It reads from the original_mlir_filename and outputs to llvm_mlir_filename
                transform_command = [
                    "mlir-opt",
                    original_mlir_filename,
                    "-convert-arith-to-llvm",
                    "-convert-func-to-llvm",
                    "--mlir-print-op-generic",
                    "-o", llvm_mlir_filename # Output to a new file
                ]
                
                # Run the command. `check=True` raises an exception if the command fails.
                # `capture_output=True` captures stdout/stderr.
                result = subprocess.run(transform_command, check=True, capture_output=True, text=True)
                
                print(f"  Successfully converted to LLVM dialect: '{llvm_mlir_filename}'.")
                # Uncomment the lines below to see the stdout/stderr from mlir-opt
                # if result.stdout:
                #     print(f"  mlir-opt stdout: {result.stdout.strip()}")
                # if result.stderr:
                #     print(f"  mlir-opt stderr: {result.stderr.strip()}")

            except FileNotFoundError:
                print(f"Error: 'mlir-opt' command not found. Make sure it's in your PATH.")
                continue # Continue processing other files
            except subprocess.CalledProcessError as e:
                print(f"Error running mlir-opt on '{original_mlir_filename}':")
                print(f"  Return Code: {e.returncode}")
                print(f"  stdout: {e.stdout.strip()}")
                print(f"  stderr: {e.stderr.strip()}")
                # Continue processing other files even if one transformation fails
                continue
            except Exception as e:
                print(f"Error writing to file or during transformation: {e}")
                # Continue trying to extract other functions even if one fails
                continue
        elif clean_block:
            # This block contained content but no 'module {'.
            # It might be an initial header or a malformed block.
            # For the given format, we generally expect either empty blocks (due to `split`)
            # or blocks containing a `module {`. We'll just skip it.
            if i == 0 and clean_block.startswith(';'):
                # This handles the initial "; 136 649 programs" comment
                # if it's not followed by a 'module {' in the same block.
                # However, in your example, the 'module {' immediately follows it.
                pass 
            # print(f"Skipping block {i} as it does not appear to contain a module: \n{clean_block[:100]}...") # Uncomment for debugging
            pass


    print(f"\nFinished extraction. Total {function_count} functions extracted into '{output_dir}/'.")

# --- How to run this script ---
# 1. Save the large input file (e.g., your_huge_file.mlir) in the same directory as this script,
#    or provide its full path.
# 2. Run the script from your terminal:
#    python your_script_name.py

# Example usage:
# Replace 'your_huge_file.mlir' with the actual name or path of your large input file.
# You can also change the output directory or the maximum number of functions.
if __name__ == "__main__":
    # You might want to get the input file name from command-line arguments
    # import sys
    # if len(sys.argv) > 1:
    #     input_file = sys.argv[1]
    # else:
    #     print("Usage: python script_name.py <input_mlir_file>")
    #     sys.exit(1)
    
    # For demonstration, assume the file is named 'input.mlir'
    input_file = "out.mlir" # <<< IMPORTANT: Change this to your actual input file name
    extract_mlir_functions(input_file, "mlir_output_files", 200)

