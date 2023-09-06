module  {
  llvm.mlir.global external @glob() : i16
  llvm.func @sterix(%arg0: i32, %arg1: i8, %arg2: i64) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.constant(4294967295 : i64) : i64
    %3 = llvm.mlir.constant(1945964878 : i32) : i32
    %4 = llvm.zext %arg0 : i32 to i64
    %5 = llvm.sext %arg1 : i8 to i32
    %6 = llvm.mul %5, %3  : i32
    %7 = llvm.trunc %arg2 : i64 to i32
    %8 = llvm.lshr %6, %7  : i32
    %9 = llvm.zext %8 : i32 to i64
    %10 = llvm.mul %4, %9  : i64
    %11 = llvm.and %10, %2  : i64
    %12 = llvm.icmp "ne" %11, %10 : i64
    llvm.cond_br %12, ^bb2(%1 : i1), ^bb1
  ^bb1:  // pred: ^bb0
    %13 = llvm.and %arg2, %10  : i64
    %14 = llvm.trunc %13 : i64 to i32
    %15 = llvm.icmp "ne" %14, %0 : i32
    %16 = llvm.xor %15, %1  : i1
    llvm.br ^bb2(%16 : i1)
  ^bb2(%17: i1):  // 2 preds: ^bb0, ^bb1
    %18 = llvm.zext %17 : i1 to i32
    llvm.return %18 : i32
  }
  llvm.func @PR33765(%arg0: i8) {
    %0 = llvm.mlir.addressof @glob : !llvm.ptr<i16>
    %1 = llvm.mlir.addressof @glob : !llvm.ptr<i16>
    %2 = llvm.mlir.constant(255 : i32) : i32
    %3 = llvm.zext %arg0 : i8 to i32
    %4 = llvm.mul %3, %3  : i32
    %5 = llvm.and %4, %2  : i32
    %6 = llvm.icmp "ne" %4, %5 : i32
    llvm.cond_br %6, ^bb1, ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb0
    %7 = llvm.load %1 : !llvm.ptr<i16>
    %8 = llvm.sext %7 : i16 to i32
    %9 = llvm.and %4, %8  : i32
    %10 = llvm.trunc %9 : i32 to i16
    llvm.store %10, %0 : !llvm.ptr<i16>
    llvm.return
  }
  llvm.func @aux(i8) -> i16
  llvm.func @iter_breaker(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(65535 : i32) : i32
    %1 = llvm.zext %arg0 : i16 to i32
    %2 = llvm.zext %arg1 : i16 to i32
    %3 = llvm.mul %1, %2  : i32
    %4 = llvm.trunc %3 : i32 to i8
    %5 = llvm.trunc %3 : i32 to i16
    %6 = llvm.icmp "ugt" %3, %0 : i32
    llvm.cond_br %6, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %7 = llvm.call @aux(%4) : (i8) -> i16
    llvm.return %7 : i16
  ^bb2:  // pred: ^bb0
    llvm.return %5 : i16
  }
  llvm.func @PR46561(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2(%1 : i32)
  ^bb1:  // pred: ^bb0
    %2 = llvm.trunc %arg3 : i8 to i1
    %3 = llvm.zext %arg1 : i1 to i32
    %4 = llvm.zext %arg2 : i1 to i32
    %5 = llvm.zext %2 : i1 to i32
    %6 = llvm.mul %3, %4  : i32
    %7 = llvm.xor %6, %5  : i32
    llvm.br ^bb2(%7 : i32)
  ^bb2(%8: i32):  // 2 preds: ^bb0, ^bb1
    %9 = llvm.icmp "eq" %8, %0 : i32
    llvm.return %9 : i1
  }
}
