"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "ffs", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "ffsl", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "ffsll", type = !llvm.func<i32 (i64)>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %1 = "llvm.call"(%0) {callee = @ffs, fastmathFlags = #llvm.fastmath<>} : (i32) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_simplify1", type = !llvm.func<i32 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %1 = "llvm.call"(%0) {callee = @ffsl, fastmathFlags = #llvm.fastmath<>} : (i32) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_simplify2", type = !llvm.func<i32 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %1 = "llvm.call"(%0) {callee = @ffsll, fastmathFlags = #llvm.fastmath<>} : (i64) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_simplify3", type = !llvm.func<i32 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %1 = "llvm.call"(%0) {callee = @ffs, fastmathFlags = #llvm.fastmath<>} : (i32) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_simplify4", type = !llvm.func<i32 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 2048 : i32} : () -> i32
    %1 = "llvm.call"(%0) {callee = @ffs, fastmathFlags = #llvm.fastmath<>} : (i32) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_simplify5", type = !llvm.func<i32 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 65536 : i32} : () -> i32
    %1 = "llvm.call"(%0) {callee = @ffs, fastmathFlags = #llvm.fastmath<>} : (i32) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_simplify6", type = !llvm.func<i32 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 65536 : i32} : () -> i32
    %1 = "llvm.call"(%0) {callee = @ffsl, fastmathFlags = #llvm.fastmath<>} : (i32) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_simplify7", type = !llvm.func<i32 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 1024 : i64} : () -> i64
    %1 = "llvm.call"(%0) {callee = @ffsll, fastmathFlags = #llvm.fastmath<>} : (i64) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_simplify8", type = !llvm.func<i32 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 65536 : i64} : () -> i64
    %1 = "llvm.call"(%0) {callee = @ffsll, fastmathFlags = #llvm.fastmath<>} : (i64) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_simplify9", type = !llvm.func<i32 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 17179869184 : i64} : () -> i64
    %1 = "llvm.call"(%0) {callee = @ffsll, fastmathFlags = #llvm.fastmath<>} : (i64) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_simplify10", type = !llvm.func<i32 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 281474976710656 : i64} : () -> i64
    %1 = "llvm.call"(%0) {callee = @ffsll, fastmathFlags = #llvm.fastmath<>} : (i64) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_simplify11", type = !llvm.func<i32 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 1152921504606846976 : i64} : () -> i64
    %1 = "llvm.call"(%0) {callee = @ffsll, fastmathFlags = #llvm.fastmath<>} : (i64) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_simplify12", type = !llvm.func<i32 ()>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @ffs, fastmathFlags = #llvm.fastmath<>} : (i32) -> i32
    "llvm.return"(%0) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_simplify13", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @ffsl, fastmathFlags = #llvm.fastmath<>} : (i32) -> i32
    "llvm.return"(%0) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_simplify14", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @ffsll, fastmathFlags = #llvm.fastmath<>} : (i64) -> i32
    "llvm.return"(%0) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_simplify15", type = !llvm.func<i32 (i64)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
