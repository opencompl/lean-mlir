module  {
  llvm.func @test_shl(%arg0: i1) {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(64 : i8) : i8
    %2 = llvm.zext %arg0 : i1 to i8
    %3 = llvm.shl %1, %2  : i8
    %4 = llvm.and %3, %0  : i8
    llvm.call @sink(%4) : (i8) -> ()
    llvm.return
  }
  llvm.func @test_lshr(%arg0: i1) {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(64 : i8) : i8
    %2 = llvm.zext %arg0 : i1 to i8
    %3 = llvm.lshr %1, %2  : i8
    %4 = llvm.and %3, %0  : i8
    llvm.call @sink(%4) : (i8) -> ()
    llvm.return
  }
  llvm.func @test_ashr(%arg0: i1) {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(-16 : i8) : i8
    %2 = llvm.zext %arg0 : i1 to i8
    %3 = llvm.ashr %1, %2  : i8
    %4 = llvm.and %3, %0  : i8
    llvm.call @sink(%4) : (i8) -> ()
    llvm.return
  }
  llvm.func @test_udiv(%arg0: i8) {
    %0 = llvm.mlir.constant(64 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.udiv %1, %arg0  : i8
    %3 = llvm.and %2, %0  : i8
    llvm.call @sink(%3) : (i8) -> ()
    llvm.return
  }
  llvm.func @sink(i8)
}
