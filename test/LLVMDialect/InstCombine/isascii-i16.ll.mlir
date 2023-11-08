"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "isascii", type = !llvm.func<i16 (i16)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "sink", type = !llvm.func<void (i16)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i16):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i16} : () -> i16
    %1 = "llvm.mlir.constant"() {value = 32767 : i16} : () -> i16
    %2 = "llvm.mlir.constant"() {value = 256 : i16} : () -> i16
    %3 = "llvm.mlir.constant"() {value = 255 : i16} : () -> i16
    %4 = "llvm.mlir.constant"() {value = 128 : i16} : () -> i16
    %5 = "llvm.mlir.constant"() {value = 127 : i16} : () -> i16
    %6 = "llvm.mlir.constant"() {value = 1 : i16} : () -> i16
    %7 = "llvm.mlir.constant"() {value = 0 : i16} : () -> i16
    %8 = "llvm.call"(%7) {callee = @isascii, fastmathFlags = #llvm.fastmath<>} : (i16) -> i16
    "llvm.call"(%8) {callee = @sink, fastmathFlags = #llvm.fastmath<>} : (i16) -> ()
    %9 = "llvm.call"(%6) {callee = @isascii, fastmathFlags = #llvm.fastmath<>} : (i16) -> i16
    "llvm.call"(%9) {callee = @sink, fastmathFlags = #llvm.fastmath<>} : (i16) -> ()
    %10 = "llvm.call"(%5) {callee = @isascii, fastmathFlags = #llvm.fastmath<>} : (i16) -> i16
    "llvm.call"(%10) {callee = @sink, fastmathFlags = #llvm.fastmath<>} : (i16) -> ()
    %11 = "llvm.call"(%4) {callee = @isascii, fastmathFlags = #llvm.fastmath<>} : (i16) -> i16
    "llvm.call"(%11) {callee = @sink, fastmathFlags = #llvm.fastmath<>} : (i16) -> ()
    %12 = "llvm.call"(%3) {callee = @isascii, fastmathFlags = #llvm.fastmath<>} : (i16) -> i16
    "llvm.call"(%12) {callee = @sink, fastmathFlags = #llvm.fastmath<>} : (i16) -> ()
    %13 = "llvm.call"(%2) {callee = @isascii, fastmathFlags = #llvm.fastmath<>} : (i16) -> i16
    "llvm.call"(%13) {callee = @sink, fastmathFlags = #llvm.fastmath<>} : (i16) -> ()
    %14 = "llvm.call"(%1) {callee = @isascii, fastmathFlags = #llvm.fastmath<>} : (i16) -> i16
    "llvm.call"(%14) {callee = @sink, fastmathFlags = #llvm.fastmath<>} : (i16) -> ()
    %15 = "llvm.call"(%0) {callee = @isascii, fastmathFlags = #llvm.fastmath<>} : (i16) -> i16
    "llvm.call"(%15) {callee = @sink, fastmathFlags = #llvm.fastmath<>} : (i16) -> ()
    %16 = "llvm.call"(%arg0) {callee = @isascii, fastmathFlags = #llvm.fastmath<>} : (i16) -> i16
    "llvm.call"(%16) {callee = @sink, fastmathFlags = #llvm.fastmath<>} : (i16) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "fold_isascii", type = !llvm.func<void (i16)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
