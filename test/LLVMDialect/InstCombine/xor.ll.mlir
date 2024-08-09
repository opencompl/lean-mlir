module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @G1(0 : i32) {addr_space = 0 : i32} : i32
  llvm.mlir.global external @G2(0 : i32) {addr_space = 0 : i32} : i32
  llvm.func @use(i8)
  llvm.func @test0(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.xor %arg0, %0  : i1
    llvm.return %1 : i1
  }
  llvm.func @test1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    llvm.return %1 : i32
  }
  llvm.func @test2(%arg0: i1) -> i1 {
    %0 = llvm.xor %arg0, %arg0  : i1
    llvm.return %0 : i1
  }
  llvm.func @test3(%arg0: i32) -> i32 {
    %0 = llvm.xor %arg0, %arg0  : i32
    llvm.return %0 : i32
  }
  llvm.func @test4(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %0, %arg0  : i32
    %2 = llvm.xor %arg0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @test5(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.or %arg0, %0  : i32
    %2 = llvm.xor %1, %0  : i32
    llvm.return %2 : i32
  }
  llvm.func @test6(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(17 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %1, %0  : i8
    llvm.return %2 : i8
  }
  llvm.func @test7(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(128 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.and %arg1, %1  : i32
    %4 = llvm.xor %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @test8(%arg0: i1) -> i8 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.mlir.constant(1 : i8) : i8
    %3 = llvm.xor %arg0, %0  : i1
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %2 : i8
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i8
  }
  llvm.func @test9(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(34 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @test9vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<123> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<34> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.xor %arg0, %0  : vector<2xi8>
    %3 = llvm.icmp "eq" %2, %1 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @test10(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @test11(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(12 : i8) : i8
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @test12(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @test12vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<4> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.xor %arg0, %0  : vector<2xi8>
    %4 = llvm.icmp "ne" %3, %2 : vector<2xi8>
    llvm.return %4 : vector<2xi1>
  }
  llvm.func @test18(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(123 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.sub %1, %2  : i32
    llvm.return %3 : i32
  }
  llvm.func @test19(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.xor %arg0, %arg1  : i32
    %1 = llvm.xor %0, %arg0  : i32
    llvm.return %1 : i32
  }
  llvm.func @test20(%arg0: i32, %arg1: i32) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.addressof @G1 : !llvm.ptr
    %2 = llvm.mlir.addressof @G2 : !llvm.ptr
    %3 = llvm.xor %arg1, %arg0  : i32
    %4 = llvm.xor %3, %arg1  : i32
    %5 = llvm.xor %4, %3  : i32
    llvm.store %5, %1 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %4, %2 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
  llvm.func @test22(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i1
    %3 = llvm.zext %2 : i1 to i32
    %4 = llvm.xor %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @fold_zext_xor_sandwich(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i1
    %3 = llvm.zext %2 : i1 to i32
    %4 = llvm.xor %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @fold_zext_xor_sandwich_vec(%arg0: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.mlir.constant(dense<2> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.xor %arg0, %1  : vector<2xi1>
    %4 = llvm.zext %3 : vector<2xi1> to vector<2xi32>
    %5 = llvm.xor %4, %2  : vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }
  llvm.func @test23(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.xor %arg1, %arg0  : i32
    %1 = llvm.icmp "eq" %0, %arg0 : i32
    llvm.return %1 : i1
  }
  llvm.func @test24(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.xor %arg1, %arg0  : i32
    %1 = llvm.icmp "ne" %0, %arg0 : i32
    llvm.return %1 : i1
  }
  llvm.func @test25(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.and %1, %arg0  : i32
    %3 = llvm.xor %2, %arg0  : i32
    llvm.return %3 : i32
  }
  llvm.func @test27(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.xor %arg2, %arg0  : i32
    %1 = llvm.xor %arg2, %arg1  : i32
    %2 = llvm.icmp "eq" %0, %1 : i32
    %3 = llvm.zext %2 : i1 to i32
    llvm.return %3 : i32
  }
  llvm.func @test28(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2147483647 : i32) : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.xor %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @test28vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-2147483647> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-2147483648> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.add %arg0, %0  : vector<2xi32>
    %3 = llvm.xor %2, %1  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @test28_sub(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2147483647 : i32) : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.xor %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @test28_subvec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-2147483647> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-2147483648> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.sub %0, %arg0  : vector<2xi32>
    %3 = llvm.xor %2, %1  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @test29(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1000 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.mlir.constant(123 : i32) : i32
    %3 = llvm.select %arg0, %0, %1 : i1, i32
    %4 = llvm.xor %3, %2  : i32
    llvm.return %4 : i32
  }
  llvm.func @test29vec(%arg0: i1) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1000> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<10> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<123> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.select %arg0, %0, %1 : i1, vector<2xi32>
    %4 = llvm.xor %3, %2  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }
  llvm.func @test29vec2(%arg0: i1) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[1000, 2500]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[10, 30]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<[123, 333]> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.select %arg0, %0, %1 : i1, vector<2xi32>
    %4 = llvm.xor %3, %2  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }
  llvm.func @test30(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1000 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.mlir.constant(123 : i32) : i32
    llvm.cond_br %arg0, ^bb2(%0 : i32), ^bb1
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%1 : i32)
  ^bb2(%3: i32):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.xor %3, %2  : i32
    llvm.return %4 : i32
  }
  llvm.func @test30vec(%arg0: i1) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1000> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<10> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<123> : vector<2xi32>) : vector<2xi32>
    llvm.cond_br %arg0, ^bb2(%0 : vector<2xi32>), ^bb1
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%1 : vector<2xi32>)
  ^bb2(%3: vector<2xi32>):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.xor %3, %2  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }
  llvm.func @test30vec2(%arg0: i1) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[1000, 2500]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[10, 30]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<[123, 333]> : vector<2xi32>) : vector<2xi32>
    llvm.cond_br %arg0, ^bb2(%0 : vector<2xi32>), ^bb1
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%1 : vector<2xi32>)
  ^bb2(%3: vector<2xi32>):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.xor %3, %2  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }
  llvm.func @or_xor_commute1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.udiv %0, %arg0  : i32
    %2 = llvm.udiv %0, %arg1  : i32
    %3 = llvm.or %2, %1  : i32
    %4 = llvm.xor %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @or_xor_commute2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.udiv %0, %arg0  : i32
    %2 = llvm.udiv %0, %arg1  : i32
    %3 = llvm.or %1, %2  : i32
    %4 = llvm.xor %3, %2  : i32
    llvm.return %4 : i32
  }
  llvm.func @or_xor_commute3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.udiv %0, %arg0  : i32
    %2 = llvm.udiv %0, %arg1  : i32
    %3 = llvm.or %2, %1  : i32
    %4 = llvm.xor %3, %2  : i32
    llvm.return %4 : i32
  }
  llvm.func @or_xor_commute4(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.udiv %0, %arg0  : i32
    %2 = llvm.udiv %0, %arg1  : i32
    %3 = llvm.or %1, %2  : i32
    %4 = llvm.xor %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @or_xor_extra_use(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr) -> i32 {
    %0 = llvm.or %arg0, %arg1  : i32
    llvm.store %0, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr
    %1 = llvm.xor %arg1, %0  : i32
    llvm.return %1 : i32
  }
  llvm.func @and_xor_commute1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.udiv %0, %arg0  : i32
    %2 = llvm.udiv %0, %arg1  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.xor %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @and_xor_commute2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.udiv %0, %arg0  : i32
    %2 = llvm.udiv %0, %arg1  : i32
    %3 = llvm.and %1, %2  : i32
    %4 = llvm.xor %3, %2  : i32
    llvm.return %4 : i32
  }
  llvm.func @and_xor_commute3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.udiv %0, %arg0  : i32
    %2 = llvm.udiv %0, %arg1  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.xor %3, %2  : i32
    llvm.return %4 : i32
  }
  llvm.func @and_xor_commute4(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.udiv %0, %arg0  : i32
    %2 = llvm.udiv %0, %arg1  : i32
    %3 = llvm.and %1, %2  : i32
    %4 = llvm.xor %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @and_xor_extra_use(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr) -> i32 {
    %0 = llvm.and %arg0, %arg1  : i32
    llvm.store %0, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr
    %1 = llvm.xor %arg1, %0  : i32
    llvm.return %1 : i32
  }
  llvm.func @xor_or_not(%arg0: i8, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.mlir.constant(12 : i8) : i8
    %3 = llvm.xor %arg0, %0  : i8
    llvm.store %3, %arg1 {alignment = 1 : i64} : i8, !llvm.ptr
    %4 = llvm.or %3, %1  : i8
    %5 = llvm.xor %4, %2  : i8
    llvm.return %5 : i8
  }
  llvm.func @xor_or_not_uses(%arg0: i8, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.mlir.constant(12 : i8) : i8
    %3 = llvm.xor %arg0, %0  : i8
    %4 = llvm.or %3, %1  : i8
    llvm.store %4, %arg1 {alignment = 1 : i64} : i8, !llvm.ptr
    %5 = llvm.xor %4, %2  : i8
    llvm.return %5 : i8
  }
  llvm.func @xor_and_not(%arg0: i8, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(42 : i8) : i8
    %2 = llvm.mlir.constant(31 : i8) : i8
    %3 = llvm.xor %arg0, %0  : i8
    llvm.store %3, %arg1 {alignment = 1 : i64} : i8, !llvm.ptr
    %4 = llvm.and %3, %1  : i8
    %5 = llvm.xor %4, %2  : i8
    llvm.return %5 : i8
  }
  llvm.func @xor_and_not_uses(%arg0: i8, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(42 : i8) : i8
    %2 = llvm.mlir.constant(31 : i8) : i8
    %3 = llvm.xor %arg0, %0  : i8
    %4 = llvm.and %3, %1  : i8
    llvm.store %4, %arg1 {alignment = 1 : i64} : i8, !llvm.ptr
    %5 = llvm.xor %4, %2  : i8
    llvm.return %5 : i8
  }
  llvm.func @test39(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(-256 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.icmp "sgt" %2, %1 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    %5 = llvm.xor %4, %0  : i32
    llvm.return %5 : i32
  }
  llvm.func @test40(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.icmp "sgt" %1, %arg1 : i32
    %3 = llvm.select %2, %1, %arg1 : i1, i32
    %4 = llvm.xor %3, %0  : i32
    llvm.return %4 : i32
  }
  llvm.func @test41(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.icmp "slt" %1, %arg1 : i32
    %3 = llvm.select %2, %1, %arg1 : i1, i32
    %4 = llvm.xor %3, %0  : i32
    llvm.return %4 : i32
  }
  llvm.func @test42(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.icmp "ugt" %1, %arg1 : i32
    %3 = llvm.select %2, %1, %arg1 : i1, i32
    %4 = llvm.xor %3, %0  : i32
    llvm.return %4 : i32
  }
  llvm.func @test43(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.icmp "ult" %1, %arg1 : i32
    %3 = llvm.select %2, %1, %arg1 : i1, i32
    %4 = llvm.xor %3, %0  : i32
    llvm.return %4 : i32
  }
  llvm.func @test44(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.add %arg1, %0  : i32
    %3 = llvm.xor %arg0, %1  : i32
    %4 = llvm.icmp "ult" %2, %3 : i32
    %5 = llvm.select %4, %2, %3 : i1, i32
    %6 = llvm.xor %5, %1  : i32
    llvm.return %6 : i32
  }
  llvm.func @test45(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.icmp "ult" %1, %2 : i32
    %4 = llvm.select %3, %1, %2 : i1, i32
    %5 = llvm.xor %4, %0  : i32
    llvm.return %5 : i32
  }
  llvm.func @test46(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<-256> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.xor %arg0, %0  : vector<4xi32>
    %3 = llvm.icmp "sgt" %2, %1 : vector<4xi32>
    %4 = llvm.select %3, %2, %1 : vector<4xi1>, vector<4xi32>
    %5 = llvm.xor %4, %0  : vector<4xi32>
    llvm.return %5 : vector<4xi32>
  }
  llvm.func @test47(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.icmp "ugt" %1, %arg1 : i32
    %3 = llvm.select %2, %1, %arg1 : i1, i32
    %4 = llvm.xor %3, %0  : i32
    %5 = llvm.add %3, %arg2  : i32
    %6 = llvm.mul %4, %5  : i32
    llvm.return %6 : i32
  }
  llvm.func @test48(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.sub %0, %arg0  : i32
    %4 = llvm.icmp "sgt" %3, %1 : i32
    %5 = llvm.select %4, %3, %1 : i1, i32
    %6 = llvm.xor %5, %2  : i32
    llvm.return %6 : i32
  }
  llvm.func @test48vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-2> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.sub %0, %arg0  : vector<2xi32>
    %5 = llvm.icmp "sgt" %4, %2 : vector<2xi32>
    %6 = llvm.select %5, %4, %2 : vector<2xi1>, vector<2xi32>
    %7 = llvm.xor %6, %3  : vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }
  llvm.func @test49(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.icmp "slt" %2, %1 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    %5 = llvm.xor %4, %1  : i32
    llvm.return %5 : i32
  }
  llvm.func @test49vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-2> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.add %arg0, %0  : vector<2xi32>
    %3 = llvm.icmp "slt" %2, %1 : vector<2xi32>
    %4 = llvm.select %3, %2, %1 : vector<2xi1>, vector<2xi32>
    %5 = llvm.xor %4, %1  : vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }
  llvm.func @test50(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.icmp "slt" %2, %3 : i32
    %5 = llvm.select %4, %2, %3 : i1, i32
    %6 = llvm.xor %5, %1  : i32
    llvm.return %6 : i32
  }
  llvm.func @test50vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-2> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.add %arg0, %0  : vector<2xi32>
    %3 = llvm.sub %0, %arg1  : vector<2xi32>
    %4 = llvm.icmp "slt" %2, %3 : vector<2xi32>
    %5 = llvm.select %4, %2, %3 : vector<2xi1>, vector<2xi32>
    %6 = llvm.xor %5, %1  : vector<2xi32>
    llvm.return %6 : vector<2xi32>
  }
  llvm.func @test51(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.icmp "sgt" %2, %3 : i32
    %5 = llvm.select %4, %2, %3 : i1, i32
    %6 = llvm.xor %5, %1  : i32
    llvm.return %6 : i32
  }
  llvm.func @test51vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<2> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.add %arg0, %0  : vector<2xi32>
    %3 = llvm.sub %0, %arg1  : vector<2xi32>
    %4 = llvm.icmp "sgt" %2, %3 : vector<2xi32>
    %5 = llvm.select %4, %2, %3 : vector<2xi1>, vector<2xi32>
    %6 = llvm.xor %5, %1  : vector<2xi32>
    llvm.return %6 : vector<2xi32>
  }
  llvm.func @or_or_xor(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.or %arg2, %arg0  : i4
    %1 = llvm.or %arg2, %arg1  : i4
    %2 = llvm.xor %0, %1  : i4
    llvm.return %2 : i4
  }
  llvm.func @or_or_xor_commute1(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.or %arg0, %arg2  : i4
    %1 = llvm.or %arg2, %arg1  : i4
    %2 = llvm.xor %0, %1  : i4
    llvm.return %2 : i4
  }
  llvm.func @or_or_xor_commute2(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.or %arg2, %arg0  : i4
    %1 = llvm.or %arg1, %arg2  : i4
    %2 = llvm.xor %0, %1  : i4
    llvm.return %2 : i4
  }
  llvm.func @or_or_xor_commute3(%arg0: vector<2xi4>, %arg1: vector<2xi4>, %arg2: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.or %arg0, %arg2  : vector<2xi4>
    %1 = llvm.or %arg1, %arg2  : vector<2xi4>
    %2 = llvm.xor %0, %1  : vector<2xi4>
    llvm.return %2 : vector<2xi4>
  }
  llvm.func @or_or_xor_use1(%arg0: i4, %arg1: i4, %arg2: i4, %arg3: !llvm.ptr) -> i4 {
    %0 = llvm.or %arg2, %arg0  : i4
    llvm.store %0, %arg3 {alignment = 1 : i64} : i4, !llvm.ptr
    %1 = llvm.or %arg2, %arg1  : i4
    %2 = llvm.xor %0, %1  : i4
    llvm.return %2 : i4
  }
  llvm.func @or_or_xor_use2(%arg0: i4, %arg1: i4, %arg2: i4, %arg3: !llvm.ptr) -> i4 {
    %0 = llvm.or %arg2, %arg0  : i4
    %1 = llvm.or %arg2, %arg1  : i4
    llvm.store %1, %arg3 {alignment = 1 : i64} : i4, !llvm.ptr
    %2 = llvm.xor %0, %1  : i4
    llvm.return %2 : i4
  }
  llvm.func @not_is_canonical(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1073741823 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.add %2, %arg1  : i32
    %4 = llvm.shl %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @not_shl(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.shl %arg0, %0  : i8
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @not_shl_vec(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<-32> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.shl %arg0, %0  : vector<2xi8>
    %3 = llvm.xor %2, %1  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }
  llvm.func @not_shl_extra_use(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.shl %arg0, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @not_shl_wrong_const(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.shl %arg0, %0  : i8
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @not_lshr(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @not_lshr_vec(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<7> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.lshr %arg0, %0  : vector<2xi8>
    %3 = llvm.xor %2, %1  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }
  llvm.func @not_lshr_extra_use(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @not_lshr_wrong_const(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @ashr_not(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(5 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.ashr %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @not_ashr(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @not_ashr_vec(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<7> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.ashr %arg0, %0  : vector<2xi8>
    %3 = llvm.xor %2, %1  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }
  llvm.func @not_ashr_extra_use(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @not_ashr_wrong_const(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(-2 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @xor_andn_commute1(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.xor %arg0, %0  : vector<2xi32>
    %2 = llvm.and %1, %arg1  : vector<2xi32>
    %3 = llvm.xor %2, %arg0  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @xor_andn_commute2(%arg0: i33, %arg1: i33) -> i33 {
    %0 = llvm.mlir.constant(42 : i33) : i33
    %1 = llvm.mlir.constant(-1 : i33) : i33
    %2 = llvm.udiv %0, %arg1  : i33
    %3 = llvm.xor %arg0, %1  : i33
    %4 = llvm.and %2, %3  : i33
    %5 = llvm.xor %4, %arg0  : i33
    llvm.return %5 : i33
  }
  llvm.func @xor_andn_commute3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.udiv %0, %arg0  : i32
    %3 = llvm.xor %2, %1  : i32
    %4 = llvm.and %3, %arg1  : i32
    %5 = llvm.xor %2, %4  : i32
    llvm.return %5 : i32
  }
  llvm.func @xor_andn_commute4(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.udiv %0, %arg0  : i32
    %3 = llvm.udiv %0, %arg1  : i32
    %4 = llvm.xor %2, %1  : i32
    %5 = llvm.and %3, %4  : i32
    %6 = llvm.xor %2, %5  : i32
    llvm.return %6 : i32
  }
  llvm.func @xor_orn(%arg0: vector<2xi64>, %arg1: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.xor %arg0, %0  : vector<2xi64>
    %2 = llvm.or %1, %arg1  : vector<2xi64>
    %3 = llvm.xor %2, %arg0  : vector<2xi64>
    llvm.return %3 : vector<2xi64>
  }
  llvm.func @xor_orn_commute1(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.udiv %0, %arg0  : i8
    %3 = llvm.xor %2, %1  : i8
    %4 = llvm.or %3, %arg1  : i8
    %5 = llvm.xor %2, %4  : i8
    llvm.return %5 : i8
  }
  llvm.func @xor_orn_commute2(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.udiv %0, %arg1  : i32
    %3 = llvm.xor %arg0, %1  : i32
    %4 = llvm.or %2, %3  : i32
    %5 = llvm.xor %4, %arg0  : i32
    llvm.return %5 : i32
  }
  llvm.func @xor_orn_commute2_1use(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.udiv %0, %arg1  : i32
    %3 = llvm.xor %arg0, %1  : i32
    %4 = llvm.or %2, %3  : i32
    llvm.store %3, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr
    %5 = llvm.xor %4, %arg0  : i32
    llvm.return %5 : i32
  }
  llvm.func @xor_orn_commute3(%arg0: i67, %arg1: i67, %arg2: !llvm.ptr) -> i67 {
    %0 = llvm.mlir.constant(42 : i67) : i67
    %1 = llvm.mlir.constant(-1 : i67) : i67
    %2 = llvm.udiv %0, %arg0  : i67
    %3 = llvm.udiv %0, %arg1  : i67
    %4 = llvm.xor %2, %1  : i67
    %5 = llvm.or %3, %4  : i67
    %6 = llvm.xor %2, %5  : i67
    llvm.return %6 : i67
  }
  llvm.func @xor_orn_commute3_1use(%arg0: i67, %arg1: i67, %arg2: !llvm.ptr) -> i67 {
    %0 = llvm.mlir.constant(42 : i67) : i67
    %1 = llvm.mlir.constant(-1 : i67) : i67
    %2 = llvm.udiv %0, %arg0  : i67
    %3 = llvm.udiv %0, %arg1  : i67
    %4 = llvm.xor %2, %1  : i67
    %5 = llvm.or %3, %4  : i67
    llvm.store %5, %arg2 {alignment = 4 : i64} : i67, !llvm.ptr
    %6 = llvm.xor %2, %5  : i67
    llvm.return %6 : i67
  }
  llvm.func @xor_orn_2use(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr, %arg3: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    llvm.store %1, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr
    %2 = llvm.or %1, %arg1  : i32
    llvm.store %2, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr
    %3 = llvm.xor %2, %arg0  : i32
    llvm.return %3 : i32
  }
  llvm.func @ctlz_pow2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = "llvm.intr.ctlz"(%3) <{is_zero_poison = true}> : (i32) -> i32
    %5 = llvm.xor %4, %1  : i32
    llvm.return %5 : i32
  }
  llvm.func @cttz_pow2(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<7> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.shl %0, %arg0  : vector<2xi8>
    %3 = llvm.udiv %2, %arg1  : vector<2xi8>
    %4 = "llvm.intr.cttz"(%3) <{is_zero_poison = true}> : (vector<2xi8>) -> vector<2xi8>
    %5 = llvm.xor %4, %1  : vector<2xi8>
    llvm.return %5 : vector<2xi8>
  }
  llvm.func @ctlz_pow2_or_zero(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = "llvm.intr.ctlz"(%3) <{is_zero_poison = false}> : (i32) -> i32
    %5 = llvm.xor %4, %1  : i32
    llvm.return %5 : i32
  }
  llvm.func @ctlz_pow2_wrong_const(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(30 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = "llvm.intr.ctlz"(%3) <{is_zero_poison = true}> : (i32) -> i32
    %5 = llvm.xor %4, %1  : i32
    llvm.return %5 : i32
  }
  llvm.func @tryFactorization_xor_ashr_lshr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-3 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.ashr %0, %arg0  : i32
    %3 = llvm.lshr %1, %arg0  : i32
    %4 = llvm.xor %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @tryFactorization_xor_lshr_ashr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-3 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.ashr %0, %arg0  : i32
    %3 = llvm.lshr %1, %arg0  : i32
    %4 = llvm.xor %3, %2  : i32
    llvm.return %4 : i32
  }
  llvm.func @tryFactorization_xor_ashr_lshr_negative_lhs(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-3 : i32) : i32
    %1 = llvm.mlir.constant(-5 : i32) : i32
    %2 = llvm.ashr %0, %arg0  : i32
    %3 = llvm.lshr %1, %arg0  : i32
    %4 = llvm.xor %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @tryFactorization_xor_lshr_lshr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-3 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.lshr %0, %arg0  : i32
    %3 = llvm.lshr %1, %arg0  : i32
    %4 = llvm.xor %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @tryFactorization_xor_ashr_ashr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-3 : i32) : i32
    %1 = llvm.mlir.constant(-5 : i32) : i32
    %2 = llvm.ashr %0, %arg0  : i32
    %3 = llvm.ashr %1, %arg0  : i32
    %4 = llvm.xor %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @PR96857_xor_with_noundef(%arg0: i4, %arg1: i4, %arg2: i4 {llvm.noundef}) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.and %arg2, %arg0  : i4
    %2 = llvm.xor %arg2, %0  : i4
    %3 = llvm.and %2, %arg1  : i4
    %4 = llvm.xor %1, %3  : i4
    llvm.return %4 : i4
  }
  llvm.func @PR96857_xor_without_noundef(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.and %arg2, %arg0  : i4
    %2 = llvm.xor %arg2, %0  : i4
    %3 = llvm.and %2, %arg1  : i4
    %4 = llvm.xor %1, %3  : i4
    llvm.return %4 : i4
  }
}
