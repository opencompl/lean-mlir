"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "use8", type = !llvm.func<void (i8)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "use2x8", type = !llvm.func<void (vector<2xi8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i8} : () -> i8
    %1 = "llvm.xor"(%arg1, %0) : (i8, i8) -> i8
    "llvm.call"(%1) {callee = @use8, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    %2 = "llvm.icmp"(%1, %arg0) {predicate = 6 : i64} : (i8, i8) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "t0_basic", type = !llvm.func<i1 (i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi8>, %arg1: vector<2xi8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<-1> : vector<2xi8>} : () -> vector<2xi8>
    %1 = "llvm.xor"(%arg1, %0) : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    "llvm.call"(%1) {callee = @use2x8, fastmathFlags = #llvm.fastmath<>} : (vector<2xi8>) -> ()
    %2 = "llvm.icmp"(%1, %arg0) {predicate = 6 : i64} : (vector<2xi8>, vector<2xi8>) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "t1_vec", type = !llvm.func<vector<2xi1> (vector<2xi8>, vector<2xi8>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "gen8", type = !llvm.func<i8 ()>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i8} : () -> i8
    %1 = "llvm.xor"(%arg0, %0) : (i8, i8) -> i8
    "llvm.call"(%1) {callee = @use8, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    %2 = "llvm.call"() {callee = @gen8, fastmathFlags = #llvm.fastmath<>} : () -> i8
    %3 = "llvm.icmp"(%2, %1) {predicate = 7 : i64} : (i8, i8) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "t2_commutative", type = !llvm.func<i1 (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i8} : () -> i8
    %1 = "llvm.xor"(%arg1, %0) : (i8, i8) -> i8
    %2 = "llvm.icmp"(%1, %arg0) {predicate = 6 : i64} : (i8, i8) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "t3_no_extrause", type = !llvm.func<i1 (i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i8} : () -> i8
    %1 = "llvm.xor"(%arg1, %0) : (i8, i8) -> i8
    "llvm.call"(%1) {callee = @use8, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    %2 = "llvm.icmp"(%1, %arg0) {predicate = 7 : i64} : (i8, i8) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "n4_wrong_pred0", type = !llvm.func<i1 (i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i8} : () -> i8
    %1 = "llvm.xor"(%arg1, %0) : (i8, i8) -> i8
    "llvm.call"(%1) {callee = @use8, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    %2 = "llvm.icmp"(%1, %arg0) {predicate = 8 : i64} : (i8, i8) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "n5_wrong_pred1", type = !llvm.func<i1 (i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i8} : () -> i8
    %1 = "llvm.xor"(%arg1, %0) : (i8, i8) -> i8
    "llvm.call"(%1) {callee = @use8, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    %2 = "llvm.icmp"(%1, %arg0) {predicate = 0 : i64} : (i8, i8) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "n6_wrong_pred2", type = !llvm.func<i1 (i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i8} : () -> i8
    %1 = "llvm.xor"(%arg1, %0) : (i8, i8) -> i8
    "llvm.call"(%1) {callee = @use8, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    %2 = "llvm.icmp"(%1, %arg0) {predicate = 1 : i64} : (i8, i8) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "n7_wrong_pred3", type = !llvm.func<i1 (i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i8} : () -> i8
    %1 = "llvm.xor"(%arg1, %0) : (i8, i8) -> i8
    "llvm.call"(%1) {callee = @use8, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    %2 = "llvm.icmp"(%1, %arg0) {predicate = 2 : i64} : (i8, i8) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "n8_wrong_pred4", type = !llvm.func<i1 (i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i8} : () -> i8
    %1 = "llvm.xor"(%arg1, %0) : (i8, i8) -> i8
    "llvm.call"(%1) {callee = @use8, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    %2 = "llvm.icmp"(%1, %arg0) {predicate = 3 : i64} : (i8, i8) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "n9_wrong_pred5", type = !llvm.func<i1 (i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i8} : () -> i8
    %1 = "llvm.xor"(%arg1, %0) : (i8, i8) -> i8
    "llvm.call"(%1) {callee = @use8, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    %2 = "llvm.icmp"(%1, %arg0) {predicate = 4 : i64} : (i8, i8) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "n10_wrong_pred6", type = !llvm.func<i1 (i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i8} : () -> i8
    %1 = "llvm.xor"(%arg1, %0) : (i8, i8) -> i8
    "llvm.call"(%1) {callee = @use8, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    %2 = "llvm.icmp"(%1, %arg0) {predicate = 5 : i64} : (i8, i8) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "n11_wrong_pred7", type = !llvm.func<i1 (i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi8>, %arg1: vector<2xi8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<[-1, -2]> : vector<2xi8>} : () -> vector<2xi8>
    %1 = "llvm.xor"(%arg1, %0) : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    "llvm.call"(%1) {callee = @use2x8, fastmathFlags = #llvm.fastmath<>} : (vector<2xi8>) -> ()
    %2 = "llvm.icmp"(%1, %arg0) {predicate = 6 : i64} : (vector<2xi8>, vector<2xi8>) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "n12_vec_nonsplat", type = !llvm.func<vector<2xi1> (vector<2xi8>, vector<2xi8>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
