"module"() ( {
  "llvm.mlir.global"() ( {
  }) {linkage = 10 : i64, sym_name = "b", type = !llvm.array<1 x i16>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %2 = "llvm.lshr"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.udiv"(%2, %0) : (i32, i32) -> i32
    %4 = "llvm.sext"(%3) : (i32) -> i64
    "llvm.return"(%4) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "test1", type = !llvm.func<i64 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 3 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 31 : i32} : () -> i32
    %2 = "llvm.lshr"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.udiv"(%2, %0) : (i32, i32) -> i32
    %4 = "llvm.sext"(%3) : (i32) -> i64
    "llvm.return"(%4) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "test2", type = !llvm.func<i64 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 30 : i32} : () -> i32
    %1 = "llvm.lshr"(%arg0, %0) : (i32, i32) -> i32
    %2 = "llvm.udiv"(%1, %arg1) : (i32, i32) -> i32
    %3 = "llvm.sext"(%2) : (i32) -> i64
    "llvm.return"(%3) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "test1_PR2274", type = !llvm.func<i64 (i32, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 31 : i32} : () -> i32
    %1 = "llvm.lshr"(%arg0, %0) : (i32, i32) -> i32
    %2 = "llvm.udiv"(%1, %arg1) : (i32, i32) -> i32
    %3 = "llvm.sext"(%2) : (i32) -> i64
    "llvm.return"(%3) : (i64) -> ()
  }) {linkage = 10 : i64, sym_name = "test2_PR2274", type = !llvm.func<i64 (i32, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i1):  // no predecessors
    %0 = "llvm.mlir.addressof"() {global_name = @b} : () -> !llvm.ptr<array<1 x i16>>
    %1 = "llvm.ptrtoint"(%0) : (!llvm.ptr<array<1 x i16>>) -> i16
    %2 = "llvm.mlir.constant"() {value = 1 : i16} : () -> i16
    %3 = "llvm.shl"(%2, %1) : (i16, i16) -> i16
    %4 = "llvm.zext"(%3) : (i16) -> i32
    %5 = "llvm.zext"(%arg0) : (i1) -> i32
    %6 = "llvm.udiv"(%5, %4) : (i32, i32) -> i32
    "llvm.return"(%6) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "PR30366", type = !llvm.func<i32 (i1)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i177, %arg1: i177):  // no predecessors
    %0 = "llvm.mlir.undef"() : () -> !llvm.ptr<i1>
    %1 = "llvm.mlir.constant"() {value = -1 : i177} : () -> i177
    %2 = "llvm.udiv"(%arg1, %1) : (i177, i177) -> i177
    %3 = "llvm.add"(%2, %1) : (i177, i177) -> i177
    %4 = "llvm.add"(%3, %1) : (i177, i177) -> i177
    %5 = "llvm.mul"(%2, %4) : (i177, i177) -> i177
    %6 = "llvm.add"(%4, %4) : (i177, i177) -> i177
    %7 = "llvm.xor"(%3, %6) : (i177, i177) -> i177
    %8 = "llvm.ashr"(%arg1, %4) : (i177, i177) -> i177
    %9 = "llvm.add"(%7, %8) : (i177, i177) -> i177
    %10 = "llvm.udiv"(%2, %5) : (i177, i177) -> i177
    %11 = "llvm.icmp"(%arg1, %9) {predicate = 6 : i64} : (i177, i177) -> i1
    "llvm.store"(%11, %0) : (i1, !llvm.ptr<i1>) -> ()
    "llvm.return"(%10) : (i177) -> ()
  }) {linkage = 10 : i64, sym_name = "ossfuzz_4857", type = !llvm.func<i177 (i177, i177)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 12 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 3 : i32} : () -> i32
    %2 = "llvm.or"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.udiv"(%2, %0) : (i32, i32) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "udiv_demanded", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 12 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = -3 : i32} : () -> i32
    %2 = "llvm.and"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.udiv"(%2, %0) : (i32, i32) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "udiv_exact_demanded", type = !llvm.func<i32 (i32)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
