module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @bit_ceil_32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.add %arg0, %0  : i32
    %4 = "llvm.intr.ctlz"(%3) <{is_zero_poison = false}> : (i32) -> i32
    %5 = llvm.sub %1, %4  : i32
    %6 = llvm.shl %2, %5  : i32
    %7 = llvm.icmp "ugt" %arg0, %2 : i32
    %8 = llvm.select %7, %6, %2 : i1, i32
    llvm.return %8 : i32
  }
  llvm.func @bit_ceil_64(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.mlir.constant(64 : i64) : i64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.add %arg0, %0  : i64
    %4 = "llvm.intr.ctlz"(%3) <{is_zero_poison = false}> : (i64) -> i64
    %5 = llvm.sub %1, %4  : i64
    %6 = llvm.shl %2, %5  : i64
    %7 = llvm.icmp "ugt" %arg0, %2 : i64
    %8 = llvm.select %7, %6, %2 : i1, i64
    llvm.return %8 : i64
  }
  llvm.func @bit_ceil_32_minus_1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(-3 : i32) : i32
    %4 = llvm.add %arg0, %0  : i32
    %5 = "llvm.intr.ctlz"(%4) <{is_zero_poison = false}> : (i32) -> i32
    %6 = llvm.sub %1, %5 overflow<nsw, nuw>  : i32
    %7 = llvm.shl %2, %6 overflow<nuw>  : i32
    %8 = llvm.add %arg0, %3  : i32
    %9 = llvm.icmp "ult" %8, %0 : i32
    %10 = llvm.select %9, %7, %2 : i1, i32
    llvm.return %10 : i32
  }
  llvm.func @bit_ceil_32_plus_1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.mlir.constant(-2 : i32) : i32
    %4 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = false}> : (i32) -> i32
    %5 = llvm.sub %0, %4  : i32
    %6 = llvm.shl %1, %5  : i32
    %7 = llvm.add %arg0, %2  : i32
    %8 = llvm.icmp "ult" %7, %3 : i32
    %9 = llvm.select %8, %6, %1 : i1, i32
    llvm.return %9 : i32
  }
  llvm.func @bit_ceil_plus_2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.mlir.constant(-2 : i32) : i32
    %3 = llvm.add %arg0, %0  : i32
    %4 = "llvm.intr.ctlz"(%3) <{is_zero_poison = false}> : (i32) -> i32
    %5 = llvm.sub %1, %4 overflow<nsw, nuw>  : i32
    %6 = llvm.shl %0, %5 overflow<nuw>  : i32
    %7 = llvm.icmp "ult" %arg0, %2 : i32
    %8 = llvm.select %7, %6, %0 : i1, i32
    llvm.return %8 : i32
  }
  llvm.func @bit_ceil_32_neg(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(-2 : i32) : i32
    %4 = llvm.xor %arg0, %0  : i32
    %5 = "llvm.intr.ctlz"(%4) <{is_zero_poison = false}> : (i32) -> i32
    %6 = llvm.sub %1, %5 overflow<nsw, nuw>  : i32
    %7 = llvm.shl %2, %6 overflow<nuw>  : i32
    %8 = llvm.add %arg0, %0  : i32
    %9 = llvm.icmp "ult" %8, %3 : i32
    %10 = llvm.select %9, %7, %2 : i1, i32
    llvm.return %10 : i32
  }
  llvm.func @bit_ceil_not(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.sub %0, %arg0  : i32
    %4 = "llvm.intr.ctlz"(%3) <{is_zero_poison = false}> : (i32) -> i32
    %5 = llvm.sub %1, %4 overflow<nsw, nuw>  : i32
    %6 = llvm.shl %2, %5 overflow<nuw>  : i32
    %7 = llvm.icmp "ult" %arg0, %0 : i32
    %8 = llvm.select %7, %6, %2 : i1, i32
    llvm.return %8 : i32
  }
  llvm.func @bit_ceil_commuted_operands(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.add %arg0, %0  : i32
    %5 = "llvm.intr.ctlz"(%4) <{is_zero_poison = false}> : (i32) -> i32
    %6 = llvm.sub %1, %5  : i32
    %7 = llvm.shl %2, %6  : i32
    %8 = llvm.icmp "eq" %4, %3 : i32
    %9 = llvm.select %8, %2, %7 : i1, i32
    llvm.return %9 : i32
  }
  llvm.func @bit_ceil_wrong_select_constant(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.add %arg0, %0  : i32
    %5 = "llvm.intr.ctlz"(%4) <{is_zero_poison = false}> : (i32) -> i32
    %6 = llvm.sub %1, %5  : i32
    %7 = llvm.shl %2, %6  : i32
    %8 = llvm.icmp "ugt" %arg0, %2 : i32
    %9 = llvm.select %8, %7, %3 : i1, i32
    llvm.return %9 : i32
  }
  llvm.func @bit_ceil_32_wrong_cond(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.add %arg0, %0  : i32
    %5 = "llvm.intr.ctlz"(%4) <{is_zero_poison = false}> : (i32) -> i32
    %6 = llvm.sub %1, %5  : i32
    %7 = llvm.shl %2, %6  : i32
    %8 = llvm.icmp "ugt" %arg0, %3 : i32
    %9 = llvm.select %8, %7, %2 : i1, i32
    llvm.return %9 : i32
  }
  llvm.func @bit_ceil_wrong_sub_constant(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(33 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.add %arg0, %0  : i32
    %4 = "llvm.intr.ctlz"(%3) <{is_zero_poison = false}> : (i32) -> i32
    %5 = llvm.sub %1, %4  : i32
    %6 = llvm.shl %2, %5  : i32
    %7 = llvm.icmp "ugt" %arg0, %2 : i32
    %8 = llvm.select %7, %6, %2 : i1, i32
    llvm.return %8 : i32
  }
  llvm.func @bit_ceil_32_shl_used_twice(%arg0: i32, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.add %arg0, %0  : i32
    %4 = "llvm.intr.ctlz"(%3) <{is_zero_poison = false}> : (i32) -> i32
    %5 = llvm.sub %1, %4  : i32
    %6 = llvm.shl %2, %5  : i32
    %7 = llvm.icmp "ugt" %arg0, %2 : i32
    %8 = llvm.select %7, %6, %2 : i1, i32
    llvm.store %6, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return %8 : i32
  }
  llvm.func @bit_ceil_32_sub_used_twice(%arg0: i32, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.add %arg0, %0  : i32
    %4 = "llvm.intr.ctlz"(%3) <{is_zero_poison = false}> : (i32) -> i32
    %5 = llvm.sub %1, %4  : i32
    %6 = llvm.shl %2, %5  : i32
    %7 = llvm.icmp "ugt" %arg0, %2 : i32
    %8 = llvm.select %7, %6, %2 : i1, i32
    llvm.store %5, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return %8 : i32
  }
  llvm.func @bit_ceil_v4i32(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<32> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mlir.constant(dense<1> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.add %arg0, %0  : vector<4xi32>
    %4 = "llvm.intr.ctlz"(%3) <{is_zero_poison = false}> : (vector<4xi32>) -> vector<4xi32>
    %5 = llvm.sub %1, %4  : vector<4xi32>
    %6 = llvm.shl %2, %5  : vector<4xi32>
    %7 = llvm.icmp "ugt" %arg0, %2 : vector<4xi32>
    %8 = llvm.select %7, %6, %2 : vector<4xi1>, vector<4xi32>
    llvm.return %8 : vector<4xi32>
  }
  llvm.func @pr91691(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.sub %0, %arg0 overflow<nuw>  : i32
    %4 = "llvm.intr.ctlz"(%3) <{is_zero_poison = false}> : (i32) -> i32
    %5 = llvm.sub %1, %4  : i32
    %6 = llvm.shl %2, %5  : i32
    %7 = llvm.icmp "ult" %arg0, %0 : i32
    %8 = llvm.select %7, %6, %2 : i1, i32
    llvm.return %8 : i32
  }
  llvm.func @pr91691_keep_nsw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %4 = "llvm.intr.ctlz"(%3) <{is_zero_poison = false}> : (i32) -> i32
    %5 = llvm.sub %1, %4  : i32
    %6 = llvm.shl %2, %5  : i32
    %7 = llvm.icmp "ult" %arg0, %0 : i32
    %8 = llvm.select %7, %6, %2 : i1, i32
    llvm.return %8 : i32
  }
}
