module  {
  llvm.mlir.global internal constant @".str1"("\B5%8\00")
  llvm.func @test() -> i32 {
    %0 = llvm.mlir.addressof @".str1" : !llvm.ptr<array<4 x i8>>
    %1 = llvm.bitcast %0 : !llvm.ptr<array<4 x i8>> to !llvm.ptr<i32>
    %2 = llvm.load %1 : !llvm.ptr<i32>
    llvm.return %2 : i32
  }
}
