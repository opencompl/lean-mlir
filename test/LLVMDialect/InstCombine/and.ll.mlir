module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @g() {addr_space = 0 : i32} : i64
  llvm.func @use8(i8)
  llvm.func @use16(i16)
  llvm.func @use32(i32)
  llvm.func @test_with_1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.shl %0, %arg0  : i32
    %2 = llvm.and %1, %0  : i32
    llvm.return %2 : i32
  }
  llvm.func @test_with_3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.shl %0, %arg0  : i32
    %3 = llvm.and %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @test_with_5(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.shl %0, %arg0  : i32
    %3 = llvm.and %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @test_with_neg_5(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-5 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.shl %0, %arg0  : i32
    %3 = llvm.and %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @test_with_even(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.shl %0, %arg0  : i32
    %3 = llvm.and %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @test_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.shl %0, %arg0  : vector<2xi32>
    %3 = llvm.and %2, %1  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @test_with_neg_even(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-4 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.shl %0, %arg0  : i32
    %3 = llvm.and %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @test_with_more_one_use(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.shl %0, %arg0  : i32
    %3 = llvm.and %2, %1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    llvm.return %3 : i32
  }
  llvm.func @test1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    llvm.return %1 : i32
  }
  llvm.func @test2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    llvm.return %1 : i32
  }
  llvm.func @test3(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.and %arg0, %0  : i1
    llvm.return %1 : i1
  }
  llvm.func @test3_logical(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.select %arg0, %0, %0 : i1, i1
    llvm.return %1 : i1
  }
  llvm.func @test4(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.and %arg0, %0  : i1
    llvm.return %1 : i1
  }
  llvm.func @test4_logical(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.select %arg0, %0, %1 : i1, i1
    llvm.return %2 : i1
  }
  llvm.func @test5(%arg0: i32) -> i32 {
    %0 = llvm.and %arg0, %arg0  : i32
    llvm.return %0 : i32
  }
  llvm.func @test6(%arg0: i1) -> i1 {
    %0 = llvm.and %arg0, %arg0  : i1
    llvm.return %0 : i1
  }
  llvm.func @test6_logical(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.select %arg0, %arg0, %0 : i1, i1
    llvm.return %1 : i1
  }
  llvm.func @test7(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.and %arg0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @test8(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.and %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @test9(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }
  llvm.func @test9a(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }
  llvm.func @test10(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(15 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.xor %3, %1  : i32
    %5 = llvm.and %4, %2  : i32
    llvm.return %5 : i32
  }
  llvm.func @test11(%arg0: i32, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.or %arg0, %0  : i32
    %3 = llvm.xor %2, %1  : i32
    llvm.store %3, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr
    %4 = llvm.and %3, %0  : i32
    llvm.return %4 : i32
  }
  llvm.func @test12(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i32
    %1 = llvm.icmp "ule" %arg0, %arg1 : i32
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @test12_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.icmp "ult" %arg0, %arg1 : i32
    %2 = llvm.icmp "ule" %arg0, %arg1 : i32
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @test13(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i32
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i32
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @test13_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.icmp "ult" %arg0, %arg1 : i32
    %2 = llvm.icmp "ugt" %arg0, %arg1 : i32
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @test14(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @test15(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.and %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @test16(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.shl %arg0, %0  : i8
    %3 = llvm.and %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @test18(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-128 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }
  llvm.func @test18_vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-128> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.and %arg0, %0  : vector<2xi32>
    %4 = llvm.icmp "ne" %3, %2 : vector<2xi32>
    llvm.return %4 : vector<2xi1>
  }
  llvm.func @test18a(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-2 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @test18a_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-2> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.and %arg0, %0  : vector<2xi8>
    %4 = llvm.icmp "eq" %3, %2 : vector<2xi8>
    llvm.return %4 : vector<2xi1>
  }
  llvm.func @test19(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @test20(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.and %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @test23(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.icmp "sle" %arg0, %1 : i32
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @test23_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    %4 = llvm.icmp "sle" %arg0, %1 : i32
    %5 = llvm.select %3, %4, %2 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @test23vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<2> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "sgt" %arg0, %0 : vector<2xi32>
    %3 = llvm.icmp "sle" %arg0, %1 : vector<2xi32>
    %4 = llvm.and %2, %3  : vector<2xi1>
    llvm.return %4 : vector<2xi1>
  }
  llvm.func @test24(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.icmp "ne" %arg0, %1 : i32
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @test24_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    %4 = llvm.icmp "ne" %arg0, %1 : i32
    %5 = llvm.select %3, %4, %2 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @test25(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(50 : i32) : i32
    %1 = llvm.mlir.constant(100 : i32) : i32
    %2 = llvm.icmp "sge" %arg0, %0 : i32
    %3 = llvm.icmp "slt" %arg0, %1 : i32
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @test25_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(50 : i32) : i32
    %1 = llvm.mlir.constant(100 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.icmp "sge" %arg0, %0 : i32
    %4 = llvm.icmp "slt" %arg0, %1 : i32
    %5 = llvm.select %3, %4, %2 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @test25vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<50> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<100> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "sge" %arg0, %0 : vector<2xi32>
    %3 = llvm.icmp "slt" %arg0, %1 : vector<2xi32>
    %4 = llvm.and %2, %3  : vector<2xi1>
    llvm.return %4 : vector<2xi1>
  }
  llvm.func @test27(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.mlir.constant(16 : i8) : i8
    %2 = llvm.mlir.constant(-16 : i8) : i8
    %3 = llvm.and %arg0, %0  : i8
    %4 = llvm.sub %3, %1  : i8
    %5 = llvm.and %4, %2  : i8
    %6 = llvm.add %5, %1  : i8
    llvm.return %6 : i8
  }
  llvm.func @ashr_lowmask(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.mlir.constant(255 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @ashr_lowmask_use(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(2147483647 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.and %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @ashr_lowmask_use_splat(%arg0: vector<2xi8>, %arg1: !llvm.ptr) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<7> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.ashr %arg0, %0  : vector<2xi8>
    llvm.store %2, %arg1 {alignment = 2 : i64} : vector<2xi8>, !llvm.ptr
    %3 = llvm.and %2, %1  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }
  llvm.func @ashr_not_lowmask1_use(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.mlir.constant(254 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.and %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @ashr_not_lowmask2_use(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.mlir.constant(127 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.and %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @ashr_not_lowmask3_use(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.mlir.constant(511 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.and %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @test29(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.and %1, %0  : i32
    llvm.return %2 : i32
  }
  llvm.func @test30(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.and %1, %0  : i32
    llvm.return %2 : i32
  }
  llvm.func @test31(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.zext %arg0 : i1 to i32
    %3 = llvm.shl %2, %0  : i32
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @and_demanded_bits_splat_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<7> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.add %arg0, %0  : vector<2xi32>
    %3 = llvm.and %2, %1  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @and_zext_demanded(%arg0: i16, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i16) : i16
    %1 = llvm.mlir.constant(255 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i16
    %3 = llvm.zext %2 : i16 to i32
    %4 = llvm.or %arg1, %1  : i32
    %5 = llvm.and %4, %3  : i32
    llvm.return %5 : i32
  }
  llvm.func @test32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.lshr %3, %1  : i32
    %5 = llvm.and %4, %2  : i32
    llvm.return %5 : i32
  }
  llvm.func @test33(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.and %arg0, %1  : i32
    %5 = llvm.or %4, %3  : i32
    llvm.return %5 : i32
  }
  llvm.func @test33b(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.and %arg0, %1  : i32
    %5 = llvm.or %3, %4  : i32
    llvm.return %5 : i32
  }
  llvm.func @test33vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-2> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.and %arg0, %0  : vector<2xi32>
    %3 = llvm.xor %2, %0  : vector<2xi32>
    %4 = llvm.and %arg0, %1  : vector<2xi32>
    %5 = llvm.or %4, %3  : vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }
  llvm.func @test33vecb(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-2> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.and %arg0, %0  : vector<2xi32>
    %3 = llvm.xor %2, %0  : vector<2xi32>
    %4 = llvm.and %arg0, %1  : vector<2xi32>
    %5 = llvm.or %3, %4  : vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }
  llvm.func @test34(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.or %arg1, %arg0  : i32
    %1 = llvm.and %0, %arg1  : i32
    llvm.return %1 : i32
  }
  llvm.func @PR24942(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<31> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<2> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.lshr %arg0, %0  : vector<2xi32>
    %3 = llvm.and %2, %1  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @test35(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(240 : i64) : i64
    %2 = llvm.zext %arg0 : i32 to i64
    %3 = llvm.sub %0, %2  : i64
    %4 = llvm.and %3, %1  : i64
    llvm.return %4 : i64
  }
  llvm.func @test35_uniform(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.mlir.constant(dense<240> : vector<2xi64>) : vector<2xi64>
    %3 = llvm.zext %arg0 : vector<2xi32> to vector<2xi64>
    %4 = llvm.sub %1, %3  : vector<2xi64>
    %5 = llvm.and %4, %2  : vector<2xi64>
    llvm.return %5 : vector<2xi64>
  }
  llvm.func @test36(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(7 : i64) : i64
    %1 = llvm.mlir.constant(240 : i64) : i64
    %2 = llvm.zext %arg0 : i32 to i64
    %3 = llvm.add %2, %0  : i64
    %4 = llvm.and %3, %1  : i64
    llvm.return %4 : i64
  }
  llvm.func @test36_uniform(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<7> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<240> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.zext %arg0 : vector<2xi32> to vector<2xi64>
    %3 = llvm.add %2, %0  : vector<2xi64>
    %4 = llvm.and %3, %1  : vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }
  llvm.func @test36_poison(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.poison : i64
    %1 = llvm.mlir.constant(7 : i64) : i64
    %2 = llvm.mlir.undef : vector<2xi64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi64>
    %7 = llvm.mlir.constant(240 : i64) : i64
    %8 = llvm.mlir.undef : vector<2xi64>
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.insertelement %7, %8[%9 : i32] : vector<2xi64>
    %11 = llvm.mlir.constant(1 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<2xi64>
    %13 = llvm.zext %arg0 : vector<2xi32> to vector<2xi64>
    %14 = llvm.add %13, %6  : vector<2xi64>
    %15 = llvm.and %14, %12  : vector<2xi64>
    llvm.return %15 : vector<2xi64>
  }
  llvm.func @test37(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(7 : i64) : i64
    %1 = llvm.mlir.constant(240 : i64) : i64
    %2 = llvm.zext %arg0 : i32 to i64
    %3 = llvm.mul %2, %0  : i64
    %4 = llvm.and %3, %1  : i64
    llvm.return %4 : i64
  }
  llvm.func @test37_uniform(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<7> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<240> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.zext %arg0 : vector<2xi32> to vector<2xi64>
    %3 = llvm.mul %2, %0  : vector<2xi64>
    %4 = llvm.and %3, %1  : vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }
  llvm.func @test37_nonuniform(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<[7, 9]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<[240, 110]> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.zext %arg0 : vector<2xi32> to vector<2xi64>
    %3 = llvm.mul %2, %0  : vector<2xi64>
    %4 = llvm.and %3, %1  : vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }
  llvm.func @test38(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(7 : i64) : i64
    %1 = llvm.mlir.constant(240 : i64) : i64
    %2 = llvm.zext %arg0 : i32 to i64
    %3 = llvm.xor %2, %0  : i64
    %4 = llvm.and %3, %1  : i64
    llvm.return %4 : i64
  }
  llvm.func @test39(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(7 : i64) : i64
    %1 = llvm.mlir.constant(240 : i64) : i64
    %2 = llvm.zext %arg0 : i32 to i64
    %3 = llvm.or %2, %0  : i64
    %4 = llvm.and %3, %1  : i64
    llvm.return %4 : i64
  }
  llvm.func @lowmask_add_zext(%arg0: i8, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.add %1, %arg1  : i32
    %3 = llvm.and %2, %0  : i32
    llvm.return %3 : i32
  }
  llvm.func @lowmask_add_zext_commute(%arg0: i16, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(65535 : i32) : i32
    %1 = llvm.mul %arg1, %arg1  : i32
    %2 = llvm.zext %arg0 : i16 to i32
    %3 = llvm.add %1, %2  : i32
    %4 = llvm.and %3, %0  : i32
    llvm.return %4 : i32
  }
  llvm.func @lowmask_add_zext_wrong_mask(%arg0: i8, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(511 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.add %1, %arg1  : i32
    %3 = llvm.and %2, %0  : i32
    llvm.return %3 : i32
  }
  llvm.func @lowmask_add_zext_use1(%arg0: i8, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.add %1, %arg1  : i32
    %3 = llvm.and %2, %0  : i32
    llvm.return %3 : i32
  }
  llvm.func @lowmask_add_zext_use2(%arg0: i8, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.add %1, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.and %2, %0  : i32
    llvm.return %3 : i32
  }
  llvm.func @lowmask_sub_zext(%arg0: vector<2xi4>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<15> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.zext %arg0 : vector<2xi4> to vector<2xi32>
    %2 = llvm.sub %1, %arg1  : vector<2xi32>
    %3 = llvm.and %2, %0  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @lowmask_sub_zext_commute(%arg0: i5, %arg1: i17) -> i17 {
    %0 = llvm.mlir.constant(31 : i17) : i17
    %1 = llvm.zext %arg0 : i5 to i17
    %2 = llvm.sub %arg1, %1  : i17
    %3 = llvm.and %2, %0  : i17
    llvm.return %3 : i17
  }
  llvm.func @lowmask_mul_zext(%arg0: i8, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.mul %1, %arg1  : i32
    %3 = llvm.and %2, %0  : i32
    llvm.return %3 : i32
  }
  llvm.func @lowmask_xor_zext_commute(%arg0: i8, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mul %arg1, %arg1  : i32
    %2 = llvm.zext %arg0 : i8 to i32
    %3 = llvm.xor %1, %2  : i32
    %4 = llvm.and %3, %0  : i32
    llvm.return %4 : i32
  }
  llvm.func @lowmask_or_zext_commute(%arg0: i16, %arg1: i24) -> i24 {
    %0 = llvm.mlir.constant(65535 : i24) : i24
    %1 = llvm.zext %arg0 : i16 to i24
    %2 = llvm.or %arg1, %1  : i24
    %3 = llvm.and %2, %0  : i24
    llvm.return %3 : i24
  }
  llvm.func @test40(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1000 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.mlir.constant(123 : i32) : i32
    %3 = llvm.select %arg0, %0, %1 : i1, i32
    %4 = llvm.and %3, %2  : i32
    llvm.return %4 : i32
  }
  llvm.func @test40vec(%arg0: i1) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1000> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<10> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<123> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.select %arg0, %0, %1 : i1, vector<2xi32>
    %4 = llvm.and %3, %2  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }
  llvm.func @test40vec2(%arg0: i1) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[1000, 2500]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[10, 30]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<[123, 333]> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.select %arg0, %0, %1 : i1, vector<2xi32>
    %4 = llvm.and %3, %2  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }
  llvm.func @test41(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1000 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.mlir.constant(123 : i32) : i32
    llvm.cond_br %arg0, ^bb2(%0 : i32), ^bb1
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%1 : i32)
  ^bb2(%3: i32):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.and %3, %2  : i32
    llvm.return %4 : i32
  }
  llvm.func @test41vec(%arg0: i1) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1000> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<10> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<123> : vector<2xi32>) : vector<2xi32>
    llvm.cond_br %arg0, ^bb2(%0 : vector<2xi32>), ^bb1
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%1 : vector<2xi32>)
  ^bb2(%3: vector<2xi32>):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.and %3, %2  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }
  llvm.func @test41vec2(%arg0: i1) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[1000, 2500]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[10, 30]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<[123, 333]> : vector<2xi32>) : vector<2xi32>
    llvm.cond_br %arg0, ^bb2(%0 : vector<2xi32>), ^bb1
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%1 : vector<2xi32>)
  ^bb2(%3: vector<2xi32>):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.and %3, %2  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }
  llvm.func @test42(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mul %arg1, %arg2  : i32
    %2 = llvm.or %arg0, %1  : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.xor %3, %1  : i32
    %5 = llvm.and %4, %2  : i32
    llvm.return %5 : i32
  }
  llvm.func @test43(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mul %arg1, %arg2  : i32
    %2 = llvm.or %arg0, %1  : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.xor %3, %1  : i32
    %5 = llvm.and %2, %4  : i32
    llvm.return %5 : i32
  }
  llvm.func @test44(%arg0: i32, %arg1: i32) -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.or %1, %arg0  : i32
    %3 = llvm.and %2, %arg1  : i32
    llvm.return %3 : i32
  }
  llvm.func @test45(%arg0: i32, %arg1: i32) -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.or %arg0, %1  : i32
    %3 = llvm.and %2, %arg1  : i32
    llvm.return %3 : i32
  }
  llvm.func @test46(%arg0: i32, %arg1: i32) -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.or %1, %arg0  : i32
    %3 = llvm.and %arg1, %2  : i32
    llvm.return %3 : i32
  }
  llvm.func @test47(%arg0: i32, %arg1: i32) -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.or %arg0, %1  : i32
    %3 = llvm.and %arg1, %2  : i32
    llvm.return %3 : i32
  }
  llvm.func @and_orn_cmp_1(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %arg1 : i32
    %2 = llvm.icmp "sle" %arg0, %arg1 : i32
    %3 = llvm.icmp "ugt" %arg2, %0 : i32
    %4 = llvm.or %3, %2  : i1
    %5 = llvm.and %1, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @and_orn_cmp_1_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.icmp "sgt" %arg0, %arg1 : i32
    %4 = llvm.icmp "sle" %arg0, %arg1 : i32
    %5 = llvm.icmp "ugt" %arg2, %0 : i32
    %6 = llvm.select %5, %1, %4 : i1, i1
    %7 = llvm.select %3, %6, %2 : i1, i1
    llvm.return %7 : i1
  }
  llvm.func @and_orn_cmp_2(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[42, 47]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "sge" %arg0, %arg1 : vector<2xi32>
    %2 = llvm.icmp "slt" %arg0, %arg1 : vector<2xi32>
    %3 = llvm.icmp "ugt" %arg2, %0 : vector<2xi32>
    %4 = llvm.or %3, %2  : vector<2xi1>
    %5 = llvm.and %4, %1  : vector<2xi1>
    llvm.return %5 : vector<2xi1>
  }
  llvm.func @and_orn_cmp_3(%arg0: i72, %arg1: i72, %arg2: i72) -> i1 {
    %0 = llvm.mlir.constant(42 : i72) : i72
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i72
    %2 = llvm.icmp "ule" %arg0, %arg1 : i72
    %3 = llvm.icmp "ugt" %arg2, %0 : i72
    %4 = llvm.or %2, %3  : i1
    %5 = llvm.and %1, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @and_orn_cmp_3_logical(%arg0: i72, %arg1: i72, %arg2: i72) -> i1 {
    %0 = llvm.mlir.constant(42 : i72) : i72
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.icmp "ugt" %arg0, %arg1 : i72
    %4 = llvm.icmp "ule" %arg0, %arg1 : i72
    %5 = llvm.icmp "ugt" %arg2, %0 : i72
    %6 = llvm.select %4, %1, %5 : i1, i1
    %7 = llvm.select %3, %6, %2 : i1, i1
    llvm.return %7 : i1
  }
  llvm.func @or_andn_cmp_4(%arg0: vector<3xi32>, %arg1: vector<3xi32>, %arg2: vector<3xi32>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(dense<[42, 43, -1]> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.icmp "eq" %arg0, %arg1 : vector<3xi32>
    %2 = llvm.icmp "ne" %arg0, %arg1 : vector<3xi32>
    %3 = llvm.icmp "ugt" %arg2, %0 : vector<3xi32>
    %4 = llvm.or %2, %3  : vector<3xi1>
    %5 = llvm.and %4, %1  : vector<3xi1>
    llvm.return %5 : vector<3xi1>
  }
  llvm.func @andn_or_cmp_1(%arg0: i37, %arg1: i37, %arg2: i37) -> i1 {
    %0 = llvm.mlir.constant(42 : i37) : i37
    %1 = llvm.icmp "sgt" %arg0, %arg1 : i37
    %2 = llvm.icmp "sle" %arg0, %arg1 : i37
    %3 = llvm.icmp "ugt" %arg2, %0 : i37
    %4 = llvm.or %3, %1  : i1
    %5 = llvm.and %2, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @andn_or_cmp_1_logical(%arg0: i37, %arg1: i37, %arg2: i37) -> i1 {
    %0 = llvm.mlir.constant(42 : i37) : i37
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.icmp "sgt" %arg0, %arg1 : i37
    %4 = llvm.icmp "sle" %arg0, %arg1 : i37
    %5 = llvm.icmp "ugt" %arg2, %0 : i37
    %6 = llvm.select %5, %1, %3 : i1, i1
    %7 = llvm.select %4, %6, %2 : i1, i1
    llvm.return %7 : i1
  }
  llvm.func @andn_or_cmp_2(%arg0: i16, %arg1: i16, %arg2: i16) -> i1 {
    %0 = llvm.mlir.constant(42 : i16) : i16
    %1 = llvm.icmp "sge" %arg0, %arg1 : i16
    %2 = llvm.icmp "slt" %arg0, %arg1 : i16
    %3 = llvm.icmp "ugt" %arg2, %0 : i16
    %4 = llvm.or %3, %1  : i1
    %5 = llvm.and %4, %2  : i1
    llvm.return %5 : i1
  }
  llvm.func @andn_or_cmp_2_logical(%arg0: i16, %arg1: i16, %arg2: i16) -> i1 {
    %0 = llvm.mlir.constant(42 : i16) : i16
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.icmp "sge" %arg0, %arg1 : i16
    %4 = llvm.icmp "slt" %arg0, %arg1 : i16
    %5 = llvm.icmp "ugt" %arg2, %0 : i16
    %6 = llvm.select %5, %1, %3 : i1, i1
    %7 = llvm.select %6, %4, %2 : i1, i1
    llvm.return %7 : i1
  }
  llvm.func @andn_or_cmp_3(%arg0: vector<4xi32>, %arg1: vector<4xi32>, %arg2: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(dense<[42, 0, 1, -1]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.icmp "ugt" %arg0, %arg1 : vector<4xi32>
    %2 = llvm.icmp "ule" %arg0, %arg1 : vector<4xi32>
    %3 = llvm.icmp "ugt" %arg2, %0 : vector<4xi32>
    %4 = llvm.or %1, %3  : vector<4xi1>
    %5 = llvm.and %2, %4  : vector<4xi1>
    llvm.return %5 : vector<4xi1>
  }
  llvm.func @andn_or_cmp_4(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %arg1 : i32
    %2 = llvm.icmp "ne" %arg0, %arg1 : i32
    %3 = llvm.icmp "ugt" %arg2, %0 : i32
    %4 = llvm.or %1, %3  : i1
    %5 = llvm.and %4, %2  : i1
    llvm.return %5 : i1
  }
  llvm.func @andn_or_cmp_4_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.icmp "eq" %arg0, %arg1 : i32
    %4 = llvm.icmp "ne" %arg0, %arg1 : i32
    %5 = llvm.icmp "ugt" %arg2, %0 : i32
    %6 = llvm.select %3, %1, %5 : i1, i1
    %7 = llvm.select %6, %4, %2 : i1, i1
    llvm.return %7 : i1
  }
  llvm.func @lowbitmask_casted_shift(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(2147483647 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.sext %2 : i8 to i32
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @lowbitmask_casted_shift_wrong_mask1(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(2147483647 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.sext %2 : i8 to i32
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @lowbitmask_casted_shift_wrong_mask2(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(536870911 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.sext %2 : i8 to i32
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @lowbitmask_casted_shift_use1(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(536870911 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.sext %2 : i8 to i32
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @lowbitmask_casted_shift_use2(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(536870911 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.sext %2 : i8 to i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @lowbitmask_casted_shift_vec_splat(%arg0: vector<2xi47>) -> vector<2xi59> {
    %0 = llvm.mlir.constant(5 : i47) : i47
    %1 = llvm.mlir.constant(dense<5> : vector<2xi47>) : vector<2xi47>
    %2 = llvm.mlir.constant(18014398509481983 : i59) : i59
    %3 = llvm.mlir.constant(dense<18014398509481983> : vector<2xi59>) : vector<2xi59>
    %4 = llvm.ashr %arg0, %1  : vector<2xi47>
    %5 = llvm.sext %4 : vector<2xi47> to vector<2xi59>
    %6 = llvm.and %5, %3  : vector<2xi59>
    llvm.return %6 : vector<2xi59>
  }
  llvm.func @lowmask_sext_in_reg(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(20 : i32) : i32
    %1 = llvm.mlir.constant(4095 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.ashr %2, %0  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @lowmask_not_sext_in_reg(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(19 : i32) : i32
    %1 = llvm.mlir.constant(20 : i32) : i32
    %2 = llvm.mlir.constant(4095 : i32) : i32
    %3 = llvm.shl %arg0, %0  : i32
    %4 = llvm.ashr %3, %1  : i32
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.and %4, %2  : i32
    llvm.return %5 : i32
  }
  llvm.func @not_lowmask_sext_in_reg(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(20 : i32) : i32
    %1 = llvm.mlir.constant(4096 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.ashr %2, %0  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @not_lowmask_sext_in_reg2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(21 : i32) : i32
    %1 = llvm.mlir.constant(4095 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.ashr %2, %0  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @lowmask_sext_in_reg_splat(%arg0: vector<2xi32>, %arg1: !llvm.ptr) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<20> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<4095> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.shl %arg0, %0  : vector<2xi32>
    %3 = llvm.ashr %2, %0  : vector<2xi32>
    llvm.store %3, %arg1 {alignment = 8 : i64} : vector<2xi32>, !llvm.ptr
    %4 = llvm.and %3, %1  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }
  llvm.func @lowmask_add(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-64 : i8) : i8
    %1 = llvm.mlir.constant(32 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.and %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @lowmask_add_2(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-64 : i8) : i8
    %1 = llvm.mlir.constant(63 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.and %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @lowmask_add_2_uses(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-64 : i8) : i8
    %1 = llvm.mlir.constant(63 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.and %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @lowmask_add_2_splat(%arg0: vector<2xi8>, %arg1: !llvm.ptr) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-64> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<63> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.add %arg0, %0  : vector<2xi8>
    llvm.store %2, %arg1 {alignment = 2 : i64} : vector<2xi8>, !llvm.ptr
    %3 = llvm.and %2, %1  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }
  llvm.func @not_lowmask_add(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-64 : i8) : i8
    %1 = llvm.mlir.constant(64 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.and %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @not_lowmask_add2(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-96 : i8) : i8
    %1 = llvm.mlir.constant(63 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.and %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @lowmask_add_splat(%arg0: vector<2xi8>, %arg1: !llvm.ptr) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-64> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<32> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.add %arg0, %0  : vector<2xi8>
    llvm.store %2, %arg1 {alignment = 2 : i64} : vector<2xi8>, !llvm.ptr
    %3 = llvm.and %2, %1  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }
  llvm.func @lowmask_add_splat_poison(%arg0: vector<2xi8>, %arg1: !llvm.ptr) -> vector<2xi8> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(-64 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(32 : i8) : i8
    %8 = llvm.mlir.undef : vector<2xi8>
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<2xi8>
    %11 = llvm.mlir.constant(1 : i32) : i32
    %12 = llvm.insertelement %7, %10[%11 : i32] : vector<2xi8>
    %13 = llvm.add %arg0, %6  : vector<2xi8>
    llvm.store %13, %arg1 {alignment = 2 : i64} : vector<2xi8>, !llvm.ptr
    %14 = llvm.and %13, %12  : vector<2xi8>
    llvm.return %14 : vector<2xi8>
  }
  llvm.func @lowmask_add_vec(%arg0: vector<2xi8>, %arg1: !llvm.ptr) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[-96, -64]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[16, 32]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.add %arg0, %0  : vector<2xi8>
    llvm.store %2, %arg1 {alignment = 2 : i64} : vector<2xi8>, !llvm.ptr
    %3 = llvm.and %2, %1  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }
  llvm.func @flip_masked_bit(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(16 : i8) : i8
    %1 = llvm.add %arg0, %0  : i8
    %2 = llvm.and %1, %0  : i8
    llvm.return %2 : i8
  }
  llvm.func @flip_masked_bit_uniform(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.add %arg0, %0  : vector<2xi8>
    %2 = llvm.and %1, %0  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }
  llvm.func @flip_masked_bit_poison(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(16 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.add %arg0, %6  : vector<2xi8>
    %8 = llvm.and %7, %6  : vector<2xi8>
    llvm.return %8 : vector<2xi8>
  }
  llvm.func @flip_masked_bit_nonuniform(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[16, 4]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.add %arg0, %0  : vector<2xi8>
    %2 = llvm.and %1, %0  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }
  llvm.func @ashr_bitwidth_mask(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    %2 = llvm.and %1, %arg1  : i8
    llvm.return %2 : i8
  }
  llvm.func @ashr_bitwidth_mask_vec_commute(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[42, 2]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<7> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mul %arg1, %0  : vector<2xi8>
    %3 = llvm.ashr %arg0, %1  : vector<2xi8>
    %4 = llvm.and %2, %3  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }
  llvm.func @ashr_bitwidth_mask_use(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.and %1, %arg1  : i8
    llvm.return %2 : i8
  }
  llvm.func @ashr_not_bitwidth_mask(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    %2 = llvm.and %1, %arg1  : i8
    llvm.return %2 : i8
  }
  llvm.func @lshr_bitwidth_mask(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.lshr %arg0, %0  : i8
    %2 = llvm.and %1, %arg1  : i8
    llvm.return %2 : i8
  }
  llvm.func @signbit_splat_mask(%arg0: i8, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    %2 = llvm.sext %1 : i8 to i16
    %3 = llvm.and %2, %arg1  : i16
    llvm.return %3 : i16
  }
  llvm.func @signbit_splat_mask_commute(%arg0: vector<2xi5>, %arg1: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.poison : i5
    %1 = llvm.mlir.constant(4 : i5) : i5
    %2 = llvm.mlir.undef : vector<2xi5>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi5>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi5>
    %7 = llvm.mul %arg1, %arg1  : vector<2xi16>
    %8 = llvm.ashr %arg0, %6  : vector<2xi5>
    %9 = llvm.sext %8 : vector<2xi5> to vector<2xi16>
    %10 = llvm.and %7, %9  : vector<2xi16>
    llvm.return %10 : vector<2xi16>
  }
  llvm.func @signbit_splat_mask_use1(%arg0: i8, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.sext %1 : i8 to i16
    %3 = llvm.and %2, %arg1  : i16
    llvm.return %3 : i16
  }
  llvm.func @signbit_splat_mask_use2(%arg0: i8, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    %2 = llvm.sext %1 : i8 to i16
    llvm.call @use16(%2) : (i16) -> ()
    %3 = llvm.and %2, %arg1  : i16
    llvm.return %3 : i16
  }
  llvm.func @not_signbit_splat_mask1(%arg0: i8, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    %2 = llvm.zext %1 : i8 to i16
    %3 = llvm.and %2, %arg1  : i16
    llvm.return %3 : i16
  }
  llvm.func @not_signbit_splat_mask2(%arg0: i8, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    %2 = llvm.sext %1 : i8 to i16
    %3 = llvm.and %2, %arg1  : i16
    llvm.return %3 : i16
  }
  llvm.func @not_ashr_bitwidth_mask(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.xor %2, %1  : i8
    %4 = llvm.and %3, %arg1  : i8
    llvm.return %4 : i8
  }
  llvm.func @not_ashr_bitwidth_mask_vec_commute(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[42, 2]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<7> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.mul %arg1, %0  : vector<2xi8>
    %4 = llvm.ashr %arg0, %1  : vector<2xi8>
    %5 = llvm.xor %4, %2  : vector<2xi8>
    %6 = llvm.and %3, %5  : vector<2xi8>
    llvm.return %6 : vector<2xi8>
  }
  llvm.func @not_ashr_bitwidth_mask_use1(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.xor %2, %1  : i8
    %4 = llvm.and %3, %arg1  : i8
    llvm.return %4 : i8
  }
  llvm.func @not_ashr_bitwidth_mask_use2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.xor %2, %1  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.and %3, %arg1  : i8
    llvm.return %4 : i8
  }
  llvm.func @not_ashr_not_bitwidth_mask(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.xor %2, %1  : i8
    %4 = llvm.and %3, %arg1  : i8
    llvm.return %4 : i8
  }
  llvm.func @not_lshr_bitwidth_mask(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.xor %2, %1  : i8
    %4 = llvm.and %3, %arg1  : i8
    llvm.return %4 : i8
  }
  llvm.func @invert_signbit_splat_mask(%arg0: i8, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.xor %2, %1  : i8
    %4 = llvm.sext %3 : i8 to i16
    %5 = llvm.and %4, %arg1  : i16
    llvm.return %5 : i16
  }
  llvm.func @invert_signbit_splat_mask_commute(%arg0: vector<2xi5>, %arg1: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.poison : i5
    %1 = llvm.mlir.constant(4 : i5) : i5
    %2 = llvm.mlir.undef : vector<2xi5>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi5>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi5>
    %7 = llvm.mlir.constant(-1 : i5) : i5
    %8 = llvm.mlir.constant(dense<-1> : vector<2xi5>) : vector<2xi5>
    %9 = llvm.mul %arg1, %arg1  : vector<2xi16>
    %10 = llvm.ashr %arg0, %6  : vector<2xi5>
    %11 = llvm.xor %10, %8  : vector<2xi5>
    %12 = llvm.sext %11 : vector<2xi5> to vector<2xi16>
    %13 = llvm.and %9, %12  : vector<2xi16>
    llvm.return %13 : vector<2xi16>
  }
  llvm.func @invert_signbit_splat_mask_use1(%arg0: i8, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.xor %2, %1  : i8
    %4 = llvm.sext %3 : i8 to i16
    %5 = llvm.and %4, %arg1  : i16
    llvm.return %5 : i16
  }
  llvm.func @invert_signbit_splat_mask_use2(%arg0: i8, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.xor %2, %1  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.sext %3 : i8 to i16
    %5 = llvm.and %4, %arg1  : i16
    llvm.return %5 : i16
  }
  llvm.func @invert_signbit_splat_mask_use3(%arg0: i8, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.xor %2, %1  : i8
    %4 = llvm.sext %3 : i8 to i16
    llvm.call @use16(%4) : (i16) -> ()
    %5 = llvm.and %4, %arg1  : i16
    llvm.return %5 : i16
  }
  llvm.func @not_invert_signbit_splat_mask1(%arg0: i8, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.xor %2, %1  : i8
    %4 = llvm.zext %3 : i8 to i16
    %5 = llvm.and %4, %arg1  : i16
    llvm.return %5 : i16
  }
  llvm.func @not_invert_signbit_splat_mask2(%arg0: i8, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.xor %2, %1  : i8
    %4 = llvm.sext %3 : i8 to i16
    %5 = llvm.and %4, %arg1  : i16
    llvm.return %5 : i16
  }
  llvm.func @shl_lshr_pow2_const_case1(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(4 : i16) : i16
    %1 = llvm.mlir.constant(6 : i16) : i16
    %2 = llvm.mlir.constant(8 : i16) : i16
    %3 = llvm.shl %0, %arg0  : i16
    %4 = llvm.lshr %3, %1  : i16
    %5 = llvm.and %4, %2  : i16
    llvm.return %5 : i16
  }
  llvm.func @shl_ashr_pow2_const_case1(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(4 : i16) : i16
    %1 = llvm.mlir.constant(6 : i16) : i16
    %2 = llvm.mlir.constant(8 : i16) : i16
    %3 = llvm.shl %0, %arg0  : i16
    %4 = llvm.ashr %3, %1  : i16
    %5 = llvm.and %4, %2  : i16
    llvm.return %5 : i16
  }
  llvm.func @shl_lshr_pow2_const_case1_uniform_vec(%arg0: vector<3xi16>) -> vector<3xi16> {
    %0 = llvm.mlir.constant(dense<4> : vector<3xi16>) : vector<3xi16>
    %1 = llvm.mlir.constant(dense<6> : vector<3xi16>) : vector<3xi16>
    %2 = llvm.mlir.constant(dense<8> : vector<3xi16>) : vector<3xi16>
    %3 = llvm.shl %0, %arg0  : vector<3xi16>
    %4 = llvm.lshr %3, %1  : vector<3xi16>
    %5 = llvm.and %4, %2  : vector<3xi16>
    llvm.return %5 : vector<3xi16>
  }
  llvm.func @shl_lshr_pow2_const_case1_non_uniform_vec(%arg0: vector<3xi16>) -> vector<3xi16> {
    %0 = llvm.mlir.constant(dense<[2, 8, 32]> : vector<3xi16>) : vector<3xi16>
    %1 = llvm.mlir.constant(dense<[5, 6, 3]> : vector<3xi16>) : vector<3xi16>
    %2 = llvm.mlir.constant(dense<[8, 4, 8]> : vector<3xi16>) : vector<3xi16>
    %3 = llvm.shl %0, %arg0  : vector<3xi16>
    %4 = llvm.lshr %3, %1  : vector<3xi16>
    %5 = llvm.and %4, %2  : vector<3xi16>
    llvm.return %5 : vector<3xi16>
  }
  llvm.func @shl_lshr_pow2_const_case1_non_uniform_vec_negative(%arg0: vector<3xi16>) -> vector<3xi16> {
    %0 = llvm.mlir.constant(dense<[2, 8, 32]> : vector<3xi16>) : vector<3xi16>
    %1 = llvm.mlir.constant(dense<[5, 6, 3]> : vector<3xi16>) : vector<3xi16>
    %2 = llvm.mlir.constant(dense<[8, 4, 16384]> : vector<3xi16>) : vector<3xi16>
    %3 = llvm.shl %0, %arg0  : vector<3xi16>
    %4 = llvm.lshr %3, %1  : vector<3xi16>
    %5 = llvm.and %4, %2  : vector<3xi16>
    llvm.return %5 : vector<3xi16>
  }
  llvm.func @shl_lshr_pow2_const_case1_poison1_vec(%arg0: vector<3xi16>) -> vector<3xi16> {
    %0 = llvm.mlir.constant(16 : i16) : i16
    %1 = llvm.mlir.poison : i16
    %2 = llvm.mlir.undef : vector<3xi16>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<3xi16>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<3xi16>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi16>
    %9 = llvm.mlir.constant(dense<5> : vector<3xi16>) : vector<3xi16>
    %10 = llvm.mlir.constant(dense<8> : vector<3xi16>) : vector<3xi16>
    %11 = llvm.shl %8, %arg0  : vector<3xi16>
    %12 = llvm.lshr %11, %9  : vector<3xi16>
    %13 = llvm.and %12, %10  : vector<3xi16>
    llvm.return %13 : vector<3xi16>
  }
  llvm.func @shl_lshr_pow2_const_case1_poison2_vec(%arg0: vector<3xi16>) -> vector<3xi16> {
    %0 = llvm.mlir.constant(dense<16> : vector<3xi16>) : vector<3xi16>
    %1 = llvm.mlir.constant(5 : i16) : i16
    %2 = llvm.mlir.poison : i16
    %3 = llvm.mlir.undef : vector<3xi16>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<3xi16>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<3xi16>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<3xi16>
    %10 = llvm.mlir.constant(dense<8> : vector<3xi16>) : vector<3xi16>
    %11 = llvm.shl %0, %arg0  : vector<3xi16>
    %12 = llvm.lshr %11, %9  : vector<3xi16>
    %13 = llvm.and %12, %10  : vector<3xi16>
    llvm.return %13 : vector<3xi16>
  }
  llvm.func @shl_lshr_pow2_const_case1_poison3_vec(%arg0: vector<3xi16>) -> vector<3xi16> {
    %0 = llvm.mlir.constant(dense<16> : vector<3xi16>) : vector<3xi16>
    %1 = llvm.mlir.constant(dense<5> : vector<3xi16>) : vector<3xi16>
    %2 = llvm.mlir.constant(8 : i16) : i16
    %3 = llvm.mlir.poison : i16
    %4 = llvm.mlir.undef : vector<3xi16>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<3xi16>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<3xi16>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %2, %8[%9 : i32] : vector<3xi16>
    %11 = llvm.shl %0, %arg0  : vector<3xi16>
    %12 = llvm.lshr %11, %1  : vector<3xi16>
    %13 = llvm.and %12, %10  : vector<3xi16>
    llvm.return %13 : vector<3xi16>
  }
  llvm.func @shl_lshr_pow2_const_case2(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(16 : i16) : i16
    %1 = llvm.mlir.constant(3 : i16) : i16
    %2 = llvm.mlir.constant(8 : i16) : i16
    %3 = llvm.shl %0, %arg0  : i16
    %4 = llvm.lshr %3, %1  : i16
    %5 = llvm.and %4, %2  : i16
    llvm.return %5 : i16
  }
  llvm.func @shl_lshr_pow2_not_const_case2(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(16 : i16) : i16
    %1 = llvm.mlir.constant(3 : i16) : i16
    %2 = llvm.mlir.constant(8 : i16) : i16
    %3 = llvm.shl %0, %arg0  : i16
    %4 = llvm.lshr %3, %1  : i16
    %5 = llvm.and %4, %2  : i16
    %6 = llvm.xor %5, %2  : i16
    llvm.return %6 : i16
  }
  llvm.func @shl_lshr_pow2_const_negative_overflow1(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(4096 : i16) : i16
    %1 = llvm.mlir.constant(6 : i16) : i16
    %2 = llvm.mlir.constant(8 : i16) : i16
    %3 = llvm.shl %0, %arg0  : i16
    %4 = llvm.lshr %3, %1  : i16
    %5 = llvm.and %4, %2  : i16
    llvm.return %5 : i16
  }
  llvm.func @shl_lshr_pow2_const_negative_overflow2(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(8 : i16) : i16
    %1 = llvm.mlir.constant(6 : i16) : i16
    %2 = llvm.mlir.constant(-32768 : i16) : i16
    %3 = llvm.shl %0, %arg0  : i16
    %4 = llvm.lshr %3, %1  : i16
    %5 = llvm.and %4, %2  : i16
    llvm.return %5 : i16
  }
  llvm.func @shl_lshr_pow2_const_negative_oneuse(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(4 : i16) : i16
    %1 = llvm.mlir.constant(6 : i16) : i16
    %2 = llvm.mlir.constant(8 : i16) : i16
    %3 = llvm.shl %0, %arg0  : i16
    %4 = llvm.lshr %3, %1  : i16
    llvm.call @use16(%4) : (i16) -> ()
    %5 = llvm.and %4, %2  : i16
    llvm.return %5 : i16
  }
  llvm.func @shl_lshr_pow2_const_negative_nopow2_1(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(3 : i16) : i16
    %1 = llvm.mlir.constant(6 : i16) : i16
    %2 = llvm.mlir.constant(8 : i16) : i16
    %3 = llvm.shl %0, %arg0  : i16
    %4 = llvm.lshr %3, %1  : i16
    %5 = llvm.and %4, %2  : i16
    llvm.return %5 : i16
  }
  llvm.func @shl_lshr_pow2_const_negative_nopow2_2(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(3 : i16) : i16
    %1 = llvm.mlir.constant(6 : i16) : i16
    %2 = llvm.mlir.constant(7 : i16) : i16
    %3 = llvm.shl %0, %arg0  : i16
    %4 = llvm.lshr %3, %1  : i16
    %5 = llvm.and %4, %2  : i16
    llvm.return %5 : i16
  }
  llvm.func @lshr_lshr_pow2_const(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(2048 : i16) : i16
    %1 = llvm.mlir.constant(6 : i16) : i16
    %2 = llvm.mlir.constant(4 : i16) : i16
    %3 = llvm.lshr %0, %arg0  : i16
    %4 = llvm.lshr %3, %1  : i16
    %5 = llvm.and %4, %2  : i16
    llvm.return %5 : i16
  }
  llvm.func @lshr_lshr_pow2_const_negative_oneuse(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(2048 : i16) : i16
    %1 = llvm.mlir.constant(6 : i16) : i16
    %2 = llvm.mlir.constant(4 : i16) : i16
    %3 = llvm.lshr %0, %arg0  : i16
    %4 = llvm.lshr %3, %1  : i16
    llvm.call @use16(%4) : (i16) -> ()
    %5 = llvm.and %4, %2  : i16
    llvm.return %5 : i16
  }
  llvm.func @lshr_lshr_pow2_const_negative_nopow2_1(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(2047 : i16) : i16
    %1 = llvm.mlir.constant(6 : i16) : i16
    %2 = llvm.mlir.constant(4 : i16) : i16
    %3 = llvm.lshr %0, %arg0  : i16
    %4 = llvm.lshr %3, %1  : i16
    %5 = llvm.and %4, %2  : i16
    llvm.return %5 : i16
  }
  llvm.func @lshr_lshr_pow2_const_negative_nopow2_2(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(8192 : i16) : i16
    %1 = llvm.mlir.constant(6 : i16) : i16
    %2 = llvm.mlir.constant(3 : i16) : i16
    %3 = llvm.lshr %0, %arg0  : i16
    %4 = llvm.lshr %3, %1  : i16
    %5 = llvm.and %4, %2  : i16
    llvm.return %5 : i16
  }
  llvm.func @lshr_lshr_pow2_const_negative_overflow(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(-32768 : i16) : i16
    %1 = llvm.mlir.constant(15 : i16) : i16
    %2 = llvm.mlir.constant(4 : i16) : i16
    %3 = llvm.lshr %0, %arg0  : i16
    %4 = llvm.lshr %3, %1  : i16
    %5 = llvm.and %4, %2  : i16
    llvm.return %5 : i16
  }
  llvm.func @lshr_shl_pow2_const_case1(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(256 : i16) : i16
    %1 = llvm.mlir.constant(2 : i16) : i16
    %2 = llvm.mlir.constant(8 : i16) : i16
    %3 = llvm.lshr %0, %arg0  : i16
    %4 = llvm.shl %3, %1  : i16
    %5 = llvm.and %4, %2  : i16
    llvm.return %5 : i16
  }
  llvm.func @lshr_shl_pow2_const_xor(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(256 : i16) : i16
    %1 = llvm.mlir.constant(2 : i16) : i16
    %2 = llvm.mlir.constant(8 : i16) : i16
    %3 = llvm.lshr %0, %arg0  : i16
    %4 = llvm.shl %3, %1  : i16
    %5 = llvm.and %4, %2  : i16
    %6 = llvm.xor %5, %2  : i16
    llvm.return %6 : i16
  }
  llvm.func @lshr_shl_pow2_const_case2(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(8192 : i16) : i16
    %1 = llvm.mlir.constant(4 : i16) : i16
    %2 = llvm.mlir.constant(32 : i16) : i16
    %3 = llvm.lshr %0, %arg0  : i16
    %4 = llvm.shl %3, %1  : i16
    %5 = llvm.and %4, %2  : i16
    llvm.return %5 : i16
  }
  llvm.func @lshr_shl_pow2_const_overflow(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(8192 : i16) : i16
    %1 = llvm.mlir.constant(6 : i16) : i16
    %2 = llvm.mlir.constant(32 : i16) : i16
    %3 = llvm.lshr %0, %arg0  : i16
    %4 = llvm.shl %3, %1  : i16
    %5 = llvm.and %4, %2  : i16
    llvm.return %5 : i16
  }
  llvm.func @lshr_shl_pow2_const_negative_oneuse(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(8192 : i16) : i16
    %1 = llvm.mlir.constant(4 : i16) : i16
    %2 = llvm.mlir.constant(32 : i16) : i16
    %3 = llvm.lshr %0, %arg0  : i16
    %4 = llvm.shl %3, %1  : i16
    llvm.call @use16(%4) : (i16) -> ()
    %5 = llvm.and %4, %2  : i16
    llvm.return %5 : i16
  }
  llvm.func @lshr_shl_pow2_const_case1_uniform_vec(%arg0: vector<3xi16>) -> vector<3xi16> {
    %0 = llvm.mlir.constant(dense<8192> : vector<3xi16>) : vector<3xi16>
    %1 = llvm.mlir.constant(dense<6> : vector<3xi16>) : vector<3xi16>
    %2 = llvm.mlir.constant(dense<128> : vector<3xi16>) : vector<3xi16>
    %3 = llvm.lshr %0, %arg0  : vector<3xi16>
    %4 = llvm.shl %3, %1  : vector<3xi16>
    %5 = llvm.and %4, %2  : vector<3xi16>
    llvm.return %5 : vector<3xi16>
  }
  llvm.func @lshr_shl_pow2_const_case1_non_uniform_vec(%arg0: vector<3xi16>) -> vector<3xi16> {
    %0 = llvm.mlir.constant(dense<[8192, 16384, -32768]> : vector<3xi16>) : vector<3xi16>
    %1 = llvm.mlir.constant(dense<[7, 5, 3]> : vector<3xi16>) : vector<3xi16>
    %2 = llvm.mlir.constant(dense<[128, 256, 512]> : vector<3xi16>) : vector<3xi16>
    %3 = llvm.lshr %0, %arg0  : vector<3xi16>
    %4 = llvm.shl %3, %1  : vector<3xi16>
    %5 = llvm.and %4, %2  : vector<3xi16>
    llvm.return %5 : vector<3xi16>
  }
  llvm.func @lshr_shl_pow2_const_case1_non_uniform_vec_negative(%arg0: vector<3xi16>) -> vector<3xi16> {
    %0 = llvm.mlir.constant(dense<[8192, 16384, -32768]> : vector<3xi16>) : vector<3xi16>
    %1 = llvm.mlir.constant(dense<[8, 5, 3]> : vector<3xi16>) : vector<3xi16>
    %2 = llvm.mlir.constant(dense<[128, 256, 512]> : vector<3xi16>) : vector<3xi16>
    %3 = llvm.lshr %0, %arg0  : vector<3xi16>
    %4 = llvm.shl %3, %1  : vector<3xi16>
    %5 = llvm.and %4, %2  : vector<3xi16>
    llvm.return %5 : vector<3xi16>
  }
  llvm.func @lshr_shl_pow2_const_case1_poison1_vec(%arg0: vector<3xi16>) -> vector<3xi16> {
    %0 = llvm.mlir.constant(8192 : i16) : i16
    %1 = llvm.mlir.poison : i16
    %2 = llvm.mlir.undef : vector<3xi16>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<3xi16>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<3xi16>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi16>
    %9 = llvm.mlir.constant(dense<6> : vector<3xi16>) : vector<3xi16>
    %10 = llvm.mlir.constant(dense<128> : vector<3xi16>) : vector<3xi16>
    %11 = llvm.lshr %8, %arg0  : vector<3xi16>
    %12 = llvm.shl %11, %9  : vector<3xi16>
    %13 = llvm.and %12, %10  : vector<3xi16>
    llvm.return %13 : vector<3xi16>
  }
  llvm.func @lshr_shl_pow2_const_case1_poison2_vec(%arg0: vector<3xi16>) -> vector<3xi16> {
    %0 = llvm.mlir.constant(dense<8192> : vector<3xi16>) : vector<3xi16>
    %1 = llvm.mlir.constant(6 : i16) : i16
    %2 = llvm.mlir.poison : i16
    %3 = llvm.mlir.undef : vector<3xi16>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<3xi16>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<3xi16>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<3xi16>
    %10 = llvm.mlir.constant(dense<128> : vector<3xi16>) : vector<3xi16>
    %11 = llvm.lshr %0, %arg0  : vector<3xi16>
    %12 = llvm.shl %11, %9  : vector<3xi16>
    %13 = llvm.and %12, %10  : vector<3xi16>
    llvm.return %13 : vector<3xi16>
  }
  llvm.func @lshr_shl_pow2_const_case1_poison3_vec(%arg0: vector<3xi16>) -> vector<3xi16> {
    %0 = llvm.mlir.constant(dense<8192> : vector<3xi16>) : vector<3xi16>
    %1 = llvm.mlir.constant(dense<6> : vector<3xi16>) : vector<3xi16>
    %2 = llvm.mlir.constant(128 : i16) : i16
    %3 = llvm.mlir.poison : i16
    %4 = llvm.mlir.undef : vector<3xi16>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<3xi16>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<3xi16>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %2, %8[%9 : i32] : vector<3xi16>
    %11 = llvm.lshr %0, %arg0  : vector<3xi16>
    %12 = llvm.shl %11, %1  : vector<3xi16>
    %13 = llvm.and %12, %10  : vector<3xi16>
    llvm.return %13 : vector<3xi16>
  }
  llvm.func @negate_lowbitmask(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.sub %1, %2  : i8
    %4 = llvm.and %3, %arg1  : i8
    llvm.return %4 : i8
  }
  llvm.func @negate_lowbitmask_commute(%arg0: vector<2xi5>, %arg1: vector<2xi5>) -> vector<2xi5> {
    %0 = llvm.mlir.poison : i5
    %1 = llvm.mlir.constant(1 : i5) : i5
    %2 = llvm.mlir.undef : vector<2xi5>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi5>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi5>
    %7 = llvm.mlir.constant(0 : i5) : i5
    %8 = llvm.mlir.undef : vector<2xi5>
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<2xi5>
    %11 = llvm.mlir.constant(1 : i32) : i32
    %12 = llvm.insertelement %7, %10[%11 : i32] : vector<2xi5>
    %13 = llvm.mul %arg1, %arg1  : vector<2xi5>
    %14 = llvm.and %arg0, %6  : vector<2xi5>
    %15 = llvm.sub %12, %14  : vector<2xi5>
    %16 = llvm.and %13, %15  : vector<2xi5>
    llvm.return %16 : vector<2xi5>
  }
  llvm.func @negate_lowbitmask_use1(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.sub %1, %2  : i8
    %4 = llvm.and %3, %arg1  : i8
    llvm.return %4 : i8
  }
  llvm.func @negate_lowbitmask_use2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.sub %1, %2  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.and %3, %arg1  : i8
    llvm.return %4 : i8
  }
  llvm.func @test_and_or_constexpr_infloop() -> i64 {
    %0 = llvm.mlir.addressof @g : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i64
    %2 = llvm.mlir.constant(-8 : i64) : i64
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.and %1, %2  : i64
    %5 = llvm.or %4, %3  : i64
    llvm.return %5 : i64
  }
  llvm.func @and_zext(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.zext %arg1 : i1 to i32
    %1 = llvm.and %arg0, %0  : i32
    llvm.return %1 : i32
  }
  llvm.func @and_zext_commuted(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.zext %arg1 : i1 to i32
    %1 = llvm.and %0, %arg0  : i32
    llvm.return %1 : i32
  }
  llvm.func @and_zext_multiuse(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.zext %arg1 : i1 to i32
    llvm.call @use32(%0) : (i32) -> ()
    %1 = llvm.and %arg0, %0  : i32
    llvm.return %1 : i32
  }
  llvm.func @and_zext_vec(%arg0: vector<2xi32>, %arg1: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.zext %arg1 : vector<2xi1> to vector<2xi32>
    %1 = llvm.and %arg0, %0  : vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }
  llvm.func @and_zext_eq_even(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.zext %1 : i1 to i32
    %3 = llvm.and %arg0, %2  : i32
    llvm.return %3 : i32
  }
  llvm.func @and_zext_eq_even_commuted(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.zext %1 : i1 to i32
    %3 = llvm.and %2, %arg0  : i32
    llvm.return %3 : i32
  }
  llvm.func @and_zext_eq_odd(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.zext %1 : i1 to i32
    %3 = llvm.and %arg0, %2  : i32
    llvm.return %3 : i32
  }
  llvm.func @and_zext_eq_odd_commuted(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.zext %1 : i1 to i32
    %3 = llvm.and %2, %arg0  : i32
    llvm.return %3 : i32
  }
  llvm.func @and_zext_eq_zero(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    %4 = llvm.lshr %arg0, %arg1  : i32
    %5 = llvm.xor %4, %1  : i32
    %6 = llvm.and %3, %5  : i32
    llvm.return %6 : i32
  }
  llvm.func @canonicalize_and_add_power2_or_zero(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg1  : i32
    %2 = llvm.and %1, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.mul %arg0, %arg0  : i32
    %4 = llvm.add %3, %2  : i32
    %5 = llvm.and %4, %2  : i32
    llvm.return %5 : i32
  }
  llvm.func @canonicalize_and_sub_power2_or_zero(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg1  : i32
    %2 = llvm.and %1, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.sub %arg0, %2  : i32
    %4 = llvm.and %3, %2  : i32
    llvm.return %4 : i32
  }
  llvm.func @canonicalize_and_add_power2_or_zero_commuted1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg1  : i32
    %2 = llvm.and %1, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.add %2, %arg0  : i32
    %4 = llvm.and %3, %2  : i32
    llvm.return %4 : i32
  }
  llvm.func @canonicalize_and_add_power2_or_zero_commuted2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg1  : i32
    %2 = llvm.and %1, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.mul %arg0, %arg0  : i32
    %4 = llvm.add %3, %2  : i32
    %5 = llvm.and %2, %4  : i32
    llvm.return %5 : i32
  }
  llvm.func @canonicalize_and_add_power2_or_zero_commuted3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg1  : i32
    %2 = llvm.and %1, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.add %2, %arg0  : i32
    %4 = llvm.and %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @canonicalize_and_sub_power2_or_zero_commuted_nofold(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg1  : i32
    %2 = llvm.and %1, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.sub %2, %arg0  : i32
    %4 = llvm.and %3, %2  : i32
    llvm.return %4 : i32
  }
  llvm.func @canonicalize_and_add_non_power2_or_zero_nofold(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.add %arg0, %arg1  : i32
    %1 = llvm.and %0, %arg1  : i32
    llvm.return %1 : i32
  }
  llvm.func @canonicalize_and_add_power2_or_zero_multiuse_nofold(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg1  : i32
    %2 = llvm.and %1, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.mul %arg0, %arg0  : i32
    %4 = llvm.add %3, %2  : i32
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.and %4, %2  : i32
    llvm.return %5 : i32
  }
  llvm.func @canonicalize_and_sub_power2_or_zero_multiuse_nofold(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg1  : i32
    %2 = llvm.and %1, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.sub %arg0, %2  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.and %3, %2  : i32
    llvm.return %4 : i32
  }
  llvm.func @add_constant_equal_with_the_top_bit_of_demandedbits_pass(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(24 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @add_constant_equal_with_the_top_bit_of_demandedbits_pass_vector(%arg0: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.mlir.constant(dense<24> : vector<2xi16>) : vector<2xi16>
    %2 = llvm.add %arg0, %0  : vector<2xi16>
    %3 = llvm.and %2, %1  : vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }
  llvm.func @add_constant_equal_with_the_top_bit_of_demandedbits_fail1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(24 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @add_constant_equal_with_the_top_bit_of_demandedbits_fail2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.and %1, %0  : i32
    llvm.return %2 : i32
  }
  llvm.func @add_constant_equal_with_the_top_bit_of_demandedbits_insertpt(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(24 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.or %2, %arg1  : i32
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @and_sext_multiuse(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i32
    %1 = llvm.sext %0 : i1 to i32
    %2 = llvm.and %1, %arg2  : i32
    %3 = llvm.and %1, %arg3  : i32
    %4 = llvm.add %2, %3  : i32
    llvm.return %4 : i32
  }
}
