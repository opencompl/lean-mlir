"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.load"(%arg0) : (!llvm.ptr<i8>) -> i8
    "llvm.return"(%0) : (i8) -> ()
  }) {linkage = 10 : i64, sym_name = "bar", type = !llvm.func<i8 (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @bar, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>) -> i8
    "llvm.return"(%0) : (i8) -> ()
  }) {linkage = 10 : i64, sym_name = "foo", type = !llvm.func<i8 (ptr<i8>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
