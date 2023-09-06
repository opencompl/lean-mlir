module  {
  llvm.func @udiv400(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(100 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.lshr %arg0, %1  : i32
    %3 = llvm.udiv %2, %0  : i32
    llvm.return %3 : i32
  }
  llvm.func @udiv400_no(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(100 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.ashr %arg0, %1  : i32
    %3 = llvm.udiv %2, %0  : i32
    llvm.return %3 : i32
  }
  llvm.func @sdiv400_yes(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(100 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.lshr %arg0, %1  : i32
    %3 = llvm.sdiv %2, %0  : i32
    llvm.return %3 : i32
  }
  llvm.func @udiv_i80(%arg0: i80) -> i80 {
    %0 = llvm.mlir.constant(100 : i80) : i80
    %1 = llvm.mlir.constant(2 : i80) : i80
    %2 = llvm.lshr %arg0, %1  : i80
    %3 = llvm.udiv %2, %0  : i80
    llvm.return %3 : i80
  }
  llvm.func @no_crash_notconst_udiv(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(100 : i32) : i32
    %1 = llvm.lshr %arg0, %arg1  : i32
    %2 = llvm.udiv %1, %0  : i32
    llvm.return %2 : i32
  }
}
