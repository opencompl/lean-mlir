"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 16383 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 14 : i32} : () -> i32
    %3 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %4 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %5 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %6 = "llvm.mlir.constant"() {value = 0 : i8} : () -> i8
    %7 = "llvm.load"(%arg0) : (!llvm.ptr<i8>) -> i8
    %8 = "llvm.icmp"(%7, %6) {predicate = 0 : i64} : (i8, i8) -> i1
    "llvm.cond_br"(%8, %5, %4, %5)[^bb2, ^bb1] {operand_segment_sizes = dense<[1, 1, 2]> : vector<3xi32>} : (i1, i32, i64, i32) -> ()
  ^bb1(%9: i64, %10: i32):  // 2 preds: ^bb0, ^bb1
    %11 = "llvm.getelementptr"(%arg0, %9) : (!llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    %12 = "llvm.shl"(%10, %3) : (i32, i32) -> i32
    %13 = "llvm.lshr"(%10, %2) : (i32, i32) -> i32
    %14 = "llvm.add"(%12, %13) : (i32, i32) -> i32
    %15 = "llvm.load"(%11) : (!llvm.ptr<i8>) -> i8
    %16 = "llvm.sext"(%15) : (i8) -> i32
    %17 = "llvm.xor"(%16, %14) : (i32, i32) -> i32
    %18 = "llvm.and"(%17, %1) : (i32, i32) -> i32
    %19 = "llvm.add"(%9, %0) : (i64, i64) -> i64
    %20 = "llvm.getelementptr"(%arg0, %19) : (!llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    %21 = "llvm.load"(%20) : (!llvm.ptr<i8>) -> i8
    %22 = "llvm.icmp"(%21, %6) {predicate = 0 : i64} : (i8, i8) -> i1
    "llvm.cond_br"(%22, %18, %19, %18)[^bb2, ^bb1] {operand_segment_sizes = dense<[1, 1, 2]> : vector<3xi32>} : (i1, i32, i64, i32) -> ()
  ^bb2(%23: i32):  // 2 preds: ^bb0, ^bb1
    "llvm.return"(%23) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "hash_string", type = !llvm.func<i32 (ptr<i8>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
