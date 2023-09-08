"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "gen8", type = !llvm.func<i8 ()>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "use8", type = !llvm.func<void (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i8} : () -> i8
    %1 = "llvm.sub"(%0, %arg0) : (i8, i8) -> i8
    %2 = "llvm.icmp"(%1, %arg0) {predicate = 4 : i64} : (i8, i8) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "t0", type = !llvm.func<i1 (i8)>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 0 : i8} : () -> i8
    %1 = "llvm.call"() {callee = @gen8, fastmathFlags = #llvm.fastmath<>} : () -> i8
    %2 = "llvm.sub"(%0, %1) : (i8, i8) -> i8
    %3 = "llvm.icmp"(%1, %2) {predicate = 2 : i64} : (i8, i8) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "t0_commutative", type = !llvm.func<i1 ()>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i8} : () -> i8
    %1 = "llvm.sub"(%0, %arg0) : (i8, i8) -> i8
    "llvm.call"(%1) {callee = @use8, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    %2 = "llvm.icmp"(%1, %arg0) {predicate = 4 : i64} : (i8, i8) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "t0_extrause", type = !llvm.func<i1 (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i8} : () -> i8
    %1 = "llvm.sub"(%0, %arg0) : (i8, i8) -> i8
    %2 = "llvm.icmp"(%1, %arg0) {predicate = 5 : i64} : (i8, i8) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "t1", type = !llvm.func<i1 (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i8} : () -> i8
    %1 = "llvm.sub"(%0, %arg0) : (i8, i8) -> i8
    %2 = "llvm.icmp"(%1, %arg0) {predicate = 2 : i64} : (i8, i8) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "t2", type = !llvm.func<i1 (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i8} : () -> i8
    %1 = "llvm.sub"(%0, %arg0) : (i8, i8) -> i8
    %2 = "llvm.icmp"(%1, %arg0) {predicate = 3 : i64} : (i8, i8) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "t3", type = !llvm.func<i1 (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i8} : () -> i8
    %1 = "llvm.sub"(%0, %arg0) : (i8, i8) -> i8
    %2 = "llvm.icmp"(%1, %arg0) {predicate = 8 : i64} : (i8, i8) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "t4", type = !llvm.func<i1 (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i8} : () -> i8
    %1 = "llvm.sub"(%0, %arg0) : (i8, i8) -> i8
    %2 = "llvm.icmp"(%1, %arg0) {predicate = 9 : i64} : (i8, i8) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "t5", type = !llvm.func<i1 (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i8} : () -> i8
    %1 = "llvm.sub"(%0, %arg0) : (i8, i8) -> i8
    %2 = "llvm.icmp"(%1, %arg0) {predicate = 6 : i64} : (i8, i8) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "t6", type = !llvm.func<i1 (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i8} : () -> i8
    %1 = "llvm.sub"(%0, %arg0) : (i8, i8) -> i8
    %2 = "llvm.icmp"(%1, %arg0) {predicate = 7 : i64} : (i8, i8) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "t7", type = !llvm.func<i1 (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i8} : () -> i8
    %1 = "llvm.sub"(%0, %arg0) : (i8, i8) -> i8
    %2 = "llvm.icmp"(%1, %arg0) {predicate = 0 : i64} : (i8, i8) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "t8", type = !llvm.func<i1 (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i8} : () -> i8
    %1 = "llvm.sub"(%0, %arg0) : (i8, i8) -> i8
    %2 = "llvm.icmp"(%1, %arg0) {predicate = 1 : i64} : (i8, i8) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "t9", type = !llvm.func<i1 (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i8} : () -> i8
    %1 = "llvm.sub"(%0, %arg0) : (i8, i8) -> i8
    %2 = "llvm.icmp"(%1, %arg0) {predicate = 4 : i64} : (i8, i8) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "n10", type = !llvm.func<i1 (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i8} : () -> i8
    %1 = "llvm.sub"(%0, %arg0) : (i8, i8) -> i8
    %2 = "llvm.icmp"(%1, %arg0) {predicate = 4 : i64} : (i8, i8) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "n11", type = !llvm.func<i1 (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i8} : () -> i8
    %1 = "llvm.sub"(%0, %arg0) : (i8, i8) -> i8
    %2 = "llvm.icmp"(%1, %arg1) {predicate = 4 : i64} : (i8, i8) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "n12", type = !llvm.func<i1 (i8, i8)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
