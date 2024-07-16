#!/usr/bin/env sh

#!/bin/bash

# Create the lean directory if it doesn't exist
mkdir -p lean-mlir/SSA/Projects/InstCombine/lean
rm lean-mlir/SSA/Projects/InstCombine/lean/*
# Loop through all files in combined-mlir directory
for file in combined-mlir/*.ll.mlir; do
    # Extract the base name of the file
    base_name=$(basename "$file" .ll.mlir)

    # Check if corresponding file exists in before-mlir and both are non-empty
    if [ -s "before-mlir/${base_name}.ll.mlir" ] && [ -s "$file" ]; then
        # Create output file
        output_file="lean-mlir/SSA/Projects/InstCombine/lean/${base_name}.lean"
        > "$output_file"

        echo "import SSA.Projects.InstCombine.LLVM.PrettyEDSL" >> "$output_file"
        echo "import SSA.Projects.InstCombine.AliveStatements" >> "$output_file"
        echo "import SSA.Projects.InstCombine.Refinement" >> "$output_file"
        echo "import SSA.Projects.InstCombine.Tactic" >> "$output_file"

        echo "open MLIR AST" >> "$output_file"
        echo "open Std (BitVec)" >> "$output_file"
        echo "open Ctxt (Var)" >> "$output_file"

        echo "namespace  $base_name" >> "$output_file"
        echo "set_option pp.proofs false" >> "$output_file"
        echo "set_option pp.proofs.withType false" >> "$output_file"
        echo "set_option linter.deprecated false" >> "$output_file"


        # Process before-mlir file
        sed -n '/^  llvm\.func @.*{$/,/^  }$/p' "before-mlir/${base_name}.ll.mlir" | while IFS= read -r line; do
           printf 'before line is %s\n' "$line"
            if [[ $line =~  llvm\.func\ @(.+)\( ]]; then
                func_name="${BASH_REMATCH[1]}"
                printf "%s\n" "def ${func_name}_before := [llvmfunc|" >> "$output_file"
                printf "%s\n" "$line" >> "$output_file"
            elif [[ $line =~ "}" ]]; then
                printf "%s\n" "$line]" >> "$output_file"
                printf "%s\n" "" >> "$output_file"
            else
                printf "%s\n" "$line" >> "$output_file"
            fi
        done

        # Process combined-mlir file
        sed -n '/^  llvm\.func @.*{$/,/^  }$/p' "$file" | while IFS= read -r line; do
            printf "line combined is %s\n" $line
            if [[ $line =~  llvm\.func\ @(.+)\( ]]; then
                func_name="${BASH_REMATCH[1]}"
                printf "%s\n" "def ${func_name}_combined := [llvmfunc|" >> "$output_file"
                printf "%s\n" "$line" >> "$output_file"
            elif [[ $line =~ "  }" ]]; then
                printf "%s\n" "$line]" >> "$output_file"
                printf "%s\n" "" >> "$output_file"

                echo "theorem inst_combine_$func_name   : ${func_name}_before  ⊑  ${func_name}_combined := by" >> "$output_file"
                printf "%s\n" "  unfold ${func_name}_before ${func_name}_combined"  >> "$output_file"
                printf "%s\n" "  simp_alive_peephole"  >> "$output_file"
                printf "%s\n" "  sorry"  >> "$output_file"

            else
                printf "%s\n" "$line" >> "$output_file"
            fi
        done
    fi
done

# # Ensure the lean directory exists
# mkdir -p lean

# # Loop through all files in combined-mlir
# for file in combined-mlir/*.ll.mlir; do
#     # Extract the base name
#     base=$(basename "$file" .ll.mlir)

#     # Check if corresponding file exists in before-mlir and both are non-empty
#     if [ -s "before-mlir/${base}.ll.mlir" ] && [ -s "$file" ]; then
#         # Create output file
#         output_file="lean/${base}.lean"
#         > "$output_file"

#         # Process before-mlir file
#         while IFS= read -r line; do
#             if [[ $line =~ ^[[:space:]]*llvm\.func[[:space:]]@([[:alnum:]_]+)[[:space:]] ]]; then
#                 func_name="${BASH_REMATCH[1]}"
#                 printf "%s\n" "def ${func_name}_before := [llvmfunc|" >> "$output_file"
#                 printf "%s\n" "$line" >> "$output_file"
#                 while IFS= read -r func_line && [[ $func_line != "}" ]]; do
#                     printf "%s\n" "$func_line" >> "$output_file"
#                 done
#                 printf "%s\n" "}" >> "$output_file"
#                 printf "%s\n" "]" >> "$output_file"
#                 printf "%s\n" "" >> "$output_file"
#             fi
#         done < "before-mlir/${base}.ll.mlir"

#         # Process combined-mlir file
#         while IFS= read -r line; do
#             if [[ $line =~ ^[[:space:]]*llvm\.func[[:space:]]@([[:alnum:]_]+)[[:space:]] ]]; then
#                 func_name="${BASH_REMATCH[1]}"
#                 printf "%s\n" "def ${func_name}_combined := [llvmfunc|" >> "$output_file"
#                 printf "%s\n" "$line" >> "$output_file"
#                 while IFS= read -r func_line && [[ $func_line != "}" ]]; do
#                     printf "%s\n" "$func_line" >> "$output_file"
#                 done
#                 printf "%s\n" "}" >> "$output_file"
#                 printf "%s\n" "]" >> "$output_file"
#                 printf "%s\n" "" >> "$output_file"
#             fi
#         done < "$file"
#     fi
# done
