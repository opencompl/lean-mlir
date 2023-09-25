"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.bswap.i16", type = !llvm.func<i16 (i16)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.bswap.i32", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i16):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 256 : i16} : () -> i16
    %1 = "llvm.mlir.constant"() {value = 511 : i16} : () -> i16
    %2 = "llvm.or"(%arg0, %1) : (i16, i16) -> i16
    %3 = "llvm.call"(%2) {callee = @llvm.bswap.i16, fastmathFlags = #llvm.fastmath<>} : (i16) -> i16
    %4 = "llvm.and"(%3, %0) : (i16, i16) -> i16
    %5 = "llvm.icmp"(%4, %0) {predicate = 0 : i64} : (i16, i16) -> i1
    "llvm.return"(%5) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "test1", type = !llvm.func<i1 (i16)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i16):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 256 : i16} : () -> i16
    %1 = "llvm.mlir.constant"() {value = 1 : i16} : () -> i16
    %2 = "llvm.or"(%arg0, %1) : (i16, i16) -> i16
    %3 = "llvm.call"(%2) {callee = @llvm.bswap.i16, fastmathFlags = #llvm.fastmath<>} : (i16) -> i16
    %4 = "llvm.and"(%3, %0) : (i16, i16) -> i16
    %5 = "llvm.icmp"(%4, %0) {predicate = 0 : i64} : (i16, i16) -> i1
    "llvm.return"(%5) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "test2", type = !llvm.func<i1 (i16)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i16):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i16} : () -> i16
    %1 = "llvm.mlir.constant"() {value = 256 : i16} : () -> i16
    %2 = "llvm.or"(%arg0, %1) : (i16, i16) -> i16
    %3 = "llvm.call"(%2) {callee = @llvm.bswap.i16, fastmathFlags = #llvm.fastmath<>} : (i16) -> i16
    %4 = "llvm.and"(%3, %0) : (i16, i16) -> i16
    %5 = "llvm.icmp"(%4, %0) {predicate = 0 : i64} : (i16, i16) -> i1
    "llvm.return"(%5) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "test3", type = !llvm.func<i1 (i16)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 127 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 2147483647 : i32} : () -> i32
    %2 = "llvm.or"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.call"(%2) {callee = @llvm.bswap.i32, fastmathFlags = #llvm.fastmath<>} : (i32) -> i32
    %4 = "llvm.and"(%3, %0) : (i32, i32) -> i32
    %5 = "llvm.icmp"(%4, %0) {predicate = 0 : i64} : (i32, i32) -> i1
    "llvm.return"(%5) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "test4", type = !llvm.func<i1 (i32)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
