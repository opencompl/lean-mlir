module  {
  llvm.func @foo(...)
  llvm.func @test(%arg0: i64) {
    %0 = llvm.inttoptr %arg0 : i64 to !llvm.ptr<i32>
    llvm.call @foo(%0) : (!llvm.ptr<i32>) -> ()
    llvm.return
  }
}
