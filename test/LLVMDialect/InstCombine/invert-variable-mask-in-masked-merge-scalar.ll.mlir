"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i4, %arg1: i4, %arg2: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i4} : () -> i4
    %1 = "llvm.xor"(%arg2, %0) : (i4, i4) -> i4
    %2 = "llvm.xor"(%arg0, %arg1) : (i4, i4) -> i4
    %3 = "llvm.and"(%2, %1) : (i4, i4) -> i4
    %4 = "llvm.xor"(%3, %arg1) : (i4, i4) -> i4
    "llvm.return"(%4) : (i4) -> ()
  }) {linkage = 10 : i64, sym_name = "scalar", type = !llvm.func<i4 (i4, i4, i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4, %arg1: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i4} : () -> i4
    %1 = "llvm.xor"(%arg1, %0) : (i4, i4) -> i4
    %2 = "llvm.xor"(%arg0, %0) : (i4, i4) -> i4
    %3 = "llvm.and"(%2, %1) : (i4, i4) -> i4
    %4 = "llvm.xor"(%3, %0) : (i4, i4) -> i4
    "llvm.return"(%4) : (i4) -> ()
  }) {linkage = 10 : i64, sym_name = "in_constant_varx_mone_invmask", type = !llvm.func<i4 (i4, i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4, %arg1: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 6 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = -1 : i4} : () -> i4
    %2 = "llvm.xor"(%arg1, %1) : (i4, i4) -> i4
    %3 = "llvm.xor"(%arg0, %0) : (i4, i4) -> i4
    %4 = "llvm.and"(%3, %2) : (i4, i4) -> i4
    %5 = "llvm.xor"(%4, %0) : (i4, i4) -> i4
    "llvm.return"(%5) : (i4) -> ()
  }) {linkage = 10 : i64, sym_name = "in_constant_varx_6_invmask", type = !llvm.func<i4 (i4, i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4, %arg1: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i4} : () -> i4
    %1 = "llvm.xor"(%arg1, %0) : (i4, i4) -> i4
    %2 = "llvm.xor"(%0, %arg0) : (i4, i4) -> i4
    %3 = "llvm.and"(%2, %1) : (i4, i4) -> i4
    %4 = "llvm.xor"(%3, %arg0) : (i4, i4) -> i4
    "llvm.return"(%4) : (i4) -> ()
  }) {linkage = 10 : i64, sym_name = "in_constant_mone_vary_invmask", type = !llvm.func<i4 (i4, i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4, %arg1: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 6 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = -1 : i4} : () -> i4
    %2 = "llvm.xor"(%arg1, %1) : (i4, i4) -> i4
    %3 = "llvm.xor"(%arg0, %0) : (i4, i4) -> i4
    %4 = "llvm.and"(%3, %2) : (i4, i4) -> i4
    %5 = "llvm.xor"(%4, %arg0) : (i4, i4) -> i4
    "llvm.return"(%5) : (i4) -> ()
  }) {linkage = 10 : i64, sym_name = "in_constant_6_vary_invmask", type = !llvm.func<i4 (i4, i4)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "gen4", type = !llvm.func<i4 ()>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4, %arg1: i4, %arg2: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i4} : () -> i4
    %1 = "llvm.xor"(%arg2, %0) : (i4, i4) -> i4
    %2 = "llvm.xor"(%arg1, %arg0) : (i4, i4) -> i4
    %3 = "llvm.and"(%2, %1) : (i4, i4) -> i4
    %4 = "llvm.xor"(%3, %arg1) : (i4, i4) -> i4
    "llvm.return"(%4) : (i4) -> ()
  }) {linkage = 10 : i64, sym_name = "c_1_0_0", type = !llvm.func<i4 (i4, i4, i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4, %arg1: i4, %arg2: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i4} : () -> i4
    %1 = "llvm.xor"(%arg2, %0) : (i4, i4) -> i4
    %2 = "llvm.xor"(%arg0, %arg1) : (i4, i4) -> i4
    %3 = "llvm.and"(%2, %1) : (i4, i4) -> i4
    %4 = "llvm.xor"(%3, %arg0) : (i4, i4) -> i4
    "llvm.return"(%4) : (i4) -> ()
  }) {linkage = 10 : i64, sym_name = "c_0_1_0", type = !llvm.func<i4 (i4, i4, i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i4} : () -> i4
    %1 = "llvm.xor"(%arg0, %0) : (i4, i4) -> i4
    %2 = "llvm.call"() {callee = @gen4, fastmathFlags = #llvm.fastmath<>} : () -> i4
    %3 = "llvm.call"() {callee = @gen4, fastmathFlags = #llvm.fastmath<>} : () -> i4
    %4 = "llvm.xor"(%2, %3) : (i4, i4) -> i4
    %5 = "llvm.and"(%4, %1) : (i4, i4) -> i4
    %6 = "llvm.xor"(%3, %5) : (i4, i4) -> i4
    "llvm.return"(%6) : (i4) -> ()
  }) {linkage = 10 : i64, sym_name = "c_0_0_1", type = !llvm.func<i4 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4, %arg1: i4, %arg2: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i4} : () -> i4
    %1 = "llvm.xor"(%arg2, %0) : (i4, i4) -> i4
    %2 = "llvm.xor"(%arg1, %arg0) : (i4, i4) -> i4
    %3 = "llvm.and"(%2, %1) : (i4, i4) -> i4
    %4 = "llvm.xor"(%3, %arg0) : (i4, i4) -> i4
    "llvm.return"(%4) : (i4) -> ()
  }) {linkage = 10 : i64, sym_name = "c_1_1_0", type = !llvm.func<i4 (i4, i4, i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4, %arg1: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i4} : () -> i4
    %1 = "llvm.xor"(%arg1, %0) : (i4, i4) -> i4
    %2 = "llvm.call"() {callee = @gen4, fastmathFlags = #llvm.fastmath<>} : () -> i4
    %3 = "llvm.xor"(%2, %arg0) : (i4, i4) -> i4
    %4 = "llvm.and"(%3, %1) : (i4, i4) -> i4
    %5 = "llvm.xor"(%2, %4) : (i4, i4) -> i4
    "llvm.return"(%5) : (i4) -> ()
  }) {linkage = 10 : i64, sym_name = "c_1_0_1", type = !llvm.func<i4 (i4, i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4, %arg1: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i4} : () -> i4
    %1 = "llvm.xor"(%arg1, %0) : (i4, i4) -> i4
    %2 = "llvm.call"() {callee = @gen4, fastmathFlags = #llvm.fastmath<>} : () -> i4
    %3 = "llvm.xor"(%2, %arg0) : (i4, i4) -> i4
    %4 = "llvm.and"(%3, %1) : (i4, i4) -> i4
    %5 = "llvm.xor"(%2, %4) : (i4, i4) -> i4
    "llvm.return"(%5) : (i4) -> ()
  }) {linkage = 10 : i64, sym_name = "c_0_1_1", type = !llvm.func<i4 (i4, i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i4} : () -> i4
    %1 = "llvm.xor"(%arg0, %0) : (i4, i4) -> i4
    %2 = "llvm.call"() {callee = @gen4, fastmathFlags = #llvm.fastmath<>} : () -> i4
    %3 = "llvm.call"() {callee = @gen4, fastmathFlags = #llvm.fastmath<>} : () -> i4
    %4 = "llvm.xor"(%3, %2) : (i4, i4) -> i4
    %5 = "llvm.and"(%4, %1) : (i4, i4) -> i4
    %6 = "llvm.xor"(%2, %5) : (i4, i4) -> i4
    "llvm.return"(%6) : (i4) -> ()
  }) {linkage = 10 : i64, sym_name = "c_1_1_1", type = !llvm.func<i4 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4, %arg1: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 6 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = -1 : i4} : () -> i4
    %2 = "llvm.xor"(%arg1, %1) : (i4, i4) -> i4
    %3 = "llvm.xor"(%arg0, %0) : (i4, i4) -> i4
    %4 = "llvm.and"(%2, %3) : (i4, i4) -> i4
    %5 = "llvm.xor"(%4, %0) : (i4, i4) -> i4
    "llvm.return"(%5) : (i4) -> ()
  }) {linkage = 10 : i64, sym_name = "commutativity_constant_varx_6_invmask", type = !llvm.func<i4 (i4, i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4, %arg1: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 6 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = -1 : i4} : () -> i4
    %2 = "llvm.xor"(%arg1, %1) : (i4, i4) -> i4
    %3 = "llvm.xor"(%arg0, %0) : (i4, i4) -> i4
    %4 = "llvm.and"(%2, %3) : (i4, i4) -> i4
    %5 = "llvm.xor"(%4, %arg0) : (i4, i4) -> i4
    "llvm.return"(%5) : (i4) -> ()
  }) {linkage = 10 : i64, sym_name = "commutativity_constant_6_vary_invmask", type = !llvm.func<i4 (i4, i4)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "use4", type = !llvm.func<void (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4, %arg1: i4, %arg2: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i4} : () -> i4
    %1 = "llvm.xor"(%arg2, %0) : (i4, i4) -> i4
    %2 = "llvm.xor"(%arg0, %arg1) : (i4, i4) -> i4
    %3 = "llvm.and"(%2, %1) : (i4, i4) -> i4
    %4 = "llvm.xor"(%3, %arg1) : (i4, i4) -> i4
    "llvm.call"(%2) {callee = @use4, fastmathFlags = #llvm.fastmath<>} : (i4) -> ()
    "llvm.return"(%4) : (i4) -> ()
  }) {linkage = 10 : i64, sym_name = "n_oneuse_D_is_ok", type = !llvm.func<i4 (i4, i4, i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4, %arg1: i4, %arg2: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i4} : () -> i4
    %1 = "llvm.xor"(%arg2, %0) : (i4, i4) -> i4
    %2 = "llvm.xor"(%arg0, %arg1) : (i4, i4) -> i4
    %3 = "llvm.and"(%2, %1) : (i4, i4) -> i4
    %4 = "llvm.xor"(%3, %arg1) : (i4, i4) -> i4
    "llvm.call"(%3) {callee = @use4, fastmathFlags = #llvm.fastmath<>} : (i4) -> ()
    "llvm.return"(%4) : (i4) -> ()
  }) {linkage = 10 : i64, sym_name = "n_oneuse_A", type = !llvm.func<i4 (i4, i4, i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4, %arg1: i4, %arg2: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i4} : () -> i4
    %1 = "llvm.xor"(%arg2, %0) : (i4, i4) -> i4
    %2 = "llvm.xor"(%arg0, %arg1) : (i4, i4) -> i4
    %3 = "llvm.and"(%2, %1) : (i4, i4) -> i4
    %4 = "llvm.xor"(%3, %arg1) : (i4, i4) -> i4
    "llvm.call"(%2) {callee = @use4, fastmathFlags = #llvm.fastmath<>} : (i4) -> ()
    "llvm.call"(%3) {callee = @use4, fastmathFlags = #llvm.fastmath<>} : (i4) -> ()
    "llvm.return"(%4) : (i4) -> ()
  }) {linkage = 10 : i64, sym_name = "n_oneuse_AD", type = !llvm.func<i4 (i4, i4, i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4, %arg1: i4, %arg2: i4, %arg3: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i4} : () -> i4
    %1 = "llvm.xor"(%arg3, %0) : (i4, i4) -> i4
    %2 = "llvm.xor"(%arg0, %arg1) : (i4, i4) -> i4
    %3 = "llvm.and"(%2, %1) : (i4, i4) -> i4
    %4 = "llvm.xor"(%3, %arg2) : (i4, i4) -> i4
    "llvm.return"(%4) : (i4) -> ()
  }) {linkage = 10 : i64, sym_name = "n_third_var", type = !llvm.func<i4 (i4, i4, i4, i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4, %arg1: i4, %arg2: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %1 = "llvm.xor"(%arg2, %0) : (i4, i4) -> i4
    %2 = "llvm.xor"(%arg0, %arg1) : (i4, i4) -> i4
    %3 = "llvm.and"(%2, %1) : (i4, i4) -> i4
    %4 = "llvm.xor"(%3, %arg1) : (i4, i4) -> i4
    "llvm.return"(%4) : (i4) -> ()
  }) {linkage = 10 : i64, sym_name = "n_badxor", type = !llvm.func<i4 (i4, i4, i4)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
