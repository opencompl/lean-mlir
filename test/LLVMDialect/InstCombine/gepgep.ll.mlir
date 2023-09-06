module  {
  llvm.mlir.global external @buffer() : !llvm.array<64 x f32>
  llvm.func @use(!llvm.ptr<i8>)
  llvm.func @f() {
    %0 = llvm.mlir.constant(64 : i64) : i64
    %1 = llvm.mlir.constant(63 : i64) : i64
    %2 = llvm.mlir.addressof @buffer : !llvm.ptr<array<64 x f32>>
    %3 = llvm.ptrtoint %2 : !llvm.ptr<array<64 x f32>> to i64
    %4 = llvm.mlir.constant(0 : i64) : i64
    %5 = llvm.sub %4, %3  : i64
    %6 = llvm.and %5, %1  : i64
    %7 = llvm.add %6, %0  : i64
    %8 = llvm.mlir.addressof @buffer : !llvm.ptr<array<64 x f32>>
    %9 = llvm.bitcast %8 : !llvm.ptr<array<64 x f32>> to !llvm.ptr<i8>
    %10 = llvm.getelementptr %9[%7] : (!llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    llvm.call @use(%10) : (!llvm.ptr<i8>) -> ()
    llvm.return
  }
}
