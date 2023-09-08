"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "gen1", type = !llvm.func<i1 ()>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i16, %arg1: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = true} : () -> i1
    %1 = "llvm.mlir.constant"() {value = 0 : i8} : () -> i8
    %2 = "llvm.mlir.constant"() {value = 0 : i16} : () -> i16
    %3 = "llvm.icmp"(%arg0, %2) {predicate = 2 : i64} : (i16, i16) -> i1
    %4 = "llvm.icmp"(%arg1, %1) {predicate = 2 : i64} : (i8, i8) -> i1
    %5 = "llvm.xor"(%4, %3) : (i1, i1) -> i1
    %6 = "llvm.xor"(%5, %0) : (i1, i1) -> i1
    "llvm.return"(%6) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "positive_easyinvert", type = !llvm.func<i1 (i16, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = true} : () -> i1
    %1 = "llvm.mlir.constant"() {value = 0 : i8} : () -> i8
    %2 = "llvm.call"() {callee = @gen1, fastmathFlags = #llvm.fastmath<>} : () -> i1
    %3 = "llvm.icmp"(%arg0, %1) {predicate = 2 : i64} : (i8, i8) -> i1
    %4 = "llvm.xor"(%3, %2) : (i1, i1) -> i1
    %5 = "llvm.xor"(%4, %0) : (i1, i1) -> i1
    "llvm.return"(%5) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "positive_easyinvert0", type = !llvm.func<i1 (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = true} : () -> i1
    %1 = "llvm.mlir.constant"() {value = 0 : i8} : () -> i8
    %2 = "llvm.call"() {callee = @gen1, fastmathFlags = #llvm.fastmath<>} : () -> i1
    %3 = "llvm.icmp"(%arg0, %1) {predicate = 2 : i64} : (i8, i8) -> i1
    %4 = "llvm.xor"(%2, %3) : (i1, i1) -> i1
    %5 = "llvm.xor"(%4, %0) : (i1, i1) -> i1
    "llvm.return"(%5) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "positive_easyinvert1", type = !llvm.func<i1 (i8)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "use1", type = !llvm.func<void (i1)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = true} : () -> i1
    %1 = "llvm.mlir.constant"() {value = 0 : i8} : () -> i8
    %2 = "llvm.call"() {callee = @gen1, fastmathFlags = #llvm.fastmath<>} : () -> i1
    %3 = "llvm.icmp"(%arg0, %1) {predicate = 2 : i64} : (i8, i8) -> i1
    "llvm.call"(%3) {callee = @use1, fastmathFlags = #llvm.fastmath<>} : (i1) -> ()
    %4 = "llvm.xor"(%2, %3) : (i1, i1) -> i1
    %5 = "llvm.xor"(%4, %0) : (i1, i1) -> i1
    "llvm.return"(%5) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "oneuse_easyinvert_0", type = !llvm.func<i1 (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = true} : () -> i1
    %1 = "llvm.mlir.constant"() {value = 0 : i8} : () -> i8
    %2 = "llvm.call"() {callee = @gen1, fastmathFlags = #llvm.fastmath<>} : () -> i1
    %3 = "llvm.icmp"(%arg0, %1) {predicate = 2 : i64} : (i8, i8) -> i1
    %4 = "llvm.xor"(%2, %3) : (i1, i1) -> i1
    "llvm.call"(%4) {callee = @use1, fastmathFlags = #llvm.fastmath<>} : (i1) -> ()
    %5 = "llvm.xor"(%4, %0) : (i1, i1) -> i1
    "llvm.return"(%5) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "oneuse_easyinvert_1", type = !llvm.func<i1 (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = true} : () -> i1
    %1 = "llvm.mlir.constant"() {value = 0 : i8} : () -> i8
    %2 = "llvm.call"() {callee = @gen1, fastmathFlags = #llvm.fastmath<>} : () -> i1
    %3 = "llvm.icmp"(%arg0, %1) {predicate = 2 : i64} : (i8, i8) -> i1
    "llvm.call"(%3) {callee = @use1, fastmathFlags = #llvm.fastmath<>} : (i1) -> ()
    %4 = "llvm.xor"(%2, %3) : (i1, i1) -> i1
    "llvm.call"(%4) {callee = @use1, fastmathFlags = #llvm.fastmath<>} : (i1) -> ()
    %5 = "llvm.xor"(%4, %0) : (i1, i1) -> i1
    "llvm.return"(%5) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "oneuse_easyinvert_2", type = !llvm.func<i1 (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i32} : () -> i32
    %1 = "llvm.xor"(%arg0, %arg1) : (i32, i32) -> i32
    %2 = "llvm.xor"(%1, %0) : (i32, i32) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "negative", type = !llvm.func<i32 (i32, i32)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
