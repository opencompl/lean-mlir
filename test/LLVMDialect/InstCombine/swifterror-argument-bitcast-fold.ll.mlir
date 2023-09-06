module  {
  llvm.func @spam(%arg0: !llvm.ptr<ptr<i32>>) {
    %0 = llvm.mlir.addressof @widget : !llvm.ptr<func<void (ptr<ptr<i64>>)>>
    %1 = llvm.bitcast %0 : !llvm.ptr<func<void (ptr<ptr<i64>>)>> to !llvm.ptr<func<void (ptr<ptr<i32>>)>>
    llvm.call %1(%arg0) : (!llvm.ptr<ptr<i32>>) -> ()
    llvm.return
  }
  llvm.func @widget(!llvm.ptr<ptr<i64>>)
}
