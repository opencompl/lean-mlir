"module"() ( {
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 42 : i32} : () -> i32
    %1 = "llvm.call"(%0) {callee = @fls, fastmathFlags = #llvm.fastmath<>} : (i32) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "myfls", type = !llvm.func<i32 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 42 : i64} : () -> i64
    %1 = "llvm.call"(%0) {callee = @flsl, fastmathFlags = #llvm.fastmath<>} : (i64) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "myflsl", type = !llvm.func<i32 ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 42 : i64} : () -> i64
    %1 = "llvm.call"(%0) {callee = @flsll, fastmathFlags = #llvm.fastmath<>} : (i64) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "myflsll", type = !llvm.func<i32 ()>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @flsl, fastmathFlags = #llvm.fastmath<>} : (i64) -> i32
    "llvm.return"(%0) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "flsnotconst", type = !llvm.func<i32 (i64)>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %1 = "llvm.call"(%0) {callee = @fls, fastmathFlags = #llvm.fastmath<>} : (i32) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "flszero", type = !llvm.func<i32 ()>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "fls", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "flsl", type = !llvm.func<i32 (i64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "flsll", type = !llvm.func<i32 (i64)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
