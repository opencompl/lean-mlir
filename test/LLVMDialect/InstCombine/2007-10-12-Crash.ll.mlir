"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "_Z9ray_traceRK3VecRK3RayRK5Scene", type = !llvm.func<f64 (ptr<struct<"struct.Vec", (f64, f64, f64)>>, ptr<struct<"struct.Ray", (struct<"struct.Vec", (f64, f64, f64)>, struct<"struct.Vec", (f64, f64, f64)>)>>, ptr<struct<"struct.Scene", (ptr<ptr<func<i32 (...)>>>)>>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: !llvm.ptr<ptr<i8>>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 4 : i32} : () -> i32
    %1 = "llvm.mlir.null"() : () -> !llvm.ptr<struct<"struct.Scene", (ptr<ptr<func<i32 (...)>>>)>>
    %2 = "llvm.mlir.null"() : () -> !llvm.ptr<struct<"struct.Vec", (f64, f64, f64)>>
    %3 = "llvm.mlir.constant"() {value = 0.000000e+00 : f64} : () -> f64
    %4 = "llvm.mlir.constant"() {value = 512 : i32} : () -> i32
    %5 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %6 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %7 = "llvm.alloca"(%6) : (i32) -> !llvm.ptr<struct<"struct.Ray", (struct<"struct.Vec", (f64, f64, f64)>, struct<"struct.Vec", (f64, f64, f64)>)>>
    %8 = "llvm.icmp"(%5, %4) {predicate = 2 : i64} : (i32, i32) -> i1
    "llvm.cond_br"(%8)[^bb4, ^bb6] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb1:  // pred: ^bb2
    %9 = "llvm.bitcast"(%7) : (!llvm.ptr<struct<"struct.Ray", (struct<"struct.Vec", (f64, f64, f64)>, struct<"struct.Vec", (f64, f64, f64)>)>>) -> !llvm.ptr<struct<"struct.Vec", (f64, f64, f64)>>
    %10 = "llvm.getelementptr"(%9, %5, %5) : (!llvm.ptr<struct<"struct.Vec", (f64, f64, f64)>>, i32, i32) -> !llvm.ptr<f64>
    "llvm.store"(%3, %10) : (f64, !llvm.ptr<f64>) -> ()
    %11 = "llvm.call"(%2, %7, %1) {callee = @_Z9ray_traceRK3VecRK3RayRK5Scene, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<struct<"struct.Vec", (f64, f64, f64)>>, !llvm.ptr<struct<"struct.Ray", (struct<"struct.Vec", (f64, f64, f64)>, struct<"struct.Vec", (f64, f64, f64)>)>>, !llvm.ptr<struct<"struct.Scene", (ptr<ptr<func<i32 (...)>>>)>>) -> f64
    "llvm.br"()[^bb2] : () -> ()
  ^bb2:  // 2 preds: ^bb1, ^bb4
    %12 = "llvm.icmp"(%5, %0) {predicate = 2 : i64} : (i32, i32) -> i1
    "llvm.cond_br"(%12)[^bb1, ^bb3] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb3:  // pred: ^bb2
    "llvm.return"(%5) : (i32) -> ()
  ^bb4:  // pred: ^bb0
    %13 = "llvm.icmp"(%5, %0) {predicate = 2 : i64} : (i32, i32) -> i1
    "llvm.cond_br"(%13)[^bb2, ^bb5] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb5:  // pred: ^bb4
    "llvm.return"(%5) : (i32) -> ()
  ^bb6:  // pred: ^bb0
    "llvm.return"(%5) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "main", type = !llvm.func<i32 (i32, ptr<ptr<i8>>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
