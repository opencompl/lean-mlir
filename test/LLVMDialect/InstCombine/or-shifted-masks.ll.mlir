"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 60 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 5 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 15 : i32} : () -> i32
    %3 = "llvm.mlir.constant"() {value = 3 : i32} : () -> i32
    %4 = "llvm.shl"(%arg0, %3) : (i32, i32) -> i32
    %5 = "llvm.and"(%4, %2) : (i32, i32) -> i32
    %6 = "llvm.shl"(%arg0, %1) : (i32, i32) -> i32
    %7 = "llvm.and"(%6, %0) : (i32, i32) -> i32
    %8 = "llvm.or"(%5, %7) : (i32, i32) -> i32
    "llvm.return"(%8) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "or_and_shifts1", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 7 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 4 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 896 : i32} : () -> i32
    %3 = "llvm.mlir.constant"() {value = 3 : i32} : () -> i32
    %4 = "llvm.shl"(%arg0, %3) : (i32, i32) -> i32
    %5 = "llvm.and"(%4, %2) : (i32, i32) -> i32
    %6 = "llvm.lshr"(%arg0, %1) : (i32, i32) -> i32
    %7 = "llvm.and"(%6, %0) : (i32, i32) -> i32
    %8 = "llvm.or"(%5, %7) : (i32, i32) -> i32
    "llvm.return"(%8) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "or_and_shifts2", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 28 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 2 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 3 : i32} : () -> i32
    %3 = "llvm.mlir.constant"() {value = 7 : i32} : () -> i32
    %4 = "llvm.and"(%arg0, %3) : (i32, i32) -> i32
    %5 = "llvm.shl"(%4, %2) : (i32, i32) -> i32
    %6 = "llvm.shl"(%arg0, %1) : (i32, i32) -> i32
    %7 = "llvm.and"(%6, %0) : (i32, i32) -> i32
    %8 = "llvm.or"(%5, %7) : (i32, i32) -> i32
    "llvm.return"(%8) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "or_and_shift_shift_and", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 6 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 4 : i32} : () -> i32
    %3 = "llvm.mlir.constant"() {value = 2 : i32} : () -> i32
    %4 = "llvm.and"(%arg0, %3) : (i32, i32) -> i32
    %5 = "llvm.and"(%arg0, %2) : (i32, i32) -> i32
    %6 = "llvm.shl"(%4, %1) : (i32, i32) -> i32
    %7 = "llvm.lshr"(%4, %0) : (i32, i32) -> i32
    %8 = "llvm.shl"(%5, %1) : (i32, i32) -> i32
    %9 = "llvm.lshr"(%5, %0) : (i32, i32) -> i32
    %10 = "llvm.or"(%6, %8) : (i32, i32) -> i32
    %11 = "llvm.or"(%7, %9) : (i32, i32) -> i32
    %12 = "llvm.or"(%11, %10) : (i32, i32) -> i32
    "llvm.return"(%12) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "multiuse1", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 96 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 24 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %3 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
    %4 = "llvm.mlir.constant"() {value = 6 : i32} : () -> i32
    %5 = "llvm.and"(%arg0, %4) : (i32, i32) -> i32
    %6 = "llvm.shl"(%5, %3) : (i32, i32) -> i32
    %7 = "llvm.shl"(%5, %2) : (i32, i32) -> i32
    %8 = "llvm.and"(%arg0, %1) : (i32, i32) -> i32
    %9 = "llvm.shl"(%8, %3) : (i32, i32) -> i32
    %10 = "llvm.shl"(%8, %2) : (i32, i32) -> i32
    %11 = "llvm.and"(%arg0, %0) : (i32, i32) -> i32
    %12 = "llvm.shl"(%11, %3) : (i32, i32) -> i32
    %13 = "llvm.shl"(%11, %2) : (i32, i32) -> i32
    %14 = "llvm.or"(%6, %9) : (i32, i32) -> i32
    %15 = "llvm.or"(%12, %14) : (i32, i32) -> i32
    %16 = "llvm.or"(%13, %10) : (i32, i32) -> i32
    %17 = "llvm.or"(%7, %16) : (i32, i32) -> i32
    %18 = "llvm.or"(%15, %17) : (i32, i32) -> i32
    "llvm.return"(%18) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "multiuse2", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 15 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 1920 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %3 = "llvm.mlir.constant"() {value = 6 : i32} : () -> i32
    %4 = "llvm.mlir.constant"() {value = 96 : i32} : () -> i32
    %5 = "llvm.and"(%arg0, %4) : (i32, i32) -> i32
    %6 = "llvm.shl"(%5, %3) : (i32, i32) -> i32
    %7 = "llvm.lshr"(%5, %2) : (i32, i32) -> i32
    %8 = "llvm.shl"(%arg0, %3) : (i32, i32) -> i32
    %9 = "llvm.and"(%8, %1) : (i32, i32) -> i32
    %10 = "llvm.or"(%6, %9) : (i32, i32) -> i32
    %11 = "llvm.lshr"(%arg0, %2) : (i32, i32) -> i32
    %12 = "llvm.and"(%11, %0) : (i32, i32) -> i32
    %13 = "llvm.or"(%7, %12) : (i32, i32) -> i32
    %14 = "llvm.or"(%13, %10) : (i32, i32) -> i32
    "llvm.return"(%14) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "multiuse3", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 15360 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 17 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 480 : i32} : () -> i32
    %3 = "llvm.mlir.constant"() {value = 22 : i32} : () -> i32
    %4 = "llvm.mlir.constant"() {value = -1 : i32} : () -> i32
    %5 = "llvm.mlir.constant"() {value = 100663296 : i32} : () -> i32
    %6 = "llvm.and"(%arg0, %5) : (i32, i32) -> i32
    %7 = "llvm.icmp"(%arg0, %4) {predicate = 4 : i64} : (i32, i32) -> i1
    "llvm.cond_br"(%7)[^bb1, ^bb2] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb1:  // pred: ^bb0
    %8 = "llvm.lshr"(%6, %3) : (i32, i32) -> i32
    %9 = "llvm.lshr"(%arg0, %3) : (i32, i32) -> i32
    %10 = "llvm.and"(%9, %2) : (i32, i32) -> i32
    %11 = "llvm.or"(%10, %8) : (i32, i32) -> i32
    "llvm.br"(%11)[^bb3] : (i32) -> ()
  ^bb2:  // pred: ^bb0
    %12 = "llvm.lshr"(%6, %1) : (i32, i32) -> i32
    %13 = "llvm.lshr"(%arg0, %1) : (i32, i32) -> i32
    %14 = "llvm.and"(%13, %0) : (i32, i32) -> i32
    %15 = "llvm.or"(%14, %12) : (i32, i32) -> i32
    "llvm.br"(%15)[^bb3] : (i32) -> ()
  ^bb3(%16: i32):  // 2 preds: ^bb1, ^bb2
    "llvm.return"(%16) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "multiuse4", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 348160 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 5570560 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 1360 : i32} : () -> i32
    %3 = "llvm.mlir.constant"() {value = 21760 : i32} : () -> i32
    %4 = "llvm.mlir.constant"() {value = -1 : i32} : () -> i32
    %5 = "llvm.mlir.constant"() {value = 5 : i32} : () -> i32
    %6 = "llvm.shl"(%arg0, %5) : (i32, i32) -> i32
    %7 = "llvm.icmp"(%arg0, %4) {predicate = 4 : i64} : (i32, i32) -> i1
    "llvm.cond_br"(%7)[^bb1, ^bb2] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb1:  // pred: ^bb0
    %8 = "llvm.and"(%6, %3) : (i32, i32) -> i32
    %9 = "llvm.and"(%arg0, %2) : (i32, i32) -> i32
    %10 = "llvm.shl"(%9, %5) : (i32, i32) -> i32
    %11 = "llvm.or"(%10, %8) : (i32, i32) -> i32
    "llvm.br"(%11)[^bb3] : (i32) -> ()
  ^bb2:  // pred: ^bb0
    %12 = "llvm.and"(%6, %1) : (i32, i32) -> i32
    %13 = "llvm.and"(%arg0, %0) : (i32, i32) -> i32
    %14 = "llvm.shl"(%13, %5) : (i32, i32) -> i32
    %15 = "llvm.or"(%14, %12) : (i32, i32) -> i32
    "llvm.br"(%15)[^bb3] : (i32) -> ()
  ^bb3(%16: i32):  // 2 preds: ^bb1, ^bb2
    "llvm.return"(%16) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "multiuse5", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 255 : i32} : () -> i32
    %2 = "llvm.and"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.shl"(%2, %0) : (i32, i32) -> i32
    %4 = "llvm.or"(%2, %3) : (i32, i32) -> i32
    "llvm.return"(%4) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "shl_mask", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 7 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 255 : i32} : () -> i32
    %2 = "llvm.and"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.shl"(%2, %0) : (i32, i32) -> i32
    %4 = "llvm.or"(%2, %3) : (i32, i32) -> i32
    "llvm.return"(%4) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "shl_mask_wrong_shl_const", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i37):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 8 : i37} : () -> i37
    %1 = "llvm.mlir.constant"() {value = 255 : i37} : () -> i37
    %2 = "llvm.and"(%arg0, %1) : (i37, i37) -> i37
    %3 = "llvm.shl"(%2, %0) : (i37, i37) -> i37
    %4 = "llvm.or"(%2, %3) : (i37, i37) -> i37
    "llvm.return"(%4) : (i37) -> ()
  }) {linkage = 10 : i64, sym_name = "shl_mask_weird_type", type = !llvm.func<i37 (i37)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: !llvm.ptr<i32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 255 : i32} : () -> i32
    %2 = "llvm.and"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.shl"(%2, %0) : (i32, i32) -> i32
    "llvm.store"(%3, %arg1) : (i32, !llvm.ptr<i32>) -> ()
    %4 = "llvm.or"(%2, %3) : (i32, i32) -> i32
    "llvm.return"(%4) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "shl_mask_extra_use", type = !llvm.func<i32 (i32, ptr<i32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 65537 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 255 : i32} : () -> i32
    %3 = "llvm.and"(%arg0, %2) : (i32, i32) -> i32
    %4 = "llvm.mul"(%3, %1) : (i32, i32) -> i32
    %5 = "llvm.shl"(%3, %0) : (i32, i32) -> i32
    %6 = "llvm.or"(%4, %5) : (i32, i32) -> i32
    "llvm.return"(%6) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "shl_mul_mask", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 65535 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 255 : i32} : () -> i32
    %3 = "llvm.and"(%arg0, %2) : (i32, i32) -> i32
    %4 = "llvm.mul"(%3, %1) : (i32, i32) -> i32
    %5 = "llvm.shl"(%3, %0) : (i32, i32) -> i32
    %6 = "llvm.or"(%4, %5) : (i32, i32) -> i32
    "llvm.return"(%6) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "shl_mul_mask_wrong_mul_const", type = !llvm.func<i32 (i32)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
