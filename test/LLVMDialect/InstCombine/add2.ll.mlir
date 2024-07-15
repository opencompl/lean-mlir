module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test1(%arg0: i64, %arg1: i32) -> i64 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.constant(123 : i64) : i64
    %2 = llvm.zext %arg1 : i32 to i64
    %3 = llvm.shl %2, %0  : i64
    %4 = llvm.add %3, %arg0  : i64
    %5 = llvm.and %4, %1  : i64
    llvm.return %5 : i64
  }
  llvm.func @test2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.and %arg0, %1  : i32
    %4 = llvm.add %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @test3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.mlir.constant(30 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.lshr %arg0, %1  : i32
    %4 = llvm.add %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @test4(%arg0: i32) -> i32 {
    %0 = llvm.add %arg0, %arg0 overflow<nuw>  : i32
    llvm.return %0 : i32
  }
  llvm.func @test5(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.add %arg0, %arg1  : vector<2xi1>
    llvm.return %0 : vector<2xi1>
  }
  llvm.func @test6(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<[2, 3]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.shl %arg0, %0  : vector<2xi64>
    %2 = llvm.add %1, %arg0  : vector<2xi64>
    llvm.return %2 : vector<2xi64>
  }
  llvm.func @test7(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<[2, 3]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<[3, 4]> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.shl %arg0, %0  : vector<2xi64>
    %3 = llvm.mul %arg0, %1  : vector<2xi64>
    %4 = llvm.add %2, %3  : vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }
  llvm.func @test9(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(2 : i16) : i16
    %1 = llvm.mlir.constant(32767 : i16) : i16
    %2 = llvm.mul %arg0, %0  : i16
    %3 = llvm.mul %arg0, %1  : i16
    %4 = llvm.add %2, %3  : i16
    llvm.return %4 : i16
  }
  llvm.func @test10(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(-1431655766 : i32) : i32
    %2 = llvm.mlir.constant(1431655765 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.ashr %arg0, %0  : i32
    %5 = llvm.or %4, %1  : i32
    %6 = llvm.xor %5, %2  : i32
    %7 = llvm.add %arg1, %3  : i32
    %8 = llvm.add %7, %6  : i32
    llvm.return %8 : i32
  }
  llvm.func @test11(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1431655766 : i32) : i32
    %1 = llvm.mlir.constant(1431655765 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.or %arg0, %0  : i32
    %4 = llvm.xor %3, %1  : i32
    %5 = llvm.add %arg1, %2  : i32
    %6 = llvm.add %5, %4  : i32
    llvm.return %6 : i32
  }
  llvm.func @test12(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1431655766 : i32) : i32
    %2 = llvm.mlir.constant(1431655765 : i32) : i32
    %3 = llvm.add %arg1, %0 overflow<nsw>  : i32
    %4 = llvm.or %arg0, %1  : i32
    %5 = llvm.xor %4, %2  : i32
    %6 = llvm.add %3, %5 overflow<nsw>  : i32
    llvm.return %6 : i32
  }
  llvm.func @test13(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1431655767 : i32) : i32
    %1 = llvm.mlir.constant(1431655766 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.or %arg0, %0  : i32
    %4 = llvm.xor %3, %1  : i32
    %5 = llvm.add %arg1, %2  : i32
    %6 = llvm.add %5, %4  : i32
    llvm.return %6 : i32
  }
  llvm.func @test14(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1431655767 : i32) : i32
    %2 = llvm.mlir.constant(1431655766 : i32) : i32
    %3 = llvm.add %arg1, %0 overflow<nsw>  : i32
    %4 = llvm.or %arg0, %1  : i32
    %5 = llvm.xor %4, %2  : i32
    %6 = llvm.add %3, %5 overflow<nsw>  : i32
    llvm.return %6 : i32
  }
  llvm.func @test15(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1431655767 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.add %arg1, %1  : i32
    %5 = llvm.add %4, %3  : i32
    llvm.return %5 : i32
  }
  llvm.func @test16(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1431655767 : i32) : i32
    %2 = llvm.add %arg1, %0 overflow<nsw>  : i32
    %3 = llvm.and %arg0, %1  : i32
    %4 = llvm.xor %3, %1  : i32
    %5 = llvm.add %2, %4 overflow<nsw>  : i32
    llvm.return %5 : i32
  }
  llvm.func @test17(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1431655766 : i32) : i32
    %1 = llvm.mlir.constant(-1431655765 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.xor %2, %1  : i32
    %4 = llvm.add %3, %arg1 overflow<nsw>  : i32
    llvm.return %4 : i32
  }
  llvm.func @test18(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1431655766 : i32) : i32
    %2 = llvm.add %arg1, %0 overflow<nsw>  : i32
    %3 = llvm.and %arg0, %1  : i32
    %4 = llvm.xor %3, %1  : i32
    %5 = llvm.add %2, %4 overflow<nsw>  : i32
    llvm.return %5 : i32
  }
  llvm.func @add_nsw_mul_nsw(%arg0: i16) -> i16 {
    %0 = llvm.add %arg0, %arg0 overflow<nsw>  : i16
    %1 = llvm.add %0, %arg0 overflow<nsw>  : i16
    llvm.return %1 : i16
  }
  llvm.func @mul_add_to_mul_1(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(8 : i16) : i16
    %1 = llvm.mul %arg0, %0 overflow<nsw>  : i16
    %2 = llvm.add %arg0, %1 overflow<nsw>  : i16
    llvm.return %2 : i16
  }
  llvm.func @mul_add_to_mul_2(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(8 : i16) : i16
    %1 = llvm.mul %arg0, %0 overflow<nsw>  : i16
    %2 = llvm.add %1, %arg0 overflow<nsw>  : i16
    llvm.return %2 : i16
  }
  llvm.func @mul_add_to_mul_3(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(2 : i16) : i16
    %1 = llvm.mlir.constant(3 : i16) : i16
    %2 = llvm.mul %arg0, %0  : i16
    %3 = llvm.mul %arg0, %1  : i16
    %4 = llvm.add %2, %3 overflow<nsw>  : i16
    llvm.return %4 : i16
  }
  llvm.func @mul_add_to_mul_4(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(2 : i16) : i16
    %1 = llvm.mlir.constant(7 : i16) : i16
    %2 = llvm.mul %arg0, %0 overflow<nsw>  : i16
    %3 = llvm.mul %arg0, %1 overflow<nsw>  : i16
    %4 = llvm.add %2, %3 overflow<nsw>  : i16
    llvm.return %4 : i16
  }
  llvm.func @mul_add_to_mul_5(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(3 : i16) : i16
    %1 = llvm.mlir.constant(7 : i16) : i16
    %2 = llvm.mul %arg0, %0 overflow<nsw>  : i16
    %3 = llvm.mul %arg0, %1 overflow<nsw>  : i16
    %4 = llvm.add %2, %3 overflow<nsw>  : i16
    llvm.return %4 : i16
  }
  llvm.func @mul_add_to_mul_6(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mul %arg0, %arg1 overflow<nsw>  : i32
    %2 = llvm.mul %1, %0 overflow<nsw>  : i32
    %3 = llvm.add %1, %2 overflow<nsw>  : i32
    llvm.return %3 : i32
  }
  llvm.func @mul_add_to_mul_7(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(32767 : i16) : i16
    %1 = llvm.mul %arg0, %0 overflow<nsw>  : i16
    %2 = llvm.add %arg0, %1 overflow<nsw>  : i16
    llvm.return %2 : i16
  }
  llvm.func @mul_add_to_mul_8(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(16383 : i16) : i16
    %1 = llvm.mlir.constant(16384 : i16) : i16
    %2 = llvm.mul %arg0, %0 overflow<nsw>  : i16
    %3 = llvm.mul %arg0, %1 overflow<nsw>  : i16
    %4 = llvm.add %2, %3 overflow<nsw>  : i16
    llvm.return %4 : i16
  }
  llvm.func @mul_add_to_mul_9(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(16384 : i16) : i16
    %1 = llvm.mul %arg0, %0 overflow<nsw>  : i16
    %2 = llvm.mul %arg0, %0 overflow<nsw>  : i16
    %3 = llvm.add %1, %2 overflow<nsw>  : i16
    llvm.return %3 : i16
  }
  llvm.func @add_cttz(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(-8 : i16) : i16
    %1 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = true}> : (i16) -> i16
    %2 = llvm.add %1, %0  : i16
    llvm.return %2 : i16
  }
  llvm.func @add_cttz_2(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(-16 : i16) : i16
    %1 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = true}> : (i16) -> i16
    %2 = llvm.add %1, %0  : i16
    llvm.return %2 : i16
  }
  llvm.func @add_or_and(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.or %arg0, %arg1  : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.add %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @add_or_and_commutative(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.or %arg0, %arg1  : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.add %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @add_and_or(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.or %arg0, %arg1  : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.add %1, %0  : i32
    llvm.return %2 : i32
  }
  llvm.func @add_and_or_commutative(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.or %arg0, %arg1  : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.add %1, %0  : i32
    llvm.return %2 : i32
  }
  llvm.func @add_nsw_or_and(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.or %arg0, %arg1  : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.add %0, %1 overflow<nsw>  : i32
    llvm.return %2 : i32
  }
  llvm.func @add_nuw_or_and(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.or %arg0, %arg1  : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.add %0, %1 overflow<nuw>  : i32
    llvm.return %2 : i32
  }
  llvm.func @add_nuw_nsw_or_and(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.or %arg0, %arg1  : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.add %0, %1 overflow<nsw, nuw>  : i32
    llvm.return %2 : i32
  }
  llvm.func @add_of_mul(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mul %arg0, %arg1 overflow<nsw>  : i8
    %1 = llvm.mul %arg0, %arg2 overflow<nsw>  : i8
    %2 = llvm.add %0, %1 overflow<nsw>  : i8
    llvm.return %2 : i8
  }
  llvm.func @add_of_selects(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.select %arg0, %0, %1 : i1, i32
    %4 = llvm.select %arg0, %arg1, %2 : i1, i32
    %5 = llvm.add %3, %4  : i32
    llvm.return %5 : i32
  }
  llvm.func @add_undemanded_low_bits(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(1616 : i32) : i32
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.or %arg0, %0  : i32
    %4 = llvm.add %3, %1  : i32
    %5 = llvm.lshr %4, %2  : i32
    llvm.return %5 : i32
  }
  llvm.func @sub_undemanded_low_bits(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(1616 : i32) : i32
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.or %arg0, %0  : i32
    %4 = llvm.sub %3, %1  : i32
    %5 = llvm.lshr %4, %2  : i32
    llvm.return %5 : i32
  }
}
