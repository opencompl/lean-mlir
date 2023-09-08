"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "memcpy", type = !llvm.func<i8 (ptr<i8>, ptr<i8>, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>, %arg2: i32):  // no predecessors
    %0 = "llvm.call"(%arg0, %arg1, %arg2) {callee = @memcpy, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32) -> i8
    "llvm.return"(%0) : (i8) -> ()
  }) {linkage = 10 : i64, sym_name = "test_no_simplify1", type = !llvm.func<i8 (ptr<i8>, ptr<i8>, i32)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
