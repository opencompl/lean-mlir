module  {
  llvm.mlir.global available_externally constant @g1(1 : i32) : i32
  llvm.mlir.global linkonce_odr constant @g2(2 : i32) : i32
  llvm.mlir.global weak_odr constant @g3(3 : i32) : i32
  llvm.mlir.global internal constant @g4(4 : i32) : i32
  llvm.func @test() -> i32 {
    %0 = llvm.mlir.addressof @g4 : !llvm.ptr<i32>
    %1 = llvm.mlir.addressof @g3 : !llvm.ptr<i32>
    %2 = llvm.mlir.addressof @g2 : !llvm.ptr<i32>
    %3 = llvm.mlir.addressof @g1 : !llvm.ptr<i32>
    %4 = llvm.load %3 : !llvm.ptr<i32>
    %5 = llvm.load %2 : !llvm.ptr<i32>
    %6 = llvm.load %1 : !llvm.ptr<i32>
    %7 = llvm.load %0 : !llvm.ptr<i32>
    %8 = llvm.add %4, %5  : i32
    %9 = llvm.add %8, %6  : i32
    %10 = llvm.add %9, %7  : i32
    llvm.return %10 : i32
  }
}
