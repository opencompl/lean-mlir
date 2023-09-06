module  {
  llvm.func @fls(i16) -> i16
  llvm.func @sink(i16)
  llvm.func @fold_fls(%arg0: i16) {
    %0 = llvm.mlir.constant(1 : i16) : i16
    %1 = llvm.mlir.constant(0 : i16) : i16
    %2 = llvm.call @fls(%1) : (i16) -> i16
    llvm.call @sink(%2) : (i16) -> ()
    %3 = llvm.call @fls(%0) : (i16) -> i16
    llvm.call @sink(%3) : (i16) -> ()
    %4 = llvm.call @fls(%arg0) : (i16) -> i16
    llvm.call @sink(%4) : (i16) -> ()
    llvm.return
  }
}
