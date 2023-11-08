"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "isdigit", type = !llvm.func<i16 (i16)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "sink", type = !llvm.func<void (i16)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i16):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 32767 : i16} : () -> i16
    %1 = "llvm.mlir.constant"() {value = 256 : i16} : () -> i16
    %2 = "llvm.mlir.constant"() {value = 255 : i16} : () -> i16
    %3 = "llvm.mlir.constant"() {value = 128 : i16} : () -> i16
    %4 = "llvm.mlir.constant"() {value = 127 : i16} : () -> i16
    %5 = "llvm.mlir.constant"() {value = 58 : i16} : () -> i16
    %6 = "llvm.mlir.constant"() {value = 57 : i16} : () -> i16
    %7 = "llvm.mlir.constant"() {value = 49 : i16} : () -> i16
    %8 = "llvm.mlir.constant"() {value = 48 : i16} : () -> i16
    %9 = "llvm.mlir.constant"() {value = 47 : i16} : () -> i16
    %10 = "llvm.mlir.constant"() {value = 1 : i16} : () -> i16
    %11 = "llvm.mlir.constant"() {value = 0 : i16} : () -> i16
    %12 = "llvm.call"(%11) {callee = @isdigit, fastmathFlags = #llvm.fastmath<>} : (i16) -> i16
    "llvm.call"(%12) {callee = @sink, fastmathFlags = #llvm.fastmath<>} : (i16) -> ()
    %13 = "llvm.call"(%10) {callee = @isdigit, fastmathFlags = #llvm.fastmath<>} : (i16) -> i16
    "llvm.call"(%13) {callee = @sink, fastmathFlags = #llvm.fastmath<>} : (i16) -> ()
    %14 = "llvm.call"(%9) {callee = @isdigit, fastmathFlags = #llvm.fastmath<>} : (i16) -> i16
    "llvm.call"(%14) {callee = @sink, fastmathFlags = #llvm.fastmath<>} : (i16) -> ()
    %15 = "llvm.call"(%8) {callee = @isdigit, fastmathFlags = #llvm.fastmath<>} : (i16) -> i16
    "llvm.call"(%15) {callee = @sink, fastmathFlags = #llvm.fastmath<>} : (i16) -> ()
    %16 = "llvm.call"(%7) {callee = @isdigit, fastmathFlags = #llvm.fastmath<>} : (i16) -> i16
    "llvm.call"(%16) {callee = @sink, fastmathFlags = #llvm.fastmath<>} : (i16) -> ()
    %17 = "llvm.call"(%6) {callee = @isdigit, fastmathFlags = #llvm.fastmath<>} : (i16) -> i16
    "llvm.call"(%17) {callee = @sink, fastmathFlags = #llvm.fastmath<>} : (i16) -> ()
    %18 = "llvm.call"(%5) {callee = @isdigit, fastmathFlags = #llvm.fastmath<>} : (i16) -> i16
    "llvm.call"(%18) {callee = @sink, fastmathFlags = #llvm.fastmath<>} : (i16) -> ()
    %19 = "llvm.call"(%4) {callee = @isdigit, fastmathFlags = #llvm.fastmath<>} : (i16) -> i16
    "llvm.call"(%19) {callee = @sink, fastmathFlags = #llvm.fastmath<>} : (i16) -> ()
    %20 = "llvm.call"(%3) {callee = @isdigit, fastmathFlags = #llvm.fastmath<>} : (i16) -> i16
    "llvm.call"(%20) {callee = @sink, fastmathFlags = #llvm.fastmath<>} : (i16) -> ()
    %21 = "llvm.call"(%2) {callee = @isdigit, fastmathFlags = #llvm.fastmath<>} : (i16) -> i16
    "llvm.call"(%21) {callee = @sink, fastmathFlags = #llvm.fastmath<>} : (i16) -> ()
    %22 = "llvm.call"(%1) {callee = @isdigit, fastmathFlags = #llvm.fastmath<>} : (i16) -> i16
    "llvm.call"(%22) {callee = @sink, fastmathFlags = #llvm.fastmath<>} : (i16) -> ()
    %23 = "llvm.call"(%0) {callee = @isdigit, fastmathFlags = #llvm.fastmath<>} : (i16) -> i16
    "llvm.call"(%23) {callee = @sink, fastmathFlags = #llvm.fastmath<>} : (i16) -> ()
    %24 = "llvm.call"(%arg0) {callee = @isdigit, fastmathFlags = #llvm.fastmath<>} : (i16) -> i16
    "llvm.call"(%24) {callee = @sink, fastmathFlags = #llvm.fastmath<>} : (i16) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "fold_isdigit", type = !llvm.func<void (i16)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
