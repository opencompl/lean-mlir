module  {
  llvm.func @llvm.experimental.guard(i1, ...)
  llvm.func @test_guard_adjacent_same_cond(%arg0: i1) {
    llvm.call @llvm.experimental.guard(%arg0) : (i1) -> ()
    llvm.call @llvm.experimental.guard(%arg0) : (i1) -> ()
    llvm.call @llvm.experimental.guard(%arg0) : (i1) -> ()
    llvm.call @llvm.experimental.guard(%arg0) : (i1) -> ()
    llvm.call @llvm.experimental.guard(%arg0) : (i1) -> ()
    llvm.call @llvm.experimental.guard(%arg0) : (i1) -> ()
    llvm.call @llvm.experimental.guard(%arg0) : (i1) -> ()
    llvm.call @llvm.experimental.guard(%arg0) : (i1) -> ()
    llvm.call @llvm.experimental.guard(%arg0) : (i1) -> ()
    llvm.call @llvm.experimental.guard(%arg0) : (i1) -> ()
    llvm.return
  }
  llvm.func @test_guard_adjacent_diff_cond(%arg0: i1, %arg1: i1, %arg2: i1) {
    %0 = llvm.mlir.constant(789 : i32) : i32
    %1 = llvm.mlir.constant(456 : i32) : i32
    %2 = llvm.mlir.constant(123 : i32) : i32
    llvm.call @llvm.experimental.guard(%arg0, %2) : (i1, i32) -> ()
    llvm.call @llvm.experimental.guard(%arg1, %1) : (i1, i32) -> ()
    llvm.call @llvm.experimental.guard(%arg2, %0) : (i1, i32) -> ()
    llvm.return
  }
  llvm.func @test_guard_adjacent_diff_cond2(%arg0: i32, %arg1: i32) {
    %0 = llvm.mlir.constant(789 : i32) : i32
    %1 = llvm.mlir.constant(128 : i32) : i32
    %2 = llvm.mlir.constant(255 : i32) : i32
    %3 = llvm.mlir.constant(456 : i32) : i32
    %4 = llvm.mlir.constant(123 : i32) : i32
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.icmp "slt" %arg0, %5 : i32
    llvm.call @llvm.experimental.guard(%6, %4) : (i1, i32) -> ()
    %7 = llvm.icmp "slt" %arg1, %5 : i32
    llvm.call @llvm.experimental.guard(%7, %3) : (i1, i32) -> ()
    %8 = llvm.and %arg0, %2  : i32
    %9 = llvm.icmp "sle" %8, %1 : i32
    llvm.call @llvm.experimental.guard(%9, %0) : (i1, i32) -> ()
    llvm.return
  }
  llvm.func @negative_load(%arg0: i32, %arg1: !llvm.ptr<i32>) {
    %0 = llvm.mlir.constant(456 : i32) : i32
    %1 = llvm.mlir.constant(123 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "slt" %arg0, %2 : i32
    llvm.call @llvm.experimental.guard(%3, %1) : (i1, i32) -> ()
    %4 = llvm.load %arg1 : !llvm.ptr<i32>
    %5 = llvm.icmp "slt" %4, %2 : i32
    llvm.call @llvm.experimental.guard(%5, %0) : (i1, i32) -> ()
    llvm.return
  }
  llvm.func @deref_load(%arg0: i32, %arg1: !llvm.ptr<i32>) {
    %0 = llvm.mlir.constant(456 : i32) : i32
    %1 = llvm.mlir.constant(123 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "slt" %arg0, %2 : i32
    llvm.call @llvm.experimental.guard(%3, %1) : (i1, i32) -> ()
    %4 = llvm.load %arg1 : !llvm.ptr<i32>
    %5 = llvm.icmp "slt" %4, %2 : i32
    llvm.call @llvm.experimental.guard(%5, %0) : (i1, i32) -> ()
    llvm.return
  }
  llvm.func @negative_div(%arg0: i32, %arg1: i32) {
    %0 = llvm.mlir.constant(456 : i32) : i32
    %1 = llvm.mlir.constant(123 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "slt" %arg0, %2 : i32
    llvm.call @llvm.experimental.guard(%3, %1) : (i1, i32) -> ()
    %4 = llvm.udiv %arg0, %arg1  : i32
    %5 = llvm.icmp "slt" %4, %2 : i32
    llvm.call @llvm.experimental.guard(%5, %0) : (i1, i32) -> ()
    llvm.return
  }
  llvm.func @negative_window(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32) {
    %0 = llvm.mlir.constant(456 : i32) : i32
    %1 = llvm.mlir.constant(123 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "slt" %arg0, %2 : i32
    llvm.call @llvm.experimental.guard(%3, %1) : (i1, i32) -> ()
    %4 = llvm.add %arg1, %arg2  : i32
    %5 = llvm.add %4, %arg3  : i32
    %6 = llvm.add %5, %arg4  : i32
    %7 = llvm.icmp "slt" %6, %2 : i32
    llvm.call @llvm.experimental.guard(%7, %0) : (i1, i32) -> ()
    llvm.return
  }
}
