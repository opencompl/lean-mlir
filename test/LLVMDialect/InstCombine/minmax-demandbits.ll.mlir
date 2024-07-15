module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @and_umax_less(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(-32 : i32) : i32
    %2 = llvm.icmp "ugt" %0, %arg0 : i32
    %3 = llvm.select %2, %0, %arg0 : i1, i32
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @and_umax_muchless(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(-32 : i32) : i32
    %2 = llvm.icmp "ugt" %0, %arg0 : i32
    %3 = llvm.select %2, %0, %arg0 : i1, i32
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @and_umax_more(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-32 : i32) : i32
    %2 = llvm.icmp "ugt" %0, %arg0 : i32
    %3 = llvm.select %2, %0, %arg0 : i1, i32
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @shr_umax(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.icmp "ugt" %0, %arg0 : i32
    %3 = llvm.select %2, %0, %arg0 : i1, i32
    %4 = llvm.lshr %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @t_0_1(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.icmp "ugt" %arg0, %0 : i8
    %3 = llvm.select %2, %arg0, %0 : i1, i8
    %4 = llvm.and %3, %1  : i8
    llvm.return %4 : i8
  }
  llvm.func @t_0_10(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.icmp "ugt" %arg0, %0 : i8
    %3 = llvm.select %2, %arg0, %0 : i1, i8
    %4 = llvm.and %3, %1  : i8
    llvm.return %4 : i8
  }
  llvm.func @t_1_10(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.icmp "ugt" %arg0, %0 : i8
    %3 = llvm.select %2, %arg0, %0 : i1, i8
    %4 = llvm.and %3, %1  : i8
    llvm.return %4 : i8
  }
  llvm.func @t_2_4(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.icmp "ugt" %arg0, %0 : i8
    %3 = llvm.select %2, %arg0, %0 : i1, i8
    %4 = llvm.and %3, %1  : i8
    llvm.return %4 : i8
  }
  llvm.func @t_2_192(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(-64 : i8) : i8
    %2 = llvm.icmp "ugt" %arg0, %0 : i8
    %3 = llvm.select %2, %arg0, %0 : i1, i8
    %4 = llvm.and %3, %1  : i8
    llvm.return %4 : i8
  }
  llvm.func @t_2_63_or(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(63 : i8) : i8
    %2 = llvm.icmp "ugt" %arg0, %0 : i8
    %3 = llvm.select %2, %arg0, %0 : i1, i8
    %4 = llvm.or %3, %1  : i8
    llvm.return %4 : i8
  }
  llvm.func @f_1_1(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.icmp "ugt" %arg0, %0 : i8
    %2 = llvm.select %1, %arg0, %0 : i1, i8
    %3 = llvm.and %2, %0  : i8
    llvm.return %3 : i8
  }
  llvm.func @f_32_32(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(32 : i8) : i8
    %1 = llvm.mlir.constant(-32 : i8) : i8
    %2 = llvm.icmp "ugt" %arg0, %0 : i8
    %3 = llvm.select %2, %arg0, %0 : i1, i8
    %4 = llvm.and %3, %1  : i8
    llvm.return %4 : i8
  }
  llvm.func @f_191_192(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-65 : i8) : i8
    %1 = llvm.mlir.constant(-64 : i8) : i8
    %2 = llvm.icmp "ugt" %arg0, %0 : i8
    %3 = llvm.select %2, %arg0, %0 : i1, i8
    %4 = llvm.and %3, %1  : i8
    llvm.return %4 : i8
  }
  llvm.func @f_10_1(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.icmp "ugt" %arg0, %0 : i8
    %3 = llvm.select %2, %arg0, %0 : i1, i8
    %4 = llvm.and %3, %1  : i8
    llvm.return %4 : i8
  }
  llvm.func @and_umin(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(-32 : i32) : i32
    %2 = llvm.icmp "ult" %0, %arg0 : i32
    %3 = llvm.select %2, %0, %arg0 : i1, i32
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @or_umin(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.icmp "ult" %0, %arg0 : i32
    %3 = llvm.select %2, %0, %arg0 : i1, i32
    %4 = llvm.or %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @or_min_31_30(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-30 : i8) : i8
    %1 = llvm.mlir.constant(31 : i8) : i8
    %2 = llvm.icmp "ult" %arg0, %0 : i8
    %3 = llvm.select %2, %arg0, %0 : i1, i8
    %4 = llvm.or %3, %1  : i8
    llvm.return %4 : i8
  }
  llvm.func @and_min_7_7(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-7 : i8) : i8
    %1 = llvm.mlir.constant(-8 : i8) : i8
    %2 = llvm.icmp "ult" %arg0, %0 : i8
    %3 = llvm.select %2, %arg0, %0 : i1, i8
    %4 = llvm.and %3, %1  : i8
    llvm.return %4 : i8
  }
  llvm.func @and_min_7_8(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-8 : i8) : i8
    %1 = llvm.icmp "ult" %arg0, %0 : i8
    %2 = llvm.select %1, %arg0, %0 : i1, i8
    %3 = llvm.and %2, %0  : i8
    llvm.return %3 : i8
  }
  llvm.func @and_min_7_9(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-9 : i8) : i8
    %1 = llvm.mlir.constant(-8 : i8) : i8
    %2 = llvm.icmp "ult" %arg0, %0 : i8
    %3 = llvm.select %2, %arg0, %0 : i1, i8
    %4 = llvm.and %3, %1  : i8
    llvm.return %4 : i8
  }
}
