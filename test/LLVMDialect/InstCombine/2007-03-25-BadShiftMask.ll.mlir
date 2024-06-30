"module"() ( {
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 0 : i8} : () -> i8
    %1 = "llvm.mlir.constant"() {value = 2047 : i16} : () -> i16
    %2 = "llvm.mlir.constant"() {value = 21 : i32} : () -> i32
    %3 = "llvm.mlir.constant"() {value = 0x7FF0000000000000 : f64} : () -> f64
    %4 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %5 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %6 = "llvm.alloca"(%5) : (i32) -> !llvm.ptr<struct<"struct..1anon", (f64)>>
    %7 = "llvm.getelementptr"(%6, %4, %4) : (!llvm.ptr<struct<"struct..1anon", (f64)>>, i32, i32) -> !llvm.ptr<f64>
    "llvm.store"(%3, %7) : (f64, !llvm.ptr<f64>) -> ()
    %8 = "llvm.getelementptr"(%6, %4, %4) : (!llvm.ptr<struct<"struct..1anon", (f64)>>, i32, i32) -> !llvm.ptr<f64>
    %9 = "llvm.bitcast"(%8) : (!llvm.ptr<f64>) -> !llvm.ptr<struct<"struct..0anon", (i32, i32)>>
    %10 = "llvm.getelementptr"(%9, %4, %5) : (!llvm.ptr<struct<"struct..0anon", (i32, i32)>>, i32, i32) -> !llvm.ptr<i32>
    %11 = "llvm.load"(%10) : (!llvm.ptr<i32>) -> i32
    %12 = "llvm.shl"(%11, %5) : (i32, i32) -> i32
    %13 = "llvm.lshr"(%12, %2) : (i32, i32) -> i32
    %14 = "llvm.trunc"(%13) : (i32) -> i16
    %15 = "llvm.icmp"(%14, %1) {predicate = 1 : i64} : (i16, i16) -> i1
    %16 = "llvm.zext"(%15) : (i1) -> i8
    %17 = "llvm.icmp"(%16, %0) {predicate = 1 : i64} : (i8, i8) -> i1
    "llvm.cond_br"(%17)[^bb1, ^bb2] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb1:  // pred: ^bb0
    "llvm.return"(%4) : (i32) -> ()
  ^bb2:  // pred: ^bb0
    "llvm.return"(%5) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "main", type = !llvm.func<i32 ()>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
