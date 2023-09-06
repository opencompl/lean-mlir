module  {
  llvm.func @isascii(i16) -> i16
  llvm.func @sink(i16)
  llvm.func @fold_isascii(%arg0: i16) {
    %0 = llvm.mlir.constant(-1 : i16) : i16
    %1 = llvm.mlir.constant(32767 : i16) : i16
    %2 = llvm.mlir.constant(256 : i16) : i16
    %3 = llvm.mlir.constant(255 : i16) : i16
    %4 = llvm.mlir.constant(128 : i16) : i16
    %5 = llvm.mlir.constant(127 : i16) : i16
    %6 = llvm.mlir.constant(1 : i16) : i16
    %7 = llvm.mlir.constant(0 : i16) : i16
    %8 = llvm.call @isascii(%7) : (i16) -> i16
    llvm.call @sink(%8) : (i16) -> ()
    %9 = llvm.call @isascii(%6) : (i16) -> i16
    llvm.call @sink(%9) : (i16) -> ()
    %10 = llvm.call @isascii(%5) : (i16) -> i16
    llvm.call @sink(%10) : (i16) -> ()
    %11 = llvm.call @isascii(%4) : (i16) -> i16
    llvm.call @sink(%11) : (i16) -> ()
    %12 = llvm.call @isascii(%3) : (i16) -> i16
    llvm.call @sink(%12) : (i16) -> ()
    %13 = llvm.call @isascii(%2) : (i16) -> i16
    llvm.call @sink(%13) : (i16) -> ()
    %14 = llvm.call @isascii(%1) : (i16) -> i16
    llvm.call @sink(%14) : (i16) -> ()
    %15 = llvm.call @isascii(%0) : (i16) -> i16
    llvm.call @sink(%15) : (i16) -> ()
    %16 = llvm.call @isascii(%arg0) : (i16) -> i16
    llvm.call @sink(%16) : (i16) -> ()
    llvm.return
  }
}
