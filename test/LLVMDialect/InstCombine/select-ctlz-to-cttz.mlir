module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use(i32)
  llvm.func @use2(i1)
  llvm.func @select_clz_to_ctz(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = "llvm.intr.ctlz"(%3) <{is_zero_poison = true}> : (i32) -> i32
    %5 = llvm.icmp "eq" %arg0, %0 : i32
    %6 = llvm.xor %4, %1  : i32
    %7 = llvm.select %5, %4, %6 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @select_clz_to_ctz_preserve_flag(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = "llvm.intr.ctlz"(%3) <{is_zero_poison = false}> : (i32) -> i32
    %5 = llvm.icmp "eq" %arg0, %0 : i32
    %6 = llvm.xor %4, %1  : i32
    %7 = llvm.select %5, %4, %6 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @select_clz_to_ctz_constant_for_zero(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.mlir.constant(32 : i32) : i32
    %3 = llvm.sub %0, %arg0  : i32
    %4 = llvm.and %3, %arg0  : i32
    %5 = "llvm.intr.ctlz"(%4) <{is_zero_poison = false}> : (i32) -> i32
    %6 = llvm.icmp "eq" %arg0, %0 : i32
    %7 = llvm.xor %5, %1  : i32
    %8 = llvm.select %6, %2, %7 : i1, i32
    llvm.return %8 : i32
  }
  llvm.func @select_clz_to_ctz_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<31> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.sub %1, %arg0  : vector<2xi32>
    %4 = llvm.and %3, %arg0  : vector<2xi32>
    %5 = "llvm.intr.ctlz"(%4) <{is_zero_poison = true}> : (vector<2xi32>) -> vector<2xi32>
    %6 = llvm.icmp "eq" %arg0, %1 : vector<2xi32>
    %7 = llvm.xor %5, %2  : vector<2xi32>
    %8 = llvm.select %6, %5, %7 : vector<2xi1>, vector<2xi32>
    llvm.return %8 : vector<2xi32>
  }
  llvm.func @select_clz_to_ctz_extra_use(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = "llvm.intr.ctlz"(%3) <{is_zero_poison = true}> : (i32) -> i32
    %5 = llvm.icmp "eq" %arg0, %0 : i32
    %6 = llvm.xor %4, %1  : i32
    llvm.call @use(%6) : (i32) -> ()
    %7 = llvm.select %5, %4, %6 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @select_clz_to_ctz_and_commuted(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.and %arg0, %2  : i32
    %4 = "llvm.intr.ctlz"(%3) <{is_zero_poison = true}> : (i32) -> i32
    %5 = llvm.icmp "eq" %arg0, %0 : i32
    %6 = llvm.xor %4, %1  : i32
    %7 = llvm.select %5, %4, %6 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @select_clz_to_ctz_icmp_ne(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = "llvm.intr.ctlz"(%3) <{is_zero_poison = true}> : (i32) -> i32
    %5 = llvm.icmp "ne" %arg0, %0 : i32
    llvm.call @use2(%5) : (i1) -> ()
    %6 = llvm.xor %4, %1  : i32
    %7 = llvm.select %5, %6, %4 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @select_clz_to_ctz_i64(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(63 : i64) : i64
    %2 = llvm.sub %0, %arg0  : i64
    %3 = llvm.and %2, %arg0  : i64
    %4 = "llvm.intr.ctlz"(%3) <{is_zero_poison = true}> : (i64) -> i64
    %5 = llvm.icmp "eq" %arg0, %0 : i64
    %6 = llvm.xor %4, %1  : i64
    %7 = llvm.select %5, %4, %6 : i1, i64
    llvm.return %7 : i64
  }
  llvm.func @select_clz_to_ctz_wrong_sub(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(31 : i32) : i32
    %3 = llvm.sub %0, %arg0  : i32
    %4 = llvm.and %3, %arg0  : i32
    %5 = "llvm.intr.ctlz"(%4) <{is_zero_poison = true}> : (i32) -> i32
    %6 = llvm.icmp "eq" %arg0, %1 : i32
    %7 = llvm.xor %5, %2  : i32
    %8 = llvm.select %6, %5, %7 : i1, i32
    llvm.return %8 : i32
  }
  llvm.func @select_clz_to_ctz_i64_wrong_xor(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(64 : i64) : i64
    %2 = llvm.sub %0, %arg0  : i64
    %3 = llvm.and %2, %arg0  : i64
    %4 = "llvm.intr.ctlz"(%3) <{is_zero_poison = true}> : (i64) -> i64
    %5 = llvm.icmp "eq" %arg0, %0 : i64
    %6 = llvm.xor %4, %1  : i64
    %7 = llvm.select %5, %4, %6 : i1, i64
    llvm.return %7 : i64
  }
  llvm.func @select_clz_to_ctz_i64_wrong_icmp_cst(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(63 : i64) : i64
    %3 = llvm.sub %0, %arg0  : i64
    %4 = llvm.and %3, %arg0  : i64
    %5 = "llvm.intr.ctlz"(%4) <{is_zero_poison = true}> : (i64) -> i64
    %6 = llvm.icmp "eq" %arg0, %1 : i64
    %7 = llvm.xor %5, %2  : i64
    %8 = llvm.select %6, %5, %7 : i1, i64
    llvm.return %8 : i64
  }
  llvm.func @select_clz_to_ctz_i64_wrong_icmp_pred(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(63 : i64) : i64
    %2 = llvm.sub %0, %arg0  : i64
    %3 = llvm.and %2, %arg0  : i64
    %4 = "llvm.intr.ctlz"(%3) <{is_zero_poison = true}> : (i64) -> i64
    %5 = llvm.icmp "slt" %arg0, %0 : i64
    %6 = llvm.xor %4, %1  : i64
    %7 = llvm.select %5, %4, %6 : i1, i64
    llvm.return %7 : i64
  }
  llvm.func @select_clz_to_ctz_vec_with_undef(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.undef : i32
    %3 = llvm.mlir.constant(31 : i32) : i32
    %4 = llvm.mlir.undef : vector<2xi32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xi32>
    %9 = llvm.sub %1, %arg0  : vector<2xi32>
    %10 = llvm.and %9, %arg0  : vector<2xi32>
    %11 = "llvm.intr.ctlz"(%10) <{is_zero_poison = true}> : (vector<2xi32>) -> vector<2xi32>
    %12 = llvm.icmp "eq" %arg0, %1 : vector<2xi32>
    %13 = llvm.xor %11, %8  : vector<2xi32>
    %14 = llvm.select %12, %11, %13 : vector<2xi1>, vector<2xi32>
    llvm.return %14 : vector<2xi32>
  }
  llvm.func @select_clz_to_ctz_wrong_constant_for_zero(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = "llvm.intr.ctlz"(%3) <{is_zero_poison = false}> : (i32) -> i32
    %5 = llvm.icmp "eq" %arg0, %0 : i32
    %6 = llvm.xor %4, %1  : i32
    %7 = llvm.select %5, %1, %6 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @PR45762(%arg0: i3) -> i4 {
    %0 = llvm.mlir.constant(0 : i3) : i3
    %1 = llvm.mlir.constant(3 : i3) : i3
    %2 = llvm.mlir.constant(1 : i4) : i4
    %3 = llvm.mlir.constant(0 : i4) : i4
    %4 = llvm.mlir.constant(2 : i4) : i4
    %5 = llvm.mlir.constant(false) : i1
    %6 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (i3) -> i3
    %7 = llvm.icmp "eq" %arg0, %0 : i3
    %8 = llvm.select %7, %1, %6 : i1, i3
    %9 = llvm.zext %8 : i3 to i4
    %10 = llvm.shl %2, %9  : i4
    %11 = llvm.lshr %10, %3  : i4
    %12 = llvm.trunc %11 : i4 to i1
    %13 = llvm.lshr %10, %2  : i4
    %14 = llvm.trunc %13 : i4 to i1
    %15 = llvm.lshr %10, %4  : i4
    %16 = llvm.trunc %15 : i4 to i1
    %17 = llvm.or %12, %14  : i1
    %18 = llvm.or %17, %16  : i1
    %19 = llvm.mul %10, %10  : i4
    %20 = llvm.icmp "eq" %18, %5 : i1
    %21 = llvm.select %20, %10, %19 : i1, i4
    llvm.return %21 : i4
  }
  llvm.func @PR45762_logical(%arg0: i3) -> i4 {
    %0 = llvm.mlir.constant(0 : i3) : i3
    %1 = llvm.mlir.constant(3 : i3) : i3
    %2 = llvm.mlir.constant(1 : i4) : i4
    %3 = llvm.mlir.constant(0 : i4) : i4
    %4 = llvm.mlir.constant(2 : i4) : i4
    %5 = llvm.mlir.constant(true) : i1
    %6 = llvm.mlir.constant(false) : i1
    %7 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (i3) -> i3
    %8 = llvm.icmp "eq" %arg0, %0 : i3
    %9 = llvm.select %8, %1, %7 : i1, i3
    %10 = llvm.zext %9 : i3 to i4
    %11 = llvm.shl %2, %10  : i4
    %12 = llvm.lshr %11, %3  : i4
    %13 = llvm.trunc %12 : i4 to i1
    %14 = llvm.lshr %11, %2  : i4
    %15 = llvm.trunc %14 : i4 to i1
    %16 = llvm.lshr %11, %4  : i4
    %17 = llvm.trunc %16 : i4 to i1
    %18 = llvm.select %13, %5, %15 : i1, i1
    %19 = llvm.select %18, %5, %17 : i1, i1
    %20 = llvm.mul %11, %11  : i4
    %21 = llvm.icmp "eq" %19, %6 : i1
    %22 = llvm.select %21, %11, %20 : i1, i4
    llvm.return %22 : i4
  }
}
