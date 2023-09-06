module  {
  llvm.func @foo1(%arg0: !llvm.ptr<i32>) -> i32 {
    %0 = llvm.load %arg0 : !llvm.ptr<i32>
    llvm.return %0 : i32
  }
  llvm.func @foo2(%arg0: !llvm.ptr<i32>) -> i32 {
    %0 = llvm.call @func1(%arg0) : (!llvm.ptr<i32>) -> !llvm.ptr<i32>
    %1 = llvm.load %0 : !llvm.ptr<i32>
    llvm.return %1 : i32
  }
  llvm.func @func1(!llvm.ptr<i32>) -> !llvm.ptr<i32>
}
