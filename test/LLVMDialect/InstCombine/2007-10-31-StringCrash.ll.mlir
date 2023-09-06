module  {
  llvm.func @__darwin_gcc3_preregister_frame_info()
  llvm.func @_start(%arg0: i32, %arg1: !llvm.ptr<ptr<i8>>, %arg2: !llvm.ptr<ptr<i8>>) {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @__darwin_gcc3_preregister_frame_info : !llvm.ptr<func<void ()>>
    %3 = llvm.bitcast %2 : !llvm.ptr<func<void ()>> to !llvm.ptr<i32>
    %4 = llvm.load %3 : !llvm.ptr<i32>
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.zext %5 : i1 to i8
    %7 = llvm.icmp "ne" %6, %0 : i8
    llvm.cond_br %7, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }
}
