"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i16, %arg1: i32):  // no predecessors
    %0 = "llvm.sext"(%arg0) : (i16) -> i32
    %1 = "llvm.shl"(%0, %arg1) : (i32, i32) -> i32
    %2 = "llvm.trunc"(%1) : (i32) -> i16
    "llvm.return"(%2) : (i16) -> ()
  }) {linkage = 10 : i64, sym_name = "sext_shl_trunc_same_size", type = !llvm.func<i16 (i16, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i16, %arg1: i32):  // no predecessors
    %0 = "llvm.sext"(%arg0) : (i16) -> i32
    %1 = "llvm.shl"(%0, %arg1) : (i32, i32) -> i32
    %2 = "llvm.trunc"(%1) : (i32) -> i5
    "llvm.return"(%2) : (i5) -> ()
  }) {linkage = 10 : i64, sym_name = "sext_shl_trunc_smaller", type = !llvm.func<i5 (i16, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i16, %arg1: i32):  // no predecessors
    %0 = "llvm.sext"(%arg0) : (i16) -> i32
    %1 = "llvm.shl"(%0, %arg1) : (i32, i32) -> i32
    %2 = "llvm.trunc"(%1) : (i32) -> i17
    "llvm.return"(%2) : (i17) -> ()
  }) {linkage = 10 : i64, sym_name = "sext_shl_trunc_larger", type = !llvm.func<i17 (i16, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i16, %arg1: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 65535 : i32} : () -> i32
    %1 = "llvm.sext"(%arg0) : (i16) -> i32
    %2 = "llvm.shl"(%1, %arg1) : (i32, i32) -> i32
    %3 = "llvm.and"(%2, %0) : (i32, i32) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "sext_shl_mask", type = !llvm.func<i32 (i16, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i16, %arg1: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 65536 : i32} : () -> i32
    %1 = "llvm.sext"(%arg0) : (i16) -> i32
    %2 = "llvm.shl"(%1, %arg1) : (i32, i32) -> i32
    %3 = "llvm.and"(%2, %0) : (i32, i32) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "sext_shl_mask_higher", type = !llvm.func<i32 (i16, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 65536 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 196609 : i32} : () -> i32
    %2 = "llvm.or"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.shl"(%2, %arg1) : (i32, i32) -> i32
    %4 = "llvm.and"(%3, %0) : (i32, i32) -> i32
    "llvm.return"(%4) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "set_shl_mask", type = !llvm.func<i32 (i32, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 255 : i32} : () -> i32
    %1 = "llvm.and"(%arg0, %0) : (i32, i32) -> i32
    %2 = "llvm.shl"(%1, %arg1) : (i32, i32) -> i32
    %3 = "llvm.trunc"(%2) : (i32) -> i8
    "llvm.return"(%3) : (i8) -> ()
  }) {linkage = 10 : i64, sym_name = "must_drop_poison", type = !llvm.func<i8 (i32, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i40):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 31 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 16 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 31 : i40} : () -> i40
    %3 = "llvm.ashr"(%arg0, %2) : (i40, i40) -> i40
    %4 = "llvm.trunc"(%3) : (i40) -> i32
    %5 = "llvm.shl"(%4, %1) : (i32, i32) -> i32
    %6 = "llvm.ashr"(%5, %1) : (i32, i32) -> i32
    %7 = "llvm.shl"(%6, %0) : (i32, i32) -> i32
    "llvm.return"(%5) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "f_t15_t01_t09", type = !llvm.func<i32 (i40)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
