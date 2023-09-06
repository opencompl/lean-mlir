module  {
  llvm.func @f(%arg0: i16) {
    llvm.return
  }
  llvm.func @g(%arg0: i32) -> i32 {
    %0 = llvm.mlir.addressof @f : !llvm.ptr<func<void (i16)>>
    %1 = llvm.bitcast %0 : !llvm.ptr<func<void (i16)>> to !llvm.ptr<func<i32 (i32)>>
    %2 = llvm.call %1(%arg0) : (i32) -> i32
    llvm.return %2 : i32
  }
}
