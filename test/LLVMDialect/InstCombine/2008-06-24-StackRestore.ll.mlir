module  {
  llvm.mlir.global weak @p() : !llvm.ptr<i8> {
    %0 = llvm.mlir.null : !llvm.ptr<i8>
    llvm.return %0 : !llvm.ptr<i8>
  }
  llvm.func @main() -> i32 {
    %0 = llvm.mlir.constant(999999 : i32) : i32
    %1 = llvm.mlir.addressof @p : !llvm.ptr<ptr<i8>>
    %2 = llvm.mlir.constant(1000 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.addressof @p : !llvm.ptr<ptr<i8>>
    %5 = llvm.mlir.constant(2 : i32) : i32
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.call @llvm.stacksave() : () -> !llvm.ptr<i8>
    %8 = llvm.alloca %6 x i32 : (i32) -> !llvm.ptr<i32>
    %9 = llvm.bitcast %8 : !llvm.ptr<i32> to !llvm.ptr<i8>
    llvm.store %5, %8 : !llvm.ptr<i32>
    llvm.store %9, %4 : !llvm.ptr<ptr<i8>>
    llvm.br ^bb2(%3, %7 : i32, !llvm.ptr<i8>)
  ^bb1:  // pred: ^bb2
    llvm.return %3 : i32
  ^bb2(%10: i32, %11: !llvm.ptr<i8>):  // 2 preds: ^bb0, ^bb2
    %12 = llvm.add %10, %6  : i32
    llvm.call @llvm.stackrestore(%11) : (!llvm.ptr<i8>) -> ()
    %13 = llvm.call @llvm.stacksave() : () -> !llvm.ptr<i8>
    %14 = llvm.srem %12, %2  : i32
    %15 = llvm.add %14, %6  : i32
    %16 = llvm.alloca %15 x i32 : (i32) -> !llvm.ptr<i32>
    %17 = llvm.bitcast %16 : !llvm.ptr<i32> to !llvm.ptr<i8>
    llvm.store %6, %16 : !llvm.ptr<i32>
    %18 = llvm.getelementptr %16[%14] : (!llvm.ptr<i32>, i32) -> !llvm.ptr<i32>
    llvm.store %5, %18 : !llvm.ptr<i32>
    llvm.store %17, %1 : !llvm.ptr<ptr<i8>>
    %19 = llvm.icmp "eq" %12, %0 : i32
    llvm.cond_br %19, ^bb1, ^bb2(%12, %13 : i32, !llvm.ptr<i8>)
  }
  llvm.func @llvm.stacksave() -> !llvm.ptr<i8>
  llvm.func @llvm.stackrestore(!llvm.ptr<i8>)
}
