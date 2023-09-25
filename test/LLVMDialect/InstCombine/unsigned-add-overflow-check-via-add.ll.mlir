"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "use8", type = !llvm.func<void (i8)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "use2x8", type = !llvm.func<void (vector<2xi8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8):  // no predecessors
    %0 = "llvm.add"(%arg0, %arg1) : (i8, i8) -> i8
    "llvm.call"(%0) {callee = @use8, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    %1 = "llvm.icmp"(%0, %arg1) {predicate = 6 : i64} : (i8, i8) -> i1
    "llvm.return"(%1) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "t0_basic", type = !llvm.func<i1 (i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi8>, %arg1: vector<2xi8>):  // no predecessors
    %0 = "llvm.add"(%arg0, %arg1) : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    "llvm.call"(%0) {callee = @use2x8, fastmathFlags = #llvm.fastmath<>} : (vector<2xi8>) -> ()
    %1 = "llvm.icmp"(%0, %arg1) {predicate = 6 : i64} : (vector<2xi8>, vector<2xi8>) -> i1
    "llvm.return"(%1) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "t1_vec", type = !llvm.func<vector<2xi1> (vector<2xi8>, vector<2xi8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8):  // no predecessors
    %0 = "llvm.add"(%arg0, %arg1) : (i8, i8) -> i8
    "llvm.call"(%0) {callee = @use8, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    %1 = "llvm.icmp"(%0, %arg0) {predicate = 6 : i64} : (i8, i8) -> i1
    "llvm.return"(%1) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "t2_symmetry", type = !llvm.func<i1 (i8, i8)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "gen8", type = !llvm.func<i8 ()>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.call"() {callee = @gen8, fastmathFlags = #llvm.fastmath<>} : () -> i8
    %1 = "llvm.add"(%0, %arg0) : (i8, i8) -> i8
    "llvm.call"(%1) {callee = @use8, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    %2 = "llvm.icmp"(%1, %0) {predicate = 6 : i64} : (i8, i8) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "t3_commutative", type = !llvm.func<i1 (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8):  // no predecessors
    %0 = "llvm.add"(%arg0, %arg1) : (i8, i8) -> i8
    "llvm.call"(%0) {callee = @use8, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    %1 = "llvm.icmp"(%arg1, %0) {predicate = 8 : i64} : (i8, i8) -> i1
    "llvm.return"(%1) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "t4_commutative", type = !llvm.func<i1 (i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.call"() {callee = @gen8, fastmathFlags = #llvm.fastmath<>} : () -> i8
    %1 = "llvm.add"(%0, %arg0) : (i8, i8) -> i8
    "llvm.call"(%1) {callee = @use8, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    %2 = "llvm.icmp"(%0, %1) {predicate = 8 : i64} : (i8, i8) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "t5_commutative", type = !llvm.func<i1 (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8):  // no predecessors
    %0 = "llvm.add"(%arg0, %arg1) : (i8, i8) -> i8
    %1 = "llvm.icmp"(%0, %arg1) {predicate = 6 : i64} : (i8, i8) -> i1
    "llvm.return"(%1) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "t6_no_extrause", type = !llvm.func<i1 (i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8, %arg2: i8):  // no predecessors
    %0 = "llvm.add"(%arg0, %arg1) : (i8, i8) -> i8
    "llvm.call"(%0) {callee = @use8, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    %1 = "llvm.icmp"(%0, %arg2) {predicate = 6 : i64} : (i8, i8) -> i1
    "llvm.return"(%1) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "n7_different_y", type = !llvm.func<i1 (i8, i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8):  // no predecessors
    %0 = "llvm.add"(%arg0, %arg1) : (i8, i8) -> i8
    "llvm.call"(%0) {callee = @use8, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    %1 = "llvm.icmp"(%0, %arg1) {predicate = 7 : i64} : (i8, i8) -> i1
    "llvm.return"(%1) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "n8_wrong_pred0", type = !llvm.func<i1 (i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8):  // no predecessors
    %0 = "llvm.add"(%arg0, %arg1) : (i8, i8) -> i8
    "llvm.call"(%0) {callee = @use8, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    %1 = "llvm.icmp"(%0, %arg1) {predicate = 8 : i64} : (i8, i8) -> i1
    "llvm.return"(%1) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "n9_wrong_pred1", type = !llvm.func<i1 (i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8):  // no predecessors
    %0 = "llvm.add"(%arg0, %arg1) : (i8, i8) -> i8
    "llvm.call"(%0) {callee = @use8, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    %1 = "llvm.icmp"(%0, %arg1) {predicate = 0 : i64} : (i8, i8) -> i1
    "llvm.return"(%1) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "n10_wrong_pred2", type = !llvm.func<i1 (i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8):  // no predecessors
    %0 = "llvm.add"(%arg0, %arg1) : (i8, i8) -> i8
    "llvm.call"(%0) {callee = @use8, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    %1 = "llvm.icmp"(%0, %arg1) {predicate = 1 : i64} : (i8, i8) -> i1
    "llvm.return"(%1) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "n11_wrong_pred3", type = !llvm.func<i1 (i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8):  // no predecessors
    %0 = "llvm.add"(%arg0, %arg1) : (i8, i8) -> i8
    "llvm.call"(%0) {callee = @use8, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    %1 = "llvm.icmp"(%0, %arg1) {predicate = 2 : i64} : (i8, i8) -> i1
    "llvm.return"(%1) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "n12_wrong_pred4", type = !llvm.func<i1 (i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8):  // no predecessors
    %0 = "llvm.add"(%arg0, %arg1) : (i8, i8) -> i8
    "llvm.call"(%0) {callee = @use8, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    %1 = "llvm.icmp"(%0, %arg1) {predicate = 3 : i64} : (i8, i8) -> i1
    "llvm.return"(%1) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "n13_wrong_pred5", type = !llvm.func<i1 (i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8):  // no predecessors
    %0 = "llvm.add"(%arg0, %arg1) : (i8, i8) -> i8
    "llvm.call"(%0) {callee = @use8, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    %1 = "llvm.icmp"(%0, %arg1) {predicate = 4 : i64} : (i8, i8) -> i1
    "llvm.return"(%1) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "n14_wrong_pred6", type = !llvm.func<i1 (i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8):  // no predecessors
    %0 = "llvm.add"(%arg0, %arg1) : (i8, i8) -> i8
    "llvm.call"(%0) {callee = @use8, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    %1 = "llvm.icmp"(%0, %arg1) {predicate = 5 : i64} : (i8, i8) -> i1
    "llvm.return"(%1) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "n15_wrong_pred7", type = !llvm.func<i1 (i8, i8)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
