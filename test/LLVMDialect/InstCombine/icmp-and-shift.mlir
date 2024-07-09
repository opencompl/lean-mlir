module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use(i8)
  llvm.func @icmp_eq_and_pow2_shl1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.shl %0, %arg0  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.icmp "eq" %4, %2 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }
  llvm.func @icmp_eq_and_pow2_shl1_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.shl %0, %arg0  : vector<2xi32>
    %5 = llvm.and %4, %1  : vector<2xi32>
    %6 = llvm.icmp "eq" %5, %3 : vector<2xi32>
    %7 = llvm.zext %6 : vector<2xi1> to vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }
  llvm.func @icmp_ne_and_pow2_shl1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.shl %0, %arg0  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.icmp "ne" %4, %2 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }
  llvm.func @icmp_ne_and_pow2_shl1_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.shl %0, %arg0  : vector<2xi32>
    %5 = llvm.and %4, %1  : vector<2xi32>
    %6 = llvm.icmp "ne" %5, %3 : vector<2xi32>
    %7 = llvm.zext %6 : vector<2xi1> to vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }
  llvm.func @icmp_eq_and_pow2_shl_pow2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.shl %0, %arg0  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.icmp "eq" %4, %2 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }
  llvm.func @icmp_eq_and_pow2_shl_pow2_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<4> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.shl %0, %arg0  : vector<2xi32>
    %5 = llvm.and %4, %1  : vector<2xi32>
    %6 = llvm.icmp "eq" %5, %3 : vector<2xi32>
    %7 = llvm.zext %6 : vector<2xi1> to vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }
  llvm.func @icmp_ne_and_pow2_shl_pow2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.shl %0, %arg0  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.icmp "ne" %4, %2 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }
  llvm.func @icmp_ne_and_pow2_shl_pow2_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<4> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.shl %0, %arg0  : vector<2xi32>
    %5 = llvm.and %4, %1  : vector<2xi32>
    %6 = llvm.icmp "ne" %5, %3 : vector<2xi32>
    %7 = llvm.zext %6 : vector<2xi1> to vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }
  llvm.func @icmp_eq_and_pow2_shl_pow2_negative1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(11 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.shl %0, %arg0  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.icmp "eq" %4, %2 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }
  llvm.func @icmp_eq_and_pow2_shl_pow2_negative2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(14 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.shl %0, %arg0  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.icmp "eq" %4, %2 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }
  llvm.func @icmp_eq_and_pow2_shl_pow2_negative3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.shl %0, %arg0  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.icmp "eq" %4, %2 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }
  llvm.func @icmp_eq_and_pow2_minus1_shl1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(15 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.shl %0, %arg0  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.icmp "eq" %4, %2 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }
  llvm.func @icmp_eq_and_pow2_minus1_shl1_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<15> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.shl %0, %arg0  : vector<2xi32>
    %5 = llvm.and %4, %1  : vector<2xi32>
    %6 = llvm.icmp "eq" %5, %3 : vector<2xi32>
    %7 = llvm.zext %6 : vector<2xi1> to vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }
  llvm.func @icmp_ne_and_pow2_minus1_shl1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(15 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.shl %0, %arg0  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.icmp "ne" %4, %2 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }
  llvm.func @icmp_ne_and_pow2_minus1_shl1_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<15> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.shl %0, %arg0  : vector<2xi32>
    %5 = llvm.and %4, %1  : vector<2xi32>
    %6 = llvm.icmp "ne" %5, %3 : vector<2xi32>
    %7 = llvm.zext %6 : vector<2xi1> to vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }
  llvm.func @icmp_eq_and_pow2_minus1_shl_pow2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(15 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.shl %0, %arg0  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.icmp "eq" %4, %2 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }
  llvm.func @icmp_eq_and_pow2_minus1_shl_pow2_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<4> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<15> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.shl %0, %arg0  : vector<2xi32>
    %5 = llvm.and %4, %1  : vector<2xi32>
    %6 = llvm.icmp "eq" %5, %3 : vector<2xi32>
    %7 = llvm.zext %6 : vector<2xi1> to vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }
  llvm.func @icmp_ne_and_pow2_minus1_shl_pow2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(15 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.shl %0, %arg0  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.icmp "ne" %4, %2 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }
  llvm.func @icmp_ne_and_pow2_minus1_shl_pow2_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<4> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<15> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.shl %0, %arg0  : vector<2xi32>
    %5 = llvm.and %4, %1  : vector<2xi32>
    %6 = llvm.icmp "ne" %5, %3 : vector<2xi32>
    %7 = llvm.zext %6 : vector<2xi1> to vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }
  llvm.func @icmp_eq_and_pow2_minus1_shl1_negative1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(15 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.shl %0, %arg0  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.icmp "eq" %4, %2 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }
  llvm.func @icmp_eq_and_pow2_minus1_shl1_negative2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(15 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.shl %0, %arg0  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.icmp "eq" %4, %2 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }
  llvm.func @icmp_eq_and1_lshr_pow2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.lshr %0, %arg0  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.icmp "eq" %4, %2 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }
  llvm.func @icmp_eq_and1_lshr_pow2_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.lshr %0, %arg0  : vector<2xi32>
    %5 = llvm.and %4, %1  : vector<2xi32>
    %6 = llvm.icmp "eq" %5, %3 : vector<2xi32>
    %7 = llvm.zext %6 : vector<2xi1> to vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }
  llvm.func @icmp_ne_and1_lshr_pow2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.lshr %0, %arg0  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.icmp "eq" %4, %2 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }
  llvm.func @icmp_ne_and1_lshr_pow2_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<4> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.lshr %0, %arg0  : vector<2xi32>
    %5 = llvm.and %4, %1  : vector<2xi32>
    %6 = llvm.icmp "ne" %5, %3 : vector<2xi32>
    %7 = llvm.zext %6 : vector<2xi1> to vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }
  llvm.func @icmp_eq_and_pow2_lshr_pow2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.lshr %0, %arg0  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.icmp "eq" %4, %2 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }
  llvm.func @icmp_eq_and_pow2_lshr_pow2_case2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.lshr %0, %arg0  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.icmp "eq" %4, %2 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }
  llvm.func @icmp_eq_and_pow2_lshr_pow2_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<4> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.lshr %0, %arg0  : vector<2xi32>
    %5 = llvm.and %4, %1  : vector<2xi32>
    %6 = llvm.icmp "eq" %5, %3 : vector<2xi32>
    %7 = llvm.zext %6 : vector<2xi1> to vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }
  llvm.func @icmp_ne_and_pow2_lshr_pow2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.lshr %0, %arg0  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.icmp "eq" %4, %2 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }
  llvm.func @icmp_ne_and_pow2_lshr_pow2_case2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.lshr %0, %arg0  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.icmp "eq" %4, %2 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }
  llvm.func @icmp_ne_and_pow2_lshr_pow2_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<4> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.lshr %0, %arg0  : vector<2xi32>
    %5 = llvm.and %4, %1  : vector<2xi32>
    %6 = llvm.icmp "ne" %5, %3 : vector<2xi32>
    %7 = llvm.zext %6 : vector<2xi1> to vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }
  llvm.func @icmp_eq_and1_lshr_pow2_negative1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.lshr %0, %arg0  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.icmp "eq" %4, %2 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }
  llvm.func @icmp_eq_and1_lshr_pow2_negative2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.lshr %0, %arg0  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.icmp "eq" %4, %2 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }
  llvm.func @eq_and_shl_one(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.shl %0, %arg1  : i8
    %2 = llvm.and %1, %arg0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @ne_and_shl_one_commute(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.shl %6, %arg1  : vector<2xi8>
    %8 = llvm.and %7, %arg0  : vector<2xi8>
    %9 = llvm.icmp "ne" %7, %8 : vector<2xi8>
    llvm.return %9 : vector<2xi1>
  }
  llvm.func @ne_and_lshr_minval(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mul %arg0, %arg0  : i8
    %2 = llvm.lshr %0, %arg1  : i8
    %3 = llvm.and %1, %2  : i8
    %4 = llvm.icmp "ne" %3, %2 : i8
    llvm.return %4 : i1
  }
  llvm.func @eq_and_lshr_minval_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mul %arg0, %arg0  : i8
    %2 = llvm.lshr %0, %arg1  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.and %1, %2  : i8
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.icmp "eq" %2, %3 : i8
    llvm.return %4 : i1
  }
  llvm.func @eq_and_shl_two(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.shl %0, %arg1  : i8
    %2 = llvm.and %arg0, %1  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @slt_and_shl_one(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.shl %0, %arg1  : i8
    %2 = llvm.and %arg0, %1  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @fold_eq_lhs(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.shl %0, %arg0  : i8
    %3 = llvm.and %2, %arg1  : i8
    %4 = llvm.icmp "eq" %3, %1 : i8
    llvm.return %4 : i1
  }
  llvm.func @fold_eq_lhs_fail_eq_nonzero(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.shl %0, %arg0  : i8
    %3 = llvm.and %2, %arg1  : i8
    %4 = llvm.icmp "eq" %3, %1 : i8
    llvm.return %4 : i1
  }
  llvm.func @fold_eq_lhs_fail_multiuse_shl(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.shl %0, %arg0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.and %2, %arg1  : i8
    %4 = llvm.icmp "eq" %3, %1 : i8
    llvm.return %4 : i1
  }
  llvm.func @fold_ne_rhs(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.xor %arg1, %0  : i8
    %4 = llvm.shl %1, %arg0  : i8
    %5 = llvm.and %3, %4  : i8
    %6 = llvm.icmp "ne" %5, %2 : i8
    llvm.return %6 : i1
  }
  llvm.func @fold_ne_rhs_fail_multiuse_and(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.xor %arg1, %0  : i8
    %4 = llvm.shl %1, %arg0  : i8
    %5 = llvm.and %3, %4  : i8
    llvm.call @use(%5) : (i8) -> ()
    %6 = llvm.icmp "ne" %5, %2 : i8
    llvm.return %6 : i1
  }
  llvm.func @fold_ne_rhs_fail_shift_not_1s(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(-2 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.xor %arg1, %0  : i8
    %4 = llvm.shl %1, %arg0  : i8
    %5 = llvm.and %3, %4  : i8
    %6 = llvm.icmp "ne" %5, %2 : i8
    llvm.return %6 : i1
  }
}
