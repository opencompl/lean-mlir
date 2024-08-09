module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global common @a(dense<0> : tensor<5xi16>) {addr_space = 0 : i32, alignment = 2 : i64} : !llvm.array<5 x i16>
  llvm.mlir.global common @b(0 : i16) {addr_space = 0 : i32, alignment = 2 : i64} : i16
  llvm.func @use(i32)
  llvm.func @rem_signed(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.sdiv %arg0, %arg1  : i64
    %1 = llvm.mul %0, %arg1  : i64
    %2 = llvm.sub %arg0, %1  : i64
    llvm.return %2 : i64
  }
  llvm.func @rem_signed_vec(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.sdiv %arg0, %arg1  : vector<4xi32>
    %1 = llvm.mul %0, %arg1  : vector<4xi32>
    %2 = llvm.sub %arg0, %1  : vector<4xi32>
    llvm.return %2 : vector<4xi32>
  }
  llvm.func @rem_unsigned(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.udiv %arg0, %arg1  : i64
    %1 = llvm.mul %0, %arg1  : i64
    %2 = llvm.sub %arg0, %1  : i64
    llvm.return %2 : i64
  }
  llvm.func @big_divisor(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-127 : i8) : i8
    %1 = llvm.urem %arg0, %0  : i8
    llvm.return %1 : i8
  }
  llvm.func @biggest_divisor(%arg0: i5) -> i5 {
    %0 = llvm.mlir.constant(-1 : i5) : i5
    %1 = llvm.urem %arg0, %0  : i5
    llvm.return %1 : i5
  }
  llvm.func @urem_with_sext_bool_divisor(%arg0: i1, %arg1: i8) -> i8 {
    %0 = llvm.sext %arg0 : i1 to i8
    %1 = llvm.urem %arg1, %0  : i8
    llvm.return %1 : i8
  }
  llvm.func @urem_with_sext_bool_divisor_vec(%arg0: vector<2xi1>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.sext %arg0 : vector<2xi1> to vector<2xi8>
    %1 = llvm.urem %arg1, %0  : vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }
  llvm.func @big_divisor_vec(%arg0: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-3 : i4) : i4
    %1 = llvm.mlir.constant(dense<-3> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.urem %arg0, %1  : vector<2xi4>
    llvm.return %2 : vector<2xi4>
  }
  llvm.func @urem1(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.udiv %arg0, %arg1  : i8
    %1 = llvm.mul %0, %arg1  : i8
    %2 = llvm.sub %arg0, %1  : i8
    llvm.return %2 : i8
  }
  llvm.func @srem1(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.sdiv %arg0, %arg1  : i8
    %1 = llvm.mul %0, %arg1  : i8
    %2 = llvm.sub %arg0, %1  : i8
    llvm.return %2 : i8
  }
  llvm.func @urem2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.udiv %arg0, %arg1  : i8
    %1 = llvm.mul %0, %arg1  : i8
    %2 = llvm.sub %1, %arg0  : i8
    llvm.return %2 : i8
  }
  llvm.func @urem3(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(-3 : i8) : i8
    %2 = llvm.udiv %arg0, %0  : i8
    %3 = llvm.mul %2, %1  : i8
    %4 = llvm.sub %arg0, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @sdiv_mul_sdiv(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.sdiv %arg0, %arg1  : i32
    %1 = llvm.mul %0, %arg1  : i32
    %2 = llvm.sdiv %1, %arg1  : i32
    llvm.return %2 : i32
  }
  llvm.func @udiv_mul_udiv(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.udiv %arg0, %arg1  : i32
    %1 = llvm.mul %0, %arg1  : i32
    %2 = llvm.udiv %1, %arg1  : i32
    llvm.return %2 : i32
  }
  llvm.func @test1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.srem %arg0, %0  : i32
    llvm.return %1 : i32
  }
  llvm.func @test3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.urem %arg0, %0  : i32
    llvm.return %1 : i32
  }
  llvm.func @vec_power_of_2_constant_splat_divisor(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.urem %arg0, %0  : vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }
  llvm.func @weird_vec_power_of_2_constant_splat_divisor(%arg0: vector<2xi19>) -> vector<2xi19> {
    %0 = llvm.mlir.constant(8 : i19) : i19
    %1 = llvm.mlir.constant(dense<8> : vector<2xi19>) : vector<2xi19>
    %2 = llvm.urem %arg0, %1  : vector<2xi19>
    llvm.return %2 : vector<2xi19>
  }
  llvm.func @test3a(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-8 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.srem %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }
  llvm.func @test3a_vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-8> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.srem %arg0, %0  : vector<2xi32>
    %4 = llvm.icmp "ne" %3, %2 : vector<2xi32>
    llvm.return %4 : vector<2xi1>
  }
  llvm.func @test4(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.select %arg1, %0, %1 : i1, i32
    %3 = llvm.urem %arg0, %2  : i32
    llvm.return %3 : i32
  }
  llvm.func @test5(%arg0: i32, %arg1: i8) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.zext %arg1 : i8 to i32
    %2 = llvm.shl %0, %1  : i32
    %3 = llvm.urem %arg0, %2  : i32
    llvm.return %3 : i32
  }
  llvm.func @test6(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.srem %arg0, %0  : i32
    llvm.return %1 : i32
  }
  llvm.func @test7(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.mul %arg0, %0  : i32
    %3 = llvm.srem %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @test8(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.srem %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @test9(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.mul %arg0, %0  : i32
    %3 = llvm.urem %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @test10(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(4 : i64) : i64
    %2 = llvm.zext %arg0 : i8 to i32
    %3 = llvm.mul %2, %0  : i32
    %4 = llvm.sext %3 : i32 to i64
    %5 = llvm.urem %4, %1  : i64
    %6 = llvm.trunc %5 : i64 to i32
    llvm.return %6 : i32
  }
  llvm.func @test11(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.mul %3, %1  : i32
    %5 = llvm.urem %4, %2  : i32
    llvm.return %5 : i32
  }
  llvm.func @test12(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-4 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.srem %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @test13(%arg0: i32) -> i32 {
    %0 = llvm.srem %arg0, %arg0  : i32
    llvm.return %0 : i32
  }
  llvm.func @test14(%arg0: i64, %arg1: i32) -> i64 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.shl %0, %arg1  : i32
    %2 = llvm.zext %1 : i32 to i64
    %3 = llvm.urem %arg0, %2  : i64
    llvm.return %3 : i64
  }
  llvm.func @test15(%arg0: i32, %arg1: i32) -> i64 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.shl %0, %arg1  : i32
    %2 = llvm.zext %1 : i32 to i64
    %3 = llvm.zext %arg0 : i32 to i64
    %4 = llvm.urem %3, %2  : i64
    llvm.return %4 : i64
  }
  llvm.func @test16(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(11 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.lshr %arg1, %0  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.add %3, %1  : i32
    %5 = llvm.urem %arg0, %4  : i32
    llvm.return %5 : i32
  }
  llvm.func @test17(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.urem %0, %arg0  : i32
    llvm.return %1 : i32
  }
  llvm.func @test18(%arg0: i16, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4 : i16) : i16
    %1 = llvm.mlir.constant(0 : i16) : i16
    %2 = llvm.mlir.constant(32 : i32) : i32
    %3 = llvm.mlir.constant(64 : i32) : i32
    %4 = llvm.and %arg0, %0  : i16
    %5 = llvm.icmp "ne" %4, %1 : i16
    %6 = llvm.select %5, %2, %3 : i1, i32
    %7 = llvm.urem %arg1, %6  : i32
    llvm.return %7 : i32
  }
  llvm.func @test19(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.shl %0, %arg0  : i32
    %2 = llvm.shl %0, %arg1  : i32
    %3 = llvm.and %1, %2  : i32
    %4 = llvm.add %3, %1  : i32
    %5 = llvm.urem %arg1, %4  : i32
    llvm.return %5 : i32
  }
  llvm.func @test19_commutative0(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.shl %0, %arg0  : i32
    %2 = llvm.shl %0, %arg1  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.add %3, %1  : i32
    %5 = llvm.urem %arg1, %4  : i32
    llvm.return %5 : i32
  }
  llvm.func @test19_commutative1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.shl %0, %arg0  : i32
    %2 = llvm.shl %0, %arg1  : i32
    %3 = llvm.and %1, %2  : i32
    %4 = llvm.add %1, %3  : i32
    %5 = llvm.urem %arg1, %4  : i32
    llvm.return %5 : i32
  }
  llvm.func @test19_commutative2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.shl %0, %arg0  : i32
    %2 = llvm.shl %0, %arg1  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.add %1, %3  : i32
    %5 = llvm.urem %arg1, %4  : i32
    llvm.return %5 : i32
  }
  llvm.func @test20(%arg0: vector<2xi64>, %arg1: vector<2xi1>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<[8, 9]> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.mlir.constant(dense<[2, 3]> : vector<2xi64>) : vector<2xi64>
    %3 = llvm.select %arg1, %0, %1 : vector<2xi1>, vector<2xi64>
    %4 = llvm.urem %3, %2  : vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }
  llvm.func @test21(%arg0: i1, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2(%0 : i32)
  ^bb1:  // pred: ^bb0
    %1 = llvm.load volatile %arg1 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.br ^bb2(%1 : i32)
  ^bb2(%2: i32):  // 2 preds: ^bb0, ^bb1
    %3 = llvm.srem %2, %0  : i32
    llvm.return %3 : i32
  }
  llvm.func @pr27968_0(%arg0: i1, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(4 : i64) : i64
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(0 : i16) : i16
    %4 = llvm.mlir.constant(dense<0> : tensor<5xi16>) : !llvm.array<5 x i16>
    %5 = llvm.mlir.addressof @a : !llvm.ptr
    %6 = llvm.getelementptr inbounds %5[%2, %1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<5 x i16>
    %7 = llvm.mlir.addressof @b : !llvm.ptr
    %8 = llvm.mlir.constant(0 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2(%0 : i32)
  ^bb1:  // pred: ^bb0
    %9 = llvm.load volatile %arg1 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.br ^bb2(%9 : i32)
  ^bb2(%10: i32):  // 2 preds: ^bb0, ^bb1
    %11 = llvm.icmp "eq" %6, %7 : !llvm.ptr
    llvm.cond_br %11, ^bb3, ^bb4
  ^bb3:  // pred: ^bb2
    %12 = llvm.zext %11 : i1 to i32
    %13 = llvm.srem %10, %12  : i32
    llvm.return %13 : i32
  ^bb4:  // pred: ^bb2
    llvm.return %8 : i32
  }
  llvm.func @pr27968_1(%arg0: i1, %arg1: i1, %arg2: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-2147483648 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2(%0 : i32)
  ^bb1:  // pred: ^bb0
    %3 = llvm.load volatile %arg2 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.br ^bb2(%3 : i32)
  ^bb2(%4: i32):  // 2 preds: ^bb0, ^bb1
    llvm.cond_br %arg1, ^bb3, ^bb4
  ^bb3:  // pred: ^bb2
    %5 = llvm.srem %4, %2  : i32
    llvm.return %5 : i32
  ^bb4:  // pred: ^bb2
    llvm.return %1 : i32
  }
  llvm.func @pr27968_2(%arg0: i1, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(4 : i64) : i64
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(0 : i16) : i16
    %4 = llvm.mlir.constant(dense<0> : tensor<5xi16>) : !llvm.array<5 x i16>
    %5 = llvm.mlir.addressof @a : !llvm.ptr
    %6 = llvm.getelementptr inbounds %5[%2, %1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<5 x i16>
    %7 = llvm.mlir.addressof @b : !llvm.ptr
    %8 = llvm.mlir.constant(0 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2(%0 : i32)
  ^bb1:  // pred: ^bb0
    %9 = llvm.load volatile %arg1 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.br ^bb2(%9 : i32)
  ^bb2(%10: i32):  // 2 preds: ^bb0, ^bb1
    %11 = llvm.icmp "eq" %6, %7 : !llvm.ptr
    llvm.cond_br %11, ^bb3, ^bb4
  ^bb3:  // pred: ^bb2
    %12 = llvm.zext %11 : i1 to i32
    %13 = llvm.urem %10, %12  : i32
    llvm.return %13 : i32
  ^bb4:  // pred: ^bb2
    llvm.return %8 : i32
  }
  llvm.func @pr27968_3(%arg0: i1, %arg1: i1, %arg2: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-2147483648 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2(%0 : i32)
  ^bb1:  // pred: ^bb0
    %3 = llvm.load volatile %arg2 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.br ^bb2(%3 : i32)
  ^bb2(%4: i32):  // 2 preds: ^bb0, ^bb1
    llvm.cond_br %arg1, ^bb3, ^bb4
  ^bb3:  // pred: ^bb2
    %5 = llvm.urem %4, %2  : i32
    llvm.return %5 : i32
  ^bb4:  // pred: ^bb2
    llvm.return %1 : i32
  }
  llvm.func @test22(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.srem %1, %0  : i32
    llvm.return %2 : i32
  }
  llvm.func @test23(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<2147483647> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.and %arg0, %0  : vector<2xi32>
    %2 = llvm.srem %1, %0  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @test24(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.urem %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }
  llvm.func @test24_vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-2147483648> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.urem %arg0, %0  : vector<2xi32>
    %4 = llvm.icmp "ne" %3, %2 : vector<2xi32>
    llvm.return %4 : vector<2xi1>
  }
  llvm.func @test25(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.srem %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }
  llvm.func @test25_vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-2147483648> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.srem %arg0, %0  : vector<2xi32>
    %4 = llvm.icmp "ne" %3, %2 : vector<2xi32>
    llvm.return %4 : vector<2xi1>
  }
  llvm.func @test26(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.shl %0, %arg1  : i32
    %3 = llvm.srem %arg0, %2  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    llvm.return %4 : i1
  }
  llvm.func @test27(%arg0: i32, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.srem %arg0, %0  : i32
    llvm.store %2, %arg1 {alignment = 1 : i64} : i32, !llvm.ptr
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }
  llvm.func @test28(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.srem %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }
  llvm.func @positive_and_odd_eq(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.srem %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }
  llvm.func @negative_and_odd_eq(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.srem %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }
  llvm.func @positive_and_odd_ne(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.srem %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }
  llvm.func @negative_and_odd_ne(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.srem %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }
  llvm.func @PR34870(%arg0: i1, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.select %arg0, %arg2, %0 : i1, f64
    %2 = llvm.frem %arg1, %1  : f64
    llvm.return %2 : f64
  }
  llvm.func @srem_constant_dividend_select_of_constants_divisor(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(-3 : i32) : i32
    %2 = llvm.mlir.constant(42 : i32) : i32
    %3 = llvm.select %arg0, %0, %1 : i1, i32
    %4 = llvm.srem %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @srem_constant_dividend_select_of_constants_divisor_use(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(-3 : i32) : i32
    %2 = llvm.mlir.constant(42 : i32) : i32
    %3 = llvm.select %arg0, %0, %1 : i1, i32
    llvm.call @use(%3) : (i32) -> ()
    %4 = llvm.srem %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @srem_constant_dividend_select_of_constants_divisor_0_arm(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(42 : i32) : i32
    %3 = llvm.select %arg0, %0, %1 : i1, i32
    %4 = llvm.srem %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @srem_constant_dividend_select_divisor1(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-3 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.select %arg0, %arg1, %0 : i1, i32
    %3 = llvm.srem %1, %2  : i32
    llvm.return %3 : i32
  }
  llvm.func @srem_constant_dividend_select_divisor2(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.select %arg0, %0, %arg1 : i1, i32
    %3 = llvm.srem %1, %2  : i32
    llvm.return %3 : i32
  }
  llvm.func @srem_constant_dividend_select_of_constants_divisor_vec(%arg0: i1) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[12, -5]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[-4, 4]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<[42, -42]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.select %arg0, %0, %1 : i1, vector<2xi8>
    %4 = llvm.srem %2, %3  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }
  llvm.func @srem_constant_dividend_select_of_constants_divisor_vec_ub1(%arg0: i1) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[0, -5]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[-4, 4]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<[42, -42]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.select %arg0, %0, %1 : i1, vector<2xi8>
    %4 = llvm.srem %2, %3  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }
  llvm.func @srem_constant_dividend_select_of_constants_divisor_vec_ub2(%arg0: i1) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[12, -5]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[-4, -1]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<[42, -128]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.select %arg0, %0, %1 : i1, vector<2xi8>
    %4 = llvm.srem %2, %3  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }
  llvm.func @srem_select_of_constants_divisor(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(-3 : i32) : i32
    %2 = llvm.select %arg0, %0, %1 : i1, i32
    %3 = llvm.srem %arg1, %2  : i32
    llvm.return %3 : i32
  }
  llvm.func @urem_constant_dividend_select_of_constants_divisor(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(-3 : i32) : i32
    %2 = llvm.mlir.constant(42 : i32) : i32
    %3 = llvm.select %arg0, %0, %1 : i1, i32
    %4 = llvm.urem %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @urem_constant_dividend_select_of_constants_divisor_use(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(-3 : i32) : i32
    %2 = llvm.mlir.constant(42 : i32) : i32
    %3 = llvm.select %arg0, %0, %1 : i1, i32
    llvm.call @use(%3) : (i32) -> ()
    %4 = llvm.urem %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @urem_constant_dividend_select_of_constants_divisor_0_arm(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(42 : i32) : i32
    %3 = llvm.select %arg0, %0, %1 : i1, i32
    %4 = llvm.urem %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @urem_constant_dividend_select_divisor1(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-3 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.select %arg0, %arg1, %0 : i1, i32
    %3 = llvm.urem %1, %2  : i32
    llvm.return %3 : i32
  }
  llvm.func @urem_constant_dividend_select_divisor2(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.select %arg0, %0, %arg1 : i1, i32
    %3 = llvm.urem %1, %2  : i32
    llvm.return %3 : i32
  }
  llvm.func @urem_constant_dividend_select_of_constants_divisor_vec(%arg0: i1) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[12, -5]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[-4, 4]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<[42, -42]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.select %arg0, %0, %1 : i1, vector<2xi8>
    %4 = llvm.urem %2, %3  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }
  llvm.func @urem_constant_dividend_select_of_constants_divisor_vec_ub1(%arg0: i1) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[0, -5]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[-4, 4]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<[42, -42]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.select %arg0, %0, %1 : i1, vector<2xi8>
    %4 = llvm.urem %2, %3  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }
  llvm.func @urem_constant_dividend_select_of_constants_divisor_vec_ub2(%arg0: i1) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[12, -5]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[-4, -1]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<[42, -128]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.select %arg0, %0, %1 : i1, vector<2xi8>
    %4 = llvm.urem %2, %3  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }
  llvm.func @urem_select_of_constants_divisor(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(-3 : i32) : i32
    %2 = llvm.select %arg0, %0, %1 : i1, i32
    %3 = llvm.urem %arg1, %2  : i32
    llvm.return %3 : i32
  }
  llvm.func @PR62401(%arg0: vector<2xi1>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.sext %arg0 : vector<2xi1> to vector<2xi32>
    %1 = llvm.urem %arg1, %0  : vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }
}
