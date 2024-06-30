"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @strlen, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>) -> i64
    %1 = "llvm.trunc"(%0) : (i64) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "use", type = !llvm.func<i32 (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "strlen", type = !llvm.func<i64 (ptr<i8>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
