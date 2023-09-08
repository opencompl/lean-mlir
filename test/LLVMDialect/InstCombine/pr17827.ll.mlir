"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 32 : i8} : () -> i8
    %1 = "llvm.mlir.constant"() {value = -64 : i8} : () -> i8
    %2 = "llvm.mlir.constant"() {value = 5 : i8} : () -> i8
    %3 = "llvm.shl"(%arg0, %2) : (i8, i8) -> i8
    %4 = "llvm.and"(%3, %1) : (i8, i8) -> i8
    %5 = "llvm.icmp"(%4, %0) {predicate = 2 : i64} : (i8, i8) -> i1
    "llvm.return"(%5) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "test_shift_and_cmp_not_changed1", type = !llvm.func<i1 (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 32 : i8} : () -> i8
    %1 = "llvm.mlir.constant"() {value = -64 : i8} : () -> i8
    %2 = "llvm.mlir.constant"() {value = 5 : i8} : () -> i8
    %3 = "llvm.ashr"(%arg0, %2) : (i8, i8) -> i8
    %4 = "llvm.and"(%3, %1) : (i8, i8) -> i8
    %5 = "llvm.icmp"(%4, %0) {predicate = 2 : i64} : (i8, i8) -> i1
    "llvm.return"(%5) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "test_shift_and_cmp_not_changed2", type = !llvm.func<i1 (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i8} : () -> i8
    %1 = "llvm.mlir.constant"() {value = 5 : i8} : () -> i8
    %2 = "llvm.mlir.constant"() {value = 8 : i8} : () -> i8
    %3 = "llvm.mlir.constant"() {value = 6 : i8} : () -> i8
    %4 = "llvm.and"(%arg0, %3) : (i8, i8) -> i8
    %5 = "llvm.and"(%arg1, %2) : (i8, i8) -> i8
    %6 = "llvm.or"(%5, %4) : (i8, i8) -> i8
    %7 = "llvm.shl"(%6, %1) : (i8, i8) -> i8
    %8 = "llvm.ashr"(%7, %1) : (i8, i8) -> i8
    %9 = "llvm.icmp"(%8, %0) {predicate = 2 : i64} : (i8, i8) -> i1
    "llvm.return"(%9) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "test_shift_and_cmp_changed1", type = !llvm.func<i1 (i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi8>, %arg1: vector<2xi8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<1> : vector<2xi8>} : () -> vector<2xi8>
    %1 = "llvm.mlir.constant"() {value = dense<5> : vector<2xi8>} : () -> vector<2xi8>
    %2 = "llvm.mlir.constant"() {value = dense<8> : vector<2xi8>} : () -> vector<2xi8>
    %3 = "llvm.mlir.constant"() {value = dense<6> : vector<2xi8>} : () -> vector<2xi8>
    %4 = "llvm.and"(%arg0, %3) : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %5 = "llvm.and"(%arg1, %2) : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %6 = "llvm.or"(%5, %4) : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %7 = "llvm.shl"(%6, %1) : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %8 = "llvm.ashr"(%7, %1) : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %9 = "llvm.icmp"(%8, %0) {predicate = 2 : i64} : (vector<2xi8>, vector<2xi8>) -> i1
    "llvm.return"(%9) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "test_shift_and_cmp_changed1_vec", type = !llvm.func<vector<2xi1> (vector<2xi8>, vector<2xi8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 32 : i8} : () -> i8
    %1 = "llvm.mlir.constant"() {value = -64 : i8} : () -> i8
    %2 = "llvm.mlir.constant"() {value = 5 : i8} : () -> i8
    %3 = "llvm.shl"(%arg0, %2) : (i8, i8) -> i8
    %4 = "llvm.and"(%3, %1) : (i8, i8) -> i8
    %5 = "llvm.icmp"(%4, %0) {predicate = 6 : i64} : (i8, i8) -> i1
    "llvm.return"(%5) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "test_shift_and_cmp_changed2", type = !llvm.func<i1 (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<32> : vector<2xi8>} : () -> vector<2xi8>
    %1 = "llvm.mlir.constant"() {value = dense<-64> : vector<2xi8>} : () -> vector<2xi8>
    %2 = "llvm.mlir.constant"() {value = dense<5> : vector<2xi8>} : () -> vector<2xi8>
    %3 = "llvm.shl"(%arg0, %2) : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %4 = "llvm.and"(%3, %1) : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %5 = "llvm.icmp"(%4, %0) {predicate = 6 : i64} : (vector<2xi8>, vector<2xi8>) -> i1
    "llvm.return"(%5) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "test_shift_and_cmp_changed2_vec", type = !llvm.func<vector<2xi1> (vector<2xi8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 32 : i8} : () -> i8
    %1 = "llvm.mlir.constant"() {value = -64 : i8} : () -> i8
    %2 = "llvm.mlir.constant"() {value = 5 : i8} : () -> i8
    %3 = "llvm.shl"(%arg0, %2) : (i8, i8) -> i8
    %4 = "llvm.and"(%3, %1) : (i8, i8) -> i8
    %5 = "llvm.icmp"(%4, %0) {predicate = 2 : i64} : (i8, i8) -> i1
    "llvm.return"(%5) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "test_shift_and_cmp_changed3", type = !llvm.func<i1 (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 32 : i8} : () -> i8
    %1 = "llvm.mlir.constant"() {value = -64 : i8} : () -> i8
    %2 = "llvm.mlir.constant"() {value = 5 : i8} : () -> i8
    %3 = "llvm.lshr"(%arg0, %2) : (i8, i8) -> i8
    %4 = "llvm.and"(%3, %1) : (i8, i8) -> i8
    %5 = "llvm.icmp"(%4, %0) {predicate = 2 : i64} : (i8, i8) -> i1
    "llvm.return"(%5) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "test_shift_and_cmp_changed4", type = !llvm.func<i1 (i8)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
