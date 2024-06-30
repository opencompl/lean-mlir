"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 64 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 299 : i64} : () -> i64
    %2 = "llvm.urem"(%arg0, %1) : (i64, i64) -> i64
    %3 = "llvm.udiv"(%arg0, %1) : (i64, i64) -> i64
    %4 = "llvm.urem"(%3, %0) : (i64, i64) -> i64
    %5 = "llvm.mul"(%4, %1) : (i64, i64) -> i64
    %6 = "llvm.add"(%2, %5) : (i64, i64) -> i64
    "llvm.return"(%6) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "match_unsigned", type = !llvm.func<i64 (i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi64>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<64> : vector<2xi64>} : () -> vector<2xi64>
    %1 = "llvm.mlir.constant"() {value = dense<299> : vector<2xi64>} : () -> vector<2xi64>
    %2 = "llvm.urem"(%arg0, %1) : (vector<2xi64>, vector<2xi64>) -> vector<2xi64>
    %3 = "llvm.udiv"(%arg0, %1) : (vector<2xi64>, vector<2xi64>) -> vector<2xi64>
    %4 = "llvm.urem"(%3, %0) : (vector<2xi64>, vector<2xi64>) -> vector<2xi64>
    %5 = "llvm.mul"(%4, %1) : (vector<2xi64>, vector<2xi64>) -> vector<2xi64>
    %6 = "llvm.add"(%2, %5) : (vector<2xi64>, vector<2xi64>) -> vector<2xi64>
    "llvm.return"(%6) : (vector<2xi64>) -> ()
  }) {linkage = 10 : i64, sym_name = "match_unsigned_vector", type = !llvm.func<vector<2xi64> (vector<2xi64>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 9 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 6 : i64} : () -> i64
    %2 = "llvm.mlir.constant"() {value = 63 : i64} : () -> i64
    %3 = "llvm.and"(%arg0, %2) : (i64, i64) -> i64
    %4 = "llvm.lshr"(%arg0, %1) : (i64, i64) -> i64
    %5 = "llvm.urem"(%4, %0) : (i64, i64) -> i64
    %6 = "llvm.shl"(%5, %1) : (i64, i64) -> i64
    %7 = "llvm.add"(%3, %6) : (i64, i64) -> i64
    "llvm.return"(%7) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "match_andAsRem_lshrAsDiv_shlAsMul", type = !llvm.func<i64 (i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 9 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 19136 : i64} : () -> i64
    %2 = "llvm.mlir.constant"() {value = 64 : i64} : () -> i64
    %3 = "llvm.mlir.constant"() {value = 299 : i64} : () -> i64
    %4 = "llvm.srem"(%arg0, %3) : (i64, i64) -> i64
    %5 = "llvm.sdiv"(%arg0, %3) : (i64, i64) -> i64
    %6 = "llvm.srem"(%5, %2) : (i64, i64) -> i64
    %7 = "llvm.sdiv"(%arg0, %1) : (i64, i64) -> i64
    %8 = "llvm.srem"(%7, %0) : (i64, i64) -> i64
    %9 = "llvm.mul"(%6, %3) : (i64, i64) -> i64
    %10 = "llvm.add"(%4, %9) : (i64, i64) -> i64
    %11 = "llvm.mul"(%8, %1) : (i64, i64) -> i64
    %12 = "llvm.add"(%10, %11) : (i64, i64) -> i64
    "llvm.return"(%12) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "match_signed", type = !llvm.func<i64 (i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi64>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<9> : vector<2xi64>} : () -> vector<2xi64>
    %1 = "llvm.mlir.constant"() {value = dense<19136> : vector<2xi64>} : () -> vector<2xi64>
    %2 = "llvm.mlir.constant"() {value = dense<64> : vector<2xi64>} : () -> vector<2xi64>
    %3 = "llvm.mlir.constant"() {value = dense<299> : vector<2xi64>} : () -> vector<2xi64>
    %4 = "llvm.srem"(%arg0, %3) : (vector<2xi64>, vector<2xi64>) -> vector<2xi64>
    %5 = "llvm.sdiv"(%arg0, %3) : (vector<2xi64>, vector<2xi64>) -> vector<2xi64>
    %6 = "llvm.srem"(%5, %2) : (vector<2xi64>, vector<2xi64>) -> vector<2xi64>
    %7 = "llvm.sdiv"(%arg0, %1) : (vector<2xi64>, vector<2xi64>) -> vector<2xi64>
    %8 = "llvm.srem"(%7, %0) : (vector<2xi64>, vector<2xi64>) -> vector<2xi64>
    %9 = "llvm.mul"(%6, %3) : (vector<2xi64>, vector<2xi64>) -> vector<2xi64>
    %10 = "llvm.add"(%4, %9) : (vector<2xi64>, vector<2xi64>) -> vector<2xi64>
    %11 = "llvm.mul"(%8, %1) : (vector<2xi64>, vector<2xi64>) -> vector<2xi64>
    %12 = "llvm.add"(%10, %11) : (vector<2xi64>, vector<2xi64>) -> vector<2xi64>
    "llvm.return"(%12) : (vector<2xi64>) -> ()
  }) {linkage = 10 : i64, sym_name = "match_signed_vector", type = !llvm.func<vector<2xi64> (vector<2xi64>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 64 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 299 : i64} : () -> i64
    %2 = "llvm.urem"(%arg0, %1) : (i64, i64) -> i64
    %3 = "llvm.sdiv"(%arg0, %1) : (i64, i64) -> i64
    %4 = "llvm.urem"(%3, %0) : (i64, i64) -> i64
    %5 = "llvm.mul"(%4, %1) : (i64, i64) -> i64
    %6 = "llvm.add"(%2, %5) : (i64, i64) -> i64
    "llvm.return"(%6) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "not_match_inconsistent_signs", type = !llvm.func<i64 (i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 64 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 29 : i64} : () -> i64
    %2 = "llvm.mlir.constant"() {value = 299 : i64} : () -> i64
    %3 = "llvm.urem"(%arg0, %2) : (i64, i64) -> i64
    %4 = "llvm.udiv"(%arg0, %1) : (i64, i64) -> i64
    %5 = "llvm.urem"(%4, %0) : (i64, i64) -> i64
    %6 = "llvm.mul"(%5, %2) : (i64, i64) -> i64
    %7 = "llvm.add"(%3, %6) : (i64, i64) -> i64
    "llvm.return"(%7) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "not_match_inconsistent_values", type = !llvm.func<i64 (i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 147483647 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 299 : i32} : () -> i32
    %2 = "llvm.urem"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.udiv"(%arg0, %1) : (i32, i32) -> i32
    %4 = "llvm.urem"(%3, %0) : (i32, i32) -> i32
    %5 = "llvm.mul"(%4, %1) : (i32, i32) -> i32
    %6 = "llvm.add"(%2, %5) : (i32, i32) -> i32
    "llvm.return"(%6) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "not_match_overflow", type = !llvm.func<i32 (i32)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
