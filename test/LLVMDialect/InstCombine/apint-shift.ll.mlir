module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test6(%arg0: i55) -> i55 {
    %0 = llvm.mlir.constant(1 : i55) : i55
    %1 = llvm.mlir.constant(3 : i55) : i55
    %2 = llvm.shl %arg0, %0  : i55
    %3 = llvm.mul %2, %1  : i55
    llvm.return %3 : i55
  }
  llvm.func @test6a(%arg0: i55) -> i55 {
    %0 = llvm.mlir.constant(3 : i55) : i55
    %1 = llvm.mlir.constant(1 : i55) : i55
    %2 = llvm.mul %arg0, %0  : i55
    %3 = llvm.shl %2, %1  : i55
    llvm.return %3 : i55
  }
  llvm.func @use(i55)
  llvm.func @test6a_negative_oneuse(%arg0: i55) -> i55 {
    %0 = llvm.mlir.constant(3 : i55) : i55
    %1 = llvm.mlir.constant(1 : i55) : i55
    %2 = llvm.mul %arg0, %0  : i55
    %3 = llvm.shl %2, %1  : i55
    llvm.call @use(%2) : (i55) -> ()
    llvm.return %3 : i55
  }
  llvm.func @test6a_vec(%arg0: vector<2xi55>) -> vector<2xi55> {
    %0 = llvm.mlir.constant(12 : i55) : i55
    %1 = llvm.mlir.constant(3 : i55) : i55
    %2 = llvm.mlir.constant(dense<[3, 12]> : vector<2xi55>) : vector<2xi55>
    %3 = llvm.mlir.constant(2 : i55) : i55
    %4 = llvm.mlir.constant(1 : i55) : i55
    %5 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi55>) : vector<2xi55>
    %6 = llvm.mul %arg0, %2  : vector<2xi55>
    %7 = llvm.shl %6, %5  : vector<2xi55>
    llvm.return %7 : vector<2xi55>
  }
  llvm.func @test7(%arg0: i8) -> i29 {
    %0 = llvm.mlir.constant(-1 : i29) : i29
    %1 = llvm.zext %arg0 : i8 to i29
    %2 = llvm.ashr %0, %1  : i29
    llvm.return %2 : i29
  }
  llvm.func @test8(%arg0: i7) -> i7 {
    %0 = llvm.mlir.constant(4 : i7) : i7
    %1 = llvm.mlir.constant(3 : i7) : i7
    %2 = llvm.shl %arg0, %0  : i7
    %3 = llvm.shl %2, %1  : i7
    llvm.return %3 : i7
  }
  llvm.func @test9(%arg0: i17) -> i17 {
    %0 = llvm.mlir.constant(16 : i17) : i17
    %1 = llvm.shl %arg0, %0  : i17
    %2 = llvm.lshr %1, %0  : i17
    llvm.return %2 : i17
  }
  llvm.func @test10(%arg0: i19) -> i19 {
    %0 = llvm.mlir.constant(18 : i19) : i19
    %1 = llvm.lshr %arg0, %0  : i19
    %2 = llvm.shl %1, %0  : i19
    llvm.return %2 : i19
  }
  llvm.func @lshr_lshr_splat_vec(%arg0: vector<2xi19>) -> vector<2xi19> {
    %0 = llvm.mlir.constant(3 : i19) : i19
    %1 = llvm.mlir.constant(dense<3> : vector<2xi19>) : vector<2xi19>
    %2 = llvm.mlir.constant(2 : i19) : i19
    %3 = llvm.mlir.constant(dense<2> : vector<2xi19>) : vector<2xi19>
    %4 = llvm.lshr %arg0, %1  : vector<2xi19>
    %5 = llvm.lshr %4, %3  : vector<2xi19>
    llvm.return %5 : vector<2xi19>
  }
  llvm.func @multiuse_lshr_lshr(%arg0: i9) -> i9 {
    %0 = llvm.mlir.constant(2 : i9) : i9
    %1 = llvm.mlir.constant(3 : i9) : i9
    %2 = llvm.lshr %arg0, %0  : i9
    %3 = llvm.lshr %2, %1  : i9
    %4 = llvm.mul %2, %3  : i9
    llvm.return %4 : i9
  }
  llvm.func @multiuse_lshr_lshr_splat(%arg0: vector<2xi9>) -> vector<2xi9> {
    %0 = llvm.mlir.constant(2 : i9) : i9
    %1 = llvm.mlir.constant(dense<2> : vector<2xi9>) : vector<2xi9>
    %2 = llvm.mlir.constant(3 : i9) : i9
    %3 = llvm.mlir.constant(dense<3> : vector<2xi9>) : vector<2xi9>
    %4 = llvm.lshr %arg0, %1  : vector<2xi9>
    %5 = llvm.lshr %4, %3  : vector<2xi9>
    %6 = llvm.mul %4, %5  : vector<2xi9>
    llvm.return %6 : vector<2xi9>
  }
  llvm.func @shl_shl_splat_vec(%arg0: vector<2xi19>) -> vector<2xi19> {
    %0 = llvm.mlir.constant(3 : i19) : i19
    %1 = llvm.mlir.constant(dense<3> : vector<2xi19>) : vector<2xi19>
    %2 = llvm.mlir.constant(2 : i19) : i19
    %3 = llvm.mlir.constant(dense<2> : vector<2xi19>) : vector<2xi19>
    %4 = llvm.shl %arg0, %1  : vector<2xi19>
    %5 = llvm.shl %4, %3  : vector<2xi19>
    llvm.return %5 : vector<2xi19>
  }
  llvm.func @multiuse_shl_shl(%arg0: i42) -> i42 {
    %0 = llvm.mlir.constant(8 : i42) : i42
    %1 = llvm.mlir.constant(9 : i42) : i42
    %2 = llvm.shl %arg0, %0  : i42
    %3 = llvm.shl %2, %1  : i42
    %4 = llvm.mul %2, %3  : i42
    llvm.return %4 : i42
  }
  llvm.func @multiuse_shl_shl_splat(%arg0: vector<2xi42>) -> vector<2xi42> {
    %0 = llvm.mlir.constant(8 : i42) : i42
    %1 = llvm.mlir.constant(dense<8> : vector<2xi42>) : vector<2xi42>
    %2 = llvm.mlir.constant(9 : i42) : i42
    %3 = llvm.mlir.constant(dense<9> : vector<2xi42>) : vector<2xi42>
    %4 = llvm.shl %arg0, %1  : vector<2xi42>
    %5 = llvm.shl %4, %3  : vector<2xi42>
    %6 = llvm.mul %4, %5  : vector<2xi42>
    llvm.return %6 : vector<2xi42>
  }
  llvm.func @eq_shl_lshr_splat_vec(%arg0: vector<2xi19>) -> vector<2xi19> {
    %0 = llvm.mlir.constant(3 : i19) : i19
    %1 = llvm.mlir.constant(dense<3> : vector<2xi19>) : vector<2xi19>
    %2 = llvm.shl %arg0, %1  : vector<2xi19>
    %3 = llvm.lshr %2, %1  : vector<2xi19>
    llvm.return %3 : vector<2xi19>
  }
  llvm.func @eq_lshr_shl_splat_vec(%arg0: vector<2xi19>) -> vector<2xi19> {
    %0 = llvm.mlir.constant(3 : i19) : i19
    %1 = llvm.mlir.constant(dense<3> : vector<2xi19>) : vector<2xi19>
    %2 = llvm.lshr %arg0, %1  : vector<2xi19>
    %3 = llvm.shl %2, %1  : vector<2xi19>
    llvm.return %3 : vector<2xi19>
  }
  llvm.func @lshr_shl_splat_vec(%arg0: vector<2xi7>) -> vector<2xi7> {
    %0 = llvm.mlir.constant(-8 : i7) : i7
    %1 = llvm.mlir.constant(dense<-8> : vector<2xi7>) : vector<2xi7>
    %2 = llvm.mlir.constant(3 : i7) : i7
    %3 = llvm.mlir.constant(dense<3> : vector<2xi7>) : vector<2xi7>
    %4 = llvm.mlir.constant(2 : i7) : i7
    %5 = llvm.mlir.constant(dense<2> : vector<2xi7>) : vector<2xi7>
    %6 = llvm.mul %arg0, %1  : vector<2xi7>
    %7 = llvm.lshr %6, %3  : vector<2xi7>
    %8 = llvm.shl %7, %5 overflow<nsw, nuw>  : vector<2xi7>
    llvm.return %8 : vector<2xi7>
  }
  llvm.func @shl_lshr_splat_vec(%arg0: vector<2xi7>) -> vector<2xi7> {
    %0 = llvm.mlir.constant(9 : i7) : i7
    %1 = llvm.mlir.constant(dense<9> : vector<2xi7>) : vector<2xi7>
    %2 = llvm.mlir.constant(3 : i7) : i7
    %3 = llvm.mlir.constant(dense<3> : vector<2xi7>) : vector<2xi7>
    %4 = llvm.mlir.constant(2 : i7) : i7
    %5 = llvm.mlir.constant(dense<2> : vector<2xi7>) : vector<2xi7>
    %6 = llvm.udiv %arg0, %1  : vector<2xi7>
    %7 = llvm.shl %6, %3 overflow<nuw>  : vector<2xi7>
    %8 = llvm.lshr %7, %5  : vector<2xi7>
    llvm.return %8 : vector<2xi7>
  }
  llvm.func @test11(%arg0: i23) -> i23 {
    %0 = llvm.mlir.constant(3 : i23) : i23
    %1 = llvm.mlir.constant(11 : i23) : i23
    %2 = llvm.mlir.constant(12 : i23) : i23
    %3 = llvm.mul %arg0, %0  : i23
    %4 = llvm.lshr %3, %1  : i23
    %5 = llvm.shl %4, %2  : i23
    llvm.return %5 : i23
  }
  llvm.func @test12(%arg0: i47) -> i47 {
    %0 = llvm.mlir.constant(8 : i47) : i47
    %1 = llvm.ashr %arg0, %0  : i47
    %2 = llvm.shl %1, %0  : i47
    llvm.return %2 : i47
  }
  llvm.func @test12_splat_vec(%arg0: vector<2xi47>) -> vector<2xi47> {
    %0 = llvm.mlir.constant(8 : i47) : i47
    %1 = llvm.mlir.constant(dense<8> : vector<2xi47>) : vector<2xi47>
    %2 = llvm.ashr %arg0, %1  : vector<2xi47>
    %3 = llvm.shl %2, %1  : vector<2xi47>
    llvm.return %3 : vector<2xi47>
  }
  llvm.func @test13(%arg0: i18) -> i18 {
    %0 = llvm.mlir.constant(3 : i18) : i18
    %1 = llvm.mlir.constant(8 : i18) : i18
    %2 = llvm.mlir.constant(9 : i18) : i18
    %3 = llvm.mul %arg0, %0  : i18
    %4 = llvm.ashr %3, %1  : i18
    %5 = llvm.shl %4, %2  : i18
    llvm.return %5 : i18
  }
  llvm.func @test14(%arg0: i35) -> i35 {
    %0 = llvm.mlir.constant(4 : i35) : i35
    %1 = llvm.mlir.constant(1234 : i35) : i35
    %2 = llvm.lshr %arg0, %0  : i35
    %3 = llvm.or %2, %1  : i35
    %4 = llvm.shl %3, %0  : i35
    llvm.return %4 : i35
  }
  llvm.func @test14a(%arg0: i79) -> i79 {
    %0 = llvm.mlir.constant(4 : i79) : i79
    %1 = llvm.mlir.constant(1234 : i79) : i79
    %2 = llvm.shl %arg0, %0  : i79
    %3 = llvm.and %2, %1  : i79
    %4 = llvm.lshr %3, %0  : i79
    llvm.return %4 : i79
  }
  llvm.func @test15(%arg0: i1) -> i45 {
    %0 = llvm.mlir.constant(3 : i45) : i45
    %1 = llvm.mlir.constant(1 : i45) : i45
    %2 = llvm.mlir.constant(2 : i45) : i45
    %3 = llvm.select %arg0, %0, %1 : i1, i45
    %4 = llvm.shl %3, %2  : i45
    llvm.return %4 : i45
  }
  llvm.func @test15a(%arg0: i1) -> i53 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(64 : i53) : i53
    %3 = llvm.select %arg0, %0, %1 : i1, i8
    %4 = llvm.zext %3 : i8 to i53
    %5 = llvm.shl %2, %4  : i53
    llvm.return %5 : i53
  }
  llvm.func @test16(%arg0: i84) -> i1 {
    %0 = llvm.mlir.constant(4 : i84) : i84
    %1 = llvm.mlir.constant(1 : i84) : i84
    %2 = llvm.mlir.constant(0 : i84) : i84
    %3 = llvm.ashr %arg0, %0  : i84
    %4 = llvm.and %3, %1  : i84
    %5 = llvm.icmp "ne" %4, %2 : i84
    llvm.return %5 : i1
  }
  llvm.func @test16vec(%arg0: vector<2xi84>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(4 : i84) : i84
    %1 = llvm.mlir.constant(dense<4> : vector<2xi84>) : vector<2xi84>
    %2 = llvm.mlir.constant(1 : i84) : i84
    %3 = llvm.mlir.constant(dense<1> : vector<2xi84>) : vector<2xi84>
    %4 = llvm.mlir.constant(0 : i84) : i84
    %5 = llvm.mlir.constant(dense<0> : vector<2xi84>) : vector<2xi84>
    %6 = llvm.ashr %arg0, %1  : vector<2xi84>
    %7 = llvm.and %6, %3  : vector<2xi84>
    %8 = llvm.icmp "ne" %7, %5 : vector<2xi84>
    llvm.return %8 : vector<2xi1>
  }
  llvm.func @test16vec_nonuniform(%arg0: vector<2xi84>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(2 : i84) : i84
    %1 = llvm.mlir.constant(4 : i84) : i84
    %2 = llvm.mlir.constant(dense<[4, 2]> : vector<2xi84>) : vector<2xi84>
    %3 = llvm.mlir.constant(1 : i84) : i84
    %4 = llvm.mlir.constant(dense<1> : vector<2xi84>) : vector<2xi84>
    %5 = llvm.mlir.constant(0 : i84) : i84
    %6 = llvm.mlir.constant(dense<0> : vector<2xi84>) : vector<2xi84>
    %7 = llvm.ashr %arg0, %2  : vector<2xi84>
    %8 = llvm.and %7, %4  : vector<2xi84>
    %9 = llvm.icmp "ne" %8, %6 : vector<2xi84>
    llvm.return %9 : vector<2xi1>
  }
  llvm.func @test16vec_undef(%arg0: vector<2xi84>) -> vector<2xi1> {
    %0 = llvm.mlir.undef : i84
    %1 = llvm.mlir.constant(4 : i84) : i84
    %2 = llvm.mlir.undef : vector<2xi84>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi84>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi84>
    %7 = llvm.mlir.constant(1 : i84) : i84
    %8 = llvm.mlir.constant(dense<1> : vector<2xi84>) : vector<2xi84>
    %9 = llvm.mlir.constant(0 : i84) : i84
    %10 = llvm.mlir.constant(dense<0> : vector<2xi84>) : vector<2xi84>
    %11 = llvm.ashr %arg0, %6  : vector<2xi84>
    %12 = llvm.and %11, %8  : vector<2xi84>
    %13 = llvm.icmp "ne" %12, %10 : vector<2xi84>
    llvm.return %13 : vector<2xi1>
  }
  llvm.func @test17(%arg0: i106) -> i1 {
    %0 = llvm.mlir.constant(3 : i106) : i106
    %1 = llvm.mlir.constant(1234 : i106) : i106
    %2 = llvm.lshr %arg0, %0  : i106
    %3 = llvm.icmp "eq" %2, %1 : i106
    llvm.return %3 : i1
  }
  llvm.func @test17vec(%arg0: vector<2xi106>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(3 : i106) : i106
    %1 = llvm.mlir.constant(dense<3> : vector<2xi106>) : vector<2xi106>
    %2 = llvm.mlir.constant(1234 : i106) : i106
    %3 = llvm.mlir.constant(dense<1234> : vector<2xi106>) : vector<2xi106>
    %4 = llvm.lshr %arg0, %1  : vector<2xi106>
    %5 = llvm.icmp "eq" %4, %3 : vector<2xi106>
    llvm.return %5 : vector<2xi1>
  }
  llvm.func @test18(%arg0: i11) -> i1 {
    %0 = llvm.mlir.constant(10 : i11) : i11
    %1 = llvm.mlir.constant(123 : i11) : i11
    %2 = llvm.lshr %arg0, %0  : i11
    %3 = llvm.icmp "eq" %2, %1 : i11
    llvm.return %3 : i1
  }
  llvm.func @test19(%arg0: i37) -> i1 {
    %0 = llvm.mlir.constant(2 : i37) : i37
    %1 = llvm.mlir.constant(0 : i37) : i37
    %2 = llvm.ashr %arg0, %0  : i37
    %3 = llvm.icmp "eq" %2, %1 : i37
    llvm.return %3 : i1
  }
  llvm.func @test19vec(%arg0: vector<2xi37>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(2 : i37) : i37
    %1 = llvm.mlir.constant(dense<2> : vector<2xi37>) : vector<2xi37>
    %2 = llvm.mlir.constant(0 : i37) : i37
    %3 = llvm.mlir.constant(dense<0> : vector<2xi37>) : vector<2xi37>
    %4 = llvm.ashr %arg0, %1  : vector<2xi37>
    %5 = llvm.icmp "eq" %4, %3 : vector<2xi37>
    llvm.return %5 : vector<2xi1>
  }
  llvm.func @test19a(%arg0: i39) -> i1 {
    %0 = llvm.mlir.constant(2 : i39) : i39
    %1 = llvm.mlir.constant(-1 : i39) : i39
    %2 = llvm.ashr %arg0, %0  : i39
    %3 = llvm.icmp "eq" %2, %1 : i39
    llvm.return %3 : i1
  }
  llvm.func @test19a_vec(%arg0: vector<2xi39>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(2 : i39) : i39
    %1 = llvm.mlir.constant(dense<2> : vector<2xi39>) : vector<2xi39>
    %2 = llvm.mlir.constant(-1 : i39) : i39
    %3 = llvm.mlir.constant(dense<-1> : vector<2xi39>) : vector<2xi39>
    %4 = llvm.ashr %arg0, %1  : vector<2xi39>
    %5 = llvm.icmp "eq" %4, %3 : vector<2xi39>
    llvm.return %5 : vector<2xi1>
  }
  llvm.func @test20(%arg0: i13) -> i1 {
    %0 = llvm.mlir.constant(12 : i13) : i13
    %1 = llvm.mlir.constant(123 : i13) : i13
    %2 = llvm.ashr %arg0, %0  : i13
    %3 = llvm.icmp "eq" %2, %1 : i13
    llvm.return %3 : i1
  }
  llvm.func @test21(%arg0: i12) -> i1 {
    %0 = llvm.mlir.constant(6 : i12) : i12
    %1 = llvm.mlir.constant(-128 : i12) : i12
    %2 = llvm.shl %arg0, %0  : i12
    %3 = llvm.icmp "eq" %2, %1 : i12
    llvm.return %3 : i1
  }
  llvm.func @test22(%arg0: i14) -> i1 {
    %0 = llvm.mlir.constant(7 : i14) : i14
    %1 = llvm.mlir.constant(0 : i14) : i14
    %2 = llvm.shl %arg0, %0  : i14
    %3 = llvm.icmp "eq" %2, %1 : i14
    llvm.return %3 : i1
  }
  llvm.func @test23(%arg0: i44) -> i11 {
    %0 = llvm.mlir.constant(33 : i44) : i44
    %1 = llvm.shl %arg0, %0  : i44
    %2 = llvm.ashr %1, %0  : i44
    %3 = llvm.trunc %2 : i44 to i11
    llvm.return %3 : i11
  }
  llvm.func @shl_lshr_eq_amt_multi_use(%arg0: i44) -> i44 {
    %0 = llvm.mlir.constant(33 : i44) : i44
    %1 = llvm.shl %arg0, %0  : i44
    %2 = llvm.lshr %1, %0  : i44
    %3 = llvm.add %1, %2  : i44
    llvm.return %3 : i44
  }
  llvm.func @shl_lshr_eq_amt_multi_use_splat_vec(%arg0: vector<2xi44>) -> vector<2xi44> {
    %0 = llvm.mlir.constant(33 : i44) : i44
    %1 = llvm.mlir.constant(dense<33> : vector<2xi44>) : vector<2xi44>
    %2 = llvm.shl %arg0, %1  : vector<2xi44>
    %3 = llvm.lshr %2, %1  : vector<2xi44>
    %4 = llvm.add %2, %3  : vector<2xi44>
    llvm.return %4 : vector<2xi44>
  }
  llvm.func @lshr_shl_eq_amt_multi_use(%arg0: i43) -> i43 {
    %0 = llvm.mlir.constant(23 : i43) : i43
    %1 = llvm.lshr %arg0, %0  : i43
    %2 = llvm.shl %1, %0  : i43
    %3 = llvm.mul %1, %2  : i43
    llvm.return %3 : i43
  }
  llvm.func @lshr_shl_eq_amt_multi_use_splat_vec(%arg0: vector<2xi43>) -> vector<2xi43> {
    %0 = llvm.mlir.constant(23 : i43) : i43
    %1 = llvm.mlir.constant(dense<23> : vector<2xi43>) : vector<2xi43>
    %2 = llvm.lshr %arg0, %1  : vector<2xi43>
    %3 = llvm.shl %2, %1  : vector<2xi43>
    %4 = llvm.mul %2, %3  : vector<2xi43>
    llvm.return %4 : vector<2xi43>
  }
  llvm.func @test25(%arg0: i37, %arg1: i37) -> i37 {
    %0 = llvm.mlir.constant(17 : i37) : i37
    %1 = llvm.lshr %arg1, %0  : i37
    %2 = llvm.lshr %arg0, %0  : i37
    %3 = llvm.add %2, %1  : i37
    %4 = llvm.shl %3, %0  : i37
    llvm.return %4 : i37
  }
  llvm.func @test26(%arg0: i40) -> i40 {
    %0 = llvm.mlir.constant(1 : i40) : i40
    %1 = llvm.lshr %arg0, %0  : i40
    %2 = llvm.bitcast %1 : i40 to i40
    %3 = llvm.shl %2, %0  : i40
    llvm.return %3 : i40
  }
  llvm.func @ossfuzz_9880(%arg0: i177) -> i177 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i177) : i177
    %2 = llvm.mlir.constant(-1 : i177) : i177
    %3 = llvm.alloca %0 x i177 {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %4 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> i177
    %5 = llvm.or %1, %2  : i177
    %6 = llvm.udiv %4, %5  : i177
    %7 = llvm.add %6, %5  : i177
    %8 = llvm.add %5, %7  : i177
    %9 = llvm.mul %6, %8  : i177
    %10 = llvm.shl %4, %9  : i177
    %11 = llvm.sub %10, %6  : i177
    %12 = llvm.udiv %11, %9  : i177
    llvm.return %12 : i177
  }
}
