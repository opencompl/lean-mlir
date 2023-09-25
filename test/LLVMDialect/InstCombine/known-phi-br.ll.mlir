"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 7 : i64} : () -> i64
    %1 = "llvm.icmp"(%arg0, %0) {predicate = 0 : i64} : (i64, i64) -> i1
    "llvm.cond_br"(%1, %arg0)[^bb2, ^bb1] {operand_segment_sizes = dense<[1, 1, 0]> : vector<3xi32>} : (i1, i64) -> ()
  ^bb1:  // pred: ^bb0
    "llvm.br"(%0)[^bb2] : (i64) -> ()
  ^bb2(%2: i64):  // 2 preds: ^bb0, ^bb1
    "llvm.return"(%2) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "limit_i64_eq_7", type = !llvm.func<i64 (i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 255 : i64} : () -> i64
    %1 = "llvm.icmp"(%arg0, %0) {predicate = 1 : i64} : (i64, i64) -> i1
    "llvm.call"(%1) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (i1) -> ()
    "llvm.cond_br"(%1, %arg0)[^bb1, ^bb2] {operand_segment_sizes = dense<[1, 0, 1]> : vector<3xi32>} : (i1, i64) -> ()
  ^bb1:  // pred: ^bb0
    "llvm.br"(%0)[^bb2] : (i64) -> ()
  ^bb2(%2: i64):  // 2 preds: ^bb0, ^bb1
    "llvm.return"(%2) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "limit_i64_ne_255", type = !llvm.func<i64 (i64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "use", type = !llvm.func<void (i1)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 15 : i64} : () -> i64
    %1 = "llvm.icmp"(%arg0, %0) {predicate = 7 : i64} : (i64, i64) -> i1
    "llvm.cond_br"(%1, %arg0)[^bb2, ^bb1] {operand_segment_sizes = dense<[1, 1, 0]> : vector<3xi32>} : (i1, i64) -> ()
  ^bb1:  // pred: ^bb0
    %2 = "llvm.and"(%arg0, %0) : (i64, i64) -> i64
    "llvm.br"(%2)[^bb2] : (i64) -> ()
  ^bb2(%3: i64):  // 2 preds: ^bb0, ^bb1
    %4 = "llvm.and"(%3, %0) : (i64, i64) -> i64
    "llvm.return"(%4) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "limit_i64_ule_15", type = !llvm.func<i64 (i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 7 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 8 : i64} : () -> i64
    %2 = "llvm.icmp"(%arg0, %1) {predicate = 9 : i64} : (i64, i64) -> i1
    "llvm.cond_br"(%2, %arg0)[^bb1, ^bb2] {operand_segment_sizes = dense<[1, 0, 1]> : vector<3xi32>} : (i1, i64) -> ()
  ^bb1:  // pred: ^bb0
    %3 = "llvm.and"(%arg0, %0) : (i64, i64) -> i64
    "llvm.br"(%3)[^bb2] : (i64) -> ()
  ^bb2(%4: i64):  // 2 preds: ^bb0, ^bb1
    %5 = "llvm.and"(%4, %0) : (i64, i64) -> i64
    "llvm.return"(%5) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "limit_i64_uge_8", type = !llvm.func<i64 (i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 7 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 8 : i64} : () -> i64
    %2 = "llvm.icmp"(%arg0, %1) {predicate = 6 : i64} : (i64, i64) -> i1
    "llvm.cond_br"(%2, %arg0)[^bb2, ^bb1] {operand_segment_sizes = dense<[1, 1, 0]> : vector<3xi32>} : (i1, i64) -> ()
  ^bb1:  // pred: ^bb0
    %3 = "llvm.and"(%arg0, %0) : (i64, i64) -> i64
    "llvm.br"(%3)[^bb2] : (i64) -> ()
  ^bb2(%4: i64):  // 2 preds: ^bb0, ^bb1
    %5 = "llvm.and"(%4, %0) : (i64, i64) -> i64
    "llvm.return"(%5) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "limit_i64_ult_8", type = !llvm.func<i64 (i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 7 : i64} : () -> i64
    %1 = "llvm.icmp"(%arg0, %0) {predicate = 8 : i64} : (i64, i64) -> i1
    "llvm.cond_br"(%1, %arg0)[^bb1, ^bb2] {operand_segment_sizes = dense<[1, 0, 1]> : vector<3xi32>} : (i1, i64) -> ()
  ^bb1:  // pred: ^bb0
    %2 = "llvm.and"(%arg0, %0) : (i64, i64) -> i64
    "llvm.br"(%2)[^bb2] : (i64) -> ()
  ^bb2(%3: i64):  // 2 preds: ^bb0, ^bb1
    %4 = "llvm.and"(%3, %0) : (i64, i64) -> i64
    "llvm.return"(%4) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "limit_i64_ugt_7", type = !llvm.func<i64 (i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 3 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 15 : i64} : () -> i64
    %2 = "llvm.icmp"(%arg0, %1) {predicate = 7 : i64} : (i64, i64) -> i1
    "llvm.cond_br"(%2, %arg0)[^bb2, ^bb1] {operand_segment_sizes = dense<[1, 1, 0]> : vector<3xi32>} : (i1, i64) -> ()
  ^bb1:  // pred: ^bb0
    %3 = "llvm.and"(%arg0, %1) : (i64, i64) -> i64
    "llvm.br"(%3)[^bb2] : (i64) -> ()
  ^bb2(%4: i64):  // 2 preds: ^bb0, ^bb1
    %5 = "llvm.and"(%4, %0) : (i64, i64) -> i64
    "llvm.return"(%5) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "limit_i64_ule_15_mask3", type = !llvm.func<i64 (i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 7 : i64} : () -> i64
    %2 = "llvm.mlir.constant"() {value = 8 : i64} : () -> i64
    %3 = "llvm.icmp"(%arg0, %2) {predicate = 6 : i64} : (i64, i64) -> i1
    "llvm.cond_br"(%3, %arg0)[^bb2, ^bb1] {operand_segment_sizes = dense<[1, 1, 0]> : vector<3xi32>} : (i1, i64) -> ()
  ^bb1:  // pred: ^bb0
    %4 = "llvm.and"(%arg0, %1) : (i64, i64) -> i64
    "llvm.br"(%4)[^bb2] : (i64) -> ()
  ^bb2(%5: i64):  // 2 preds: ^bb0, ^bb1
    %6 = "llvm.and"(%5, %0) : (i64, i64) -> i64
    "llvm.return"(%6) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "limit_i64_ult_8_mask1", type = !llvm.func<i64 (i64)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
