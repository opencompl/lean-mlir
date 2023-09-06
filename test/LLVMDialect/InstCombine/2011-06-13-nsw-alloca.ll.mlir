module  {
  llvm.func @fu1(%arg0: i32) {
    %0 = llvm.mlir.constant(2048 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.null : !llvm.ptr<f64>
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.alloca %4 x i32 : (i32) -> !llvm.ptr<i32>
    %6 = llvm.alloca %4 x !llvm.ptr<f64> : (i32) -> !llvm.ptr<ptr<f64>>
    llvm.store %arg0, %5 : !llvm.ptr<i32>
    llvm.store %3, %6 : !llvm.ptr<ptr<f64>>
    %7 = llvm.load %5 : !llvm.ptr<i32>
    %8 = llvm.icmp "ne" %7, %2 : i32
    llvm.cond_br %8, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %9 = llvm.load %5 : !llvm.ptr<i32>
    %10 = llvm.shl %9, %1  : i32
    %11 = llvm.add %10, %0  : i32
    %12 = llvm.alloca %11 x i8 : (i32) -> !llvm.ptr<i8>
    %13 = llvm.bitcast %12 : !llvm.ptr<i8> to !llvm.ptr<f64>
    llvm.store %13, %6 : !llvm.ptr<ptr<f64>>
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    %14 = llvm.load %6 : !llvm.ptr<ptr<f64>>
    llvm.call @bar(%14) : (!llvm.ptr<f64>) -> ()
    llvm.return
  }
  llvm.func @bar(!llvm.ptr<f64>)
  llvm.func @fu2(%arg0: i32) {
    %0 = llvm.mlir.constant(2048 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.null : !llvm.ptr<f64>
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.alloca %4 x i32 : (i32) -> !llvm.ptr<i32>
    %6 = llvm.alloca %4 x !llvm.ptr<f64> : (i32) -> !llvm.ptr<ptr<f64>>
    llvm.store %arg0, %5 : !llvm.ptr<i32>
    llvm.store %3, %6 : !llvm.ptr<ptr<f64>>
    %7 = llvm.load %5 : !llvm.ptr<i32>
    %8 = llvm.icmp "ne" %7, %2 : i32
    llvm.cond_br %8, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %9 = llvm.load %5 : !llvm.ptr<i32>
    %10 = llvm.mul %9, %1  : i32
    %11 = llvm.add %10, %0  : i32
    %12 = llvm.alloca %11 x i8 : (i32) -> !llvm.ptr<i8>
    %13 = llvm.bitcast %12 : !llvm.ptr<i8> to !llvm.ptr<f64>
    llvm.store %13, %6 : !llvm.ptr<ptr<f64>>
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    %14 = llvm.load %6 : !llvm.ptr<ptr<f64>>
    llvm.call @bar(%14) : (!llvm.ptr<f64>) -> ()
    llvm.return
  }
}
