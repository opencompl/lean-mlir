"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "use", type = !llvm.func<void (i8)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "use16", type = !llvm.func<void (i16)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i16):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 7 : i8} : () -> i8
    %1 = "llvm.mlir.constant"() {value = 8 : i16} : () -> i16
    %2 = "llvm.lshr"(%arg0, %1) : (i16, i16) -> i16
    %3 = "llvm.trunc"(%2) : (i16) -> i8
    %4 = "llvm.trunc"(%arg0) : (i16) -> i8
    %5 = "llvm.ashr"(%4, %0) : (i8, i8) -> i8
    %6 = "llvm.icmp"(%5, %3) {predicate = 0 : i64} : (i8, i8) -> i1
    "llvm.return"(%6) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "testi16i8", type = !llvm.func<i1 (i16)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i16):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 7 : i8} : () -> i8
    %1 = "llvm.mlir.constant"() {value = 8 : i16} : () -> i16
    %2 = "llvm.lshr"(%arg0, %1) : (i16, i16) -> i16
    %3 = "llvm.trunc"(%2) : (i16) -> i8
    %4 = "llvm.trunc"(%arg0) : (i16) -> i8
    %5 = "llvm.ashr"(%4, %0) : (i8, i8) -> i8
    %6 = "llvm.icmp"(%3, %5) {predicate = 0 : i64} : (i8, i8) -> i1
    "llvm.return"(%6) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "testi16i8_com", type = !llvm.func<i1 (i16)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i16):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 7 : i8} : () -> i8
    %1 = "llvm.mlir.constant"() {value = 8 : i16} : () -> i16
    %2 = "llvm.lshr"(%arg0, %1) : (i16, i16) -> i16
    %3 = "llvm.trunc"(%2) : (i16) -> i8
    %4 = "llvm.trunc"(%arg0) : (i16) -> i8
    %5 = "llvm.ashr"(%4, %0) : (i8, i8) -> i8
    %6 = "llvm.icmp"(%5, %3) {predicate = 1 : i64} : (i8, i8) -> i1
    "llvm.return"(%6) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "testi16i8_ne", type = !llvm.func<i1 (i16)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i16):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 7 : i8} : () -> i8
    %1 = "llvm.mlir.constant"() {value = 8 : i16} : () -> i16
    %2 = "llvm.lshr"(%arg0, %1) : (i16, i16) -> i16
    %3 = "llvm.trunc"(%2) : (i16) -> i8
    %4 = "llvm.trunc"(%arg0) : (i16) -> i8
    %5 = "llvm.ashr"(%4, %0) : (i8, i8) -> i8
    %6 = "llvm.icmp"(%3, %5) {predicate = 1 : i64} : (i8, i8) -> i1
    "llvm.return"(%6) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "testi16i8_ne_com", type = !llvm.func<i1 (i16)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 31 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 32 : i64} : () -> i64
    %2 = "llvm.lshr"(%arg0, %1) : (i64, i64) -> i64
    %3 = "llvm.trunc"(%2) : (i64) -> i32
    %4 = "llvm.trunc"(%arg0) : (i64) -> i32
    %5 = "llvm.ashr"(%4, %0) : (i32, i32) -> i32
    %6 = "llvm.icmp"(%5, %3) {predicate = 0 : i64} : (i32, i32) -> i1
    "llvm.return"(%6) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "testi64i32", type = !llvm.func<i1 (i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 31 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 32 : i64} : () -> i64
    %2 = "llvm.lshr"(%arg0, %1) : (i64, i64) -> i64
    %3 = "llvm.trunc"(%2) : (i64) -> i32
    %4 = "llvm.trunc"(%arg0) : (i64) -> i32
    %5 = "llvm.ashr"(%4, %0) : (i32, i32) -> i32
    %6 = "llvm.icmp"(%5, %3) {predicate = 1 : i64} : (i32, i32) -> i1
    "llvm.return"(%6) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "testi64i32_ne", type = !llvm.func<i1 (i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 7 : i8} : () -> i8
    %1 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
    %2 = "llvm.lshr"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.trunc"(%2) : (i32) -> i8
    %4 = "llvm.trunc"(%arg0) : (i32) -> i8
    %5 = "llvm.ashr"(%4, %0) : (i8, i8) -> i8
    %6 = "llvm.icmp"(%5, %3) {predicate = 0 : i64} : (i8, i8) -> i1
    "llvm.return"(%6) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "testi32i8", type = !llvm.func<i1 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i16):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 7 : i8} : () -> i8
    %1 = "llvm.mlir.constant"() {value = 7 : i16} : () -> i16
    %2 = "llvm.lshr"(%arg0, %1) : (i16, i16) -> i16
    %3 = "llvm.trunc"(%2) : (i16) -> i8
    %4 = "llvm.trunc"(%arg0) : (i16) -> i8
    %5 = "llvm.ashr"(%4, %0) : (i8, i8) -> i8
    %6 = "llvm.icmp"(%5, %3) {predicate = 0 : i64} : (i8, i8) -> i1
    "llvm.return"(%6) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "wrongimm1", type = !llvm.func<i1 (i16)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i16):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 6 : i8} : () -> i8
    %1 = "llvm.mlir.constant"() {value = 8 : i16} : () -> i16
    %2 = "llvm.lshr"(%arg0, %1) : (i16, i16) -> i16
    %3 = "llvm.trunc"(%2) : (i16) -> i8
    %4 = "llvm.trunc"(%arg0) : (i16) -> i8
    %5 = "llvm.ashr"(%4, %0) : (i8, i8) -> i8
    %6 = "llvm.icmp"(%5, %3) {predicate = 0 : i64} : (i8, i8) -> i1
    "llvm.return"(%6) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "wrongimm2", type = !llvm.func<i1 (i16)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 31 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 32 : i64} : () -> i64
    %2 = "llvm.lshr"(%arg0, %1) : (i64, i64) -> i64
    %3 = "llvm.trunc"(%2) : (i64) -> i32
    %4 = "llvm.trunc"(%arg0) : (i64) -> i32
    %5 = "llvm.ashr"(%4, %0) : (i32, i32) -> i32
    %6 = "llvm.icmp"(%5, %3) {predicate = 2 : i64} : (i32, i32) -> i1
    "llvm.return"(%6) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "slt", type = !llvm.func<i1 (i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i16):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 7 : i8} : () -> i8
    %1 = "llvm.mlir.constant"() {value = 8 : i16} : () -> i16
    %2 = "llvm.lshr"(%arg0, %1) : (i16, i16) -> i16
    %3 = "llvm.trunc"(%2) : (i16) -> i8
    %4 = "llvm.trunc"(%arg0) : (i16) -> i8
    %5 = "llvm.ashr"(%4, %0) : (i8, i8) -> i8
    %6 = "llvm.icmp"(%5, %3) {predicate = 0 : i64} : (i8, i8) -> i1
    "llvm.call"(%5) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    "llvm.return"(%6) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "extrause_a", type = !llvm.func<i1 (i16)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i16):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 7 : i8} : () -> i8
    %1 = "llvm.mlir.constant"() {value = 8 : i16} : () -> i16
    %2 = "llvm.lshr"(%arg0, %1) : (i16, i16) -> i16
    %3 = "llvm.trunc"(%2) : (i16) -> i8
    %4 = "llvm.trunc"(%arg0) : (i16) -> i8
    %5 = "llvm.ashr"(%4, %0) : (i8, i8) -> i8
    %6 = "llvm.icmp"(%5, %3) {predicate = 0 : i64} : (i8, i8) -> i1
    "llvm.call"(%3) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    "llvm.return"(%6) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "extrause_l", type = !llvm.func<i1 (i16)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i16):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 7 : i8} : () -> i8
    %1 = "llvm.mlir.constant"() {value = 8 : i16} : () -> i16
    %2 = "llvm.lshr"(%arg0, %1) : (i16, i16) -> i16
    %3 = "llvm.trunc"(%2) : (i16) -> i8
    %4 = "llvm.trunc"(%arg0) : (i16) -> i8
    %5 = "llvm.ashr"(%4, %0) : (i8, i8) -> i8
    %6 = "llvm.icmp"(%5, %3) {predicate = 0 : i64} : (i8, i8) -> i1
    "llvm.call"(%5) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    "llvm.call"(%3) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (i8) -> ()
    "llvm.return"(%6) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "extrause_la", type = !llvm.func<i1 (i16)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
