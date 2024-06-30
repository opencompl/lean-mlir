"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i1):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i8} : () -> i8
    %1 = "llvm.mlir.constant"() {value = 64 : i8} : () -> i8
    %2 = "llvm.zext"(%arg0) : (i1) -> i8
    %3 = "llvm.shl"(%1, %2) : (i8, i8) -> i8
    %4 = "llvm.and"(%3, %0) : (i8, i8) -> i8
    "llvm.call"(%4) {callee = @sink, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_shl", type = !llvm.func<void (i1)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i1):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i8} : () -> i8
    %1 = "llvm.mlir.constant"() {value = 64 : i8} : () -> i8
    %2 = "llvm.zext"(%arg0) : (i1) -> i8
    %3 = "llvm.lshr"(%1, %2) : (i8, i8) -> i8
    %4 = "llvm.and"(%3, %0) : (i8, i8) -> i8
    "llvm.call"(%4) {callee = @sink, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_lshr", type = !llvm.func<void (i1)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i1):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 3 : i8} : () -> i8
    %1 = "llvm.mlir.constant"() {value = -16 : i8} : () -> i8
    %2 = "llvm.zext"(%arg0) : (i1) -> i8
    %3 = "llvm.ashr"(%1, %2) : (i8, i8) -> i8
    %4 = "llvm.and"(%3, %0) : (i8, i8) -> i8
    "llvm.call"(%4) {callee = @sink, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_ashr", type = !llvm.func<void (i1)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 64 : i8} : () -> i8
    %1 = "llvm.mlir.constant"() {value = 10 : i8} : () -> i8
    %2 = "llvm.udiv"(%1, %arg0) : (i8, i8) -> i8
    %3 = "llvm.and"(%2, %0) : (i8, i8) -> i8
    "llvm.call"(%3) {callee = @sink, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_udiv", type = !llvm.func<void (i8)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "sink", type = !llvm.func<void (i8)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
