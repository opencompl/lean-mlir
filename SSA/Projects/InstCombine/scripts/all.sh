#!/usr/bin/env sh
# Directory containing the .lean files
DIR="./tests/LLVM"

# Output file
OUTPUT_FILE="all.lean"

# Initialize the output file
echo "" > $OUTPUT_FILE

# List all files in the directory, filter out *_proof.lean files, and process the remaining files
for file in "$DIR"/*.lean; do
  # Check if the file does not end with *_proof.lean
  if [[ ! $file =~ _proof\.lean$ ]]; then
    # Extract the filename without the directory path
    filename=$(basename "$file" .lean)
    # Append the import statement to the output file
    echo "import SSA.Projects.InstCombine.tests.LLVM.$filename" >> $OUTPUT_FILE
  fi
done

echo "all.lean file has been created with the necessary import statements."
