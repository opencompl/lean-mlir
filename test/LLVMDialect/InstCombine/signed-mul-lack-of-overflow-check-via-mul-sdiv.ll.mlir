"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8):  // no predecessors
    %0 = "llvm.mul"(%arg0, %arg1) : (i8, i8) -> i8
    %1 = "llvm.sdiv"(%0, %arg0) : (i8, i8) -> i8
    %2 = "llvm.icmp"(%1, %arg1) {predicate = 0 : i64} : (i8, i8) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "t0_basic", type = !llvm.func<i1 (i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi8>, %arg1: vector<2xi8>):  // no predecessors
    %0 = "llvm.mul"(%arg0, %arg1) : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %1 = "llvm.sdiv"(%0, %arg0) : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %2 = "llvm.icmp"(%1, %arg1) {predicate = 0 : i64} : (vector<2xi8>, vector<2xi8>) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "t1_vec", type = !llvm.func<vector<2xi1> (vector<2xi8>, vector<2xi8>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "gen8", type = !llvm.func<i8 ()>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.call"() {callee = @gen8, fastmathFlags = #llvm.fastmath<>} : () -> i8
    %1 = "llvm.mul"(%0, %arg0) : (i8, i8) -> i8
    %2 = "llvm.sdiv"(%1, %arg0) : (i8, i8) -> i8
    %3 = "llvm.icmp"(%2, %0) {predicate = 0 : i64} : (i8, i8) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "t2_commutative", type = !llvm.func<i1 (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.call"() {callee = @gen8, fastmathFlags = #llvm.fastmath<>} : () -> i8
    %1 = "llvm.mul"(%0, %arg0) : (i8, i8) -> i8
    %2 = "llvm.sdiv"(%1, %arg0) : (i8, i8) -> i8
    %3 = "llvm.icmp"(%2, %0) {predicate = 0 : i64} : (i8, i8) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "t3_commutative", type = !llvm.func<i1 (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.call"() {callee = @gen8, fastmathFlags = #llvm.fastmath<>} : () -> i8
    %1 = "llvm.mul"(%0, %arg0) : (i8, i8) -> i8
    %2 = "llvm.sdiv"(%1, %arg0) : (i8, i8) -> i8
    %3 = "llvm.icmp"(%0, %2) {predicate = 0 : i64} : (i8, i8) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "t4_commutative", type = !llvm.func<i1 (i8)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "use8", type = !llvm.func<void (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8):  // no predecessors
    %0 = "llvm.mul"(%arg0, %arg1) : (i8, i8) -> i8
    "llvm.call"(%0) {callee = @use8, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    %1 = "llvm.sdiv"(%0, %arg0) : (i8, i8) -> i8
    %2 = "llvm.icmp"(%1, %arg1) {predicate = 0 : i64} : (i8, i8) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "t5_extrause0", type = !llvm.func<i1 (i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8):  // no predecessors
    %0 = "llvm.mul"(%arg0, %arg1) : (i8, i8) -> i8
    %1 = "llvm.sdiv"(%0, %arg0) : (i8, i8) -> i8
    "llvm.call"(%1) {callee = @use8, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    %2 = "llvm.icmp"(%1, %arg1) {predicate = 0 : i64} : (i8, i8) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "t6_extrause1", type = !llvm.func<i1 (i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8):  // no predecessors
    %0 = "llvm.mul"(%arg0, %arg1) : (i8, i8) -> i8
    "llvm.call"(%0) {callee = @use8, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    %1 = "llvm.sdiv"(%0, %arg0) : (i8, i8) -> i8
    "llvm.call"(%1) {callee = @use8, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    %2 = "llvm.icmp"(%1, %arg1) {predicate = 0 : i64} : (i8, i8) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "t7_extrause2", type = !llvm.func<i1 (i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8, %arg2: i8):  // no predecessors
    %0 = "llvm.mul"(%arg0, %arg2) : (i8, i8) -> i8
    %1 = "llvm.sdiv"(%0, %arg1) : (i8, i8) -> i8
    %2 = "llvm.icmp"(%1, %arg2) {predicate = 0 : i64} : (i8, i8) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "n8_different_x", type = !llvm.func<i1 (i8, i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8, %arg2: i8):  // no predecessors
    %0 = "llvm.mul"(%arg0, %arg1) : (i8, i8) -> i8
    %1 = "llvm.sdiv"(%0, %arg0) : (i8, i8) -> i8
    %2 = "llvm.icmp"(%1, %arg2) {predicate = 0 : i64} : (i8, i8) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "n9_different_y", type = !llvm.func<i1 (i8, i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8):  // no predecessors
    %0 = "llvm.mul"(%arg0, %arg1) : (i8, i8) -> i8
    %1 = "llvm.sdiv"(%0, %arg0) : (i8, i8) -> i8
    %2 = "llvm.icmp"(%1, %arg1) {predicate = 6 : i64} : (i8, i8) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "n10_wrong_pred", type = !llvm.func<i1 (i8, i8)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
