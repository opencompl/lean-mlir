"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.bitreverse.i8", type = !llvm.func<i8 (i8)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.bitreverse.i32", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 65535 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = -65536 : i32} : () -> i32
    %2 = "llvm.or"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.call"(%2) {callee = @llvm.bitreverse.i32, fastmathFlags = #llvm.fastmath<>} : (i32) -> i32
    %4 = "llvm.and"(%3, %0) : (i32, i32) -> i32
    %5 = "llvm.icmp"(%4, %0) {predicate = 0 : i64} : (i32, i32) -> i1
    "llvm.return"(%5) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "test1", type = !llvm.func<i1 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -2147483648 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %2 = "llvm.or"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.call"(%2) {callee = @llvm.bitreverse.i32, fastmathFlags = #llvm.fastmath<>} : (i32) -> i32
    %4 = "llvm.and"(%3, %0) : (i32, i32) -> i32
    %5 = "llvm.call"(%4) {callee = @llvm.bitreverse.i32, fastmathFlags = #llvm.fastmath<>} : (i32) -> i32
    %6 = "llvm.icmp"(%5, %1) {predicate = 0 : i64} : (i32, i32) -> i1
    "llvm.return"(%6) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "test2", type = !llvm.func<i1 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 32768 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 65536 : i32} : () -> i32
    %3 = "llvm.or"(%arg0, %2) : (i32, i32) -> i32
    %4 = "llvm.call"(%3) {callee = @llvm.bitreverse.i32, fastmathFlags = #llvm.fastmath<>} : (i32) -> i32
    %5 = "llvm.and"(%4, %1) : (i32, i32) -> i32
    %6 = "llvm.icmp"(%5, %0) {predicate = 0 : i64} : (i32, i32) -> i1
    "llvm.return"(%6) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "test3", type = !llvm.func<i1 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -16 : i8} : () -> i8
    %1 = "llvm.mlir.constant"() {value = -4 : i8} : () -> i8
    %2 = "llvm.and"(%arg0, %1) : (i8, i8) -> i8
    %3 = "llvm.call"(%2) {callee = @llvm.bitreverse.i8, fastmathFlags = #llvm.fastmath<>} : (i8) -> i8
    %4 = "llvm.add"(%3, %0) : (i8, i8) -> i8
    "llvm.return"(%4) : (i8) -> ()
  }) {linkage = 10 : i64, sym_name = "add_bitreverse", type = !llvm.func<i8 (i8)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
