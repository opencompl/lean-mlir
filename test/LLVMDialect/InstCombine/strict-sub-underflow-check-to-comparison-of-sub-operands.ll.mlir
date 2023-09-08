"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.assume", type = !llvm.func<void (i1)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "gen8", type = !llvm.func<i8 ()>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "use8", type = !llvm.func<void (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i8} : () -> i8
    %1 = "llvm.icmp"(%arg1, %0) {predicate = 2 : i64} : (i8, i8) -> i1
    "llvm.call"(%1) {callee = @llvm.assume, fastmathFlags = #llvm.fastmath<>} : (i1) -> ()
    %2 = "llvm.sub"(%arg0, %arg1) : (i8, i8) -> i8
    "llvm.call"(%2) {callee = @use8, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    %3 = "llvm.icmp"(%2, %arg0) {predicate = 6 : i64} : (i8, i8) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "t0", type = !llvm.func<i1 (i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i8} : () -> i8
    %1 = "llvm.icmp"(%arg1, %0) {predicate = 2 : i64} : (i8, i8) -> i1
    "llvm.call"(%1) {callee = @llvm.assume, fastmathFlags = #llvm.fastmath<>} : (i1) -> ()
    %2 = "llvm.sub"(%arg0, %arg1) : (i8, i8) -> i8
    "llvm.call"(%2) {callee = @use8, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    %3 = "llvm.icmp"(%2, %arg0) {predicate = 9 : i64} : (i8, i8) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "t1", type = !llvm.func<i1 (i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i8} : () -> i8
    %1 = "llvm.icmp"(%arg0, %0) {predicate = 2 : i64} : (i8, i8) -> i1
    "llvm.call"(%1) {callee = @llvm.assume, fastmathFlags = #llvm.fastmath<>} : (i1) -> ()
    %2 = "llvm.call"() {callee = @gen8, fastmathFlags = #llvm.fastmath<>} : () -> i8
    %3 = "llvm.sub"(%2, %arg0) : (i8, i8) -> i8
    "llvm.call"(%3) {callee = @use8, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    %4 = "llvm.icmp"(%2, %3) {predicate = 8 : i64} : (i8, i8) -> i1
    "llvm.return"(%4) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "t2", type = !llvm.func<i1 (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i8} : () -> i8
    %1 = "llvm.icmp"(%arg0, %0) {predicate = 2 : i64} : (i8, i8) -> i1
    "llvm.call"(%1) {callee = @llvm.assume, fastmathFlags = #llvm.fastmath<>} : (i1) -> ()
    %2 = "llvm.call"() {callee = @gen8, fastmathFlags = #llvm.fastmath<>} : () -> i8
    %3 = "llvm.sub"(%2, %arg0) : (i8, i8) -> i8
    "llvm.call"(%3) {callee = @use8, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    %4 = "llvm.icmp"(%2, %3) {predicate = 7 : i64} : (i8, i8) -> i1
    "llvm.return"(%4) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "t3", type = !llvm.func<i1 (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8):  // no predecessors
    %0 = "llvm.sub"(%arg0, %arg1) : (i8, i8) -> i8
    "llvm.call"(%0) {callee = @use8, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    %1 = "llvm.icmp"(%0, %arg0) {predicate = 6 : i64} : (i8, i8) -> i1
    "llvm.return"(%1) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "n4_maybezero", type = !llvm.func<i1 (i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i8} : () -> i8
    %1 = "llvm.icmp"(%arg0, %0) {predicate = 4 : i64} : (i8, i8) -> i1
    "llvm.call"(%1) {callee = @llvm.assume, fastmathFlags = #llvm.fastmath<>} : (i1) -> ()
    %2 = "llvm.sub"(%arg0, %arg1) : (i8, i8) -> i8
    "llvm.call"(%2) {callee = @use8, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    %3 = "llvm.icmp"(%2, %arg0) {predicate = 6 : i64} : (i8, i8) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "n5_wrongnonzero", type = !llvm.func<i1 (i8, i8)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
