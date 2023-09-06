module  {
  llvm.func @main() -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(2047 : i16) : i16
    %2 = llvm.mlir.constant(21 : i32) : i32
    %3 = llvm.mlir.constant(0x7FF0000000000000 : f64) : f64
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.alloca %5 x !llvm.struct<"struct..1anon", (f64)> : (i32) -> !llvm.ptr<struct<"struct..1anon", (f64)>>
    %7 = llvm.getelementptr %6[%4, %4] : (!llvm.ptr<struct<"struct..1anon", (f64)>>, i32, i32) -> !llvm.ptr<f64>
    llvm.store %3, %7 : !llvm.ptr<f64>
    %8 = llvm.getelementptr %6[%4, %4] : (!llvm.ptr<struct<"struct..1anon", (f64)>>, i32, i32) -> !llvm.ptr<f64>
    %9 = llvm.bitcast %8 : !llvm.ptr<f64> to !llvm.ptr<struct<"struct..0anon", (i32, i32)>>
    %10 = llvm.getelementptr %9[%4, %5] : (!llvm.ptr<struct<"struct..0anon", (i32, i32)>>, i32, i32) -> !llvm.ptr<i32>
    %11 = llvm.load %10 : !llvm.ptr<i32>
    %12 = llvm.shl %11, %5  : i32
    %13 = llvm.lshr %12, %2  : i32
    %14 = llvm.trunc %13 : i32 to i16
    %15 = llvm.icmp "ne" %14, %1 : i16
    %16 = llvm.zext %15 : i1 to i8
    %17 = llvm.icmp "ne" %16, %0 : i8
    llvm.cond_br %17, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %4 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %5 : i32
  }
}
