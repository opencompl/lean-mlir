import os
import re
import subprocess

def extract_mlir_functions(input_filepath, output_dir="extracted_mlir_functions", max_functions=200):
    """
    Extracts individual MLIR module blocks (functions) from a large input file
    and saves each into a separate file.
    Additionally, runs `mlir-opt -convert-arith-to-llvm` on each generated MLIR file,
    saving the converted output to a new file.
    Furthermore, it compiles the LLVM dialect MLIR to LLVM IR (.ll) and then
    to RISC-V assembly (.s) using `llc`.

    Args:
        input_filepath (str): The path to the large MLIR input file.
        output_dir (str): The directory where the extracted function files will be saved.
                          Defaults to "extracted_mlir_functions".
        max_functions (int): The maximum number of functions to extract. Defaults to 200.
    """
    if not os.path.exists(output_dir):
        os.makedirs(output_dir)
        print(f"Created output directory: '{output_dir}'")

    try:
        with open(input_filepath, 'r') as f:
            content = f.read()
    except FileNotFoundError:
        print(f"Error: Input file '{input_filepath}' not found. 😟")
        return
    except Exception as e:
        print(f"Error reading input file: {e} 😟")
        return

    delimiter_pattern = r'\n// -{5,}.*?\n'
    blocks = re.split(delimiter_pattern, content, flags=re.DOTALL)

    function_count = 0
    for i, block_content in enumerate(blocks):
        if function_count >= max_functions:
            print(f"Reached maximum of {max_functions} functions. Stopping extraction. ✋")
            break

        clean_block = block_content.strip()

        if clean_block and 'module {' in clean_block:
            function_count += 1
            
            original_mlir_filename = os.path.join(output_dir, f"function_{function_count}.mlir")
            
            try:
                with open(original_mlir_filename, 'w') as out_f:
                    out_f.write(clean_block)
                    out_f.write('\n')
                print(f"Extracted function {function_count} to '{original_mlir_filename}' ✨")

                # --- Run mlir-opt for conversion to LLVM dialect ---
                llvm_mlir_filename = os.path.join(output_dir, f"function_{function_count}_llvm.mlir")
                print(f"  Converting '{original_mlir_filename}' to LLVM dialect... 🔄")
                
                mlir_opt_command = [
                    "mlir-opt",
                    original_mlir_filename,
                    "-convert-arith-to-llvm",
                    "-convert-func-to-llvm",
                    "--mlir-print-op-generic",
                    "-o", llvm_mlir_filename
                ]
                
                subprocess.run(mlir_opt_command, check=True, capture_output=True, text=True)
                print(f"  Successfully converted to LLVM dialect: '{llvm_mlir_filename}'. ✅")

                # --- NEW: Compile LLVM dialect MLIR to LLVM IR (.ll) ---
                llvm_ir_filename = os.path.join(output_dir, f"function_{function_count}.ll")
                print(f"  Compiling '{llvm_mlir_filename}' to LLVM IR... ➡️")

                mlir_translate_command = [
                    "mlir-translate",
                    "--mlir-to-llvmir", # This flag converts LLVM dialect MLIR to LLVM IR
                    llvm_mlir_filename,
                    "-o", llvm_ir_filename
                ]

                subprocess.run(mlir_translate_command, check=True, capture_output=True, text=True)
                print(f"  Successfully generated LLVM IR: '{llvm_ir_filename}'. ✅")

                # --- NEW: Compile LLVM IR to RISC-V assembly (.s) using llc ---
                riscv_assembly_filename = os.path.join(output_dir, f"function_{function_count}.s")
                print(f"  Compiling '{llvm_ir_filename}' to RISC-V assembly using llc... 🎯")
                
                # Make sure your LLVM installation includes llc and the RISC-V backend.
                # Use '-mtriple=riscv64-unknown-elf' for 64-bit RISC-V or 'riscv32-unknown-elf' for 32-bit.
                # Adjust '-march' based on your target RISC-V architecture (e.g., rv64imafdc for generic 64-bit).
                llc_command = [
                    "llc",
                    "-march=riscv64", #  targeting RISC-V 64-bit.
                    "-mcpu=generic-rv64", # Example CPU, adjust as needed.
                    "-mattr=+m,+b",
                    "-filetype=asm", 
                    "-O0",     # Output assembly file
                    llvm_ir_filename,
                    "-o", riscv_assembly_filename
                ]
#llc -O0 -march=riscv64 -mattr=+m,+b my_program.ll -o my_program.s
                subprocess.run(llc_command, check=True, capture_output=True, text=True)
                print(f"  Successfully generated RISC-V assembly: '{riscv_assembly_filename}'. ✅")

            except FileNotFoundError as fnfe:
                print(f"Error: Command not found. Make sure 'mlir-opt', 'mlir-translate', and 'llc' are in your PATH. ❌ Details: {fnfe}")
                continue
            except subprocess.CalledProcessError as e:
                print(f"Error during command execution on '{original_mlir_filename}': ❌")
                print(f"  Command: {' '.join(e.cmd)}")
                print(f"  Return Code: {e.returncode}")
                print(f"  stdout: {e.stdout.strip()}")
                print(f"  stderr: {e.stderr.strip()}")
                continue
            except Exception as e:
                print(f"An unexpected error occurred: {e} 💥")
                continue
        elif clean_block:
            pass

    print(f"\nFinished extraction and compilation. Total {function_count} functions processed into '{output_dir}/'. 🎉")

if __name__ == "__main__":
    input_file = "out2.mlir" # <<< IMPORTANT: Change this to your actual input file name
    extract_mlir_functions(input_file, "2riscv_output_files", 1000)