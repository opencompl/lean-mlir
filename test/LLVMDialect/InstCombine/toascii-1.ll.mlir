"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "toascii", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %1 = "llvm.call"(%0) {callee = @toascii, fastmathFlags = #llvm.fastmath<>} : (i32) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_simplify1", type = !llvm.func<i32 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %1 = "llvm.call"(%0) {callee = @toascii, fastmathFlags = #llvm.fastmath<>} : (i32) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_simplify2", type = !llvm.func<i32 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 127 : i32} : () -> i32
    %1 = "llvm.call"(%0) {callee = @toascii, fastmathFlags = #llvm.fastmath<>} : (i32) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_simplify3", type = !llvm.func<i32 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 128 : i32} : () -> i32
    %1 = "llvm.call"(%0) {callee = @toascii, fastmathFlags = #llvm.fastmath<>} : (i32) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_simplify4", type = !llvm.func<i32 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 255 : i32} : () -> i32
    %1 = "llvm.call"(%0) {callee = @toascii, fastmathFlags = #llvm.fastmath<>} : (i32) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_simplify5", type = !llvm.func<i32 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 256 : i32} : () -> i32
    %1 = "llvm.call"(%0) {callee = @toascii, fastmathFlags = #llvm.fastmath<>} : (i32) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_simplify6", type = !llvm.func<i32 ()>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @toascii, fastmathFlags = #llvm.fastmath<>} : (i32) -> i32
    "llvm.return"(%0) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_simplify7", type = !llvm.func<i32 (i32)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
