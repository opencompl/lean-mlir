"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "memcmp", type = !llvm.func<ptr<i32> (ptr<i8>, ptr<i8>, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: i32):  // no predecessors
    %0 = "llvm.call"(%arg0, %arg0, %arg1) {callee = @memcmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32) -> !llvm.ptr<i32>
    "llvm.return"(%0) : (!llvm.ptr<i32>) -> ()
  }) {linkage = 10 : i64, sym_name = "test_no_simplify1", type = !llvm.func<ptr<i32> (ptr<i8>, i32)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
