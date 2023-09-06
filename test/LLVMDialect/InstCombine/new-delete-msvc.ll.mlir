module  {
  llvm.func @"\01??2@YAPEAX_K@Z"(i64) -> !llvm.ptr<i8>
  llvm.func @"\01??3@YAXPEAX@Z"(!llvm.ptr<i8>)
  llvm.func @test9() {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.call @"\01??2@YAPEAX_K@Z"(%0) : (i64) -> !llvm.ptr<i8>
    llvm.call @"\01??3@YAXPEAX@Z"(%1) : (!llvm.ptr<i8>) -> ()
    llvm.return
  }
}
