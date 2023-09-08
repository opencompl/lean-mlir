"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i26):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 2884 : i26} : () -> i26
    %1 = "llvm.mlir.constant"() {value = 2885 : i26} : () -> i26
    %2 = "llvm.mul"(%arg0, %1) : (i26, i26) -> i26
    %3 = "llvm.mul"(%arg0, %0) : (i26, i26) -> i26
    %4 = "llvm.sub"(%2, %3) : (i26, i26) -> i26
    "llvm.return"(%4) : (i26) -> ()
  }) {linkage = 10 : i64, sym_name = "test", type = !llvm.func<i26 (i26)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
