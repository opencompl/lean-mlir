module  {
  llvm.func @isdigit(i16) -> i16
  llvm.func @sink(i16)
  llvm.func @fold_isdigit(%arg0: i16) {
    %0 = llvm.mlir.constant(32767 : i16) : i16
    %1 = llvm.mlir.constant(256 : i16) : i16
    %2 = llvm.mlir.constant(255 : i16) : i16
    %3 = llvm.mlir.constant(128 : i16) : i16
    %4 = llvm.mlir.constant(127 : i16) : i16
    %5 = llvm.mlir.constant(58 : i16) : i16
    %6 = llvm.mlir.constant(57 : i16) : i16
    %7 = llvm.mlir.constant(49 : i16) : i16
    %8 = llvm.mlir.constant(48 : i16) : i16
    %9 = llvm.mlir.constant(47 : i16) : i16
    %10 = llvm.mlir.constant(1 : i16) : i16
    %11 = llvm.mlir.constant(0 : i16) : i16
    %12 = llvm.call @isdigit(%11) : (i16) -> i16
    llvm.call @sink(%12) : (i16) -> ()
    %13 = llvm.call @isdigit(%10) : (i16) -> i16
    llvm.call @sink(%13) : (i16) -> ()
    %14 = llvm.call @isdigit(%9) : (i16) -> i16
    llvm.call @sink(%14) : (i16) -> ()
    %15 = llvm.call @isdigit(%8) : (i16) -> i16
    llvm.call @sink(%15) : (i16) -> ()
    %16 = llvm.call @isdigit(%7) : (i16) -> i16
    llvm.call @sink(%16) : (i16) -> ()
    %17 = llvm.call @isdigit(%6) : (i16) -> i16
    llvm.call @sink(%17) : (i16) -> ()
    %18 = llvm.call @isdigit(%5) : (i16) -> i16
    llvm.call @sink(%18) : (i16) -> ()
    %19 = llvm.call @isdigit(%4) : (i16) -> i16
    llvm.call @sink(%19) : (i16) -> ()
    %20 = llvm.call @isdigit(%3) : (i16) -> i16
    llvm.call @sink(%20) : (i16) -> ()
    %21 = llvm.call @isdigit(%2) : (i16) -> i16
    llvm.call @sink(%21) : (i16) -> ()
    %22 = llvm.call @isdigit(%1) : (i16) -> i16
    llvm.call @sink(%22) : (i16) -> ()
    %23 = llvm.call @isdigit(%0) : (i16) -> i16
    llvm.call @sink(%23) : (i16) -> ()
    %24 = llvm.call @isdigit(%arg0) : (i16) -> i16
    llvm.call @sink(%24) : (i16) -> ()
    llvm.return
  }
}
