module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @glb(0 : i8) {addr_space = 0 : i32} : i8
  llvm.func @gen1() -> i1
  llvm.func @cond_eq_and(%arg0: i8, %arg1: i8, %arg2: i8 {llvm.noundef}) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.icmp "eq" %arg0, %arg2 : i8
    %2 = llvm.icmp "ult" %arg0, %arg1 : i8
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @cond_eq_and_const(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.icmp "ult" %arg0, %arg1 : i8
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @cond_eq_or(%arg0: i8, %arg1: i8, %arg2: i8 {llvm.noundef}) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "ne" %arg0, %arg2 : i8
    %2 = llvm.icmp "ult" %arg0, %arg1 : i8
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @cond_eq_or_const(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.icmp "ult" %arg0, %arg1 : i8
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @xor_and(%arg0: i1, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ult" %arg1, %arg2 : i32
    %3 = llvm.select %arg0, %2, %0 : i1, i1
    %4 = llvm.xor %3, %1  : i1
    llvm.return %4 : i1
  }
  llvm.func @xor_and2(%arg0: vector<2xi1>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.constant(dense<[true, false]> : vector<2xi1>) : vector<2xi1>
    %3 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %4 = llvm.icmp "ult" %arg1, %arg2 : vector<2xi32>
    %5 = llvm.select %arg0, %4, %2 : vector<2xi1>, vector<2xi1>
    %6 = llvm.xor %5, %3  : vector<2xi1>
    llvm.return %6 : vector<2xi1>
  }
  llvm.func @xor_and3(%arg0: vector<2xi1>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.addressof @glb : !llvm.ptr
    %3 = llvm.ptrtoint %2 : !llvm.ptr to i1
    %4 = llvm.mlir.undef : vector<2xi1>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xi1>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<2xi1>
    %9 = llvm.mlir.constant(true) : i1
    %10 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %11 = llvm.icmp "ult" %arg1, %arg2 : vector<2xi32>
    %12 = llvm.select %arg0, %11, %8 : vector<2xi1>, vector<2xi1>
    %13 = llvm.xor %12, %10  : vector<2xi1>
    llvm.return %13 : vector<2xi1>
  }
  llvm.func @xor_or(%arg0: i1, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "ult" %arg1, %arg2 : i32
    %2 = llvm.select %arg0, %0, %1 : i1, i1
    %3 = llvm.xor %2, %0  : i1
    llvm.return %3 : i1
  }
  llvm.func @xor_or2(%arg0: vector<2xi1>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.constant(dense<[true, false]> : vector<2xi1>) : vector<2xi1>
    %3 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %4 = llvm.icmp "ult" %arg1, %arg2 : vector<2xi32>
    %5 = llvm.select %arg0, %2, %4 : vector<2xi1>, vector<2xi1>
    %6 = llvm.xor %5, %3  : vector<2xi1>
    llvm.return %6 : vector<2xi1>
  }
  llvm.func @xor_or3(%arg0: vector<2xi1>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.addressof @glb : !llvm.ptr
    %3 = llvm.ptrtoint %2 : !llvm.ptr to i1
    %4 = llvm.mlir.undef : vector<2xi1>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xi1>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<2xi1>
    %9 = llvm.mlir.constant(true) : i1
    %10 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %11 = llvm.icmp "ult" %arg1, %arg2 : vector<2xi32>
    %12 = llvm.select %arg0, %8, %11 : vector<2xi1>, vector<2xi1>
    %13 = llvm.xor %12, %10  : vector<2xi1>
    llvm.return %13 : vector<2xi1>
  }
  llvm.func @and_orn_cmp_1_logical(%arg0: i32, %arg1: i32, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "sgt" %arg0, %arg1 : i32
    %3 = llvm.icmp "sle" %arg0, %arg1 : i32
    %4 = llvm.select %arg2, %0, %3 : i1, i1
    %5 = llvm.select %2, %4, %1 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @and_orn_cmp_1_partial_logical(%arg0: i32, %arg1: i32, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.icmp "sgt" %arg0, %arg1 : i32
    %2 = llvm.icmp "sle" %arg0, %arg1 : i32
    %3 = llvm.or %2, %arg2  : i1
    %4 = llvm.select %1, %3, %0 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @and_orn_cmp_1_partial_logical_commute(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.call @gen1() : () -> i1
    %2 = llvm.icmp "sgt" %arg0, %arg1 : i32
    %3 = llvm.icmp "sle" %arg0, %arg1 : i32
    %4 = llvm.or %1, %3  : i1
    %5 = llvm.select %2, %4, %0 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @andn_or_cmp_2_logical(%arg0: i16, %arg1: i16, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "sge" %arg0, %arg1 : i16
    %3 = llvm.icmp "slt" %arg0, %arg1 : i16
    %4 = llvm.select %arg2, %0, %2 : i1, i1
    %5 = llvm.select %4, %3, %1 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @andn_or_cmp_2_partial_logical(%arg0: i16, %arg1: i16, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.icmp "sge" %arg0, %arg1 : i16
    %2 = llvm.icmp "slt" %arg0, %arg1 : i16
    %3 = llvm.or %1, %arg2  : i1
    %4 = llvm.select %3, %2, %0 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @andn_or_cmp_2_partial_logical_commute(%arg0: i16, %arg1: i16) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.call @gen1() : () -> i1
    %2 = llvm.icmp "sge" %arg0, %arg1 : i16
    %3 = llvm.icmp "slt" %arg0, %arg1 : i16
    %4 = llvm.or %1, %2  : i1
    %5 = llvm.select %4, %3, %0 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @not_logical_or(%arg0: i1, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<3> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %4 = llvm.mlir.constant(false) : i1
    %5 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    %6 = llvm.icmp "ult" %arg1, %0 : vector<2xi32>
    %7 = llvm.icmp "slt" %arg1, %1 : vector<2xi32>
    %8 = llvm.select %arg0, %3, %7 : i1, vector<2xi1>
    %9 = llvm.select %6, %8, %5 : vector<2xi1>, vector<2xi1>
    llvm.return %9 : vector<2xi1>
  }
  llvm.func @not_logical_or2(%arg0: i1, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<3> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %4 = llvm.mlir.constant(false) : i1
    %5 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    %6 = llvm.icmp "ult" %arg1, %0 : vector<2xi32>
    %7 = llvm.icmp "slt" %arg1, %1 : vector<2xi32>
    %8 = llvm.select %arg0, %3, %7 : i1, vector<2xi1>
    %9 = llvm.select %8, %6, %5 : vector<2xi1>, vector<2xi1>
    llvm.return %9 : vector<2xi1>
  }
  llvm.func @bools_logical_commute0(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.xor %arg2, %0  : i1
    %3 = llvm.select %2, %arg0, %1 : i1, i1
    %4 = llvm.select %arg2, %arg1, %1 : i1, i1
    %5 = llvm.select %3, %0, %4 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @bools_logical_commute0_and1(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.xor %arg2, %0  : i1
    %3 = llvm.and %2, %arg0  : i1
    %4 = llvm.select %arg2, %arg1, %1 : i1, i1
    %5 = llvm.select %3, %0, %4 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @bools_logical_commute0_and2(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.xor %arg2, %0  : i1
    %3 = llvm.select %2, %arg0, %1 : i1, i1
    %4 = llvm.and %arg2, %arg1  : i1
    %5 = llvm.select %3, %0, %4 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @bools_logical_commute0_and1_and2(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg2, %0  : i1
    %2 = llvm.and %1, %arg0  : i1
    %3 = llvm.and %arg2, %arg1  : i1
    %4 = llvm.select %2, %0, %3 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @bools_logical_commute1(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.xor %arg2, %0  : i1
    %3 = llvm.select %arg0, %2, %1 : i1, i1
    %4 = llvm.select %arg2, %arg1, %1 : i1, i1
    %5 = llvm.select %3, %0, %4 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @bools_logical_commute1_and1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.call @gen1() : () -> i1
    %3 = llvm.xor %arg1, %0  : i1
    %4 = llvm.and %2, %3  : i1
    %5 = llvm.select %arg1, %arg0, %1 : i1, i1
    %6 = llvm.select %4, %0, %5 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @bools_logical_commute1_and2(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.xor %arg2, %0  : i1
    %3 = llvm.select %arg0, %2, %1 : i1, i1
    %4 = llvm.and %arg2, %arg1  : i1
    %5 = llvm.select %3, %0, %4 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @bools_logical_commute1_and1_and2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.call @gen1() : () -> i1
    %2 = llvm.xor %arg1, %0  : i1
    %3 = llvm.and %1, %2  : i1
    %4 = llvm.and %arg1, %arg0  : i1
    %5 = llvm.select %3, %0, %4 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @bools_logical_commute2(%arg0: vector<2xi1>, %arg1: vector<2xi1>, %arg2: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    %4 = llvm.xor %arg2, %1  : vector<2xi1>
    %5 = llvm.select %4, %arg0, %3 : vector<2xi1>, vector<2xi1>
    %6 = llvm.select %arg1, %arg2, %3 : vector<2xi1>, vector<2xi1>
    %7 = llvm.select %5, %1, %6 : vector<2xi1>, vector<2xi1>
    llvm.return %7 : vector<2xi1>
  }
  llvm.func @bools_logical_commute2_and1(%arg0: vector<2xi1>, %arg1: vector<2xi1>, %arg2: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    %4 = llvm.xor %arg2, %1  : vector<2xi1>
    %5 = llvm.and %4, %arg0  : vector<2xi1>
    %6 = llvm.select %arg1, %arg2, %3 : vector<2xi1>, vector<2xi1>
    %7 = llvm.select %5, %1, %6 : vector<2xi1>, vector<2xi1>
    llvm.return %7 : vector<2xi1>
  }
  llvm.func @bools_logical_commute2_and2(%arg0: vector<2xi1>, %arg1: vector<2xi1>, %arg2: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    %4 = llvm.xor %arg2, %1  : vector<2xi1>
    %5 = llvm.select %4, %arg0, %3 : vector<2xi1>, vector<2xi1>
    %6 = llvm.and %arg1, %arg2  : vector<2xi1>
    %7 = llvm.select %5, %1, %6 : vector<2xi1>, vector<2xi1>
    llvm.return %7 : vector<2xi1>
  }
  llvm.func @bools_logical_commute2_and1_and2(%arg0: vector<2xi1>, %arg1: vector<2xi1>, %arg2: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.xor %arg2, %1  : vector<2xi1>
    %3 = llvm.and %2, %arg0  : vector<2xi1>
    %4 = llvm.and %arg1, %arg2  : vector<2xi1>
    %5 = llvm.select %3, %1, %4 : vector<2xi1>, vector<2xi1>
    llvm.return %5 : vector<2xi1>
  }
  llvm.func @bools_logical_commute3(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.xor %arg2, %0  : i1
    %3 = llvm.select %arg0, %2, %1 : i1, i1
    %4 = llvm.select %arg1, %arg2, %1 : i1, i1
    %5 = llvm.select %3, %0, %4 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @bools_logical_commute3_and1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.call @gen1() : () -> i1
    %3 = llvm.xor %arg1, %0  : i1
    %4 = llvm.and %2, %3  : i1
    %5 = llvm.select %arg0, %arg1, %1 : i1, i1
    %6 = llvm.select %4, %0, %5 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @bools_logical_commute3_and2(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.xor %arg2, %0  : i1
    %3 = llvm.select %arg0, %2, %1 : i1, i1
    %4 = llvm.and %arg1, %arg2  : i1
    %5 = llvm.select %3, %0, %4 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @bools_logical_commute3_and1_and2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.call @gen1() : () -> i1
    %2 = llvm.xor %arg1, %0  : i1
    %3 = llvm.and %1, %2  : i1
    %4 = llvm.and %arg0, %arg1  : i1
    %5 = llvm.select %3, %0, %4 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @bools2_logical_commute0(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.xor %arg2, %0  : i1
    %3 = llvm.select %arg2, %arg0, %1 : i1, i1
    %4 = llvm.select %2, %arg1, %1 : i1, i1
    %5 = llvm.select %3, %0, %4 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @bools2_logical_commute0_and1(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.xor %arg2, %0  : i1
    %3 = llvm.and %arg2, %arg0  : i1
    %4 = llvm.select %2, %arg1, %1 : i1, i1
    %5 = llvm.select %3, %0, %4 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @bools2_logical_commute0_and2(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.xor %arg2, %0  : i1
    %3 = llvm.select %arg2, %arg0, %1 : i1, i1
    %4 = llvm.and %2, %arg1  : i1
    %5 = llvm.select %3, %0, %4 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @bools2_logical_commute0_and1_and2(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg2, %0  : i1
    %2 = llvm.and %arg2, %arg0  : i1
    %3 = llvm.and %1, %arg1  : i1
    %4 = llvm.select %2, %0, %3 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @bools2_logical_commute1(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.xor %arg2, %0  : i1
    %3 = llvm.select %arg0, %arg2, %1 : i1, i1
    %4 = llvm.select %2, %arg1, %1 : i1, i1
    %5 = llvm.select %3, %0, %4 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @bools2_logical_commute1_and1(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.xor %arg2, %0  : i1
    %3 = llvm.and %arg0, %arg2  : i1
    %4 = llvm.select %2, %arg1, %1 : i1, i1
    %5 = llvm.select %3, %0, %4 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @bools2_logical_commute1_and2(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.xor %arg2, %0  : i1
    %3 = llvm.select %arg0, %arg2, %1 : i1, i1
    %4 = llvm.and %2, %arg1  : i1
    %5 = llvm.select %3, %0, %4 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @bools2_logical_commute1_and1_and2(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg2, %0  : i1
    %2 = llvm.and %arg0, %arg2  : i1
    %3 = llvm.and %1, %arg1  : i1
    %4 = llvm.select %2, %0, %3 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @bools2_logical_commute2(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.xor %arg2, %0  : i1
    %3 = llvm.select %arg2, %arg0, %1 : i1, i1
    %4 = llvm.select %arg1, %2, %1 : i1, i1
    %5 = llvm.select %3, %0, %4 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @bools2_logical_commute2_and1(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.xor %arg2, %0  : i1
    %3 = llvm.and %arg2, %arg0  : i1
    %4 = llvm.select %arg1, %2, %1 : i1, i1
    %5 = llvm.select %3, %0, %4 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @bools2_logical_commute2_and2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.call @gen1() : () -> i1
    %3 = llvm.xor %arg1, %0  : i1
    %4 = llvm.select %arg1, %arg0, %1 : i1, i1
    %5 = llvm.and %2, %3  : i1
    %6 = llvm.select %4, %0, %5 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @bools2_logical_commute2_and1_and2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.call @gen1() : () -> i1
    %2 = llvm.xor %arg1, %0  : i1
    %3 = llvm.and %arg1, %arg0  : i1
    %4 = llvm.and %1, %2  : i1
    %5 = llvm.select %3, %0, %4 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @bools2_logical_commute3(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.xor %arg2, %0  : i1
    %3 = llvm.select %arg0, %arg2, %1 : i1, i1
    %4 = llvm.select %arg1, %2, %1 : i1, i1
    %5 = llvm.select %3, %0, %4 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @bools2_logical_commute3_nopoison(%arg0: i1, %arg1: i1, %arg2: i1 {llvm.noundef}) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.xor %arg2, %0  : i1
    %3 = llvm.select %arg0, %arg2, %1 : i1, i1
    %4 = llvm.select %arg1, %2, %1 : i1, i1
    %5 = llvm.select %3, %0, %4 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @bools2_logical_commute3_and1(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.xor %arg2, %0  : i1
    %3 = llvm.and %arg0, %arg2  : i1
    %4 = llvm.select %arg1, %2, %1 : i1, i1
    %5 = llvm.select %3, %0, %4 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @bools2_logical_commute3_and2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.call @gen1() : () -> i1
    %3 = llvm.xor %arg1, %0  : i1
    %4 = llvm.select %arg0, %arg1, %1 : i1, i1
    %5 = llvm.and %2, %3  : i1
    %6 = llvm.select %4, %0, %5 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @bools2_logical_commute3_and1_and2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.call @gen1() : () -> i1
    %2 = llvm.xor %arg1, %0  : i1
    %3 = llvm.and %arg0, %arg1  : i1
    %4 = llvm.and %1, %2  : i1
    %5 = llvm.select %3, %0, %4 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @orn_and_cmp_1_logical(%arg0: i37, %arg1: i37, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "sgt" %arg0, %arg1 : i37
    %3 = llvm.icmp "sle" %arg0, %arg1 : i37
    %4 = llvm.select %arg2, %2, %0 : i1, i1
    %5 = llvm.select %3, %1, %4 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @orn_and_cmp_1_partial_logical(%arg0: i37, %arg1: i37, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "sgt" %arg0, %arg1 : i37
    %2 = llvm.icmp "sle" %arg0, %arg1 : i37
    %3 = llvm.and %1, %arg2  : i1
    %4 = llvm.select %2, %0, %3 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @orn_and_cmp_1_partial_logical_commute(%arg0: i37, %arg1: i37) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.call @gen1() : () -> i1
    %2 = llvm.icmp "sgt" %arg0, %arg1 : i37
    %3 = llvm.icmp "sle" %arg0, %arg1 : i37
    %4 = llvm.and %1, %2  : i1
    %5 = llvm.select %3, %0, %4 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @orn_and_cmp_2_logical(%arg0: i16, %arg1: i16, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "sge" %arg0, %arg1 : i16
    %3 = llvm.icmp "slt" %arg0, %arg1 : i16
    %4 = llvm.select %arg2, %2, %0 : i1, i1
    %5 = llvm.select %4, %1, %3 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @orn_and_cmp_2_partial_logical(%arg0: i16, %arg1: i16, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "sge" %arg0, %arg1 : i16
    %2 = llvm.icmp "slt" %arg0, %arg1 : i16
    %3 = llvm.and %1, %arg2  : i1
    %4 = llvm.select %3, %0, %2 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @orn_and_cmp_2_partial_logical_commute(%arg0: i16, %arg1: i16) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.call @gen1() : () -> i1
    %2 = llvm.icmp "sge" %arg0, %arg1 : i16
    %3 = llvm.icmp "slt" %arg0, %arg1 : i16
    %4 = llvm.and %1, %2  : i1
    %5 = llvm.select %4, %0, %3 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @not_logical_and(%arg0: i1, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<3> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    %4 = llvm.mlir.constant(true) : i1
    %5 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %6 = llvm.icmp "ult" %arg1, %0 : vector<2xi32>
    %7 = llvm.icmp "ugt" %arg1, %1 : vector<2xi32>
    %8 = llvm.select %arg0, %6, %3 : i1, vector<2xi1>
    %9 = llvm.select %7, %5, %8 : vector<2xi1>, vector<2xi1>
    llvm.return %9 : vector<2xi1>
  }
  llvm.func @not_logical_and2(%arg0: i1, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<3> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    %4 = llvm.mlir.constant(true) : i1
    %5 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %6 = llvm.icmp "ult" %arg1, %0 : vector<2xi32>
    %7 = llvm.icmp "ugt" %arg1, %1 : vector<2xi32>
    %8 = llvm.select %arg0, %6, %3 : i1, vector<2xi1>
    %9 = llvm.select %8, %5, %7 : vector<2xi1>, vector<2xi1>
    llvm.return %9 : vector<2xi1>
  }
}
