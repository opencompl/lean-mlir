module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use.i32(i32)
  llvm.func @use.i8(i8)
  llvm.func @use.i1(i1)
  llvm.func @eq_10(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.trunc %arg0 : i32 to i8
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    %4 = llvm.trunc %arg1 : i32 to i8
    %5 = llvm.lshr %arg1, %0  : i32
    %6 = llvm.trunc %5 : i32 to i8
    %7 = llvm.icmp "eq" %1, %4 : i8
    %8 = llvm.icmp "eq" %3, %6 : i8
    %9 = llvm.and %7, %8  : i1
    llvm.return %9 : i1
  }
  llvm.func @eq_210(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.trunc %arg0 : i32 to i8
    %3 = llvm.lshr %arg0, %0  : i32
    %4 = llvm.trunc %3 : i32 to i8
    %5 = llvm.lshr %arg0, %1  : i32
    %6 = llvm.trunc %5 : i32 to i8
    %7 = llvm.trunc %arg1 : i32 to i8
    %8 = llvm.lshr %arg1, %0  : i32
    %9 = llvm.trunc %8 : i32 to i8
    %10 = llvm.lshr %arg1, %1  : i32
    %11 = llvm.trunc %10 : i32 to i8
    %12 = llvm.icmp "eq" %2, %7 : i8
    %13 = llvm.icmp "eq" %4, %9 : i8
    %14 = llvm.icmp "eq" %6, %11 : i8
    %15 = llvm.and %12, %13  : i1
    %16 = llvm.and %14, %15  : i1
    llvm.return %16 : i1
  }
  llvm.func @eq_3210(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(24 : i32) : i32
    %3 = llvm.trunc %arg0 : i32 to i8
    %4 = llvm.lshr %arg0, %0  : i32
    %5 = llvm.trunc %4 : i32 to i8
    %6 = llvm.lshr %arg0, %1  : i32
    %7 = llvm.trunc %6 : i32 to i8
    %8 = llvm.lshr %arg0, %2  : i32
    %9 = llvm.trunc %8 : i32 to i8
    %10 = llvm.trunc %arg1 : i32 to i8
    %11 = llvm.lshr %arg1, %0  : i32
    %12 = llvm.trunc %11 : i32 to i8
    %13 = llvm.lshr %arg1, %1  : i32
    %14 = llvm.trunc %13 : i32 to i8
    %15 = llvm.lshr %arg1, %2  : i32
    %16 = llvm.trunc %15 : i32 to i8
    %17 = llvm.icmp "eq" %3, %10 : i8
    %18 = llvm.icmp "eq" %5, %12 : i8
    %19 = llvm.icmp "eq" %7, %14 : i8
    %20 = llvm.icmp "eq" %9, %16 : i8
    %21 = llvm.and %17, %18  : i1
    %22 = llvm.and %19, %21  : i1
    %23 = llvm.and %20, %22  : i1
    llvm.return %23 : i1
  }
  llvm.func @eq_21(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.trunc %4 : i32 to i8
    %6 = llvm.lshr %arg1, %0  : i32
    %7 = llvm.trunc %6 : i32 to i8
    %8 = llvm.lshr %arg1, %1  : i32
    %9 = llvm.trunc %8 : i32 to i8
    %10 = llvm.icmp "eq" %3, %7 : i8
    %11 = llvm.icmp "eq" %5, %9 : i8
    %12 = llvm.and %11, %10  : i1
    llvm.return %12 : i1
  }
  llvm.func @eq_21_comm_and(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.trunc %4 : i32 to i8
    %6 = llvm.lshr %arg1, %0  : i32
    %7 = llvm.trunc %6 : i32 to i8
    %8 = llvm.lshr %arg1, %1  : i32
    %9 = llvm.trunc %8 : i32 to i8
    %10 = llvm.icmp "eq" %3, %7 : i8
    %11 = llvm.icmp "eq" %5, %9 : i8
    %12 = llvm.and %10, %11  : i1
    llvm.return %12 : i1
  }
  llvm.func @eq_21_comm_eq(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.trunc %4 : i32 to i8
    %6 = llvm.lshr %arg1, %0  : i32
    %7 = llvm.trunc %6 : i32 to i8
    %8 = llvm.lshr %arg1, %1  : i32
    %9 = llvm.trunc %8 : i32 to i8
    %10 = llvm.icmp "eq" %3, %7 : i8
    %11 = llvm.icmp "eq" %9, %5 : i8
    %12 = llvm.and %11, %10  : i1
    llvm.return %12 : i1
  }
  llvm.func @eq_21_comm_eq2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.trunc %4 : i32 to i8
    %6 = llvm.lshr %arg1, %0  : i32
    %7 = llvm.trunc %6 : i32 to i8
    %8 = llvm.lshr %arg1, %1  : i32
    %9 = llvm.trunc %8 : i32 to i8
    %10 = llvm.icmp "eq" %7, %3 : i8
    %11 = llvm.icmp "eq" %5, %9 : i8
    %12 = llvm.and %11, %10  : i1
    llvm.return %12 : i1
  }
  llvm.func @eq_21_vector(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.lshr %arg0, %0  : vector<2xi32>
    %3 = llvm.trunc %2 : vector<2xi32> to vector<2xi8>
    %4 = llvm.lshr %arg0, %1  : vector<2xi32>
    %5 = llvm.trunc %4 : vector<2xi32> to vector<2xi8>
    %6 = llvm.lshr %arg1, %0  : vector<2xi32>
    %7 = llvm.trunc %6 : vector<2xi32> to vector<2xi8>
    %8 = llvm.lshr %arg1, %1  : vector<2xi32>
    %9 = llvm.trunc %8 : vector<2xi32> to vector<2xi8>
    %10 = llvm.icmp "eq" %3, %7 : vector<2xi8>
    %11 = llvm.icmp "eq" %5, %9 : vector<2xi8>
    %12 = llvm.and %11, %10  : vector<2xi1>
    llvm.return %12 : vector<2xi1>
  }
  llvm.func @eq_irregular_bit_widths(%arg0: i31, %arg1: i31) -> i1 {
    %0 = llvm.mlir.constant(7 : i31) : i31
    %1 = llvm.mlir.constant(13 : i31) : i31
    %2 = llvm.lshr %arg0, %0  : i31
    %3 = llvm.trunc %2 : i31 to i6
    %4 = llvm.lshr %arg0, %1  : i31
    %5 = llvm.trunc %4 : i31 to i5
    %6 = llvm.lshr %arg1, %0  : i31
    %7 = llvm.trunc %6 : i31 to i6
    %8 = llvm.lshr %arg1, %1  : i31
    %9 = llvm.trunc %8 : i31 to i5
    %10 = llvm.icmp "eq" %3, %7 : i6
    %11 = llvm.icmp "eq" %5, %9 : i5
    %12 = llvm.and %11, %10  : i1
    llvm.return %12 : i1
  }
  llvm.func @eq_21_extra_use_lshr(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    llvm.call @use.i32(%2) : (i32) -> ()
    %3 = llvm.trunc %2 : i32 to i8
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.trunc %4 : i32 to i8
    %6 = llvm.lshr %arg1, %0  : i32
    %7 = llvm.trunc %6 : i32 to i8
    %8 = llvm.lshr %arg1, %1  : i32
    %9 = llvm.trunc %8 : i32 to i8
    %10 = llvm.icmp "eq" %3, %7 : i8
    %11 = llvm.icmp "eq" %5, %9 : i8
    %12 = llvm.and %10, %11  : i1
    llvm.return %12 : i1
  }
  llvm.func @eq_21_extra_use_trunc(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    llvm.call @use.i8(%3) : (i8) -> ()
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.trunc %4 : i32 to i8
    %6 = llvm.lshr %arg1, %0  : i32
    %7 = llvm.trunc %6 : i32 to i8
    %8 = llvm.lshr %arg1, %1  : i32
    %9 = llvm.trunc %8 : i32 to i8
    %10 = llvm.icmp "eq" %3, %7 : i8
    %11 = llvm.icmp "eq" %5, %9 : i8
    %12 = llvm.and %10, %11  : i1
    llvm.return %12 : i1
  }
  llvm.func @eq_21_extra_use_eq1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.trunc %4 : i32 to i8
    %6 = llvm.lshr %arg1, %0  : i32
    %7 = llvm.trunc %6 : i32 to i8
    %8 = llvm.lshr %arg1, %1  : i32
    %9 = llvm.trunc %8 : i32 to i8
    %10 = llvm.icmp "eq" %3, %7 : i8
    llvm.call @use.i1(%10) : (i1) -> ()
    %11 = llvm.icmp "eq" %5, %9 : i8
    %12 = llvm.and %10, %11  : i1
    llvm.return %12 : i1
  }
  llvm.func @eq_21_extra_use_eq2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.trunc %4 : i32 to i8
    %6 = llvm.lshr %arg1, %0  : i32
    %7 = llvm.trunc %6 : i32 to i8
    %8 = llvm.lshr %arg1, %1  : i32
    %9 = llvm.trunc %8 : i32 to i8
    %10 = llvm.icmp "eq" %3, %7 : i8
    %11 = llvm.icmp "eq" %5, %9 : i8
    llvm.call @use.i1(%11) : (i1) -> ()
    %12 = llvm.and %10, %11  : i1
    llvm.return %12 : i1
  }
  llvm.func @eq_21_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.lshr %arg0, %0  : i32
    %4 = llvm.trunc %3 : i32 to i8
    %5 = llvm.lshr %arg0, %1  : i32
    %6 = llvm.trunc %5 : i32 to i8
    %7 = llvm.lshr %arg1, %0  : i32
    %8 = llvm.trunc %7 : i32 to i8
    %9 = llvm.lshr %arg1, %1  : i32
    %10 = llvm.trunc %9 : i32 to i8
    %11 = llvm.icmp "eq" %4, %8 : i8
    %12 = llvm.icmp "eq" %6, %10 : i8
    %13 = llvm.select %12, %11, %2 : i1, i1
    llvm.return %13 : i1
  }
  llvm.func @eq_21_wrong_op1(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.lshr %arg2, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.trunc %4 : i32 to i8
    %6 = llvm.lshr %arg1, %0  : i32
    %7 = llvm.trunc %6 : i32 to i8
    %8 = llvm.lshr %arg1, %1  : i32
    %9 = llvm.trunc %8 : i32 to i8
    %10 = llvm.icmp "eq" %3, %7 : i8
    %11 = llvm.icmp "eq" %5, %9 : i8
    %12 = llvm.and %11, %10  : i1
    llvm.return %12 : i1
  }
  llvm.func @eq_21_wrong_op2(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    %4 = llvm.lshr %arg2, %1  : i32
    %5 = llvm.trunc %4 : i32 to i8
    %6 = llvm.lshr %arg1, %0  : i32
    %7 = llvm.trunc %6 : i32 to i8
    %8 = llvm.lshr %arg1, %1  : i32
    %9 = llvm.trunc %8 : i32 to i8
    %10 = llvm.icmp "eq" %3, %7 : i8
    %11 = llvm.icmp "eq" %5, %9 : i8
    %12 = llvm.and %11, %10  : i1
    llvm.return %12 : i1
  }
  llvm.func @eq_21_wrong_op3(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.trunc %4 : i32 to i8
    %6 = llvm.lshr %arg2, %0  : i32
    %7 = llvm.trunc %6 : i32 to i8
    %8 = llvm.lshr %arg1, %1  : i32
    %9 = llvm.trunc %8 : i32 to i8
    %10 = llvm.icmp "eq" %3, %7 : i8
    %11 = llvm.icmp "eq" %5, %9 : i8
    %12 = llvm.and %11, %10  : i1
    llvm.return %12 : i1
  }
  llvm.func @eq_21_wrong_op4(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.trunc %4 : i32 to i8
    %6 = llvm.lshr %arg1, %0  : i32
    %7 = llvm.trunc %6 : i32 to i8
    %8 = llvm.lshr %arg2, %1  : i32
    %9 = llvm.trunc %8 : i32 to i8
    %10 = llvm.icmp "eq" %3, %7 : i8
    %11 = llvm.icmp "eq" %5, %9 : i8
    %12 = llvm.and %11, %10  : i1
    llvm.return %12 : i1
  }
  llvm.func @eq_21_wrong_shift1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.lshr %arg0, %0  : i32
    %4 = llvm.trunc %3 : i32 to i8
    %5 = llvm.lshr %arg0, %1  : i32
    %6 = llvm.trunc %5 : i32 to i8
    %7 = llvm.lshr %arg1, %2  : i32
    %8 = llvm.trunc %7 : i32 to i8
    %9 = llvm.lshr %arg1, %1  : i32
    %10 = llvm.trunc %9 : i32 to i8
    %11 = llvm.icmp "eq" %4, %8 : i8
    %12 = llvm.icmp "eq" %6, %10 : i8
    %13 = llvm.and %12, %11  : i1
    llvm.return %13 : i1
  }
  llvm.func @eq_21_wrong_shift2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(15 : i32) : i32
    %3 = llvm.lshr %arg0, %0  : i32
    %4 = llvm.trunc %3 : i32 to i8
    %5 = llvm.lshr %arg0, %1  : i32
    %6 = llvm.trunc %5 : i32 to i8
    %7 = llvm.lshr %arg1, %0  : i32
    %8 = llvm.trunc %7 : i32 to i8
    %9 = llvm.lshr %arg1, %2  : i32
    %10 = llvm.trunc %9 : i32 to i8
    %11 = llvm.icmp "eq" %4, %8 : i8
    %12 = llvm.icmp "eq" %6, %10 : i8
    %13 = llvm.and %12, %11  : i1
    llvm.return %13 : i1
  }
  llvm.func @eq_21_not_adjacent(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(17 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.trunc %4 : i32 to i8
    %6 = llvm.lshr %arg1, %0  : i32
    %7 = llvm.trunc %6 : i32 to i8
    %8 = llvm.lshr %arg1, %1  : i32
    %9 = llvm.trunc %8 : i32 to i8
    %10 = llvm.icmp "eq" %3, %7 : i8
    %11 = llvm.icmp "eq" %5, %9 : i8
    %12 = llvm.and %11, %10  : i1
    llvm.return %12 : i1
  }
  llvm.func @eq_shift_in_zeros(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.trunc %4 : i32 to i24
    %6 = llvm.lshr %arg1, %0  : i32
    %7 = llvm.trunc %6 : i32 to i8
    %8 = llvm.lshr %arg1, %1  : i32
    %9 = llvm.trunc %8 : i32 to i24
    %10 = llvm.icmp "eq" %3, %7 : i8
    %11 = llvm.icmp "eq" %5, %9 : i24
    %12 = llvm.and %11, %10  : i1
    llvm.return %12 : i1
  }
  llvm.func @eq_21_wrong_pred1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.trunc %4 : i32 to i8
    %6 = llvm.lshr %arg1, %0  : i32
    %7 = llvm.trunc %6 : i32 to i8
    %8 = llvm.lshr %arg1, %1  : i32
    %9 = llvm.trunc %8 : i32 to i8
    %10 = llvm.icmp "eq" %3, %7 : i8
    %11 = llvm.icmp "ne" %5, %9 : i8
    %12 = llvm.and %11, %10  : i1
    llvm.return %12 : i1
  }
  llvm.func @eq_21_wrong_pred2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.trunc %4 : i32 to i8
    %6 = llvm.lshr %arg1, %0  : i32
    %7 = llvm.trunc %6 : i32 to i8
    %8 = llvm.lshr %arg1, %1  : i32
    %9 = llvm.trunc %8 : i32 to i8
    %10 = llvm.icmp "ne" %3, %7 : i8
    %11 = llvm.icmp "ne" %5, %9 : i8
    %12 = llvm.and %11, %10  : i1
    llvm.return %12 : i1
  }
  llvm.func @ne_10(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.trunc %arg0 : i32 to i8
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    %4 = llvm.trunc %arg1 : i32 to i8
    %5 = llvm.lshr %arg1, %0  : i32
    %6 = llvm.trunc %5 : i32 to i8
    %7 = llvm.icmp "ne" %1, %4 : i8
    %8 = llvm.icmp "ne" %3, %6 : i8
    %9 = llvm.or %7, %8  : i1
    llvm.return %9 : i1
  }
  llvm.func @ne_210(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.trunc %arg0 : i32 to i8
    %3 = llvm.lshr %arg0, %0  : i32
    %4 = llvm.trunc %3 : i32 to i8
    %5 = llvm.lshr %arg0, %1  : i32
    %6 = llvm.trunc %5 : i32 to i8
    %7 = llvm.trunc %arg1 : i32 to i8
    %8 = llvm.lshr %arg1, %0  : i32
    %9 = llvm.trunc %8 : i32 to i8
    %10 = llvm.lshr %arg1, %1  : i32
    %11 = llvm.trunc %10 : i32 to i8
    %12 = llvm.icmp "ne" %2, %7 : i8
    %13 = llvm.icmp "ne" %4, %9 : i8
    %14 = llvm.icmp "ne" %6, %11 : i8
    %15 = llvm.or %12, %13  : i1
    %16 = llvm.or %14, %15  : i1
    llvm.return %16 : i1
  }
  llvm.func @ne_3210(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(24 : i32) : i32
    %3 = llvm.trunc %arg0 : i32 to i8
    %4 = llvm.lshr %arg0, %0  : i32
    %5 = llvm.trunc %4 : i32 to i8
    %6 = llvm.lshr %arg0, %1  : i32
    %7 = llvm.trunc %6 : i32 to i8
    %8 = llvm.lshr %arg0, %2  : i32
    %9 = llvm.trunc %8 : i32 to i8
    %10 = llvm.trunc %arg1 : i32 to i8
    %11 = llvm.lshr %arg1, %0  : i32
    %12 = llvm.trunc %11 : i32 to i8
    %13 = llvm.lshr %arg1, %1  : i32
    %14 = llvm.trunc %13 : i32 to i8
    %15 = llvm.lshr %arg1, %2  : i32
    %16 = llvm.trunc %15 : i32 to i8
    %17 = llvm.icmp "ne" %3, %10 : i8
    %18 = llvm.icmp "ne" %5, %12 : i8
    %19 = llvm.icmp "ne" %7, %14 : i8
    %20 = llvm.icmp "ne" %9, %16 : i8
    %21 = llvm.or %17, %18  : i1
    %22 = llvm.or %19, %21  : i1
    %23 = llvm.or %20, %22  : i1
    llvm.return %23 : i1
  }
  llvm.func @ne_21(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.trunc %4 : i32 to i8
    %6 = llvm.lshr %arg1, %0  : i32
    %7 = llvm.trunc %6 : i32 to i8
    %8 = llvm.lshr %arg1, %1  : i32
    %9 = llvm.trunc %8 : i32 to i8
    %10 = llvm.icmp "ne" %3, %7 : i8
    %11 = llvm.icmp "ne" %5, %9 : i8
    %12 = llvm.or %11, %10  : i1
    llvm.return %12 : i1
  }
  llvm.func @ne_21_comm_or(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.trunc %4 : i32 to i8
    %6 = llvm.lshr %arg1, %0  : i32
    %7 = llvm.trunc %6 : i32 to i8
    %8 = llvm.lshr %arg1, %1  : i32
    %9 = llvm.trunc %8 : i32 to i8
    %10 = llvm.icmp "ne" %3, %7 : i8
    %11 = llvm.icmp "ne" %5, %9 : i8
    %12 = llvm.or %10, %11  : i1
    llvm.return %12 : i1
  }
  llvm.func @ne_21_comm_ne(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.trunc %4 : i32 to i8
    %6 = llvm.lshr %arg1, %0  : i32
    %7 = llvm.trunc %6 : i32 to i8
    %8 = llvm.lshr %arg1, %1  : i32
    %9 = llvm.trunc %8 : i32 to i8
    %10 = llvm.icmp "ne" %3, %7 : i8
    %11 = llvm.icmp "ne" %9, %5 : i8
    %12 = llvm.or %11, %10  : i1
    llvm.return %12 : i1
  }
  llvm.func @ne_21_comm_ne2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.trunc %4 : i32 to i8
    %6 = llvm.lshr %arg1, %0  : i32
    %7 = llvm.trunc %6 : i32 to i8
    %8 = llvm.lshr %arg1, %1  : i32
    %9 = llvm.trunc %8 : i32 to i8
    %10 = llvm.icmp "ne" %7, %3 : i8
    %11 = llvm.icmp "ne" %5, %9 : i8
    %12 = llvm.or %11, %10  : i1
    llvm.return %12 : i1
  }
  llvm.func @ne_21_vector(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.lshr %arg0, %0  : vector<2xi32>
    %3 = llvm.trunc %2 : vector<2xi32> to vector<2xi8>
    %4 = llvm.lshr %arg0, %1  : vector<2xi32>
    %5 = llvm.trunc %4 : vector<2xi32> to vector<2xi8>
    %6 = llvm.lshr %arg1, %0  : vector<2xi32>
    %7 = llvm.trunc %6 : vector<2xi32> to vector<2xi8>
    %8 = llvm.lshr %arg1, %1  : vector<2xi32>
    %9 = llvm.trunc %8 : vector<2xi32> to vector<2xi8>
    %10 = llvm.icmp "ne" %3, %7 : vector<2xi8>
    %11 = llvm.icmp "ne" %5, %9 : vector<2xi8>
    %12 = llvm.or %11, %10  : vector<2xi1>
    llvm.return %12 : vector<2xi1>
  }
  llvm.func @ne_irregular_bit_widths(%arg0: i31, %arg1: i31) -> i1 {
    %0 = llvm.mlir.constant(7 : i31) : i31
    %1 = llvm.mlir.constant(13 : i31) : i31
    %2 = llvm.lshr %arg0, %0  : i31
    %3 = llvm.trunc %2 : i31 to i6
    %4 = llvm.lshr %arg0, %1  : i31
    %5 = llvm.trunc %4 : i31 to i5
    %6 = llvm.lshr %arg1, %0  : i31
    %7 = llvm.trunc %6 : i31 to i6
    %8 = llvm.lshr %arg1, %1  : i31
    %9 = llvm.trunc %8 : i31 to i5
    %10 = llvm.icmp "ne" %3, %7 : i6
    %11 = llvm.icmp "ne" %5, %9 : i5
    %12 = llvm.or %11, %10  : i1
    llvm.return %12 : i1
  }
  llvm.func @ne_21_extra_use_lshr(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    llvm.call @use.i32(%2) : (i32) -> ()
    %3 = llvm.trunc %2 : i32 to i8
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.trunc %4 : i32 to i8
    %6 = llvm.lshr %arg1, %0  : i32
    %7 = llvm.trunc %6 : i32 to i8
    %8 = llvm.lshr %arg1, %1  : i32
    %9 = llvm.trunc %8 : i32 to i8
    %10 = llvm.icmp "ne" %3, %7 : i8
    %11 = llvm.icmp "ne" %5, %9 : i8
    %12 = llvm.or %10, %11  : i1
    llvm.return %12 : i1
  }
  llvm.func @ne_21_extra_use_trunc(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    llvm.call @use.i8(%3) : (i8) -> ()
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.trunc %4 : i32 to i8
    %6 = llvm.lshr %arg1, %0  : i32
    %7 = llvm.trunc %6 : i32 to i8
    %8 = llvm.lshr %arg1, %1  : i32
    %9 = llvm.trunc %8 : i32 to i8
    %10 = llvm.icmp "ne" %3, %7 : i8
    %11 = llvm.icmp "ne" %5, %9 : i8
    %12 = llvm.or %10, %11  : i1
    llvm.return %12 : i1
  }
  llvm.func @ne_21_extra_use_ne1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.trunc %4 : i32 to i8
    %6 = llvm.lshr %arg1, %0  : i32
    %7 = llvm.trunc %6 : i32 to i8
    %8 = llvm.lshr %arg1, %1  : i32
    %9 = llvm.trunc %8 : i32 to i8
    %10 = llvm.icmp "ne" %3, %7 : i8
    llvm.call @use.i1(%10) : (i1) -> ()
    %11 = llvm.icmp "ne" %5, %9 : i8
    %12 = llvm.or %10, %11  : i1
    llvm.return %12 : i1
  }
  llvm.func @ne_21_extra_use_ne2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.trunc %4 : i32 to i8
    %6 = llvm.lshr %arg1, %0  : i32
    %7 = llvm.trunc %6 : i32 to i8
    %8 = llvm.lshr %arg1, %1  : i32
    %9 = llvm.trunc %8 : i32 to i8
    %10 = llvm.icmp "ne" %3, %7 : i8
    %11 = llvm.icmp "ne" %5, %9 : i8
    llvm.call @use.i1(%11) : (i1) -> ()
    %12 = llvm.or %10, %11  : i1
    llvm.return %12 : i1
  }
  llvm.func @ne_21_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.lshr %arg0, %0  : i32
    %4 = llvm.trunc %3 : i32 to i8
    %5 = llvm.lshr %arg0, %1  : i32
    %6 = llvm.trunc %5 : i32 to i8
    %7 = llvm.lshr %arg1, %0  : i32
    %8 = llvm.trunc %7 : i32 to i8
    %9 = llvm.lshr %arg1, %1  : i32
    %10 = llvm.trunc %9 : i32 to i8
    %11 = llvm.icmp "ne" %4, %8 : i8
    %12 = llvm.icmp "ne" %6, %10 : i8
    %13 = llvm.select %12, %2, %11 : i1, i1
    llvm.return %13 : i1
  }
  llvm.func @ne_21_wrong_op1(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.lshr %arg2, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.trunc %4 : i32 to i8
    %6 = llvm.lshr %arg1, %0  : i32
    %7 = llvm.trunc %6 : i32 to i8
    %8 = llvm.lshr %arg1, %1  : i32
    %9 = llvm.trunc %8 : i32 to i8
    %10 = llvm.icmp "ne" %3, %7 : i8
    %11 = llvm.icmp "ne" %5, %9 : i8
    %12 = llvm.or %11, %10  : i1
    llvm.return %12 : i1
  }
  llvm.func @ne_21_wrong_op2(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    %4 = llvm.lshr %arg2, %1  : i32
    %5 = llvm.trunc %4 : i32 to i8
    %6 = llvm.lshr %arg1, %0  : i32
    %7 = llvm.trunc %6 : i32 to i8
    %8 = llvm.lshr %arg1, %1  : i32
    %9 = llvm.trunc %8 : i32 to i8
    %10 = llvm.icmp "ne" %3, %7 : i8
    %11 = llvm.icmp "ne" %5, %9 : i8
    %12 = llvm.or %11, %10  : i1
    llvm.return %12 : i1
  }
  llvm.func @ne_21_wrong_op3(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.trunc %4 : i32 to i8
    %6 = llvm.lshr %arg2, %0  : i32
    %7 = llvm.trunc %6 : i32 to i8
    %8 = llvm.lshr %arg1, %1  : i32
    %9 = llvm.trunc %8 : i32 to i8
    %10 = llvm.icmp "ne" %3, %7 : i8
    %11 = llvm.icmp "ne" %5, %9 : i8
    %12 = llvm.or %11, %10  : i1
    llvm.return %12 : i1
  }
  llvm.func @ne_21_wrong_op4(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.trunc %4 : i32 to i8
    %6 = llvm.lshr %arg1, %0  : i32
    %7 = llvm.trunc %6 : i32 to i8
    %8 = llvm.lshr %arg2, %1  : i32
    %9 = llvm.trunc %8 : i32 to i8
    %10 = llvm.icmp "ne" %3, %7 : i8
    %11 = llvm.icmp "ne" %5, %9 : i8
    %12 = llvm.or %11, %10  : i1
    llvm.return %12 : i1
  }
  llvm.func @ne_21_wrong_shift1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.lshr %arg0, %0  : i32
    %4 = llvm.trunc %3 : i32 to i8
    %5 = llvm.lshr %arg0, %1  : i32
    %6 = llvm.trunc %5 : i32 to i8
    %7 = llvm.lshr %arg1, %2  : i32
    %8 = llvm.trunc %7 : i32 to i8
    %9 = llvm.lshr %arg1, %1  : i32
    %10 = llvm.trunc %9 : i32 to i8
    %11 = llvm.icmp "ne" %4, %8 : i8
    %12 = llvm.icmp "ne" %6, %10 : i8
    %13 = llvm.or %12, %11  : i1
    llvm.return %13 : i1
  }
  llvm.func @ne_21_wrong_shift2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(15 : i32) : i32
    %3 = llvm.lshr %arg0, %0  : i32
    %4 = llvm.trunc %3 : i32 to i8
    %5 = llvm.lshr %arg0, %1  : i32
    %6 = llvm.trunc %5 : i32 to i8
    %7 = llvm.lshr %arg1, %0  : i32
    %8 = llvm.trunc %7 : i32 to i8
    %9 = llvm.lshr %arg1, %2  : i32
    %10 = llvm.trunc %9 : i32 to i8
    %11 = llvm.icmp "ne" %4, %8 : i8
    %12 = llvm.icmp "ne" %6, %10 : i8
    %13 = llvm.or %12, %11  : i1
    llvm.return %13 : i1
  }
  llvm.func @ne_21_not_adjacent(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(17 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.trunc %4 : i32 to i8
    %6 = llvm.lshr %arg1, %0  : i32
    %7 = llvm.trunc %6 : i32 to i8
    %8 = llvm.lshr %arg1, %1  : i32
    %9 = llvm.trunc %8 : i32 to i8
    %10 = llvm.icmp "ne" %3, %7 : i8
    %11 = llvm.icmp "ne" %5, %9 : i8
    %12 = llvm.or %11, %10  : i1
    llvm.return %12 : i1
  }
  llvm.func @ne_shift_in_zeros(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.trunc %4 : i32 to i24
    %6 = llvm.lshr %arg1, %0  : i32
    %7 = llvm.trunc %6 : i32 to i8
    %8 = llvm.lshr %arg1, %1  : i32
    %9 = llvm.trunc %8 : i32 to i24
    %10 = llvm.icmp "ne" %3, %7 : i8
    %11 = llvm.icmp "ne" %5, %9 : i24
    %12 = llvm.or %11, %10  : i1
    llvm.return %12 : i1
  }
  llvm.func @ne_21_wrong_pred1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.trunc %4 : i32 to i8
    %6 = llvm.lshr %arg1, %0  : i32
    %7 = llvm.trunc %6 : i32 to i8
    %8 = llvm.lshr %arg1, %1  : i32
    %9 = llvm.trunc %8 : i32 to i8
    %10 = llvm.icmp "ne" %3, %7 : i8
    %11 = llvm.icmp "eq" %5, %9 : i8
    %12 = llvm.or %11, %10  : i1
    llvm.return %12 : i1
  }
  llvm.func @ne_21_wrong_pred2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.trunc %4 : i32 to i8
    %6 = llvm.lshr %arg1, %0  : i32
    %7 = llvm.trunc %6 : i32 to i8
    %8 = llvm.lshr %arg1, %1  : i32
    %9 = llvm.trunc %8 : i32 to i8
    %10 = llvm.icmp "eq" %3, %7 : i8
    %11 = llvm.icmp "eq" %5, %9 : i8
    %12 = llvm.or %11, %10  : i1
    llvm.return %12 : i1
  }
  llvm.func @eq_optimized_highbits_cmp(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(33554432 : i32) : i32
    %1 = llvm.xor %arg1, %arg0  : i32
    %2 = llvm.icmp "ult" %1, %0 : i32
    %3 = llvm.trunc %arg0 : i32 to i25
    %4 = llvm.trunc %arg1 : i32 to i25
    %5 = llvm.icmp "eq" %3, %4 : i25
    %6 = llvm.and %2, %5  : i1
    llvm.return %6 : i1
  }
  llvm.func @eq_optimized_highbits_cmp_todo_overlapping(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(16777216 : i32) : i32
    %1 = llvm.xor %arg1, %arg0  : i32
    %2 = llvm.icmp "ult" %1, %0 : i32
    %3 = llvm.trunc %arg0 : i32 to i25
    %4 = llvm.trunc %arg1 : i32 to i25
    %5 = llvm.icmp "eq" %3, %4 : i25
    %6 = llvm.and %2, %5  : i1
    llvm.return %6 : i1
  }
  llvm.func @eq_optimized_highbits_cmp_fail_not_pow2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(16777215 : i32) : i32
    %1 = llvm.xor %arg1, %arg0  : i32
    %2 = llvm.icmp "ult" %1, %0 : i32
    %3 = llvm.trunc %arg0 : i32 to i24
    %4 = llvm.trunc %arg1 : i32 to i24
    %5 = llvm.icmp "eq" %3, %4 : i24
    %6 = llvm.and %2, %5  : i1
    llvm.return %6 : i1
  }
  llvm.func @ne_optimized_highbits_cmp(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(16777215 : i32) : i32
    %1 = llvm.xor %arg1, %arg0  : i32
    %2 = llvm.icmp "ugt" %1, %0 : i32
    %3 = llvm.trunc %arg0 : i32 to i24
    %4 = llvm.trunc %arg1 : i32 to i24
    %5 = llvm.icmp "ne" %3, %4 : i24
    %6 = llvm.or %2, %5  : i1
    llvm.return %6 : i1
  }
  llvm.func @ne_optimized_highbits_cmp_fail_not_mask(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(16777216 : i32) : i32
    %1 = llvm.xor %arg1, %arg0  : i32
    %2 = llvm.icmp "ugt" %1, %0 : i32
    %3 = llvm.trunc %arg0 : i32 to i24
    %4 = llvm.trunc %arg1 : i32 to i24
    %5 = llvm.icmp "ne" %3, %4 : i24
    %6 = llvm.or %2, %5  : i1
    llvm.return %6 : i1
  }
  llvm.func @ne_optimized_highbits_cmp_fail_no_combined_int(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(16777215 : i32) : i32
    %1 = llvm.xor %arg1, %arg0  : i32
    %2 = llvm.icmp "ugt" %1, %0 : i32
    %3 = llvm.trunc %arg0 : i32 to i23
    %4 = llvm.trunc %arg1 : i32 to i23
    %5 = llvm.icmp "ne" %3, %4 : i23
    %6 = llvm.or %2, %5  : i1
    llvm.return %6 : i1
  }
  llvm.func @ne_optimized_highbits_cmp_todo_overlapping(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(8388607 : i32) : i32
    %1 = llvm.xor %arg1, %arg0  : i32
    %2 = llvm.icmp "ugt" %1, %0 : i32
    %3 = llvm.trunc %arg0 : i32 to i24
    %4 = llvm.trunc %arg1 : i32 to i24
    %5 = llvm.icmp "ne" %3, %4 : i24
    %6 = llvm.or %2, %5  : i1
    llvm.return %6 : i1
  }
}
