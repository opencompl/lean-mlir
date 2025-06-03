Here we describe how to apply use our instruction selection and apply to an LLVM IR  file.
There are several options depending on the desired output format.

Eitherway we assume the input format to be of the following format:
```
define <rty> @function(<ty> %i, ....) {
    entry:
    ....
     ret <rty> %some
    }
    
     define i32 @main(....) {
      %out = call <rty> @function(...)
      ret <rty>%out
    

     
```
Where the function will be lowered by our pass. 

IMPORTANT: succesfully run the either of the scripts (preprocess or process) the following programs must be installed:
- opt (LLVM optimizer)
- llc (LLVM code generator)
- lake (build system for Lean4& it requires Lean4 to be installed)
1.)  Either pass the file to the opt tool and observe the lowerig the terminal:
to do: the complete command.

2.) Add a file to this folder and run <to do> and observe the extracted lowering of your function in
equally named output file.

