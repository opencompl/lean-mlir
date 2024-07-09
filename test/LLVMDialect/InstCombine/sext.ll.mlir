module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use(i8)
  llvm.func @use_vec(vector<2xi5>)
  llvm.func @test1(%arg0: i32) -> i64 {
    %0 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %1 = llvm.sext %0 : i32 to i64
    llvm.return %1 : i64
  }
  llvm.func @test2(%arg0: i32) -> i64 {
    %0 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = true}> : (i32) -> i32
    %1 = llvm.sext %0 : i32 to i64
    llvm.return %1 : i64
  }
  llvm.func @test3(%arg0: i32) -> i64 {
    %0 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = true}> : (i32) -> i32
    %1 = llvm.sext %0 : i32 to i64
    llvm.return %1 : i64
  }
  llvm.func @test4(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.udiv %arg0, %0  : i32
    %2 = llvm.sext %1 : i32 to i64
    llvm.return %2 : i64
  }
  llvm.func @test5(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(30000 : i32) : i32
    %1 = llvm.urem %arg0, %0  : i32
    %2 = llvm.sext %1 : i32 to i64
    llvm.return %2 : i64
  }
  llvm.func @test6(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    %2 = llvm.mul %1, %0  : i32
    %3 = llvm.sext %2 : i32 to i64
    llvm.return %3 : i64
  }
  llvm.func @test7(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(511 : i32) : i32
    %1 = llvm.mlir.constant(20000 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.sub %1, %2  : i32
    %4 = llvm.sext %3 : i32 to i64
    llvm.return %4 : i64
  }
  llvm.func @test8(%arg0: i8, %arg1: i32, %arg2: i1, %arg3: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %arg1, %0  : i32
    %3 = llvm.select %arg2, %2, %1 : i1, i32
    %4 = llvm.trunc %3 : i32 to i16
    %5 = llvm.sext %4 : i16 to i32
    llvm.return %5 : i32
  }
  llvm.func @test9(%arg0: i16, %arg1: i1) -> i16 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    llvm.cond_br %arg1, ^bb1, ^bb2(%0 : i32)
  ^bb1:  // pred: ^bb0
    %1 = llvm.sext %arg0 : i16 to i32
    llvm.br ^bb2(%1 : i32)
  ^bb2(%2: i32):  // 2 preds: ^bb0, ^bb1
    %3 = llvm.trunc %2 : i32 to i16
    llvm.return %3 : i16
  }
  llvm.func @test10(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.trunc %arg0 : i32 to i8
    %2 = llvm.shl %1, %0  : i8
    %3 = llvm.ashr %2, %0  : i8
    %4 = llvm.sext %3 : i8 to i32
    llvm.return %4 : i32
  }
  llvm.func @test10_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<6> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.trunc %arg0 : vector<2xi32> to vector<2xi8>
    %2 = llvm.shl %1, %0  : vector<2xi8>
    %3 = llvm.ashr %2, %0  : vector<2xi8>
    %4 = llvm.sext %3 : vector<2xi8> to vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }
  llvm.func @test10_vec_nonuniform(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[6, 3]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.trunc %arg0 : vector<2xi32> to vector<2xi8>
    %2 = llvm.shl %1, %0  : vector<2xi8>
    %3 = llvm.ashr %2, %0  : vector<2xi8>
    %4 = llvm.sext %3 : vector<2xi8> to vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }
  llvm.func @test10_vec_poison0(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[6, 0]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.poison : i8
    %2 = llvm.mlir.constant(6 : i8) : i8
    %3 = llvm.mlir.undef : vector<2xi8>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi8>
    %8 = llvm.trunc %arg0 : vector<2xi32> to vector<2xi8>
    %9 = llvm.shl %8, %0  : vector<2xi8>
    %10 = llvm.ashr %9, %7  : vector<2xi8>
    %11 = llvm.sext %10 : vector<2xi8> to vector<2xi32>
    llvm.return %11 : vector<2xi32>
  }
  llvm.func @test10_vec_poison1(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(6 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(dense<[6, 0]> : vector<2xi8>) : vector<2xi8>
    %8 = llvm.trunc %arg0 : vector<2xi32> to vector<2xi8>
    %9 = llvm.shl %8, %6  : vector<2xi8>
    %10 = llvm.ashr %9, %7  : vector<2xi8>
    %11 = llvm.sext %10 : vector<2xi8> to vector<2xi32>
    llvm.return %11 : vector<2xi32>
  }
  llvm.func @test10_vec_poison2(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(6 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.trunc %arg0 : vector<2xi32> to vector<2xi8>
    %8 = llvm.shl %7, %6  : vector<2xi8>
    %9 = llvm.ashr %8, %6  : vector<2xi8>
    %10 = llvm.sext %9 : vector<2xi8> to vector<2xi32>
    llvm.return %10 : vector<2xi32>
  }
  llvm.func @test11(%arg0: vector<2xi16>, %arg1: vector<2xi16>, %arg2: !llvm.ptr) {
    %0 = llvm.mlir.constant(dense<15> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.icmp "eq" %arg1, %arg0 : vector<2xi16>
    %2 = llvm.sext %1 : vector<2xi1> to vector<2xi16>
    %3 = llvm.ashr %2, %0  : vector<2xi16>
    llvm.store %3, %arg2 {alignment = 4 : i64} : vector<2xi16>, !llvm.ptr
    llvm.return
  }
  llvm.func @test12(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.sub %1, %2 overflow<nsw>  : i32
    %4 = llvm.sext %3 : i32 to i64
    llvm.return %4 : i64
  }
  llvm.func @test13(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    %4 = llvm.sext %3 : i1 to i32
    llvm.return %4 : i32
  }
  llvm.func @test14(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(16 : i16) : i16
    %1 = llvm.and %arg0, %0  : i16
    %2 = llvm.icmp "ne" %1, %0 : i16
    %3 = llvm.sext %2 : i1 to i32
    llvm.return %3 : i32
  }
  llvm.func @test15(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    %4 = llvm.sext %3 : i1 to i32
    llvm.return %4 : i32
  }
  llvm.func @test16(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(8 : i16) : i16
    %1 = llvm.and %arg0, %0  : i16
    %2 = llvm.icmp "eq" %1, %0 : i16
    %3 = llvm.sext %2 : i1 to i32
    llvm.return %3 : i32
  }
  llvm.func @test17(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.sub %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @test18(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.icmp "slt" %arg0, %0 : i16
    %2 = llvm.select %1, %0, %arg0 : i1, i16
    %3 = llvm.sext %2 : i16 to i32
    llvm.return %3 : i32
  }
  llvm.func @test19(%arg0: i10) -> i10 {
    %0 = llvm.mlir.constant(2 : i3) : i3
    %1 = llvm.trunc %arg0 : i10 to i3
    %2 = llvm.shl %1, %0  : i3
    %3 = llvm.ashr %2, %0  : i3
    %4 = llvm.sext %3 : i3 to i10
    llvm.return %4 : i10
  }
  llvm.func @smear_set_bit(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.trunc %arg0 : i32 to i8
    %2 = llvm.ashr %1, %0  : i8
    %3 = llvm.sext %2 : i8 to i32
    llvm.return %3 : i32
  }
  llvm.func @smear_set_bit_vec_use1(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(4 : i5) : i5
    %1 = llvm.mlir.constant(dense<4> : vector<2xi5>) : vector<2xi5>
    %2 = llvm.trunc %arg0 : vector<2xi32> to vector<2xi5>
    llvm.call @use_vec(%2) : (vector<2xi5>) -> ()
    %3 = llvm.ashr %2, %1  : vector<2xi5>
    %4 = llvm.sext %3 : vector<2xi5> to vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }
  llvm.func @smear_set_bit_use2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.trunc %arg0 : i32 to i8
    %2 = llvm.ashr %1, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.sext %2 : i8 to i32
    llvm.return %3 : i32
  }
  llvm.func @smear_set_bit_wrong_shift_amount(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.trunc %arg0 : i32 to i8
    %2 = llvm.ashr %1, %0  : i8
    %3 = llvm.sext %2 : i8 to i32
    llvm.return %3 : i32
  }
  llvm.func @smear_set_bit_different_dest_type(%arg0: i32) -> i16 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.trunc %arg0 : i32 to i8
    %2 = llvm.ashr %1, %0  : i8
    %3 = llvm.sext %2 : i8 to i16
    llvm.return %3 : i16
  }
  llvm.func @smear_set_bit_different_dest_type_extra_use(%arg0: i32) -> i16 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.trunc %arg0 : i32 to i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.ashr %1, %0  : i8
    %3 = llvm.sext %2 : i8 to i16
    llvm.return %3 : i16
  }
  llvm.func @smear_set_bit_different_dest_type_wider_dst(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.trunc %arg0 : i32 to i8
    %2 = llvm.ashr %1, %0  : i8
    %3 = llvm.sext %2 : i8 to i64
    llvm.return %3 : i64
  }
}
