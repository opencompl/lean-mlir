We generated two large datasets usinng MLIR fuzz where one dataset contains functions 
containing up to two operands and one dataset contains functions up to 500 operands. 


Run splitter to split functions and convert into pure llvm dialect. Splitter also directly filter for empty functions