"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "fls", type = !llvm.func<i16 (i16)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "sink", type = !llvm.func<void (i16)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i16):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i16} : () -> i16
    %1 = "llvm.mlir.constant"() {value = 0 : i16} : () -> i16
    %2 = "llvm.call"(%1) {callee = @fls, fastmathFlags = #llvm.fastmath<>} : (i16) -> i16
    "llvm.call"(%2) {callee = @sink, fastmathFlags = #llvm.fastmath<>} : (i16) -> ()
    %3 = "llvm.call"(%0) {callee = @fls, fastmathFlags = #llvm.fastmath<>} : (i16) -> i16
    "llvm.call"(%3) {callee = @sink, fastmathFlags = #llvm.fastmath<>} : (i16) -> ()
    %4 = "llvm.call"(%arg0) {callee = @fls, fastmathFlags = #llvm.fastmath<>} : (i16) -> i16
    "llvm.call"(%4) {callee = @sink, fastmathFlags = #llvm.fastmath<>} : (i16) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "fold_fls", type = !llvm.func<void (i16)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
