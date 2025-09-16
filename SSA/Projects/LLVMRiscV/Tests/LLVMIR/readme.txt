
This test folder will describe an end-to-end integration test for the entire pipeline at some point 

VERSION 01: 

Step 1:
Start by defining an LLVM IR file (for example, addLLVM.ll).
Step 2:
Run the processing script to convert and process the file:
./process.sh addLLVM.ll
This script:
Translates the first function in the LLVM IR file into its MLIR LLVM IR dialect form.
Produces out.mlir as the output file where the extracted function is written in MLIR generic syntax.
Then invokes the opt tool with that file and writes bakc into out.mlir whatever the output of opt is,

VERSION 02

If you want to preprocess the file and then manually run the optimizer, you can:
Preprocess the file:
./preprocess.sh addLLVM.ll where addLLVM.ll is the name of your LLVM IR file.
Then switch to the root folder:
cd ../../../../../
Finally, run the optimizer using Lake:
lake exe opt SSA/Projects/LLVMRiscV/tests/LLVMIR/out.mlir