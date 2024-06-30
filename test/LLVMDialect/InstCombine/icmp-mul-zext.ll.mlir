"module"() ( {
  "llvm.mlir.global"() ( {
  }) {linkage = 10 : i64, sym_name = "glob", type = i16} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i8, %arg2: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = true} : () -> i1
    %2 = "llvm.mlir.constant"() {value = 4294967295 : i64} : () -> i64
    %3 = "llvm.mlir.constant"() {value = 1945964878 : i32} : () -> i32
    %4 = "llvm.zext"(%arg0) : (i32) -> i64
    %5 = "llvm.sext"(%arg1) : (i8) -> i32
    %6 = "llvm.mul"(%5, %3) : (i32, i32) -> i32
    %7 = "llvm.trunc"(%arg2) : (i64) -> i32
    %8 = "llvm.lshr"(%6, %7) : (i32, i32) -> i32
    %9 = "llvm.zext"(%8) : (i32) -> i64
    %10 = "llvm.mul"(%4, %9) : (i64, i64) -> i64
    %11 = "llvm.and"(%10, %2) : (i64, i64) -> i64
    %12 = "llvm.icmp"(%11, %10) {predicate = 1 : i64} : (i64, i64) -> i1
    "llvm.cond_br"(%12, %1)[^bb2, ^bb1] {operand_segment_sizes = dense<[1, 1, 0]> : vector<3xi32>} : (i1, i1) -> ()
  ^bb1:  // pred: ^bb0
    %13 = "llvm.and"(%arg2, %10) : (i64, i64) -> i64
    %14 = "llvm.trunc"(%13) : (i64) -> i32
    %15 = "llvm.icmp"(%14, %0) {predicate = 1 : i64} : (i32, i32) -> i1
    %16 = "llvm.xor"(%15, %1) : (i1, i1) -> i1
    "llvm.br"(%16)[^bb2] : (i1) -> ()
  ^bb2(%17: i1):  // 2 preds: ^bb0, ^bb1
    %18 = "llvm.zext"(%17) : (i1) -> i32
    "llvm.return"(%18) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "sterix", type = !llvm.func<i32 (i32, i8, i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.addressof"() {global_name = @glob} : () -> !llvm.ptr<i16>
    %1 = "llvm.mlir.addressof"() {global_name = @glob} : () -> !llvm.ptr<i16>
    %2 = "llvm.mlir.constant"() {value = 255 : i32} : () -> i32
    %3 = "llvm.zext"(%arg0) : (i8) -> i32
    %4 = "llvm.mul"(%3, %3) : (i32, i32) -> i32
    %5 = "llvm.and"(%4, %2) : (i32, i32) -> i32
    %6 = "llvm.icmp"(%4, %5) {predicate = 1 : i64} : (i32, i32) -> i1
    "llvm.cond_br"(%6)[^bb1, ^bb1] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb1:  // 2 preds: ^bb0, ^bb0
    %7 = "llvm.load"(%1) : (!llvm.ptr<i16>) -> i16
    %8 = "llvm.sext"(%7) : (i16) -> i32
    %9 = "llvm.and"(%4, %8) : (i32, i32) -> i32
    %10 = "llvm.trunc"(%9) : (i32) -> i16
    "llvm.store"(%10, %0) : (i16, !llvm.ptr<i16>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "PR33765", type = !llvm.func<void (i8)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "aux", type = !llvm.func<i16 (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i16, %arg1: i16):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 65535 : i32} : () -> i32
    %1 = "llvm.zext"(%arg0) : (i16) -> i32
    %2 = "llvm.zext"(%arg1) : (i16) -> i32
    %3 = "llvm.mul"(%1, %2) : (i32, i32) -> i32
    %4 = "llvm.trunc"(%3) : (i32) -> i8
    %5 = "llvm.trunc"(%3) : (i32) -> i16
    %6 = "llvm.icmp"(%3, %0) {predicate = 8 : i64} : (i32, i32) -> i1
    "llvm.cond_br"(%6)[^bb1, ^bb2] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb1:  // pred: ^bb0
    %7 = "llvm.call"(%4) {callee = @aux, fastmathFlags = #llvm.fastmath<>} : (i8) -> i16
    "llvm.return"(%7) : (i16) -> ()
  ^bb2:  // pred: ^bb0
    "llvm.return"(%5) : (i16) -> ()
  }) {linkage = 10 : i64, sym_name = "iter_breaker", type = !llvm.func<i16 (i16, i16)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = -1 : i32} : () -> i32
    "llvm.cond_br"(%arg0, %1)[^bb1, ^bb2] {operand_segment_sizes = dense<[1, 0, 1]> : vector<3xi32>} : (i1, i32) -> ()
  ^bb1:  // pred: ^bb0
    %2 = "llvm.trunc"(%arg3) : (i8) -> i1
    %3 = "llvm.zext"(%arg1) : (i1) -> i32
    %4 = "llvm.zext"(%arg2) : (i1) -> i32
    %5 = "llvm.zext"(%2) : (i1) -> i32
    %6 = "llvm.mul"(%3, %4) : (i32, i32) -> i32
    %7 = "llvm.xor"(%6, %5) : (i32, i32) -> i32
    "llvm.br"(%7)[^bb2] : (i32) -> ()
  ^bb2(%8: i32):  // 2 preds: ^bb0, ^bb1
    %9 = "llvm.icmp"(%8, %0) {predicate = 0 : i64} : (i32, i32) -> i1
    "llvm.return"(%9) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "PR46561", type = !llvm.func<i1 (i1, i1, i1, i8)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
