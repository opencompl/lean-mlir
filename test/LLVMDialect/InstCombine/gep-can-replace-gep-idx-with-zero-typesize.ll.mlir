"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "do_something", type = !llvm.func<void (vec<? x 4 x i32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64, %arg1: !llvm.ptr<vec<? x 4 x i32>>, %arg2: i64):  // no predecessors
    %0 = "llvm.getelementptr"(%arg1, %arg2) : (!llvm.ptr<vec<? x 4 x i32>>, i64) -> !llvm.ptr<vec<? x 4 x i32>>
    %1 = "llvm.load"(%0) : (!llvm.ptr<vec<? x 4 x i32>>) -> !llvm.vec<? x 4 x i32>
    "llvm.call"(%1) {callee = @do_something, fastmathFlags = #llvm.fastmath<>} : (!llvm.vec<? x 4 x i32>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "can_replace_gep_idx_with_zero_typesize", type = !llvm.func<void (i64, ptr<vec<? x 4 x i32>>, i64)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
