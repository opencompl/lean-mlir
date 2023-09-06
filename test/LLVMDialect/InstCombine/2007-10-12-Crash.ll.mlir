module  {
  llvm.func @_Z9ray_traceRK3VecRK3RayRK5Scene(!llvm.ptr<struct<"struct.Vec", (f64, f64, f64)>>, !llvm.ptr<struct<"struct.Ray", (struct<"struct.Vec", (f64, f64, f64)>, struct<"struct.Vec", (f64, f64, f64)>)>>, !llvm.ptr<struct<"struct.Scene", (ptr<ptr<func<i32 (...)>>>)>>) -> f64
  llvm.func @main(%arg0: i32, %arg1: !llvm.ptr<ptr<i8>>) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.null : !llvm.ptr<struct<"struct.Scene", (ptr<ptr<func<i32 (...)>>>)>>
    %2 = llvm.mlir.null : !llvm.ptr<struct<"struct.Vec", (f64, f64, f64)>>
    %3 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %4 = llvm.mlir.constant(512 : i32) : i32
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.alloca %6 x !llvm.struct<"struct.Ray", (struct<"struct.Vec", (f64, f64, f64)>, struct<"struct.Vec", (f64, f64, f64)>)> : (i32) -> !llvm.ptr<struct<"struct.Ray", (struct<"struct.Vec", (f64, f64, f64)>, struct<"struct.Vec", (f64, f64, f64)>)>>
    %8 = llvm.icmp "slt" %5, %4 : i32
    llvm.cond_br %8, ^bb4, ^bb6
  ^bb1:  // pred: ^bb2
    %9 = llvm.bitcast %7 : !llvm.ptr<struct<"struct.Ray", (struct<"struct.Vec", (f64, f64, f64)>, struct<"struct.Vec", (f64, f64, f64)>)>> to !llvm.ptr<struct<"struct.Vec", (f64, f64, f64)>>
    %10 = llvm.getelementptr %9[%5, %5] : (!llvm.ptr<struct<"struct.Vec", (f64, f64, f64)>>, i32, i32) -> !llvm.ptr<f64>
    llvm.store %3, %10 : !llvm.ptr<f64>
    %11 = llvm.call @_Z9ray_traceRK3VecRK3RayRK5Scene(%2, %7, %1) : (!llvm.ptr<struct<"struct.Vec", (f64, f64, f64)>>, !llvm.ptr<struct<"struct.Ray", (struct<"struct.Vec", (f64, f64, f64)>, struct<"struct.Vec", (f64, f64, f64)>)>>, !llvm.ptr<struct<"struct.Scene", (ptr<ptr<func<i32 (...)>>>)>>) -> f64
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb1, ^bb4
    %12 = llvm.icmp "slt" %5, %0 : i32
    llvm.cond_br %12, ^bb1, ^bb3
  ^bb3:  // pred: ^bb2
    llvm.return %5 : i32
  ^bb4:  // pred: ^bb0
    %13 = llvm.icmp "slt" %5, %0 : i32
    llvm.cond_br %13, ^bb2, ^bb5
  ^bb5:  // pred: ^bb4
    llvm.return %5 : i32
  ^bb6:  // pred: ^bb0
    llvm.return %5 : i32
  }
}
