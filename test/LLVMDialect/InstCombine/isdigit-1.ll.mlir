"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "isdigit", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 47 : i32} : () -> i32
    %1 = "llvm.call"(%0) {callee = @isdigit, fastmathFlags = #llvm.fastmath<>} : (i32) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_simplify1", type = !llvm.func<i32 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 48 : i32} : () -> i32
    %1 = "llvm.call"(%0) {callee = @isdigit, fastmathFlags = #llvm.fastmath<>} : (i32) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_simplify2", type = !llvm.func<i32 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 57 : i32} : () -> i32
    %1 = "llvm.call"(%0) {callee = @isdigit, fastmathFlags = #llvm.fastmath<>} : (i32) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_simplify3", type = !llvm.func<i32 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 58 : i32} : () -> i32
    %1 = "llvm.call"(%0) {callee = @isdigit, fastmathFlags = #llvm.fastmath<>} : (i32) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_simplify4", type = !llvm.func<i32 ()>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @isdigit, fastmathFlags = #llvm.fastmath<>} : (i32) -> i32
    "llvm.return"(%0) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_simplify5", type = !llvm.func<i32 (i32)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
