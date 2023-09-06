module  {
  llvm.mlir.global external @X(5 : i32) : i32
  llvm.func @test() -> i64 {
    %0 = llvm.mlir.addressof @X : !llvm.ptr<i32>
    %1 = llvm.ptrtoint %0 : !llvm.ptr<i32> to i64
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.add %3, %2  : i64
    %5 = llvm.add %1, %4  : i64
    llvm.return %5 : i64
  }
}
