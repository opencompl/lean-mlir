module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @single(%arg0: i32) -> i8 {
    %0 = llvm.mlir.constant(-128 : i32) : i32
    %1 = llvm.mlir.constant(128 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.select %2, %1, %arg0 : i1, i32
    %4 = llvm.trunc %3 : i32 to i8
    llvm.return %4 : i8
  }
  llvm.func @double(%arg0: i32) -> i8 {
    %0 = llvm.mlir.constant(-128 : i32) : i32
    %1 = llvm.mlir.constant(128 : i32) : i32
    %2 = llvm.mlir.constant(127 : i32) : i32
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    %4 = llvm.select %3, %1, %arg0 : i1, i32
    %5 = llvm.icmp "sgt" %arg0, %2 : i32
    %6 = llvm.select %5, %2, %4 : i1, i32
    %7 = llvm.trunc %6 : i32 to i8
    llvm.return %7 : i8
  }
  llvm.func @thisdoesnotloop(%arg0: i32, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(-128 : i32) : i32
    %1 = llvm.mlir.constant(128 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.select %2, %1, %arg1 : i1, i32
    %4 = llvm.trunc %3 : i32 to i8
    llvm.return %4 : i8
  }
  llvm.func @original(%arg0: i32, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(127 : i32) : i32
    %1 = llvm.mlir.constant(-128 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "slt" %0, %arg0 : i32
    %4 = llvm.icmp "sle" %1, %arg0 : i32
    %5 = llvm.select %3, %0, %1 : i1, i32
    %6 = llvm.xor %3, %2  : i1
    %7 = llvm.and %4, %6  : i1
    %8 = llvm.select %7, %arg0, %5 : i1, i32
    %9 = llvm.trunc %8 : i32 to i8
    llvm.return %9 : i8
  }
  llvm.func @original_logical(%arg0: i32, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(127 : i32) : i32
    %1 = llvm.mlir.constant(-128 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.icmp "slt" %0, %arg0 : i32
    %5 = llvm.icmp "sle" %1, %arg0 : i32
    %6 = llvm.select %4, %0, %1 : i1, i32
    %7 = llvm.xor %4, %2  : i1
    %8 = llvm.select %5, %7, %3 : i1, i1
    %9 = llvm.select %8, %arg0, %6 : i1, i32
    %10 = llvm.trunc %9 : i32 to i8
    llvm.return %10 : i8
  }
  llvm.func @PR49205(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.undef : i32
    llvm.br ^bb1(%0 : i32)
  ^bb1(%4: i32):  // 2 preds: ^bb0, ^bb2
    llvm.cond_br %arg1, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %5 = llvm.add %arg0, %3  : i32
    %6 = llvm.add %5, %2 overflow<nsw>  : i32
    llvm.br ^bb1(%6 : i32)
  ^bb3:  // pred: ^bb1
    %7 = llvm.icmp "ne" %4, %1 : i32
    %8 = llvm.zext %7 : i1 to i32
    %9 = llvm.and %4, %8  : i32
    %10 = llvm.sub %4, %9  : i32
    %11 = llvm.icmp "ne" %10, %1 : i32
    %12 = llvm.zext %11 : i1 to i32
    %13 = llvm.sub %12, %10  : i32
    %14 = llvm.and %13, %2  : i32
    llvm.return %14 : i32
  }
}
