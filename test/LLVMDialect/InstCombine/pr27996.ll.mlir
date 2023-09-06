module  {
  llvm.mlir.global external constant @i(1 : i32) : i32
  llvm.mlir.global external constant @f(1.100000e+00 : f32) : f32
  llvm.mlir.global common @cmp(0 : i32) : i32
  llvm.mlir.global common @resf() : !llvm.ptr<f32> {
    %0 = llvm.mlir.null : !llvm.ptr<f32>
    llvm.return %0 : !llvm.ptr<f32>
  }
  llvm.mlir.global common @resi() : !llvm.ptr<i32> {
    %0 = llvm.mlir.null : !llvm.ptr<i32>
    llvm.return %0 : !llvm.ptr<i32>
  }
  llvm.func @foo() -> i32 {
    %0 = llvm.mlir.addressof @resi : !llvm.ptr<ptr<i32>>
    %1 = llvm.mlir.addressof @resf : !llvm.ptr<ptr<f32>>
    %2 = llvm.mlir.addressof @f : !llvm.ptr<f32>
    %3 = llvm.bitcast %2 : !llvm.ptr<f32> to !llvm.ptr<i32>
    %4 = llvm.mlir.addressof @i : !llvm.ptr<i32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.mlir.addressof @cmp : !llvm.ptr<i32>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.mlir.addressof @cmp : !llvm.ptr<i32>
    %9 = llvm.mlir.null : !llvm.ptr<i32>
    llvm.br ^bb1(%9 : !llvm.ptr<i32>)
  ^bb1(%10: !llvm.ptr<i32>):  // 3 preds: ^bb0, ^bb3, ^bb4
    %11 = llvm.load %8 : !llvm.ptr<i32>
    %12 = llvm.ashr %11, %7  : i32
    llvm.store %12, %6 : !llvm.ptr<i32>
    %13 = llvm.icmp "ne" %12, %5 : i32
    llvm.cond_br %13, ^bb2, ^bb5
  ^bb2:  // pred: ^bb1
    %14 = llvm.and %12, %7  : i32
    %15 = llvm.icmp "ne" %14, %5 : i32
    llvm.cond_br %15, ^bb3, ^bb4
  ^bb3:  // pred: ^bb2
    llvm.br ^bb1(%4 : !llvm.ptr<i32>)
  ^bb4:  // pred: ^bb2
    llvm.br ^bb1(%3 : !llvm.ptr<i32>)
  ^bb5:  // pred: ^bb1
    %16 = llvm.bitcast %10 : !llvm.ptr<i32> to !llvm.ptr<f32>
    llvm.store %16, %1 : !llvm.ptr<ptr<f32>>
    llvm.store %10, %0 : !llvm.ptr<ptr<i32>>
    llvm.return %5 : i32
  }
}
