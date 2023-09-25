"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "use8", type = !llvm.func<void (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i6, %arg1: i6, %arg2: i6):  // no predecessors
    %0 = "llvm.shl"(%arg0, %arg2) : (i6, i6) -> i6
    %1 = "llvm.shl"(%arg1, %arg2) : (i6, i6) -> i6
    %2 = "llvm.add"(%0, %1) : (i6, i6) -> i6
    "llvm.return"(%2) : (i6) -> ()
  }) {linkage = 10 : i64, sym_name = "add_shl_same_amount", type = !llvm.func<i6 (i6, i6, i6)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi4>, %arg1: vector<2xi4>, %arg2: vector<2xi4>):  // no predecessors
    %0 = "llvm.shl"(%arg0, %arg2) : (vector<2xi4>, vector<2xi4>) -> vector<2xi4>
    %1 = "llvm.shl"(%arg1, %arg2) : (vector<2xi4>, vector<2xi4>) -> vector<2xi4>
    %2 = "llvm.add"(%0, %1) : (vector<2xi4>, vector<2xi4>) -> vector<2xi4>
    "llvm.return"(%2) : (vector<2xi4>) -> ()
  }) {linkage = 10 : i64, sym_name = "add_shl_same_amount_nsw", type = !llvm.func<vector<2xi4> (vector<2xi4>, vector<2xi4>, vector<2xi4>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64, %arg1: i64, %arg2: i64):  // no predecessors
    %0 = "llvm.shl"(%arg0, %arg2) : (i64, i64) -> i64
    %1 = "llvm.shl"(%arg1, %arg2) : (i64, i64) -> i64
    %2 = "llvm.add"(%0, %1) : (i64, i64) -> i64
    "llvm.return"(%2) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "add_shl_same_amount_nuw", type = !llvm.func<i64 (i64, i64, i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8, %arg2: i8):  // no predecessors
    %0 = "llvm.shl"(%arg0, %arg2) : (i8, i8) -> i8
    "llvm.call"(%0) {callee = @use8, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    %1 = "llvm.shl"(%arg1, %arg2) : (i8, i8) -> i8
    %2 = "llvm.add"(%0, %1) : (i8, i8) -> i8
    "llvm.return"(%2) : (i8) -> ()
  }) {linkage = 10 : i64, sym_name = "add_shl_same_amount_nsw_extra_use1", type = !llvm.func<i8 (i8, i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8, %arg2: i8):  // no predecessors
    %0 = "llvm.shl"(%arg0, %arg2) : (i8, i8) -> i8
    %1 = "llvm.shl"(%arg1, %arg2) : (i8, i8) -> i8
    "llvm.call"(%1) {callee = @use8, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    %2 = "llvm.add"(%0, %1) : (i8, i8) -> i8
    "llvm.return"(%2) : (i8) -> ()
  }) {linkage = 10 : i64, sym_name = "add_shl_same_amount_nuw_extra_use2", type = !llvm.func<i8 (i8, i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8, %arg2: i8):  // no predecessors
    %0 = "llvm.shl"(%arg0, %arg2) : (i8, i8) -> i8
    "llvm.call"(%0) {callee = @use8, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    %1 = "llvm.shl"(%arg1, %arg2) : (i8, i8) -> i8
    "llvm.call"(%1) {callee = @use8, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    %2 = "llvm.add"(%0, %1) : (i8, i8) -> i8
    "llvm.return"(%2) : (i8) -> ()
  }) {linkage = 10 : i64, sym_name = "add_shl_same_amount_nsw_nuw_extra_use3", type = !llvm.func<i8 (i8, i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i6, %arg1: i6, %arg2: i6):  // no predecessors
    %0 = "llvm.shl"(%arg0, %arg2) : (i6, i6) -> i6
    %1 = "llvm.shl"(%arg1, %arg2) : (i6, i6) -> i6
    %2 = "llvm.add"(%0, %1) : (i6, i6) -> i6
    "llvm.return"(%2) : (i6) -> ()
  }) {linkage = 10 : i64, sym_name = "add_shl_same_amount_partial_nsw1", type = !llvm.func<i6 (i6, i6, i6)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i6, %arg1: i6, %arg2: i6):  // no predecessors
    %0 = "llvm.shl"(%arg0, %arg2) : (i6, i6) -> i6
    %1 = "llvm.shl"(%arg1, %arg2) : (i6, i6) -> i6
    %2 = "llvm.add"(%0, %1) : (i6, i6) -> i6
    "llvm.return"(%2) : (i6) -> ()
  }) {linkage = 10 : i64, sym_name = "add_shl_same_amount_partial_nsw2", type = !llvm.func<i6 (i6, i6, i6)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i6, %arg1: i6, %arg2: i6):  // no predecessors
    %0 = "llvm.shl"(%arg0, %arg2) : (i6, i6) -> i6
    %1 = "llvm.shl"(%arg1, %arg2) : (i6, i6) -> i6
    %2 = "llvm.add"(%0, %1) : (i6, i6) -> i6
    "llvm.return"(%2) : (i6) -> ()
  }) {linkage = 10 : i64, sym_name = "add_shl_same_amount_partial_nuw1", type = !llvm.func<i6 (i6, i6, i6)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i6, %arg1: i6, %arg2: i6):  // no predecessors
    %0 = "llvm.shl"(%arg0, %arg2) : (i6, i6) -> i6
    %1 = "llvm.shl"(%arg1, %arg2) : (i6, i6) -> i6
    %2 = "llvm.add"(%0, %1) : (i6, i6) -> i6
    "llvm.return"(%2) : (i6) -> ()
  }) {linkage = 10 : i64, sym_name = "add_shl_same_amount_partial_nuw2", type = !llvm.func<i6 (i6, i6, i6)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i6, %arg1: i6, %arg2: i6):  // no predecessors
    %0 = "llvm.shl"(%arg0, %arg2) : (i6, i6) -> i6
    %1 = "llvm.shl"(%arg1, %arg2) : (i6, i6) -> i6
    %2 = "llvm.sub"(%0, %1) : (i6, i6) -> i6
    "llvm.return"(%2) : (i6) -> ()
  }) {linkage = 10 : i64, sym_name = "sub_shl_same_amount", type = !llvm.func<i6 (i6, i6, i6)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi4>, %arg1: vector<2xi4>, %arg2: vector<2xi4>):  // no predecessors
    %0 = "llvm.shl"(%arg0, %arg2) : (vector<2xi4>, vector<2xi4>) -> vector<2xi4>
    %1 = "llvm.shl"(%arg1, %arg2) : (vector<2xi4>, vector<2xi4>) -> vector<2xi4>
    %2 = "llvm.sub"(%0, %1) : (vector<2xi4>, vector<2xi4>) -> vector<2xi4>
    "llvm.return"(%2) : (vector<2xi4>) -> ()
  }) {linkage = 10 : i64, sym_name = "sub_shl_same_amount_nsw", type = !llvm.func<vector<2xi4> (vector<2xi4>, vector<2xi4>, vector<2xi4>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64, %arg1: i64, %arg2: i64):  // no predecessors
    %0 = "llvm.shl"(%arg0, %arg2) : (i64, i64) -> i64
    %1 = "llvm.shl"(%arg1, %arg2) : (i64, i64) -> i64
    %2 = "llvm.sub"(%0, %1) : (i64, i64) -> i64
    "llvm.return"(%2) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "sub_shl_same_amount_nuw", type = !llvm.func<i64 (i64, i64, i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8, %arg2: i8):  // no predecessors
    %0 = "llvm.shl"(%arg0, %arg2) : (i8, i8) -> i8
    "llvm.call"(%0) {callee = @use8, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    %1 = "llvm.shl"(%arg1, %arg2) : (i8, i8) -> i8
    %2 = "llvm.sub"(%0, %1) : (i8, i8) -> i8
    "llvm.return"(%2) : (i8) -> ()
  }) {linkage = 10 : i64, sym_name = "sub_shl_same_amount_nsw_extra_use1", type = !llvm.func<i8 (i8, i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8, %arg2: i8):  // no predecessors
    %0 = "llvm.shl"(%arg0, %arg2) : (i8, i8) -> i8
    %1 = "llvm.shl"(%arg1, %arg2) : (i8, i8) -> i8
    "llvm.call"(%1) {callee = @use8, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    %2 = "llvm.sub"(%0, %1) : (i8, i8) -> i8
    "llvm.return"(%2) : (i8) -> ()
  }) {linkage = 10 : i64, sym_name = "sub_shl_same_amount_nuw_extra_use2", type = !llvm.func<i8 (i8, i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8, %arg2: i8):  // no predecessors
    %0 = "llvm.shl"(%arg0, %arg2) : (i8, i8) -> i8
    "llvm.call"(%0) {callee = @use8, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    %1 = "llvm.shl"(%arg1, %arg2) : (i8, i8) -> i8
    "llvm.call"(%1) {callee = @use8, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    %2 = "llvm.sub"(%0, %1) : (i8, i8) -> i8
    "llvm.return"(%2) : (i8) -> ()
  }) {linkage = 10 : i64, sym_name = "sub_shl_same_amount_nsw_nuw_extra_use3", type = !llvm.func<i8 (i8, i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i6, %arg1: i6, %arg2: i6):  // no predecessors
    %0 = "llvm.shl"(%arg0, %arg2) : (i6, i6) -> i6
    %1 = "llvm.shl"(%arg1, %arg2) : (i6, i6) -> i6
    %2 = "llvm.sub"(%0, %1) : (i6, i6) -> i6
    "llvm.return"(%2) : (i6) -> ()
  }) {linkage = 10 : i64, sym_name = "sub_shl_same_amount_partial_nsw1", type = !llvm.func<i6 (i6, i6, i6)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i6, %arg1: i6, %arg2: i6):  // no predecessors
    %0 = "llvm.shl"(%arg0, %arg2) : (i6, i6) -> i6
    %1 = "llvm.shl"(%arg1, %arg2) : (i6, i6) -> i6
    %2 = "llvm.sub"(%0, %1) : (i6, i6) -> i6
    "llvm.return"(%2) : (i6) -> ()
  }) {linkage = 10 : i64, sym_name = "sub_shl_same_amount_partial_nsw2", type = !llvm.func<i6 (i6, i6, i6)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i6, %arg1: i6, %arg2: i6):  // no predecessors
    %0 = "llvm.shl"(%arg0, %arg2) : (i6, i6) -> i6
    %1 = "llvm.shl"(%arg1, %arg2) : (i6, i6) -> i6
    %2 = "llvm.sub"(%0, %1) : (i6, i6) -> i6
    "llvm.return"(%2) : (i6) -> ()
  }) {linkage = 10 : i64, sym_name = "sub_shl_same_amount_partial_nuw1", type = !llvm.func<i6 (i6, i6, i6)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i6, %arg1: i6, %arg2: i6):  // no predecessors
    %0 = "llvm.shl"(%arg0, %arg2) : (i6, i6) -> i6
    %1 = "llvm.shl"(%arg1, %arg2) : (i6, i6) -> i6
    %2 = "llvm.sub"(%0, %1) : (i6, i6) -> i6
    "llvm.return"(%2) : (i6) -> ()
  }) {linkage = 10 : i64, sym_name = "sub_shl_same_amount_partial_nuw2", type = !llvm.func<i6 (i6, i6, i6)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
