"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i64, %arg2: i64, %arg3: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %3 = "llvm.alloca"(%2) : (i32) -> !llvm.ptr<struct<"struct.point", (i32, i32)>>
    %4 = "llvm.alloca"(%2) : (i32) -> !llvm.ptr<struct<"struct.point", (i32, i32)>>
    %5 = "llvm.alloca"(%2) : (i32) -> !llvm.ptr<struct<"struct.point", (i32, i32)>>
    %6 = "llvm.bitcast"(%1) : (i32) -> i32
    %7 = "llvm.bitcast"(%3) : (!llvm.ptr<struct<"struct.point", (i32, i32)>>) -> !llvm.ptr<struct<(i64)>>
    %8 = "llvm.getelementptr"(%7, %0, %1) : (!llvm.ptr<struct<(i64)>>, i64, i32) -> !llvm.ptr<i64>
    "llvm.store"(%arg1, %8) : (i64, !llvm.ptr<i64>) -> ()
    %9 = "llvm.bitcast"(%4) : (!llvm.ptr<struct<"struct.point", (i32, i32)>>) -> !llvm.ptr<struct<(i64)>>
    %10 = "llvm.getelementptr"(%9, %0, %1) : (!llvm.ptr<struct<(i64)>>, i64, i32) -> !llvm.ptr<i64>
    "llvm.store"(%arg2, %10) : (i64, !llvm.ptr<i64>) -> ()
    %11 = "llvm.bitcast"(%5) : (!llvm.ptr<struct<"struct.point", (i32, i32)>>) -> !llvm.ptr<struct<(i64)>>
    %12 = "llvm.getelementptr"(%11, %0, %1) : (!llvm.ptr<struct<(i64)>>, i64, i32) -> !llvm.ptr<i64>
    "llvm.store"(%arg3, %12) : (i64, !llvm.ptr<i64>) -> ()
    %13 = "llvm.icmp"(%arg0, %1) {predicate = 0 : i64} : (i32, i32) -> i1
    %14 = "llvm.bitcast"(%3) : (!llvm.ptr<struct<"struct.point", (i32, i32)>>) -> !llvm.ptr<struct<(i64)>>
    %15 = "llvm.getelementptr"(%14, %0, %1) : (!llvm.ptr<struct<(i64)>>, i64, i32) -> !llvm.ptr<i64>
    %16 = "llvm.load"(%15) : (!llvm.ptr<i64>) -> i64
    %17 = "llvm.bitcast"(%4) : (!llvm.ptr<struct<"struct.point", (i32, i32)>>) -> !llvm.ptr<struct<(i64)>>
    %18 = "llvm.getelementptr"(%17, %0, %1) : (!llvm.ptr<struct<(i64)>>, i64, i32) -> !llvm.ptr<i64>
    %19 = "llvm.load"(%18) : (!llvm.ptr<i64>) -> i64
    %20 = "llvm.bitcast"(%5) : (!llvm.ptr<struct<"struct.point", (i32, i32)>>) -> !llvm.ptr<struct<(i64)>>
    %21 = "llvm.getelementptr"(%20, %0, %1) : (!llvm.ptr<struct<(i64)>>, i64, i32) -> !llvm.ptr<i64>
    %22 = "llvm.load"(%21) : (!llvm.ptr<i64>) -> i64
    %23 = "llvm.call"(%16, %19, %22) {callee = @determinant, fastmathFlags = #llvm.fastmath<>} : (i64, i64, i64) -> i32
    "llvm.cond_br"(%13)[^bb1, ^bb2] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb1:  // pred: ^bb0
    %24 = "llvm.icmp"(%23, %1) {predicate = 2 : i64} : (i32, i32) -> i1
    %25 = "llvm.zext"(%24) : (i1) -> i32
    "llvm.br"(%25)[^bb3] : (i32) -> ()
  ^bb2:  // pred: ^bb0
    %26 = "llvm.icmp"(%23, %1) {predicate = 4 : i64} : (i32, i32) -> i1
    %27 = "llvm.zext"(%26) : (i1) -> i32
    "llvm.br"(%27)[^bb3] : (i32) -> ()
  ^bb3(%28: i32):  // 2 preds: ^bb1, ^bb2
    "llvm.return"(%28) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "visible", type = !llvm.func<i32 (i32, i64, i64, i64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "determinant", type = !llvm.func<i32 (i64, i64, i64)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
