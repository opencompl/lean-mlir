"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_01_00", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %1 = "llvm.lshr"(%arg0, %0) : (i4, i4) -> i4
    %2 = "llvm.icmp"(%1, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_01_01", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_01_02", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_01_03", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 4 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_01_04", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 5 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_01_05", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 6 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_01_06", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 7 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_01_07", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -8 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_01_08", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -7 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_01_09", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -6 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_01_10", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -5 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_01_11", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -4 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_01_12", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -3 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_01_13", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -2 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_01_14", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_01_15", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_02_00", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_02_01", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %1 = "llvm.lshr"(%arg0, %0) : (i4, i4) -> i4
    %2 = "llvm.icmp"(%1, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_02_02", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_02_03", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 4 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_02_04", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 5 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_02_05", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 6 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_02_06", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 7 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_02_07", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -8 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_02_08", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -7 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_02_09", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -6 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_02_10", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -5 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_02_11", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -4 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_02_12", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -3 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_02_13", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -2 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_02_14", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_02_15", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_03_00", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_03_01", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_03_02", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %1 = "llvm.lshr"(%arg0, %0) : (i4, i4) -> i4
    %2 = "llvm.icmp"(%1, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_03_03", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 4 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_03_04", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 5 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_03_05", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 6 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_03_06", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 7 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_03_07", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -8 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_03_08", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -7 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_03_09", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -6 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_03_10", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -5 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_03_11", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -4 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_03_12", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -3 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_03_13", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -2 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_03_14", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_03_15", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_01_00", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %1 = "llvm.lshr"(%arg0, %0) : (i4, i4) -> i4
    %2 = "llvm.icmp"(%1, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_01_01", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_01_02", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_01_03", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 4 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_01_04", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 5 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_01_05", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 6 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_01_06", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 7 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_01_07", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -8 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_01_08", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -7 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_01_09", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -6 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_01_10", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -5 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_01_11", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -4 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_01_12", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -3 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_01_13", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -2 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_01_14", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_01_15", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_02_00", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_02_01", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %1 = "llvm.lshr"(%arg0, %0) : (i4, i4) -> i4
    %2 = "llvm.icmp"(%1, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_02_02", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_02_03", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 4 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_02_04", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 5 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_02_05", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 6 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_02_06", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 7 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_02_07", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -8 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_02_08", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -7 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_02_09", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -6 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_02_10", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -5 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_02_11", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -4 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_02_12", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -3 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_02_13", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -2 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_02_14", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_02_15", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_03_00", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_03_01", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_03_02", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %1 = "llvm.lshr"(%arg0, %0) : (i4, i4) -> i4
    %2 = "llvm.icmp"(%1, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_03_03", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 4 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_03_04", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 5 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_03_05", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 6 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_03_06", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 7 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_03_07", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -8 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_03_08", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -7 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_03_09", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -6 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_03_10", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -5 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_03_11", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -4 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_03_12", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -3 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_03_13", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -2 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_03_14", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_03_15", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_01_00", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %1 = "llvm.ashr"(%arg0, %0) : (i4, i4) -> i4
    %2 = "llvm.icmp"(%1, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_01_01", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_01_02", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_01_03", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 4 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_01_04", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 5 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_01_05", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 6 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_01_06", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 7 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_01_07", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -8 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_01_08", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -7 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_01_09", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -6 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_01_10", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -5 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_01_11", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -4 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_01_12", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -3 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_01_13", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -2 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_01_14", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_01_15", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_02_00", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_02_01", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %1 = "llvm.ashr"(%arg0, %0) : (i4, i4) -> i4
    %2 = "llvm.icmp"(%1, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_02_02", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_02_03", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 4 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_02_04", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 5 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_02_05", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 6 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_02_06", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 7 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_02_07", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -8 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_02_08", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -7 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_02_09", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -6 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_02_10", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -5 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_02_11", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -4 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_02_12", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -3 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_02_13", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -2 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_02_14", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_02_15", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_03_00", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_03_01", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_03_02", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %1 = "llvm.ashr"(%arg0, %0) : (i4, i4) -> i4
    %2 = "llvm.icmp"(%1, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_03_03", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 4 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_03_04", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 5 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_03_05", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 6 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_03_06", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 7 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_03_07", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -8 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_03_08", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -7 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_03_09", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -6 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_03_10", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -5 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_03_11", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -4 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_03_12", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -3 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_03_13", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -2 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_03_14", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_03_15", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_01_00", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %1 = "llvm.ashr"(%arg0, %0) : (i4, i4) -> i4
    %2 = "llvm.icmp"(%1, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_01_01", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_01_02", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_01_03", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 4 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_01_04", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 5 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_01_05", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 6 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_01_06", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 7 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_01_07", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -8 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_01_08", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -7 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_01_09", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -6 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_01_10", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -5 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_01_11", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -4 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_01_12", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -3 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_01_13", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -2 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_01_14", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_01_15", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_02_00", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_02_01", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %1 = "llvm.ashr"(%arg0, %0) : (i4, i4) -> i4
    %2 = "llvm.icmp"(%1, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_02_02", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_02_03", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 4 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_02_04", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 5 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_02_05", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 6 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_02_06", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 7 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_02_07", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -8 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_02_08", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -7 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_02_09", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -6 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_02_10", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -5 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_02_11", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -4 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_02_12", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -3 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_02_13", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -2 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_02_14", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_02_15", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_03_00", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_03_01", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_03_02", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %1 = "llvm.ashr"(%arg0, %0) : (i4, i4) -> i4
    %2 = "llvm.icmp"(%1, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_03_03", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 4 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_03_04", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 5 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_03_05", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 6 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_03_06", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 7 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_03_07", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -8 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_03_08", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -7 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_03_09", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -6 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_03_10", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -5 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_03_11", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -4 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_03_12", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -3 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_03_13", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -2 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_03_14", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_03_15", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_01_00_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %1 = "llvm.lshr"(%arg0, %0) : (i4, i4) -> i4
    %2 = "llvm.icmp"(%1, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_01_01_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_01_02_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_01_03_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 4 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_01_04_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 5 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_01_05_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 6 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_01_06_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 7 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_01_07_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -8 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_01_08_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -7 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_01_09_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -6 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_01_10_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -5 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_01_11_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -4 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_01_12_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -3 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_01_13_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -2 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_01_14_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_01_15_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_02_00_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_02_01_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %1 = "llvm.lshr"(%arg0, %0) : (i4, i4) -> i4
    %2 = "llvm.icmp"(%1, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_02_02_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_02_03_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 4 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_02_04_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 5 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_02_05_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 6 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_02_06_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 7 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_02_07_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -8 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_02_08_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -7 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_02_09_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -6 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_02_10_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -5 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_02_11_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -4 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_02_12_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -3 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_02_13_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -2 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_02_14_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_02_15_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_03_00_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_03_01_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_03_02_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %1 = "llvm.lshr"(%arg0, %0) : (i4, i4) -> i4
    %2 = "llvm.icmp"(%1, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_03_03_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 4 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_03_04_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 5 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_03_05_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 6 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_03_06_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 7 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_03_07_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -8 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_03_08_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -7 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_03_09_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -6 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_03_10_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -5 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_03_11_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -4 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_03_12_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -3 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_03_13_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -2 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_03_14_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrugt_03_15_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 10 : i8} : () -> i8
    %1 = "llvm.mlir.constant"() {value = 3 : i8} : () -> i8
    %2 = "llvm.ashr"(%arg0, %1) : (i8, i8) -> i8
    %3 = "llvm.icmp"(%2, %0) {predicate = 0 : i64} : (i8, i8) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashr_eq_exact", type = !llvm.func<i1 (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 10 : i8} : () -> i8
    %1 = "llvm.mlir.constant"() {value = 3 : i8} : () -> i8
    %2 = "llvm.ashr"(%arg0, %1) : (i8, i8) -> i8
    %3 = "llvm.icmp"(%2, %0) {predicate = 1 : i64} : (i8, i8) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashr_ne_exact", type = !llvm.func<i1 (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 10 : i8} : () -> i8
    %1 = "llvm.mlir.constant"() {value = 3 : i8} : () -> i8
    %2 = "llvm.ashr"(%arg0, %1) : (i8, i8) -> i8
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i8, i8) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashr_ugt_exact", type = !llvm.func<i1 (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 10 : i8} : () -> i8
    %1 = "llvm.mlir.constant"() {value = 3 : i8} : () -> i8
    %2 = "llvm.ashr"(%arg0, %1) : (i8, i8) -> i8
    %3 = "llvm.icmp"(%2, %0) {predicate = 9 : i64} : (i8, i8) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashr_uge_exact", type = !llvm.func<i1 (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 10 : i8} : () -> i8
    %1 = "llvm.mlir.constant"() {value = 3 : i8} : () -> i8
    %2 = "llvm.ashr"(%arg0, %1) : (i8, i8) -> i8
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i8, i8) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashr_ult_exact", type = !llvm.func<i1 (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 10 : i8} : () -> i8
    %1 = "llvm.mlir.constant"() {value = 3 : i8} : () -> i8
    %2 = "llvm.ashr"(%arg0, %1) : (i8, i8) -> i8
    %3 = "llvm.icmp"(%2, %0) {predicate = 7 : i64} : (i8, i8) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashr_ule_exact", type = !llvm.func<i1 (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 10 : i8} : () -> i8
    %1 = "llvm.mlir.constant"() {value = 3 : i8} : () -> i8
    %2 = "llvm.ashr"(%arg0, %1) : (i8, i8) -> i8
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i8, i8) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashr_sgt_exact", type = !llvm.func<i1 (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 10 : i8} : () -> i8
    %1 = "llvm.mlir.constant"() {value = 3 : i8} : () -> i8
    %2 = "llvm.ashr"(%arg0, %1) : (i8, i8) -> i8
    %3 = "llvm.icmp"(%2, %0) {predicate = 5 : i64} : (i8, i8) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashr_sge_exact", type = !llvm.func<i1 (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 10 : i8} : () -> i8
    %1 = "llvm.mlir.constant"() {value = 3 : i8} : () -> i8
    %2 = "llvm.ashr"(%arg0, %1) : (i8, i8) -> i8
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i8, i8) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashr_slt_exact", type = !llvm.func<i1 (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 10 : i8} : () -> i8
    %1 = "llvm.mlir.constant"() {value = 3 : i8} : () -> i8
    %2 = "llvm.ashr"(%arg0, %1) : (i8, i8) -> i8
    %3 = "llvm.icmp"(%2, %0) {predicate = 3 : i64} : (i8, i8) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashr_sle_exact", type = !llvm.func<i1 (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 10 : i8} : () -> i8
    %1 = "llvm.mlir.constant"() {value = 3 : i8} : () -> i8
    %2 = "llvm.ashr"(%arg0, %1) : (i8, i8) -> i8
    %3 = "llvm.icmp"(%2, %0) {predicate = 0 : i64} : (i8, i8) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashr_eq_noexact", type = !llvm.func<i1 (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 10 : i8} : () -> i8
    %1 = "llvm.mlir.constant"() {value = 3 : i8} : () -> i8
    %2 = "llvm.ashr"(%arg0, %1) : (i8, i8) -> i8
    %3 = "llvm.icmp"(%2, %0) {predicate = 1 : i64} : (i8, i8) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashr_ne_noexact", type = !llvm.func<i1 (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 10 : i8} : () -> i8
    %1 = "llvm.mlir.constant"() {value = 3 : i8} : () -> i8
    %2 = "llvm.ashr"(%arg0, %1) : (i8, i8) -> i8
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i8, i8) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashr_ugt_noexact", type = !llvm.func<i1 (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 10 : i8} : () -> i8
    %1 = "llvm.mlir.constant"() {value = 3 : i8} : () -> i8
    %2 = "llvm.ashr"(%arg0, %1) : (i8, i8) -> i8
    %3 = "llvm.icmp"(%2, %0) {predicate = 9 : i64} : (i8, i8) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashr_uge_noexact", type = !llvm.func<i1 (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 10 : i8} : () -> i8
    %1 = "llvm.mlir.constant"() {value = 3 : i8} : () -> i8
    %2 = "llvm.ashr"(%arg0, %1) : (i8, i8) -> i8
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i8, i8) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashr_ult_noexact", type = !llvm.func<i1 (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 10 : i8} : () -> i8
    %1 = "llvm.mlir.constant"() {value = 3 : i8} : () -> i8
    %2 = "llvm.ashr"(%arg0, %1) : (i8, i8) -> i8
    %3 = "llvm.icmp"(%2, %0) {predicate = 7 : i64} : (i8, i8) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashr_ule_noexact", type = !llvm.func<i1 (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 10 : i8} : () -> i8
    %1 = "llvm.mlir.constant"() {value = 3 : i8} : () -> i8
    %2 = "llvm.ashr"(%arg0, %1) : (i8, i8) -> i8
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i8, i8) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashr_sgt_noexact", type = !llvm.func<i1 (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 10 : i8} : () -> i8
    %1 = "llvm.mlir.constant"() {value = 3 : i8} : () -> i8
    %2 = "llvm.ashr"(%arg0, %1) : (i8, i8) -> i8
    %3 = "llvm.icmp"(%2, %0) {predicate = 5 : i64} : (i8, i8) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashr_sge_noexact", type = !llvm.func<i1 (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 10 : i8} : () -> i8
    %1 = "llvm.mlir.constant"() {value = 3 : i8} : () -> i8
    %2 = "llvm.ashr"(%arg0, %1) : (i8, i8) -> i8
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i8, i8) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashr_slt_noexact", type = !llvm.func<i1 (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 10 : i8} : () -> i8
    %1 = "llvm.mlir.constant"() {value = 3 : i8} : () -> i8
    %2 = "llvm.ashr"(%arg0, %1) : (i8, i8) -> i8
    %3 = "llvm.icmp"(%2, %0) {predicate = 3 : i64} : (i8, i8) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashr_sle_noexact", type = !llvm.func<i1 (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 10 : i8} : () -> i8
    %1 = "llvm.mlir.constant"() {value = 3 : i8} : () -> i8
    %2 = "llvm.ashr"(%arg0, %1) : (i8, i8) -> i8
    %3 = "llvm.icmp"(%2, %0) {predicate = 7 : i64} : (i8, i8) -> i1
    "llvm.store"(%2, %arg1) : (i8, !llvm.ptr<i8>) -> ()
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashr_00_00_ashr_extra_use", type = !llvm.func<i1 (i8, ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<4xi8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<10> : vector<4xi8>} : () -> vector<4xi8>
    %1 = "llvm.mlir.constant"() {value = dense<3> : vector<4xi8>} : () -> vector<4xi8>
    %2 = "llvm.ashr"(%arg0, %1) : (vector<4xi8>, vector<4xi8>) -> vector<4xi8>
    %3 = "llvm.icmp"(%2, %0) {predicate = 7 : i64} : (vector<4xi8>, vector<4xi8>) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashr_00_00_vec", type = !llvm.func<vector<4xi1> (vector<4xi8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 63 : i8} : () -> i8
    %1 = "llvm.mlir.constant"() {value = 1 : i8} : () -> i8
    %2 = "llvm.ashr"(%arg0, %1) : (i8, i8) -> i8
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i8, i8) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashr_sgt_overflow", type = !llvm.func<i1 (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_01_00_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %1 = "llvm.lshr"(%arg0, %0) : (i4, i4) -> i4
    %2 = "llvm.icmp"(%1, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_01_01_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_01_02_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_01_03_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 4 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_01_04_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 5 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_01_05_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 6 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_01_06_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 7 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_01_07_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -8 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_01_08_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -7 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_01_09_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -6 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_01_10_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -5 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_01_11_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -4 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_01_12_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -3 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_01_13_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -2 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_01_14_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_01_15_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_02_00_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_02_01_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %1 = "llvm.lshr"(%arg0, %0) : (i4, i4) -> i4
    %2 = "llvm.icmp"(%1, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_02_02_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_02_03_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 4 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_02_04_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 5 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_02_05_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 6 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_02_06_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 7 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_02_07_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -8 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_02_08_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -7 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_02_09_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -6 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_02_10_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -5 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_02_11_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -4 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_02_12_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -3 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_02_13_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -2 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_02_14_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_02_15_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_03_00_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_03_01_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_03_02_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %1 = "llvm.lshr"(%arg0, %0) : (i4, i4) -> i4
    %2 = "llvm.icmp"(%1, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_03_03_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 4 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_03_04_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 5 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_03_05_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 6 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_03_06_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 7 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_03_07_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -8 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_03_08_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -7 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_03_09_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -6 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_03_10_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -5 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_03_11_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -4 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_03_12_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -3 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_03_13_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -2 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_03_14_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.lshr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "lshrult_03_15_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_01_00_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %1 = "llvm.ashr"(%arg0, %0) : (i4, i4) -> i4
    %2 = "llvm.icmp"(%1, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_01_01_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_01_02_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_01_03_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 4 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_01_04_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 5 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_01_05_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 6 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_01_06_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 7 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_01_07_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -8 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_01_08_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -7 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_01_09_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -6 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_01_10_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -5 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_01_11_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -4 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_01_12_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -3 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_01_13_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -2 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_01_14_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_01_15_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_02_00_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_02_01_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %1 = "llvm.ashr"(%arg0, %0) : (i4, i4) -> i4
    %2 = "llvm.icmp"(%1, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_02_02_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_02_03_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 4 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_02_04_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 5 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_02_05_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 6 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_02_06_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 7 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_02_07_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -8 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_02_08_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -7 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_02_09_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -6 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_02_10_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -5 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_02_11_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -4 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_02_12_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -3 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_02_13_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -2 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_02_14_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_02_15_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_03_00_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_03_01_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_03_02_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %1 = "llvm.ashr"(%arg0, %0) : (i4, i4) -> i4
    %2 = "llvm.icmp"(%1, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_03_03_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 4 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_03_04_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 5 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_03_05_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 6 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_03_06_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 7 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_03_07_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -8 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_03_08_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -7 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_03_09_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -6 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_03_10_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -5 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_03_11_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -4 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_03_12_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -3 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_03_13_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -2 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_03_14_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 4 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrsgt_03_15_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_01_00_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %1 = "llvm.ashr"(%arg0, %0) : (i4, i4) -> i4
    %2 = "llvm.icmp"(%1, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_01_01_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_01_02_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_01_03_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 4 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_01_04_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 5 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_01_05_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 6 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_01_06_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 7 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_01_07_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -8 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_01_08_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -7 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_01_09_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -6 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_01_10_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -5 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_01_11_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -4 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_01_12_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -3 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_01_13_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -2 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_01_14_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_01_15_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_02_00_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_02_01_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %1 = "llvm.ashr"(%arg0, %0) : (i4, i4) -> i4
    %2 = "llvm.icmp"(%1, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_02_02_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_02_03_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 4 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_02_04_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 5 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_02_05_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 6 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_02_06_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 7 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_02_07_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -8 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_02_08_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -7 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_02_09_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -6 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_02_10_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -5 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_02_11_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -4 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_02_12_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -3 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_02_13_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -2 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_02_14_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_02_15_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_03_00_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_03_01_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 2 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_03_02_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %1 = "llvm.ashr"(%arg0, %0) : (i4, i4) -> i4
    %2 = "llvm.icmp"(%1, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_03_03_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 4 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_03_04_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 5 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_03_05_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 6 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_03_06_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 7 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_03_07_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -8 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_03_08_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -7 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_03_09_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -6 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_03_10_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -5 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_03_11_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -4 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_03_12_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -3 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_03_13_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -2 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_03_14_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i4):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i4} : () -> i4
    %1 = "llvm.mlir.constant"() {value = 3 : i4} : () -> i4
    %2 = "llvm.ashr"(%arg0, %1) : (i4, i4) -> i4
    %3 = "llvm.icmp"(%2, %0) {predicate = 2 : i64} : (i4, i4) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "ashrslt_03_15_exact", type = !llvm.func<i1 (i4)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
