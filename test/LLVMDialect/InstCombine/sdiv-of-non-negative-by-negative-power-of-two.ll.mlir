"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.assume", type = !llvm.func<void (i1)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -32 : i8} : () -> i8
    %1 = "llvm.mlir.constant"() {value = 0 : i8} : () -> i8
    %2 = "llvm.icmp"(%arg0, %1) {predicate = 5 : i64} : (i8, i8) -> i1
    "llvm.call"(%2) {callee = @llvm.assume, fastmathFlags = #llvm.fastmath<>} : (i1) -> ()
    %3 = "llvm.sdiv"(%arg0, %0) : (i8, i8) -> i8
    "llvm.return"(%3) : (i8) -> ()
  }) {linkage = 10 : i64, sym_name = "t0", type = !llvm.func<i8 (i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -32 : i8} : () -> i8
    %1 = "llvm.mlir.constant"() {value = -1 : i8} : () -> i8
    %2 = "llvm.icmp"(%arg0, %1) {predicate = 5 : i64} : (i8, i8) -> i1
    "llvm.call"(%2) {callee = @llvm.assume, fastmathFlags = #llvm.fastmath<>} : (i1) -> ()
    %3 = "llvm.sdiv"(%arg0, %0) : (i8, i8) -> i8
    "llvm.return"(%3) : (i8) -> ()
  }) {linkage = 10 : i64, sym_name = "n1", type = !llvm.func<i8 (i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -31 : i8} : () -> i8
    %1 = "llvm.mlir.constant"() {value = 0 : i8} : () -> i8
    %2 = "llvm.icmp"(%arg0, %1) {predicate = 5 : i64} : (i8, i8) -> i1
    "llvm.call"(%2) {callee = @llvm.assume, fastmathFlags = #llvm.fastmath<>} : (i1) -> ()
    %3 = "llvm.sdiv"(%arg0, %0) : (i8, i8) -> i8
    "llvm.return"(%3) : (i8) -> ()
  }) {linkage = 10 : i64, sym_name = "n2", type = !llvm.func<i8 (i8, i8)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
