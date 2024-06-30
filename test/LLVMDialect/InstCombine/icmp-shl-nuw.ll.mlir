"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 4294967295 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 32 : i64} : () -> i64
    %2 = "llvm.shl"(%arg0, %1) : (i64, i64) -> i64
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i64, i64) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "icmp_ugt_32", type = !llvm.func<i1 (i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i128):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 18446744073709551615 : i128} : () -> i128
    %1 = "llvm.mlir.constant"() {value = 64 : i128} : () -> i128
    %2 = "llvm.shl"(%arg0, %1) : (i128, i128) -> i128
    %3 = "llvm.icmp"(%2, %0) {predicate = 7 : i64} : (i128, i128) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "icmp_ule_64", type = !llvm.func<i1 (i128)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1048575 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 16 : i64} : () -> i64
    %2 = "llvm.shl"(%arg0, %1) : (i64, i64) -> i64
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (i64, i64) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "icmp_ugt_16", type = !llvm.func<i1 (i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi64>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<65535> : vector<2xi64>} : () -> vector<2xi64>
    %1 = "llvm.mlir.constant"() {value = dense<16> : vector<2xi64>} : () -> vector<2xi64>
    %2 = "llvm.shl"(%arg0, %1) : (vector<2xi64>, vector<2xi64>) -> vector<2xi64>
    %3 = "llvm.icmp"(%2, %0) {predicate = 7 : i64} : (vector<2xi64>, vector<2xi64>) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "icmp_ule_16x2", type = !llvm.func<vector<2xi1> (vector<2xi64>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi64>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<196608> : vector<2xi64>} : () -> vector<2xi64>
    %1 = "llvm.mlir.constant"() {value = dense<16> : vector<2xi64>} : () -> vector<2xi64>
    %2 = "llvm.shl"(%arg0, %1) : (vector<2xi64>, vector<2xi64>) -> vector<2xi64>
    %3 = "llvm.icmp"(%2, %0) {predicate = 7 : i64} : (vector<2xi64>, vector<2xi64>) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "icmp_ule_16x2_nonzero", type = !llvm.func<vector<2xi1> (vector<2xi64>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi64>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<12288> : vector<2xi64>} : () -> vector<2xi64>
    %1 = "llvm.mlir.constant"() {value = dense<12> : vector<2xi64>} : () -> vector<2xi64>
    %2 = "llvm.shl"(%arg0, %1) : (vector<2xi64>, vector<2xi64>) -> vector<2xi64>
    %3 = "llvm.icmp"(%2, %0) {predicate = 7 : i64} : (vector<2xi64>, vector<2xi64>) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "icmp_ule_12x2", type = !llvm.func<vector<2xi1> (vector<2xi64>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 4095 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 8 : i64} : () -> i64
    %2 = "llvm.shl"(%arg0, %1) : (i64, i64) -> i64
    %3 = "llvm.icmp"(%2, %0) {predicate = 6 : i64} : (i64, i64) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "icmp_ult_8", type = !llvm.func<i1 (i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi16>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<4095> : vector<2xi16>} : () -> vector<2xi16>
    %1 = "llvm.mlir.constant"() {value = dense<8> : vector<2xi16>} : () -> vector<2xi16>
    %2 = "llvm.shl"(%arg0, %1) : (vector<2xi16>, vector<2xi16>) -> vector<2xi16>
    %3 = "llvm.icmp"(%2, %0) {predicate = 9 : i64} : (vector<2xi16>, vector<2xi16>) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "icmp_uge_8x2", type = !llvm.func<vector<2xi1> (vector<2xi16>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<1048575> : vector<2xi32>} : () -> vector<2xi32>
    %1 = "llvm.mlir.constant"() {value = dense<16> : vector<2xi32>} : () -> vector<2xi32>
    %2 = "llvm.shl"(%arg0, %1) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %3 = "llvm.icmp"(%2, %0) {predicate = 8 : i64} : (vector<2xi32>, vector<2xi32>) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "icmp_ugt_16x2", type = !llvm.func<vector<2xi1> (vector<2xi32>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
