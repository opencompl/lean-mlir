"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "use8", type = !llvm.func<void (i8)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "use2xi8", type = !llvm.func<void (vector<2xi8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8):  // no predecessors
    %0 = "llvm.udiv"(%arg0, %arg1) : (i8, i8) -> i8
    "llvm.call"(%0) {callee = @use8, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    %1 = "llvm.mul"(%0, %arg1) : (i8, i8) -> i8
    %2 = "llvm.sub"(%arg0, %1) : (i8, i8) -> i8
    "llvm.return"(%2) : (i8) -> ()
  }) {linkage = 10 : i64, sym_name = "t0_basic", type = !llvm.func<i8 (i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi8>, %arg1: vector<2xi8>):  // no predecessors
    %0 = "llvm.udiv"(%arg0, %arg1) : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    "llvm.call"(%0) {callee = @use2xi8, fastmathFlags = #llvm.fastmath<>} : (vector<2xi8>) -> ()
    %1 = "llvm.mul"(%0, %arg1) : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %2 = "llvm.sub"(%arg0, %1) : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    "llvm.return"(%2) : (vector<2xi8>) -> ()
  }) {linkage = 10 : i64, sym_name = "t1_vector", type = !llvm.func<vector<2xi8> (vector<2xi8>, vector<2xi8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8):  // no predecessors
    %0 = "llvm.udiv"(%arg0, %arg1) : (i8, i8) -> i8
    "llvm.call"(%0) {callee = @use8, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    %1 = "llvm.mul"(%0, %arg1) : (i8, i8) -> i8
    "llvm.call"(%1) {callee = @use8, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    %2 = "llvm.sub"(%arg0, %1) : (i8, i8) -> i8
    "llvm.return"(%2) : (i8) -> ()
  }) {linkage = 10 : i64, sym_name = "t4_extrause", type = !llvm.func<i8 (i8, i8)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "gen8", type = !llvm.func<i8 ()>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.call"() {callee = @gen8, fastmathFlags = #llvm.fastmath<>} : () -> i8
    %1 = "llvm.udiv"(%arg0, %0) : (i8, i8) -> i8
    "llvm.call"(%1) {callee = @use8, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    %2 = "llvm.mul"(%0, %1) : (i8, i8) -> i8
    %3 = "llvm.sub"(%arg0, %2) : (i8, i8) -> i8
    "llvm.return"(%3) : (i8) -> ()
  }) {linkage = 10 : i64, sym_name = "t5_commutative", type = !llvm.func<i8 (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8, %arg2: i8):  // no predecessors
    %0 = "llvm.udiv"(%arg0, %arg2) : (i8, i8) -> i8
    "llvm.call"(%0) {callee = @use8, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    %1 = "llvm.mul"(%0, %arg2) : (i8, i8) -> i8
    %2 = "llvm.sub"(%arg1, %1) : (i8, i8) -> i8
    "llvm.return"(%2) : (i8) -> ()
  }) {linkage = 10 : i64, sym_name = "n6_different_x", type = !llvm.func<i8 (i8, i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8, %arg2: i8):  // no predecessors
    %0 = "llvm.udiv"(%arg0, %arg1) : (i8, i8) -> i8
    "llvm.call"(%0) {callee = @use8, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    %1 = "llvm.mul"(%0, %arg2) : (i8, i8) -> i8
    %2 = "llvm.sub"(%arg0, %1) : (i8, i8) -> i8
    "llvm.return"(%2) : (i8) -> ()
  }) {linkage = 10 : i64, sym_name = "n6_different_y", type = !llvm.func<i8 (i8, i8, i8)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
