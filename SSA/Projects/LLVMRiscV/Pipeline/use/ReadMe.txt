Here we describe how to apply use our instruction selection and apply to an LLVM IR  file.
There are several options dependeing on the desired output format.

Eitherway we assume the input format to be of the following format:

define <rty> @function(<ty> %i, ....) {
    entry:
    ....
     ret <rty> %some
    }
    
     define i32 @main(....) {
      %out = call <rty> @function(...)
      ret <rty>%out
    

      Where the function will be lowered by our pass. 

1.)  Either pass the file to the opt tool and observe the lowerig the terminal:
to do: the complete command.

2.) Add a file to this folder and run <to do> and observe the extracted lowering of your function in
equally named output file.

