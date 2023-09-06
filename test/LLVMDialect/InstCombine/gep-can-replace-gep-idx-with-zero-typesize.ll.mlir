module  {
  llvm.func @do_something(!llvm.vec<? x 4 x i32>)
  llvm.func @can_replace_gep_idx_with_zero_typesize(%arg0: i64, %arg1: !llvm.ptr<vec<? x 4 x i32>>, %arg2: i64) {
    %0 = llvm.getelementptr %arg1[%arg2] : (!llvm.ptr<vec<? x 4 x i32>>, i64) -> !llvm.ptr<vec<? x 4 x i32>>
    %1 = llvm.load %0 : !llvm.ptr<vec<? x 4 x i32>>
    llvm.call @do_something(%1) : (!llvm.vec<? x 4 x i32>) -> ()
    llvm.return
  }
}
