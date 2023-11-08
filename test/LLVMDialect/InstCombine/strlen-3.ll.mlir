"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %1 = "llvm.call"(%arg0) {callee = @strlen, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i32>) -> i64
    "llvm.return"(%0) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "strlen", type = !llvm.func<i64 (ptr<i32>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
