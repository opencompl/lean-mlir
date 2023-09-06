module  {
  llvm.func @foo(i32)
  llvm.func @g() {
    %0 = llvm.mlir.addressof @foo : !llvm.ptr<func<void (i32)>>
    %1 = llvm.bitcast %0 : !llvm.ptr<func<void (i32)>> to !llvm.ptr<func<void ()>>
    llvm.call %1() : () -> ()
    llvm.return
  }
}
