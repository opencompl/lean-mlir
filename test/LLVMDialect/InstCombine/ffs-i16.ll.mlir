module  {
  llvm.func @ffs(i16) -> i16
  llvm.func @sink(i16)
  llvm.func @fold_ffs(%arg0: i16) {
    %0 = llvm.mlir.constant(1 : i16) : i16
    %1 = llvm.mlir.constant(0 : i16) : i16
    %2 = llvm.call @ffs(%1) : (i16) -> i16
    llvm.call @sink(%2) : (i16) -> ()
    %3 = llvm.call @ffs(%0) : (i16) -> i16
    llvm.call @sink(%3) : (i16) -> ()
    %4 = llvm.call @ffs(%arg0) : (i16) -> i16
    llvm.call @sink(%4) : (i16) -> ()
    llvm.return
  }
}
