"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8):  // no predecessors
    %0 = "llvm.zext"(%arg0) : (i8) -> i32
    %1 = "llvm.zext"(%arg1) : (i8) -> i32
    %2 = "llvm.icmp"(%0, %1) {predicate = 4 : i64} : (i32, i32) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "zext_zext_sgt", type = !llvm.func<i1 (i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi8>, %arg1: vector<2xi8>):  // no predecessors
    %0 = "llvm.zext"(%arg0) : (vector<2xi8>) -> vector<2xi32>
    %1 = "llvm.zext"(%arg1) : (vector<2xi8>) -> vector<2xi32>
    %2 = "llvm.icmp"(%0, %1) {predicate = 8 : i64} : (vector<2xi32>, vector<2xi32>) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "zext_zext_ugt", type = !llvm.func<vector<2xi1> (vector<2xi8>, vector<2xi8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8):  // no predecessors
    %0 = "llvm.zext"(%arg0) : (i8) -> i32
    %1 = "llvm.zext"(%arg1) : (i8) -> i32
    %2 = "llvm.icmp"(%0, %1) {predicate = 0 : i64} : (i32, i32) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "zext_zext_eq", type = !llvm.func<i1 (i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i16):  // no predecessors
    %0 = "llvm.zext"(%arg0) : (i8) -> i32
    %1 = "llvm.zext"(%arg1) : (i16) -> i32
    %2 = "llvm.icmp"(%0, %1) {predicate = 3 : i64} : (i32, i32) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "zext_zext_sle_op0_narrow", type = !llvm.func<i1 (i8, i16)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i9, %arg1: i8):  // no predecessors
    %0 = "llvm.zext"(%arg0) : (i9) -> i32
    %1 = "llvm.zext"(%arg1) : (i8) -> i32
    %2 = "llvm.icmp"(%0, %1) {predicate = 7 : i64} : (i32, i32) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "zext_zext_ule_op0_wide", type = !llvm.func<i1 (i9, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8):  // no predecessors
    %0 = "llvm.sext"(%arg0) : (i8) -> i32
    %1 = "llvm.sext"(%arg1) : (i8) -> i32
    %2 = "llvm.icmp"(%0, %1) {predicate = 2 : i64} : (i32, i32) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "sext_sext_slt", type = !llvm.func<i1 (i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8):  // no predecessors
    %0 = "llvm.sext"(%arg0) : (i8) -> i32
    %1 = "llvm.sext"(%arg1) : (i8) -> i32
    %2 = "llvm.icmp"(%0, %1) {predicate = 6 : i64} : (i32, i32) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "sext_sext_ult", type = !llvm.func<i1 (i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8):  // no predecessors
    %0 = "llvm.sext"(%arg0) : (i8) -> i32
    %1 = "llvm.sext"(%arg1) : (i8) -> i32
    %2 = "llvm.icmp"(%0, %1) {predicate = 1 : i64} : (i32, i32) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "sext_sext_ne", type = !llvm.func<i1 (i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i5, %arg1: i8):  // no predecessors
    %0 = "llvm.sext"(%arg0) : (i5) -> i32
    %1 = "llvm.sext"(%arg1) : (i8) -> i32
    %2 = "llvm.icmp"(%0, %1) {predicate = 5 : i64} : (i32, i32) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "sext_sext_sge_op0_narrow", type = !llvm.func<i1 (i5, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi16>, %arg1: vector<2xi8>):  // no predecessors
    %0 = "llvm.sext"(%arg0) : (vector<2xi16>) -> vector<2xi32>
    %1 = "llvm.sext"(%arg1) : (vector<2xi8>) -> vector<2xi32>
    %2 = "llvm.icmp"(%0, %1) {predicate = 9 : i64} : (vector<2xi32>, vector<2xi32>) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "sext_sext_uge_op0_wide", type = !llvm.func<vector<2xi1> (vector<2xi16>, vector<2xi8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8):  // no predecessors
    %0 = "llvm.zext"(%arg0) : (i8) -> i32
    %1 = "llvm.sext"(%arg1) : (i8) -> i32
    %2 = "llvm.icmp"(%0, %1) {predicate = 4 : i64} : (i32, i32) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "zext_sext_sgt", type = !llvm.func<i1 (i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8):  // no predecessors
    %0 = "llvm.zext"(%arg0) : (i8) -> i32
    %1 = "llvm.sext"(%arg1) : (i8) -> i32
    %2 = "llvm.icmp"(%0, %1) {predicate = 8 : i64} : (i32, i32) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "zext_sext_ugt", type = !llvm.func<i1 (i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8):  // no predecessors
    %0 = "llvm.zext"(%arg0) : (i8) -> i32
    %1 = "llvm.sext"(%arg1) : (i8) -> i32
    %2 = "llvm.icmp"(%0, %1) {predicate = 0 : i64} : (i32, i32) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "zext_sext_eq", type = !llvm.func<i1 (i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i16):  // no predecessors
    %0 = "llvm.zext"(%arg0) : (i8) -> i32
    %1 = "llvm.sext"(%arg1) : (i16) -> i32
    %2 = "llvm.icmp"(%0, %1) {predicate = 3 : i64} : (i32, i32) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "zext_sext_sle_op0_narrow", type = !llvm.func<i1 (i8, i16)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i9, %arg1: i8):  // no predecessors
    %0 = "llvm.zext"(%arg0) : (i9) -> i32
    %1 = "llvm.sext"(%arg1) : (i8) -> i32
    %2 = "llvm.icmp"(%0, %1) {predicate = 7 : i64} : (i32, i32) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "zext_sext_ule_op0_wide", type = !llvm.func<i1 (i9, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8):  // no predecessors
    %0 = "llvm.sext"(%arg0) : (i8) -> i32
    %1 = "llvm.zext"(%arg1) : (i8) -> i32
    %2 = "llvm.icmp"(%0, %1) {predicate = 2 : i64} : (i32, i32) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "sext_zext_slt", type = !llvm.func<i1 (i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8):  // no predecessors
    %0 = "llvm.sext"(%arg0) : (i8) -> i32
    %1 = "llvm.zext"(%arg1) : (i8) -> i32
    %2 = "llvm.icmp"(%0, %1) {predicate = 6 : i64} : (i32, i32) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "sext_zext_ult", type = !llvm.func<i1 (i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi8>, %arg1: vector<2xi8>):  // no predecessors
    %0 = "llvm.sext"(%arg0) : (vector<2xi8>) -> vector<2xi32>
    %1 = "llvm.zext"(%arg1) : (vector<2xi8>) -> vector<2xi32>
    %2 = "llvm.icmp"(%0, %1) {predicate = 1 : i64} : (vector<2xi32>, vector<2xi32>) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "sext_zext_ne", type = !llvm.func<vector<2xi1> (vector<2xi8>, vector<2xi8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i5, %arg1: i8):  // no predecessors
    %0 = "llvm.sext"(%arg0) : (i5) -> i32
    %1 = "llvm.zext"(%arg1) : (i8) -> i32
    %2 = "llvm.icmp"(%0, %1) {predicate = 5 : i64} : (i32, i32) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "sext_zext_sge_op0_narrow", type = !llvm.func<i1 (i5, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i16, %arg1: i8):  // no predecessors
    %0 = "llvm.sext"(%arg0) : (i16) -> i32
    %1 = "llvm.zext"(%arg1) : (i8) -> i32
    %2 = "llvm.icmp"(%0, %1) {predicate = 9 : i64} : (i32, i32) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "sext_zext_uge_op0_wide", type = !llvm.func<i1 (i16, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 127 : i8} : () -> i8
    %1 = "llvm.udiv"(%0, %arg0) : (i8, i8) -> i8
    %2 = "llvm.zext"(%1) : (i8) -> i32
    %3 = "llvm.sext"(%arg1) : (i8) -> i32
    %4 = "llvm.icmp"(%2, %3) {predicate = 4 : i64} : (i32, i32) -> i1
    "llvm.return"(%4) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "zext_sext_sgt_known_nonneg", type = !llvm.func<i1 (i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 127 : i8} : () -> i8
    %1 = "llvm.and"(%arg0, %0) : (i8, i8) -> i8
    %2 = "llvm.zext"(%1) : (i8) -> i32
    %3 = "llvm.sext"(%arg1) : (i8) -> i32
    %4 = "llvm.icmp"(%2, %3) {predicate = 8 : i64} : (i32, i32) -> i1
    "llvm.return"(%4) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "zext_sext_ugt_known_nonneg", type = !llvm.func<i1 (i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i8} : () -> i8
    %1 = "llvm.lshr"(%arg0, %0) : (i8, i8) -> i8
    %2 = "llvm.zext"(%1) : (i8) -> i32
    %3 = "llvm.sext"(%arg1) : (i8) -> i32
    %4 = "llvm.icmp"(%2, %3) {predicate = 0 : i64} : (i32, i32) -> i1
    "llvm.return"(%4) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "zext_sext_eq_known_nonneg", type = !llvm.func<i1 (i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i16):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 12 : i8} : () -> i8
    %1 = "llvm.and"(%arg0, %0) : (i8, i8) -> i8
    %2 = "llvm.zext"(%1) : (i8) -> i32
    %3 = "llvm.sext"(%arg1) : (i16) -> i32
    %4 = "llvm.icmp"(%2, %3) {predicate = 3 : i64} : (i32, i32) -> i1
    "llvm.return"(%4) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "zext_sext_sle_known_nonneg_op0_narrow", type = !llvm.func<i1 (i8, i16)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i9, %arg1: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 254 : i9} : () -> i9
    %1 = "llvm.urem"(%arg0, %0) : (i9, i9) -> i9
    %2 = "llvm.zext"(%1) : (i9) -> i32
    %3 = "llvm.sext"(%arg1) : (i8) -> i32
    %4 = "llvm.icmp"(%2, %3) {predicate = 7 : i64} : (i32, i32) -> i1
    "llvm.return"(%4) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "zext_sext_ule_known_nonneg_op0_wide", type = !llvm.func<i1 (i9, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 126 : i8} : () -> i8
    %1 = "llvm.sext"(%arg0) : (i8) -> i32
    %2 = "llvm.and"(%arg1, %0) : (i8, i8) -> i8
    %3 = "llvm.zext"(%2) : (i8) -> i32
    %4 = "llvm.icmp"(%1, %3) {predicate = 2 : i64} : (i32, i32) -> i1
    "llvm.return"(%4) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "sext_zext_slt_known_nonneg", type = !llvm.func<i1 (i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 6 : i8} : () -> i8
    %1 = "llvm.sext"(%arg0) : (i8) -> i32
    %2 = "llvm.lshr"(%arg1, %0) : (i8, i8) -> i8
    %3 = "llvm.zext"(%2) : (i8) -> i32
    %4 = "llvm.icmp"(%1, %3) {predicate = 6 : i64} : (i32, i32) -> i1
    "llvm.return"(%4) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "sext_zext_ult_known_nonneg", type = !llvm.func<i1 (i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 6 : i8} : () -> i8
    %1 = "llvm.sext"(%arg0) : (i8) -> i32
    %2 = "llvm.udiv"(%arg1, %0) : (i8, i8) -> i8
    %3 = "llvm.zext"(%2) : (i8) -> i32
    %4 = "llvm.icmp"(%1, %3) {predicate = 1 : i64} : (i32, i32) -> i1
    "llvm.return"(%4) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "sext_zext_ne_known_nonneg", type = !llvm.func<i1 (i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi5>, %arg1: vector<2xi8>):  // no predecessors
    %0 = "llvm.sext"(%arg0) : (vector<2xi5>) -> vector<2xi32>
    %1 = "llvm.mul"(%arg1, %arg1) : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %2 = "llvm.zext"(%1) : (vector<2xi8>) -> vector<2xi32>
    %3 = "llvm.icmp"(%0, %2) {predicate = 5 : i64} : (vector<2xi32>, vector<2xi32>) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "sext_zext_sge_known_nonneg_op0_narrow", type = !llvm.func<vector<2xi1> (vector<2xi5>, vector<2xi8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i16, %arg1: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 12 : i8} : () -> i8
    %1 = "llvm.sext"(%arg0) : (i16) -> i32
    %2 = "llvm.and"(%arg1, %0) : (i8, i8) -> i8
    %3 = "llvm.zext"(%2) : (i8) -> i32
    %4 = "llvm.icmp"(%1, %3) {predicate = 9 : i64} : (i32, i32) -> i1
    "llvm.return"(%4) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "sext_zext_uge_known_nonneg_op0_wide", type = !llvm.func<i1 (i16, i8)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
