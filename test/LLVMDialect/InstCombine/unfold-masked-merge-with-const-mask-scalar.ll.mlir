"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i4, %arg1: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %1 = "llvm.xor"(%arg0, %arg1) : (i4, i4) -> i4
    %2 = "llvm.and"(%1, %0) : (i4, i4) -> i4
    %3 = "llvm.xor"(%2, %arg1) : (i4, i4) -> i4
    "llvm.return"(%3) : (i4) -> ()
  }) {linkage = 10 : i64, sym_name = "scalar0", type = !llvm.func<i4 (i4, i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4, %arg1: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -2 : i4} : () -> i4
    %1 = "llvm.xor"(%arg0, %arg1) : (i4, i4) -> i4
    %2 = "llvm.and"(%1, %0) : (i4, i4) -> i4
    %3 = "llvm.xor"(%2, %arg1) : (i4, i4) -> i4
    "llvm.return"(%3) : (i4) -> ()
  }) {linkage = 10 : i64, sym_name = "scalar1", type = !llvm.func<i4 (i4, i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4, %arg1: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = -1 : i4} : () -> i4
    %2 = "llvm.xor"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.and"(%2, %0) : (i4, i4) -> i4
    %4 = "llvm.xor"(%3, %1) : (i4, i4) -> i4
    "llvm.return"(%4) : (i4) -> ()
  }) {linkage = 10 : i64, sym_name = "in_constant_varx_mone", type = !llvm.func<i4 (i4, i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4, %arg1: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = -2 : i4} : () -> i4
    %2 = "llvm.xor"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.and"(%2, %0) : (i4, i4) -> i4
    %4 = "llvm.xor"(%3, %1) : (i4, i4) -> i4
    "llvm.return"(%4) : (i4) -> ()
  }) {linkage = 10 : i64, sym_name = "in_constant_varx_14", type = !llvm.func<i4 (i4, i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4, %arg1: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = -1 : i4} : () -> i4
    %2 = "llvm.xor"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.and"(%2, %0) : (i4, i4) -> i4
    %4 = "llvm.xor"(%3, %arg0) : (i4, i4) -> i4
    "llvm.return"(%4) : (i4) -> ()
  }) {linkage = 10 : i64, sym_name = "in_constant_mone_vary", type = !llvm.func<i4 (i4, i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4, %arg1: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = -2 : i4} : () -> i4
    %2 = "llvm.xor"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.and"(%2, %0) : (i4, i4) -> i4
    %4 = "llvm.xor"(%3, %arg0) : (i4, i4) -> i4
    "llvm.return"(%4) : (i4) -> ()
  }) {linkage = 10 : i64, sym_name = "in_constant_14_vary", type = !llvm.func<i4 (i4, i4)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "gen4", type = !llvm.func<i4 ()>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4, %arg1: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -2 : i4} : () -> i4
    %1 = "llvm.xor"(%arg1, %arg0) : (i4, i4) -> i4
    %2 = "llvm.and"(%1, %0) : (i4, i4) -> i4
    %3 = "llvm.xor"(%2, %arg1) : (i4, i4) -> i4
    "llvm.return"(%3) : (i4) -> ()
  }) {linkage = 10 : i64, sym_name = "c_1_0_0", type = !llvm.func<i4 (i4, i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4, %arg1: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -2 : i4} : () -> i4
    %1 = "llvm.xor"(%arg0, %arg1) : (i4, i4) -> i4
    %2 = "llvm.and"(%1, %0) : (i4, i4) -> i4
    %3 = "llvm.xor"(%2, %arg0) : (i4, i4) -> i4
    "llvm.return"(%3) : (i4) -> ()
  }) {linkage = 10 : i64, sym_name = "c_0_1_0", type = !llvm.func<i4 (i4, i4)>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = -2 : i4} : () -> i4
    %1 = "llvm.call"() {callee = @gen4, fastmathFlags = #llvm.fastmath<>} : () -> i4
    %2 = "llvm.call"() {callee = @gen4, fastmathFlags = #llvm.fastmath<>} : () -> i4
    %3 = "llvm.xor"(%1, %2) : (i4, i4) -> i4
    %4 = "llvm.and"(%3, %0) : (i4, i4) -> i4
    %5 = "llvm.xor"(%2, %4) : (i4, i4) -> i4
    "llvm.return"(%5) : (i4) -> ()
  }) {linkage = 10 : i64, sym_name = "c_0_0_1", type = !llvm.func<i4 ()>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4, %arg1: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -2 : i4} : () -> i4
    %1 = "llvm.xor"(%arg1, %arg0) : (i4, i4) -> i4
    %2 = "llvm.and"(%1, %0) : (i4, i4) -> i4
    %3 = "llvm.xor"(%2, %arg0) : (i4, i4) -> i4
    "llvm.return"(%3) : (i4) -> ()
  }) {linkage = 10 : i64, sym_name = "c_1_1_0", type = !llvm.func<i4 (i4, i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -2 : i4} : () -> i4
    %1 = "llvm.call"() {callee = @gen4, fastmathFlags = #llvm.fastmath<>} : () -> i4
    %2 = "llvm.xor"(%1, %arg0) : (i4, i4) -> i4
    %3 = "llvm.and"(%2, %0) : (i4, i4) -> i4
    %4 = "llvm.xor"(%1, %3) : (i4, i4) -> i4
    "llvm.return"(%4) : (i4) -> ()
  }) {linkage = 10 : i64, sym_name = "c_1_0_1", type = !llvm.func<i4 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -2 : i4} : () -> i4
    %1 = "llvm.call"() {callee = @gen4, fastmathFlags = #llvm.fastmath<>} : () -> i4
    %2 = "llvm.xor"(%1, %arg0) : (i4, i4) -> i4
    %3 = "llvm.and"(%2, %0) : (i4, i4) -> i4
    %4 = "llvm.xor"(%1, %3) : (i4, i4) -> i4
    "llvm.return"(%4) : (i4) -> ()
  }) {linkage = 10 : i64, sym_name = "c_0_1_1", type = !llvm.func<i4 (i4)>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = -2 : i4} : () -> i4
    %1 = "llvm.call"() {callee = @gen4, fastmathFlags = #llvm.fastmath<>} : () -> i4
    %2 = "llvm.call"() {callee = @gen4, fastmathFlags = #llvm.fastmath<>} : () -> i4
    %3 = "llvm.xor"(%2, %1) : (i4, i4) -> i4
    %4 = "llvm.and"(%3, %0) : (i4, i4) -> i4
    %5 = "llvm.xor"(%1, %4) : (i4, i4) -> i4
    "llvm.return"(%5) : (i4) -> ()
  }) {linkage = 10 : i64, sym_name = "c_1_1_1", type = !llvm.func<i4 ()>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4, %arg1: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = -2 : i4} : () -> i4
    %2 = "llvm.xor"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.and"(%2, %0) : (i4, i4) -> i4
    %4 = "llvm.xor"(%arg0, %3) : (i4, i4) -> i4
    "llvm.return"(%4) : (i4) -> ()
  }) {linkage = 10 : i64, sym_name = "commutativity_constant_14_vary", type = !llvm.func<i4 (i4, i4)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "use4", type = !llvm.func<void (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4, %arg1: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -2 : i4} : () -> i4
    %1 = "llvm.xor"(%arg0, %arg1) : (i4, i4) -> i4
    %2 = "llvm.and"(%1, %0) : (i4, i4) -> i4
    %3 = "llvm.xor"(%2, %arg1) : (i4, i4) -> i4
    "llvm.call"(%1) {callee = @use4, fastmathFlags = #llvm.fastmath<>} : (i4) -> ()
    "llvm.return"(%3) : (i4) -> ()
  }) {linkage = 10 : i64, sym_name = "n_oneuse_D", type = !llvm.func<i4 (i4, i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4, %arg1: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -2 : i4} : () -> i4
    %1 = "llvm.xor"(%arg0, %arg1) : (i4, i4) -> i4
    %2 = "llvm.and"(%1, %0) : (i4, i4) -> i4
    %3 = "llvm.xor"(%2, %arg1) : (i4, i4) -> i4
    "llvm.call"(%2) {callee = @use4, fastmathFlags = #llvm.fastmath<>} : (i4) -> ()
    "llvm.return"(%3) : (i4) -> ()
  }) {linkage = 10 : i64, sym_name = "n_oneuse_A", type = !llvm.func<i4 (i4, i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4, %arg1: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -2 : i4} : () -> i4
    %1 = "llvm.xor"(%arg0, %arg1) : (i4, i4) -> i4
    %2 = "llvm.and"(%1, %0) : (i4, i4) -> i4
    %3 = "llvm.xor"(%2, %arg1) : (i4, i4) -> i4
    "llvm.call"(%1) {callee = @use4, fastmathFlags = #llvm.fastmath<>} : (i4) -> ()
    "llvm.call"(%2) {callee = @use4, fastmathFlags = #llvm.fastmath<>} : (i4) -> ()
    "llvm.return"(%3) : (i4) -> ()
  }) {linkage = 10 : i64, sym_name = "n_oneuse_AD", type = !llvm.func<i4 (i4, i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4, %arg1: i4, %arg2: i4):  // no predecessors
    %0 = "llvm.xor"(%arg0, %arg1) : (i4, i4) -> i4
    %1 = "llvm.and"(%0, %arg2) : (i4, i4) -> i4
    %2 = "llvm.xor"(%1, %arg1) : (i4, i4) -> i4
    "llvm.return"(%2) : (i4) -> ()
  }) {linkage = 10 : i64, sym_name = "n_var_mask", type = !llvm.func<i4 (i4, i4, i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4, %arg1: i4, %arg2: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -2 : i4} : () -> i4
    %1 = "llvm.xor"(%arg0, %arg1) : (i4, i4) -> i4
    %2 = "llvm.and"(%1, %0) : (i4, i4) -> i4
    %3 = "llvm.xor"(%2, %arg2) : (i4, i4) -> i4
    "llvm.return"(%3) : (i4) -> ()
  }) {linkage = 10 : i64, sym_name = "n_third_var", type = !llvm.func<i4 (i4, i4, i4)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
