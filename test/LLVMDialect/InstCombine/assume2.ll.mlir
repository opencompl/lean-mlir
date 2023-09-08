"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.assume", type = !llvm.func<void (i1)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 7 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 5 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 15 : i32} : () -> i32
    %3 = "llvm.and"(%arg0, %2) : (i32, i32) -> i32
    %4 = "llvm.icmp"(%3, %1) {predicate = 0 : i64} : (i32, i32) -> i1
    "llvm.call"(%4) {callee = @llvm.assume, fastmathFlags = #llvm.fastmath<>} : (i1) -> ()
    %5 = "llvm.and"(%arg0, %0) : (i32, i32) -> i32
    "llvm.return"(%5) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test1", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 7 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = -11 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = -1 : i32} : () -> i32
    %3 = "llvm.mlir.constant"() {value = 15 : i32} : () -> i32
    %4 = "llvm.and"(%arg0, %3) : (i32, i32) -> i32
    %5 = "llvm.xor"(%4, %2) : (i32, i32) -> i32
    %6 = "llvm.icmp"(%5, %1) {predicate = 0 : i64} : (i32, i32) -> i1
    "llvm.call"(%6) {callee = @llvm.assume, fastmathFlags = #llvm.fastmath<>} : (i1) -> ()
    %7 = "llvm.and"(%arg0, %0) : (i32, i32) -> i32
    "llvm.return"(%7) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test2", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 7 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = -11 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = -16 : i32} : () -> i32
    %3 = "llvm.or"(%arg0, %2) : (i32, i32) -> i32
    %4 = "llvm.icmp"(%3, %1) {predicate = 0 : i64} : (i32, i32) -> i1
    "llvm.call"(%4) {callee = @llvm.assume, fastmathFlags = #llvm.fastmath<>} : (i1) -> ()
    %5 = "llvm.and"(%arg0, %0) : (i32, i32) -> i32
    "llvm.return"(%5) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test3", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 7 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 5 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = -1 : i32} : () -> i32
    %3 = "llvm.mlir.constant"() {value = -16 : i32} : () -> i32
    %4 = "llvm.or"(%arg0, %3) : (i32, i32) -> i32
    %5 = "llvm.xor"(%4, %2) : (i32, i32) -> i32
    %6 = "llvm.icmp"(%5, %1) {predicate = 0 : i64} : (i32, i32) -> i1
    "llvm.call"(%6) {callee = @llvm.assume, fastmathFlags = #llvm.fastmath<>} : (i1) -> ()
    %7 = "llvm.and"(%arg0, %0) : (i32, i32) -> i32
    "llvm.return"(%7) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test4", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 7 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 5 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %3 = "llvm.xor"(%arg0, %2) : (i32, i32) -> i32
    %4 = "llvm.icmp"(%3, %1) {predicate = 0 : i64} : (i32, i32) -> i1
    "llvm.call"(%4) {callee = @llvm.assume, fastmathFlags = #llvm.fastmath<>} : (i1) -> ()
    %5 = "llvm.and"(%arg0, %0) : (i32, i32) -> i32
    "llvm.return"(%5) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test5", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 63 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 20 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 2 : i32} : () -> i32
    %3 = "llvm.shl"(%arg0, %2) : (i32, i32) -> i32
    %4 = "llvm.icmp"(%3, %1) {predicate = 0 : i64} : (i32, i32) -> i1
    "llvm.call"(%4) {callee = @llvm.assume, fastmathFlags = #llvm.fastmath<>} : (i1) -> ()
    %5 = "llvm.and"(%arg0, %0) : (i32, i32) -> i32
    "llvm.return"(%5) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test6", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 252 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 5 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 2 : i32} : () -> i32
    %3 = "llvm.lshr"(%arg0, %2) : (i32, i32) -> i32
    %4 = "llvm.icmp"(%3, %1) {predicate = 0 : i64} : (i32, i32) -> i1
    "llvm.call"(%4) {callee = @llvm.assume, fastmathFlags = #llvm.fastmath<>} : (i1) -> ()
    %5 = "llvm.and"(%arg0, %0) : (i32, i32) -> i32
    "llvm.return"(%5) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test7", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 252 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 5 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 2 : i32} : () -> i32
    %3 = "llvm.lshr"(%arg0, %2) : (i32, i32) -> i32
    %4 = "llvm.icmp"(%3, %1) {predicate = 0 : i64} : (i32, i32) -> i1
    "llvm.call"(%4) {callee = @llvm.assume, fastmathFlags = #llvm.fastmath<>} : (i1) -> ()
    %5 = "llvm.and"(%arg0, %0) : (i32, i32) -> i32
    "llvm.return"(%5) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test8", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -2147483648 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 5 : i32} : () -> i32
    %2 = "llvm.icmp"(%arg0, %1) {predicate = 4 : i64} : (i32, i32) -> i1
    "llvm.call"(%2) {callee = @llvm.assume, fastmathFlags = #llvm.fastmath<>} : (i1) -> ()
    %3 = "llvm.and"(%arg0, %0) : (i32, i32) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test9", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -2147483648 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = -2 : i32} : () -> i32
    %2 = "llvm.icmp"(%arg0, %1) {predicate = 3 : i64} : (i32, i32) -> i1
    "llvm.call"(%2) {callee = @llvm.assume, fastmathFlags = #llvm.fastmath<>} : (i1) -> ()
    %3 = "llvm.and"(%arg0, %0) : (i32, i32) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test10", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 3072 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 256 : i32} : () -> i32
    %2 = "llvm.icmp"(%arg0, %1) {predicate = 7 : i64} : (i32, i32) -> i1
    "llvm.call"(%2) {callee = @llvm.assume, fastmathFlags = #llvm.fastmath<>} : (i1) -> ()
    %3 = "llvm.and"(%arg0, %0) : (i32, i32) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test11", type = !llvm.func<i32 (i32)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
