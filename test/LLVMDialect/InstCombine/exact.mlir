module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @sdiv1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.sdiv %arg0, %0  : i32
    llvm.return %1 : i32
  }
  llvm.func @sdiv2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.sdiv %arg0, %0  : i32
    llvm.return %1 : i32
  }
  llvm.func @sdiv2_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<128> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sdiv %arg0, %0  : vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }
  llvm.func @sdiv3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.sdiv %arg0, %0  : i32
    %2 = llvm.mul %1, %0  : i32
    llvm.return %2 : i32
  }
  llvm.func @sdiv4(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.sdiv %arg0, %0  : i32
    %2 = llvm.mul %1, %0  : i32
    llvm.return %2 : i32
  }
  llvm.func @sdiv5(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(-3 : i32) : i32
    %2 = llvm.sdiv %arg0, %0  : i32
    %3 = llvm.mul %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @sdiv6(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(-3 : i32) : i32
    %2 = llvm.sdiv %arg0, %0  : i32
    %3 = llvm.mul %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @udiv1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.udiv %arg0, %arg1  : i32
    %1 = llvm.mul %0, %arg1  : i32
    llvm.return %1 : i32
  }
  llvm.func @udiv2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.shl %0, %arg1  : i32
    %2 = llvm.udiv %arg0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @ashr1(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(8 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.shl %arg0, %0  : i64
    %3 = llvm.ashr %2, %1  : i64
    llvm.return %3 : i64
  }
  llvm.func @ashr1_vec(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<8> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<2> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.shl %arg0, %0  : vector<2xi64>
    %3 = llvm.ashr %2, %1  : vector<2xi64>
    llvm.return %3 : vector<2xi64>
  }
  llvm.func @ashr_icmp1(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.ashr %arg0, %0  : i64
    %3 = llvm.icmp "eq" %2, %1 : i64
    llvm.return %3 : i1
  }
  llvm.func @ashr_icmp2(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.mlir.constant(4 : i64) : i64
    %2 = llvm.ashr %arg0, %0  : i64
    %3 = llvm.icmp "slt" %2, %1 : i64
    llvm.return %3 : i1
  }
  llvm.func @ashr_icmp2_vec(%arg0: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<2> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<4> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.ashr %arg0, %0  : vector<2xi64>
    %3 = llvm.icmp "slt" %2, %1 : vector<2xi64>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @pr9998(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(7297771788697658747 : i64) : i64
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.ashr %2, %0  : i32
    %4 = llvm.sext %3 : i32 to i64
    %5 = llvm.icmp "ugt" %4, %1 : i64
    llvm.return %5 : i1
  }
  llvm.func @pr9998vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<31> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<7297771788697658747> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.shl %arg0, %0  : vector<2xi32>
    %3 = llvm.ashr %2, %0  : vector<2xi32>
    %4 = llvm.sext %3 : vector<2xi32> to vector<2xi64>
    %5 = llvm.icmp "ugt" %4, %1 : vector<2xi64>
    llvm.return %5 : vector<2xi1>
  }
  llvm.func @udiv_icmp1(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(5 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.udiv %arg0, %0  : i64
    %3 = llvm.icmp "ne" %2, %1 : i64
    llvm.return %3 : i1
  }
  llvm.func @udiv_icmp1_vec(%arg0: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %3 = llvm.udiv %arg0, %0  : vector<2xi64>
    %4 = llvm.icmp "ne" %3, %2 : vector<2xi64>
    llvm.return %4 : vector<2xi1>
  }
  llvm.func @udiv_icmp2(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(5 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.udiv %arg0, %0  : i64
    %3 = llvm.icmp "eq" %2, %1 : i64
    llvm.return %3 : i1
  }
  llvm.func @udiv_icmp2_vec(%arg0: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %3 = llvm.udiv %arg0, %0  : vector<2xi64>
    %4 = llvm.icmp "eq" %3, %2 : vector<2xi64>
    llvm.return %4 : vector<2xi1>
  }
  llvm.func @sdiv_icmp1(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(5 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.sdiv %arg0, %0  : i64
    %3 = llvm.icmp "eq" %2, %1 : i64
    llvm.return %3 : i1
  }
  llvm.func @sdiv_icmp1_vec(%arg0: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %3 = llvm.sdiv %arg0, %0  : vector<2xi64>
    %4 = llvm.icmp "eq" %3, %2 : vector<2xi64>
    llvm.return %4 : vector<2xi1>
  }
  llvm.func @sdiv_icmp2(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(5 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.sdiv %arg0, %0  : i64
    %3 = llvm.icmp "eq" %2, %1 : i64
    llvm.return %3 : i1
  }
  llvm.func @sdiv_icmp2_vec(%arg0: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<1> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.sdiv %arg0, %0  : vector<2xi64>
    %3 = llvm.icmp "eq" %2, %1 : vector<2xi64>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @sdiv_icmp3(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(5 : i64) : i64
    %1 = llvm.mlir.constant(-1 : i64) : i64
    %2 = llvm.sdiv %arg0, %0  : i64
    %3 = llvm.icmp "eq" %2, %1 : i64
    llvm.return %3 : i1
  }
  llvm.func @sdiv_icmp3_vec(%arg0: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.sdiv %arg0, %0  : vector<2xi64>
    %3 = llvm.icmp "eq" %2, %1 : vector<2xi64>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @sdiv_icmp4(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(-5 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.sdiv %arg0, %0  : i64
    %3 = llvm.icmp "eq" %2, %1 : i64
    llvm.return %3 : i1
  }
  llvm.func @sdiv_icmp4_vec(%arg0: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-5> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %3 = llvm.sdiv %arg0, %0  : vector<2xi64>
    %4 = llvm.icmp "eq" %3, %2 : vector<2xi64>
    llvm.return %4 : vector<2xi1>
  }
  llvm.func @sdiv_icmp5(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(-5 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.sdiv %arg0, %0  : i64
    %3 = llvm.icmp "eq" %2, %1 : i64
    llvm.return %3 : i1
  }
  llvm.func @sdiv_icmp5_vec(%arg0: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-5> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<1> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.sdiv %arg0, %0  : vector<2xi64>
    %3 = llvm.icmp "eq" %2, %1 : vector<2xi64>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @sdiv_icmp6(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(-5 : i64) : i64
    %1 = llvm.mlir.constant(-1 : i64) : i64
    %2 = llvm.sdiv %arg0, %0  : i64
    %3 = llvm.icmp "eq" %2, %1 : i64
    llvm.return %3 : i1
  }
  llvm.func @sdiv_icmp6_vec(%arg0: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-5> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.sdiv %arg0, %0  : vector<2xi64>
    %3 = llvm.icmp "eq" %2, %1 : vector<2xi64>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @mul_of_udiv(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(12 : i8) : i8
    %1 = llvm.mlir.constant(6 : i8) : i8
    %2 = llvm.udiv %arg0, %0  : i8
    %3 = llvm.mul %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @mul_of_sdiv(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(12 : i8) : i8
    %1 = llvm.mlir.constant(-6 : i8) : i8
    %2 = llvm.sdiv %arg0, %0  : i8
    %3 = llvm.mul %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @mul_of_sdiv_non_splat(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[6, -12]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<6> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.sdiv %arg0, %0  : vector<2xi8>
    %3 = llvm.mul %2, %1  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }
  llvm.func @mul_of_sdiv_fail_missing_exact(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(12 : i8) : i8
    %1 = llvm.mlir.constant(-6 : i8) : i8
    %2 = llvm.sdiv %arg0, %0  : i8
    %3 = llvm.mul %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @mul_of_udiv_fail_bad_remainder(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(11 : i8) : i8
    %1 = llvm.mlir.constant(6 : i8) : i8
    %2 = llvm.udiv %arg0, %0  : i8
    %3 = llvm.mul %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @mul_of_sdiv_fail_ub(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(-6 : i8) : i8
    %2 = llvm.sdiv %arg0, %0  : i8
    %3 = llvm.mul %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @mul_of_sdiv_fail_ub_non_splat(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[-6, -12]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<6> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.sdiv %arg0, %0  : vector<2xi8>
    %3 = llvm.mul %2, %1  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }
}
