module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @glob() {addr_space = 0 : i32} : i16
  llvm.func @sterix(%arg0: i32, %arg1: i8, %arg2: i64) -> i32 {
    %0 = llvm.mlir.constant(1945964878 : i32) : i32
    %1 = llvm.mlir.constant(4294967295 : i64) : i64
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.zext %arg0 : i32 to i64
    %5 = llvm.sext %arg1 : i8 to i32
    %6 = llvm.mul %5, %0  : i32
    %7 = llvm.trunc %arg2 : i64 to i32
    %8 = llvm.lshr %6, %7  : i32
    %9 = llvm.zext %8 : i32 to i64
    %10 = llvm.mul %4, %9 overflow<nsw, nuw>  : i64
    %11 = llvm.and %10, %1  : i64
    %12 = llvm.icmp "ne" %11, %10 : i64
    llvm.cond_br %12, ^bb2(%2 : i1), ^bb1
  ^bb1:  // pred: ^bb0
    %13 = llvm.and %arg2, %10  : i64
    %14 = llvm.trunc %13 : i64 to i32
    %15 = llvm.icmp "ne" %14, %3 : i32
    %16 = llvm.xor %15, %2  : i1
    llvm.br ^bb2(%16 : i1)
  ^bb2(%17: i1):  // 2 preds: ^bb0, ^bb1
    %18 = llvm.zext %17 : i1 to i32
    llvm.return %18 : i32
  }
  llvm.func @PR33765(%arg0: i8) {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.addressof @glob : !llvm.ptr
    %2 = llvm.zext %arg0 : i8 to i32
    %3 = llvm.mul %2, %2 overflow<nsw, nuw>  : i32
    %4 = llvm.and %3, %0  : i32
    %5 = llvm.icmp "ne" %3, %4 : i32
    llvm.cond_br %5, ^bb1, ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb0
    %6 = llvm.load %1 {alignment = 2 : i64} : !llvm.ptr -> i16
    %7 = llvm.sext %6 : i16 to i32
    %8 = llvm.and %3, %7  : i32
    %9 = llvm.trunc %8 : i32 to i16
    llvm.store %9, %1 {alignment = 2 : i64} : i16, !llvm.ptr
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
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2(%0 : i32)
  ^bb1:  // pred: ^bb0
    %2 = llvm.trunc %arg3 : i8 to i1
    %3 = llvm.zext %arg1 : i1 to i32
    %4 = llvm.zext %arg2 : i1 to i32
    %5 = llvm.zext %2 : i1 to i32
    %6 = llvm.mul %3, %4  : i32
    %7 = llvm.xor %6, %5  : i32
    llvm.br ^bb2(%7 : i32)
  ^bb2(%8: i32):  // 2 preds: ^bb0, ^bb1
    %9 = llvm.icmp "eq" %8, %1 : i32
    llvm.return %9 : i1
  }
}
