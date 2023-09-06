module  {
  llvm.func @visible(%arg0: i32, %arg1: i64, %arg2: i64, %arg3: i64) -> i32 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.alloca %2 x !llvm.struct<"struct.point", (i32, i32)> : (i32) -> !llvm.ptr<struct<"struct.point", (i32, i32)>>
    %4 = llvm.alloca %2 x !llvm.struct<"struct.point", (i32, i32)> : (i32) -> !llvm.ptr<struct<"struct.point", (i32, i32)>>
    %5 = llvm.alloca %2 x !llvm.struct<"struct.point", (i32, i32)> : (i32) -> !llvm.ptr<struct<"struct.point", (i32, i32)>>
    %6 = llvm.bitcast %1 : i32 to i32
    %7 = llvm.bitcast %3 : !llvm.ptr<struct<"struct.point", (i32, i32)>> to !llvm.ptr<struct<(i64)>>
    %8 = llvm.getelementptr %7[%0, %1] : (!llvm.ptr<struct<(i64)>>, i64, i32) -> !llvm.ptr<i64>
    llvm.store %arg1, %8 : !llvm.ptr<i64>
    %9 = llvm.bitcast %4 : !llvm.ptr<struct<"struct.point", (i32, i32)>> to !llvm.ptr<struct<(i64)>>
    %10 = llvm.getelementptr %9[%0, %1] : (!llvm.ptr<struct<(i64)>>, i64, i32) -> !llvm.ptr<i64>
    llvm.store %arg2, %10 : !llvm.ptr<i64>
    %11 = llvm.bitcast %5 : !llvm.ptr<struct<"struct.point", (i32, i32)>> to !llvm.ptr<struct<(i64)>>
    %12 = llvm.getelementptr %11[%0, %1] : (!llvm.ptr<struct<(i64)>>, i64, i32) -> !llvm.ptr<i64>
    llvm.store %arg3, %12 : !llvm.ptr<i64>
    %13 = llvm.icmp "eq" %arg0, %1 : i32
    %14 = llvm.bitcast %3 : !llvm.ptr<struct<"struct.point", (i32, i32)>> to !llvm.ptr<struct<(i64)>>
    %15 = llvm.getelementptr %14[%0, %1] : (!llvm.ptr<struct<(i64)>>, i64, i32) -> !llvm.ptr<i64>
    %16 = llvm.load %15 : !llvm.ptr<i64>
    %17 = llvm.bitcast %4 : !llvm.ptr<struct<"struct.point", (i32, i32)>> to !llvm.ptr<struct<(i64)>>
    %18 = llvm.getelementptr %17[%0, %1] : (!llvm.ptr<struct<(i64)>>, i64, i32) -> !llvm.ptr<i64>
    %19 = llvm.load %18 : !llvm.ptr<i64>
    %20 = llvm.bitcast %5 : !llvm.ptr<struct<"struct.point", (i32, i32)>> to !llvm.ptr<struct<(i64)>>
    %21 = llvm.getelementptr %20[%0, %1] : (!llvm.ptr<struct<(i64)>>, i64, i32) -> !llvm.ptr<i64>
    %22 = llvm.load %21 : !llvm.ptr<i64>
    %23 = llvm.call @determinant(%16, %19, %22) : (i64, i64, i64) -> i32
    llvm.cond_br %13, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %24 = llvm.icmp "slt" %23, %1 : i32
    %25 = llvm.zext %24 : i1 to i32
    llvm.br ^bb3(%25 : i32)
  ^bb2:  // pred: ^bb0
    %26 = llvm.icmp "sgt" %23, %1 : i32
    %27 = llvm.zext %26 : i1 to i32
    llvm.br ^bb3(%27 : i32)
  ^bb3(%28: i32):  // 2 preds: ^bb1, ^bb2
    llvm.return %28 : i32
  }
  llvm.func @determinant(i64, i64, i64) -> i32
}
