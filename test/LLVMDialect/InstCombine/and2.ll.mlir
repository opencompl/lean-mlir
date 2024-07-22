module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.and %arg0, %arg1  : i1
    %1 = llvm.and %0, %arg0  : i1
    llvm.return %1 : i1
  }
  llvm.func @test2_logical(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.select %arg0, %arg1, %0 : i1, i1
    %2 = llvm.select %1, %arg0, %0 : i1, i1
    llvm.return %2 : i1
  }
  llvm.func @test3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.and %arg0, %arg1  : i32
    %1 = llvm.and %arg1, %0  : i32
    llvm.return %1 : i32
  }
  llvm.func @test7(%arg0: i32, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.icmp "sgt" %arg0, %1 : i32
    %4 = llvm.and %2, %arg1  : i1
    %5 = llvm.and %4, %3  : i1
    llvm.return %5 : i1
  }
  llvm.func @test7_logical(%arg0: i32, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    %4 = llvm.icmp "sgt" %arg0, %1 : i32
    %5 = llvm.select %3, %arg1, %2 : i1, i1
    %6 = llvm.select %5, %4, %2 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @test8(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(14 : i32) : i32
    %2 = llvm.icmp "ne" %arg0, %0 : i32
    %3 = llvm.icmp "ult" %arg0, %1 : i32
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @test8_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(14 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.icmp "ne" %arg0, %0 : i32
    %4 = llvm.icmp "ult" %arg0, %1 : i32
    %5 = llvm.select %3, %4, %2 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @test8vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<14> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.icmp "ne" %arg0, %1 : vector<2xi32>
    %4 = llvm.icmp "ult" %arg0, %2 : vector<2xi32>
    %5 = llvm.and %3, %4  : vector<2xi1>
    llvm.return %5 : vector<2xi1>
  }
  llvm.func @test9(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : i64
    %3 = llvm.and %2, %1  : i64
    llvm.return %3 : i64
  }
  llvm.func @test9vec(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.mlir.constant(dense<1> : vector<2xi64>) : vector<2xi64>
    %3 = llvm.sub %1, %arg0 overflow<nsw>  : vector<2xi64>
    %4 = llvm.and %3, %2  : vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }
  llvm.func @test10(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : i64
    %3 = llvm.and %2, %1  : i64
    %4 = llvm.add %2, %3  : i64
    llvm.return %4 : i64
  }
  llvm.func @and1_shl1_is_cmp_eq_0(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.shl %0, %arg0  : i8
    %2 = llvm.and %1, %0  : i8
    llvm.return %2 : i8
  }
  llvm.func @and1_shl1_is_cmp_eq_0_multiuse(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.shl %0, %arg0  : i8
    %2 = llvm.and %1, %0  : i8
    %3 = llvm.add %1, %2  : i8
    llvm.return %3 : i8
  }
  llvm.func @and1_shl1_is_cmp_eq_0_vec(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.shl %0, %arg0  : vector<2xi8>
    %2 = llvm.and %1, %0  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }
  llvm.func @and1_shl1_is_cmp_eq_0_vec_poison(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.shl %6, %arg0  : vector<2xi8>
    %8 = llvm.and %7, %6  : vector<2xi8>
    llvm.return %8 : vector<2xi8>
  }
  llvm.func @and1_lshr1_is_cmp_eq_0(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.lshr %0, %arg0  : i8
    %2 = llvm.and %1, %0  : i8
    llvm.return %2 : i8
  }
  llvm.func @and1_lshr1_is_cmp_eq_0_multiuse(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.lshr %0, %arg0  : i8
    %2 = llvm.and %1, %0  : i8
    %3 = llvm.add %1, %2  : i8
    llvm.return %3 : i8
  }
  llvm.func @and1_lshr1_is_cmp_eq_0_vec(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.lshr %0, %arg0  : vector<2xi8>
    %2 = llvm.and %1, %0  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }
  llvm.func @and1_lshr1_is_cmp_eq_0_vec_poison(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.lshr %6, %arg0  : vector<2xi8>
    %8 = llvm.and %7, %6  : vector<2xi8>
    llvm.return %8 : vector<2xi8>
  }
  llvm.func @test11(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(128 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.add %2, %arg1  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.mul %4, %2  : i32
    llvm.return %5 : i32
  }
  llvm.func @test12(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(128 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.add %arg1, %2  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.mul %4, %2  : i32
    llvm.return %5 : i32
  }
  llvm.func @test13(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(128 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.sub %arg1, %2  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.mul %4, %2  : i32
    llvm.return %5 : i32
  }
  llvm.func @test14(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(128 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.sub %2, %arg1  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.mul %4, %2  : i32
    llvm.return %5 : i32
  }
}
