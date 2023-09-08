"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "foo", type = !llvm.func<void (...)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64):  // no predecessors
    %0 = "llvm.inttoptr"(%arg0) : (i64) -> !llvm.ptr<i32>
    "llvm.call"(%0) {callee = @foo, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i32>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test", type = !llvm.func<void (i64)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
