module  {
  llvm.mlir.global weak @p() : !llvm.ptr<i8> {
    %0 = llvm.mlir.null : !llvm.ptr<i8>
    llvm.return %0 : !llvm.ptr<i8>
  }
  llvm.func @main() -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(999999 : i32) : i32
    %2 = llvm.mlir.addressof @p : !llvm.ptr<ptr<i8>>
    %3 = llvm.mlir.constant(4 : i32) : i32
    %4 = llvm.mlir.constant(32 : i64) : i64
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.mlir.constant(47 : i32) : i32
    %7 = llvm.mlir.constant(0 : i32) : i32
    %8 = llvm.bitcast %7 : i32 to i32
    llvm.br ^bb1(%7 : i32)
  ^bb1(%9: i32):  // 2 preds: ^bb0, ^bb3
    %10 = llvm.call @llvm.stacksave() : () -> !llvm.ptr<i8>
    %11 = llvm.srem %9, %6  : i32
    %12 = llvm.add %11, %5  : i32
    %13 = llvm.sub %12, %5  : i32
    %14 = llvm.zext %12 : i32 to i64
    %15 = llvm.mul %14, %4  : i64
    %16 = llvm.mul %12, %3  : i32
    %17 = llvm.zext %12 : i32 to i64
    %18 = llvm.mul %17, %4  : i64
    %19 = llvm.mul %12, %3  : i32
    %20 = llvm.alloca %19 x i8 : (i32) -> !llvm.ptr<i8>
    %21 = llvm.bitcast %20 : !llvm.ptr<i8> to !llvm.ptr<i32>
    %22 = llvm.getelementptr %21[%7] : (!llvm.ptr<i32>, i32) -> !llvm.ptr<i32>
    llvm.store %5, %22 : !llvm.ptr<i32>
    %23 = llvm.bitcast %21 : !llvm.ptr<i32> to !llvm.ptr<i8>
    llvm.store %23, %2 : !llvm.ptr<ptr<i8>>
    %24 = llvm.add %9, %5  : i32
    %25 = llvm.icmp "sle" %24, %1 : i32
    %26 = llvm.zext %25 : i1 to i8
    %27 = llvm.icmp "ne" %26, %0 : i8
    llvm.cond_br %27, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    llvm.call @llvm.stackrestore(%10) : (!llvm.ptr<i8>) -> ()
    llvm.return %7 : i32
  ^bb3:  // pred: ^bb1
    llvm.call @llvm.stackrestore(%10) : (!llvm.ptr<i8>) -> ()
    llvm.br ^bb1(%24 : i32)
  }
  llvm.func @llvm.stacksave() -> !llvm.ptr<i8>
  llvm.func @llvm.stackrestore(!llvm.ptr<i8>)
}
