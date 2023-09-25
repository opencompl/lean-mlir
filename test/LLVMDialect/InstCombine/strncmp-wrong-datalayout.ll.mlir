"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "strncmp", type = !llvm.func<i32 (ptr<i8>, ptr<i8>, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %1 = "llvm.call"(%arg0, %arg1, %0) {callee = @strncmp, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test6", type = !llvm.func<i32 (ptr<i8>, ptr<i8>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
