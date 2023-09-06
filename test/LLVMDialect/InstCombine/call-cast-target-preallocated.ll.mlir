module  {
  llvm.func @llvm.call.preallocated.setup(i32) -> !llvm.metadata
  llvm.func @llvm.call.preallocated.arg(!llvm.metadata, i32) -> !llvm.ptr<i8>
  llvm.func @takes_i32(i32)
  llvm.func @takes_i32_preallocated(!llvm.ptr<i32>)
  llvm.func @f() {
    %0 = llvm.mlir.addressof @takes_i32 : !llvm.ptr<func<void (i32)>>
    %1 = llvm.bitcast %0 : !llvm.ptr<func<void (i32)>> to !llvm.ptr<func<void (ptr<i32>)>>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.call @llvm.call.preallocated.setup(%3) : (i32) -> !llvm.metadata
    %5 = llvm.call @llvm.call.preallocated.arg(%4, %2) : (!llvm.metadata, i32) -> !llvm.ptr<i8>
    %6 = llvm.bitcast %5 : !llvm.ptr<i8> to !llvm.ptr<i32>
    llvm.call %1(%6) : (!llvm.ptr<i32>) -> ()
    llvm.return
  }
  llvm.func @g() {
    %0 = llvm.mlir.addressof @takes_i32_preallocated : !llvm.ptr<func<void (ptr<i32>)>>
    %1 = llvm.bitcast %0 : !llvm.ptr<func<void (ptr<i32>)>> to !llvm.ptr<func<void (i32)>>
    %2 = llvm.mlir.constant(0 : i32) : i32
    llvm.call %1(%2) : (i32) -> ()
    llvm.return
  }
}
