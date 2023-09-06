module  {
  llvm.mlir.global common @c(0 : i8) : i8
  llvm.mlir.global common @a(0 : i8) : i8
  llvm.mlir.global common @b(0 : i8) : i8
  llvm.func @func() {
    %0 = llvm.mlir.addressof @a : !llvm.ptr<i8>
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.addressof @a : !llvm.ptr<i8>
    %5 = llvm.mlir.addressof @b : !llvm.ptr<i8>
    %6 = llvm.mlir.constant(-1 : i32) : i32
    %7 = llvm.mlir.addressof @a : !llvm.ptr<i8>
    %8 = llvm.mlir.constant(1 : i32) : i32
    %9 = llvm.mlir.addressof @c : !llvm.ptr<i8>
    %10 = llvm.load %9 : !llvm.ptr<i8>
    %11 = llvm.zext %10 : i8 to i32
    %12 = llvm.or %11, %8  : i32
    %13 = llvm.trunc %12 : i32 to i8
    llvm.store %13, %7 : !llvm.ptr<i8>
    %14 = llvm.zext %13 : i8 to i32
    %15 = llvm.xor %14, %6  : i32
    %16 = llvm.and %8, %15  : i32
    %17 = llvm.trunc %16 : i32 to i8
    llvm.store %17, %5 : !llvm.ptr<i8>
    %18 = llvm.load %4 : !llvm.ptr<i8>
    %19 = llvm.zext %18 : i8 to i32
    %20 = llvm.zext %17 : i8 to i32
    %21 = llvm.icmp "ne" %19, %3 : i32
    llvm.cond_br %21, ^bb1, ^bb2(%2 : i1)
  ^bb1:  // pred: ^bb0
    %22 = llvm.icmp "ne" %20, %3 : i32
    llvm.br ^bb2(%22 : i1)
  ^bb2(%23: i1):  // 2 preds: ^bb0, ^bb1
    %24 = llvm.zext %23 : i1 to i32
    %25 = llvm.mul %1, %24  : i32
    %26 = llvm.trunc %25 : i32 to i8
    llvm.store %26, %0 : !llvm.ptr<i8>
    llvm.return
  }
}
