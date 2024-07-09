module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @inbuf() {addr_space = 0 : i32} : !llvm.array<32832 x i8>
  llvm.func @use_i32(i32)
  llvm.func @use_v2i32(vector<2xi32>)
  llvm.func @test1(%arg0: i32) -> i32 {
    %0 = llvm.bitcast %arg0 : i32 to i32
    %1 = llvm.bitcast %0 : i32 to i32
    llvm.return %1 : i32
  }
  llvm.func @test2(%arg0: i8) -> i64 {
    %0 = llvm.zext %arg0 : i8 to i16
    %1 = llvm.zext %0 : i16 to i32
    %2 = llvm.zext %1 : i32 to i64
    llvm.return %2 : i64
  }
  llvm.func @test3(%arg0: i64) -> i64 {
    %0 = llvm.trunc %arg0 : i64 to i8
    %1 = llvm.zext %0 : i8 to i64
    llvm.return %1 : i64
  }
  llvm.func @test4(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.icmp "slt" %arg0, %arg1 : i32
    %1 = llvm.zext %0 : i1 to i8
    %2 = llvm.zext %1 : i8 to i32
    llvm.return %2 : i32
  }
  llvm.func @test5(%arg0: i1) -> i32 {
    %0 = llvm.zext %arg0 : i1 to i8
    %1 = llvm.zext %0 : i8 to i32
    llvm.return %1 : i32
  }
  llvm.func @test6(%arg0: i64) -> i32 {
    %0 = llvm.trunc %arg0 : i64 to i32
    %1 = llvm.bitcast %0 : i32 to i32
    llvm.return %1 : i32
  }
  llvm.func @test7(%arg0: i1) -> i64 {
    %0 = llvm.zext %arg0 : i1 to i32
    %1 = llvm.sext %0 : i32 to i64
    llvm.return %1 : i64
  }
  llvm.func @test8(%arg0: i8) -> i64 {
    %0 = llvm.sext %arg0 : i8 to i64
    %1 = llvm.bitcast %0 : i64 to i64
    llvm.return %1 : i64
  }
  llvm.func @test9(%arg0: i16) -> i16 {
    %0 = llvm.sext %arg0 : i16 to i32
    %1 = llvm.trunc %0 : i32 to i16
    llvm.return %1 : i16
  }
  llvm.func @test10(%arg0: i16) -> i16 {
    %0 = llvm.sext %arg0 : i16 to i32
    %1 = llvm.trunc %0 : i32 to i16
    llvm.return %1 : i16
  }
  llvm.func @varargs(i32, ...)
  llvm.func @test11(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(5 : i32) : i32
    llvm.call @varargs(%0, %arg0) vararg(!llvm.func<void (i32, ...)>) : (i32, !llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @__gxx_personality_v0(...) -> i32
  llvm.func @test_invoke_vararg_cast(%arg0: !llvm.ptr, %arg1: !llvm.ptr) attributes {personality = @__gxx_personality_v0} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    llvm.invoke @varargs(%0, %arg1, %arg0) to ^bb1 unwind ^bb2 vararg(!llvm.func<void (i32, ...)>) : (i32, !llvm.ptr, !llvm.ptr) -> ()
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    %1 = llvm.landingpad cleanup : !llvm.struct<(ptr, i32)>
    llvm.return
  }
  llvm.func @test13(%arg0: i64) -> !llvm.ptr {
    %0 = llvm.mlir.addressof @inbuf : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.getelementptr %0[%1, %arg0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<0 x i8>
    llvm.return %2 : !llvm.ptr
  }
  llvm.func @test14(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.bitcast %arg0 : i8 to i8
    %2 = llvm.icmp "ult" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @test16(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    llvm.return %1 : i1
  }
  llvm.func @test17(%arg0: i1) -> i16 {
    %0 = llvm.zext %arg0 : i1 to i32
    %1 = llvm.trunc %0 : i32 to i16
    llvm.return %1 : i16
  }
  llvm.func @test18(%arg0: i8) -> i16 {
    %0 = llvm.sext %arg0 : i8 to i32
    %1 = llvm.trunc %0 : i32 to i16
    llvm.return %1 : i16
  }
  llvm.func @test19(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(12345 : i64) : i64
    %1 = llvm.sext %arg0 : i32 to i64
    %2 = llvm.icmp "slt" %1, %0 : i64
    llvm.return %2 : i1
  }
  llvm.func @test19vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[12345, 2147483647]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.sext %arg0 : vector<2xi32> to vector<2xi64>
    %2 = llvm.icmp "slt" %1, %0 : vector<2xi64>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @test19vec2(%arg0: vector<3xi1>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<3xi32>) : vector<3xi32>
    %2 = llvm.sext %arg0 : vector<3xi1> to vector<3xi32>
    %3 = llvm.icmp "eq" %2, %1 : vector<3xi32>
    llvm.return %3 : vector<3xi1>
  }
  llvm.func @test20(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.icmp "slt" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @test21(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.trunc %arg0 : i32 to i8
    %2 = llvm.sext %1 : i8 to i32
    %3 = llvm.and %2, %0  : i32
    llvm.return %3 : i32
  }
  llvm.func @test22(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.trunc %arg0 : i32 to i8
    %2 = llvm.sext %1 : i8 to i32
    %3 = llvm.shl %2, %0  : i32
    llvm.return %3 : i32
  }
  llvm.func @test23(%arg0: i32) -> i32 {
    %0 = llvm.trunc %arg0 : i32 to i16
    %1 = llvm.zext %0 : i16 to i32
    llvm.return %1 : i32
  }
  llvm.func @test24(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(14 : i32) : i32
    %1 = llvm.mlir.constant(1234 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.select %arg0, %0, %1 : i1, i32
    %4 = llvm.icmp "ne" %3, %2 : i32
    llvm.return %4 : i1
  }
  llvm.func @test26(%arg0: f32) -> i32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fptosi %0 : f64 to i32
    llvm.return %1 : i32
  }
  llvm.func @test27(%arg0: !llvm.ptr) -> !llvm.ptr {
    llvm.return %arg0 : !llvm.ptr
  }
  llvm.func @test28(%arg0: !llvm.ptr) -> !llvm.ptr {
    llvm.return %arg0 : !llvm.ptr
  }
  llvm.func @test29(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.trunc %arg0 : i32 to i8
    %1 = llvm.trunc %arg1 : i32 to i8
    %2 = llvm.or %1, %0  : i8
    %3 = llvm.zext %2 : i8 to i32
    llvm.return %3 : i32
  }
  llvm.func @test30(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.trunc %arg0 : i32 to i8
    %2 = llvm.xor %1, %0  : i8
    %3 = llvm.zext %2 : i8 to i32
    llvm.return %3 : i32
  }
  llvm.func @test31(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.trunc %arg0 : i64 to i32
    %3 = llvm.and %2, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    llvm.return %4 : i1
  }
  llvm.func @test31vec(%arg0: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<10> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %3 = llvm.and %2, %0  : vector<2xi32>
    %4 = llvm.icmp "eq" %3, %1 : vector<2xi32>
    llvm.return %4 : vector<2xi1>
  }
  llvm.func @test32vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.mlir.constant(dense<10> : vector<2xi16>) : vector<2xi16>
    %2 = llvm.zext %arg0 : vector<2xi8> to vector<2xi16>
    %3 = llvm.and %2, %0  : vector<2xi16>
    %4 = llvm.icmp "eq" %3, %1 : vector<2xi16>
    llvm.return %4 : vector<2xi1>
  }
  llvm.func @test33(%arg0: i32) -> i32 {
    %0 = llvm.bitcast %arg0 : i32 to f32
    %1 = llvm.bitcast %0 : f32 to i32
    llvm.return %1 : i32
  }
  llvm.func @test34(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.zext %arg0 : i16 to i32
    %2 = llvm.lshr %1, %0  : i32
    %3 = llvm.trunc %2 : i32 to i16
    llvm.return %3 : i16
  }
  llvm.func @test35(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(8 : i16) : i16
    %1 = llvm.bitcast %arg0 : i16 to i16
    %2 = llvm.lshr %1, %0  : i16
    %3 = llvm.bitcast %2 : i16 to i16
    llvm.return %3 : i16
  }
  llvm.func @test36(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    %4 = llvm.icmp "eq" %3, %1 : i8
    llvm.return %4 : i1
  }
  llvm.func @test36vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<31> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.lshr %arg0, %0  : vector<2xi32>
    %4 = llvm.trunc %3 : vector<2xi32> to vector<2xi8>
    %5 = llvm.icmp "eq" %4, %2 : vector<2xi8>
    llvm.return %5 : vector<2xi1>
  }
  llvm.func @test37(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(512 : i32) : i32
    %2 = llvm.mlir.constant(11 : i8) : i8
    %3 = llvm.lshr %arg0, %0  : i32
    %4 = llvm.or %3, %1  : i32
    %5 = llvm.trunc %4 : i32 to i8
    %6 = llvm.icmp "eq" %5, %2 : i8
    llvm.return %6 : i1
  }
  llvm.func @test38(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    %3 = llvm.zext %2 : i1 to i8
    %4 = llvm.xor %3, %1  : i8
    %5 = llvm.zext %4 : i8 to i64
    llvm.return %5 : i64
  }
  llvm.func @test39(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.zext %arg0 : i16 to i32
    %2 = llvm.lshr %1, %0  : i32
    %3 = llvm.shl %1, %0  : i32
    %4 = llvm.or %2, %3  : i32
    %5 = llvm.trunc %4 : i32 to i16
    llvm.return %5 : i16
  }
  llvm.func @test40(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(9 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.zext %arg0 : i16 to i32
    %3 = llvm.lshr %2, %0  : i32
    %4 = llvm.shl %2, %1  : i32
    %5 = llvm.or %3, %4  : i32
    %6 = llvm.trunc %5 : i32 to i16
    llvm.return %6 : i16
  }
  llvm.func @test40vec(%arg0: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<9> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.zext %arg0 : vector<2xi16> to vector<2xi32>
    %3 = llvm.lshr %2, %0  : vector<2xi32>
    %4 = llvm.shl %2, %1  : vector<2xi32>
    %5 = llvm.or %3, %4  : vector<2xi32>
    %6 = llvm.trunc %5 : vector<2xi32> to vector<2xi16>
    llvm.return %6 : vector<2xi16>
  }
  llvm.func @test40vec_nonuniform(%arg0: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<[9, 10]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[8, 9]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.zext %arg0 : vector<2xi16> to vector<2xi32>
    %3 = llvm.lshr %2, %0  : vector<2xi32>
    %4 = llvm.shl %2, %1  : vector<2xi32>
    %5 = llvm.or %3, %4  : vector<2xi32>
    %6 = llvm.trunc %5 : vector<2xi32> to vector<2xi16>
    llvm.return %6 : vector<2xi16>
  }
  llvm.func @test40vec_poison(%arg0: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(9 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.mlir.constant(8 : i32) : i32
    %8 = llvm.mlir.undef : vector<2xi32>
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.insertelement %7, %8[%9 : i32] : vector<2xi32>
    %11 = llvm.mlir.constant(1 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<2xi32>
    %13 = llvm.zext %arg0 : vector<2xi16> to vector<2xi32>
    %14 = llvm.lshr %13, %6  : vector<2xi32>
    %15 = llvm.shl %13, %12  : vector<2xi32>
    %16 = llvm.or %14, %15  : vector<2xi32>
    %17 = llvm.trunc %16 : vector<2xi32> to vector<2xi16>
    llvm.return %17 : vector<2xi16>
  }
  llvm.func @test41(%arg0: !llvm.ptr) -> !llvm.ptr {
    llvm.return %arg0 : !llvm.ptr
  }
  llvm.func @test41_addrspacecast_smaller(%arg0: !llvm.ptr) -> !llvm.ptr<1> {
    %0 = llvm.addrspacecast %arg0 : !llvm.ptr to !llvm.ptr<1>
    llvm.return %0 : !llvm.ptr<1>
  }
  llvm.func @test41_addrspacecast_larger(%arg0: !llvm.ptr<1>) -> !llvm.ptr {
    %0 = llvm.addrspacecast %arg0 : !llvm.ptr<1> to !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }
  llvm.func @test42(%arg0: i32) -> i32 {
    %0 = llvm.trunc %arg0 : i32 to i8
    %1 = llvm.zext %0 : i8 to i32
    llvm.return %1 : i32
  }
  llvm.func @test43(%arg0: i8 {llvm.zeroext}) -> (i64 {llvm.zeroext}) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.add %1, %0  : i32
    %3 = llvm.sext %2 : i32 to i64
    llvm.return %3 : i64
  }
  llvm.func @test44(%arg0: i8) -> i64 {
    %0 = llvm.mlir.constant(1234 : i16) : i16
    %1 = llvm.zext %arg0 : i8 to i16
    %2 = llvm.or %1, %0  : i16
    %3 = llvm.zext %2 : i16 to i64
    llvm.return %3 : i64
  }
  llvm.func @test45(%arg0: i8, %arg1: i64) -> i64 {
    %0 = llvm.trunc %arg1 : i64 to i32
    %1 = llvm.sext %arg0 : i8 to i32
    %2 = llvm.or %1, %0  : i32
    %3 = llvm.zext %2 : i32 to i64
    llvm.return %3 : i64
  }
  llvm.func @test46(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.trunc %arg0 : i64 to i32
    %3 = llvm.and %2, %0  : i32
    %4 = llvm.shl %3, %1  : i32
    %5 = llvm.zext %4 : i32 to i64
    llvm.return %5 : i64
  }
  llvm.func @test46vec(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %3 = llvm.and %2, %0  : vector<2xi32>
    %4 = llvm.shl %3, %1  : vector<2xi32>
    %5 = llvm.zext %4 : vector<2xi32> to vector<2xi64>
    llvm.return %5 : vector<2xi64>
  }
  llvm.func @test47(%arg0: i8) -> i64 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.sext %arg0 : i8 to i32
    %2 = llvm.or %1, %0  : i32
    %3 = llvm.zext %2 : i32 to i64
    llvm.return %3 : i64
  }
  llvm.func @test48(%arg0: i8, %arg1: i8) -> i64 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.zext %arg1 : i8 to i32
    %2 = llvm.zext %arg0 : i8 to i32
    %3 = llvm.shl %2, %0  : i32
    %4 = llvm.or %3, %2  : i32
    %5 = llvm.zext %4 : i32 to i64
    llvm.return %5 : i64
  }
  llvm.func @test49(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.trunc %arg0 : i64 to i32
    %2 = llvm.or %1, %0  : i32
    %3 = llvm.sext %2 : i32 to i64
    llvm.return %3 : i64
  }
  llvm.func @test50(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.add %3, %1  : i32
    %5 = llvm.sext %4 : i32 to i64
    llvm.return %5 : i64
  }
  llvm.func @test51(%arg0: i64, %arg1: i1) -> i64 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.trunc %arg0 : i64 to i32
    %3 = llvm.and %2, %0  : i32
    %4 = llvm.or %2, %1  : i32
    %5 = llvm.select %arg1, %3, %4 : i1, i32
    %6 = llvm.sext %5 : i32 to i64
    llvm.return %6 : i64
  }
  llvm.func @test52(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(-32574 : i16) : i16
    %1 = llvm.mlir.constant(-25350 : i16) : i16
    %2 = llvm.trunc %arg0 : i64 to i16
    %3 = llvm.or %2, %0  : i16
    %4 = llvm.and %3, %1  : i16
    %5 = llvm.zext %4 : i16 to i32
    llvm.return %5 : i32
  }
  llvm.func @test53(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(-32574 : i16) : i16
    %1 = llvm.mlir.constant(-25350 : i16) : i16
    %2 = llvm.trunc %arg0 : i32 to i16
    %3 = llvm.or %2, %0  : i16
    %4 = llvm.and %3, %1  : i16
    %5 = llvm.zext %4 : i16 to i64
    llvm.return %5 : i64
  }
  llvm.func @test54(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(-32574 : i16) : i16
    %1 = llvm.mlir.constant(-25350 : i16) : i16
    %2 = llvm.trunc %arg0 : i64 to i16
    %3 = llvm.or %2, %0  : i16
    %4 = llvm.and %3, %1  : i16
    %5 = llvm.sext %4 : i16 to i32
    llvm.return %5 : i32
  }
  llvm.func @test55(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(-32574 : i16) : i16
    %1 = llvm.mlir.constant(-25350 : i16) : i16
    %2 = llvm.trunc %arg0 : i32 to i16
    %3 = llvm.or %2, %0  : i16
    %4 = llvm.and %3, %1  : i16
    %5 = llvm.sext %4 : i16 to i64
    llvm.return %5 : i64
  }
  llvm.func @test56(%arg0: i16) -> i64 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.sext %arg0 : i16 to i32
    %2 = llvm.lshr %1, %0  : i32
    %3 = llvm.zext %2 : i32 to i64
    llvm.return %3 : i64
  }
  llvm.func @test56vec(%arg0: vector<2xi16>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sext %arg0 : vector<2xi16> to vector<2xi32>
    %2 = llvm.lshr %1, %0  : vector<2xi32>
    %3 = llvm.zext %2 : vector<2xi32> to vector<2xi64>
    llvm.return %3 : vector<2xi64>
  }
  llvm.func @test57(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.trunc %arg0 : i64 to i32
    %2 = llvm.lshr %1, %0  : i32
    %3 = llvm.zext %2 : i32 to i64
    llvm.return %3 : i64
  }
  llvm.func @test57vec(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %2 = llvm.lshr %1, %0  : vector<2xi32>
    %3 = llvm.zext %2 : vector<2xi32> to vector<2xi64>
    llvm.return %3 : vector<2xi64>
  }
  llvm.func @test58(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(128 : i32) : i32
    %2 = llvm.trunc %arg0 : i64 to i32
    %3 = llvm.lshr %2, %0  : i32
    %4 = llvm.or %3, %1  : i32
    %5 = llvm.zext %4 : i32 to i64
    llvm.return %5 : i64
  }
  llvm.func @test59(%arg0: i8, %arg1: i8) -> i64 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(48 : i32) : i32
    %2 = llvm.zext %arg0 : i8 to i32
    %3 = llvm.shl %2, %0  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.zext %arg1 : i8 to i32
    %6 = llvm.lshr %5, %0  : i32
    %7 = llvm.or %6, %4  : i32
    %8 = llvm.zext %7 : i32 to i64
    llvm.return %8 : i64
  }
  llvm.func @test60(%arg0: vector<4xi32>) -> vector<3xi32> {
    %0 = llvm.bitcast %arg0 : vector<4xi32> to i128
    %1 = llvm.trunc %0 : i128 to i96
    %2 = llvm.bitcast %1 : i96 to vector<3xi32>
    llvm.return %2 : vector<3xi32>
  }
  llvm.func @test61(%arg0: vector<3xi32>) -> vector<4xi32> {
    %0 = llvm.bitcast %arg0 : vector<3xi32> to i96
    %1 = llvm.zext %0 : i96 to i128
    %2 = llvm.bitcast %1 : i128 to vector<4xi32>
    llvm.return %2 : vector<4xi32>
  }
  llvm.func @test62(%arg0: vector<3xf32>) -> vector<4xi32> {
    %0 = llvm.bitcast %arg0 : vector<3xf32> to i96
    %1 = llvm.zext %0 : i96 to i128
    %2 = llvm.bitcast %1 : i128 to vector<4xi32>
    llvm.return %2 : vector<4xi32>
  }
  llvm.func @test63(%arg0: i64) -> vector<2xf32> {
    %0 = llvm.bitcast %arg0 : i64 to vector<2xi32>
    %1 = llvm.uitofp %0 : vector<2xi32> to vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }
  llvm.func @test64(%arg0: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.bitcast %arg0 : vector<4xf32> to vector<4xi32>
    %1 = llvm.bitcast %0 : vector<4xi32> to vector<4xf32>
    llvm.return %1 : vector<4xf32>
  }
  llvm.func @test65(%arg0: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.bitcast %arg0 : vector<4xf32> to vector<2xf64>
    %1 = llvm.bitcast %0 : vector<2xf64> to vector<4xf32>
    llvm.return %1 : vector<4xf32>
  }
  llvm.func @test66(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.bitcast %arg0 : vector<2xf32> to f64
    %1 = llvm.bitcast %0 : f64 to vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }
  llvm.func @test2c() -> f32 {
    %0 = llvm.mlir.constant(-1.000000e+00 : f32) : f32
    llvm.return %0 : f32
  }
  llvm.func @test_mmx(%arg0: vector<2xi32>) -> i64 {
    %0 = llvm.bitcast %arg0 : vector<2xi32> to !llvm.x86_mmx
    %1 = llvm.bitcast %0 : !llvm.x86_mmx to vector<2xi32>
    %2 = llvm.bitcast %1 : vector<2xi32> to i64
    llvm.return %2 : i64
  }
  llvm.func @test_mmx_const(%arg0: vector<2xi32>) -> i64 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.bitcast %1 : vector<2xi32> to !llvm.x86_mmx
    %3 = llvm.bitcast %2 : !llvm.x86_mmx to vector<2xi32>
    %4 = llvm.bitcast %3 : vector<2xi32> to i64
    llvm.return %4 : i64
  }
  llvm.func @test67(%arg0: i1, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(24 : i32) : i32
    %2 = llvm.mlir.constant(-16777216 : i32) : i32
    %3 = llvm.mlir.constant(0 : i8) : i8
    %4 = llvm.zext %arg0 : i1 to i32
    %5 = llvm.xor %4, %0  : i32
    %6 = llvm.and %arg1, %5  : i32
    %7 = llvm.shl %6, %1 overflow<nsw, nuw>  : i32
    %8 = llvm.xor %7, %2  : i32
    %9 = llvm.ashr %8, %1  : i32
    %10 = llvm.trunc %9 : i32 to i8
    %11 = llvm.icmp "eq" %10, %3 : i8
    llvm.return %11 : i1
  }
  llvm.func @test68(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.struct<"s", (i32, i32, i16)> {
    %0 = llvm.mlir.constant(12 : i64) : i64
    %1 = llvm.mul %arg1, %0  : i64
    %2 = llvm.getelementptr inbounds %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr -> !llvm.struct<"s", (i32, i32, i16)>
    llvm.return %3 : !llvm.struct<"s", (i32, i32, i16)>
  }
  llvm.func @test68_addrspacecast(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.struct<"s", (i32, i32, i16)> {
    %0 = llvm.mlir.constant(12 : i64) : i64
    %1 = llvm.mul %arg1, %0  : i64
    %2 = llvm.addrspacecast %arg0 : !llvm.ptr to !llvm.ptr<2>
    %3 = llvm.getelementptr inbounds %2[%1] : (!llvm.ptr<2>, i64) -> !llvm.ptr<2>, i8
    %4 = llvm.addrspacecast %3 : !llvm.ptr<2> to !llvm.ptr
    %5 = llvm.load %4 {alignment = 4 : i64} : !llvm.ptr -> !llvm.struct<"s", (i32, i32, i16)>
    llvm.return %5 : !llvm.struct<"s", (i32, i32, i16)>
  }
  llvm.func @test68_addrspacecast_2(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.struct<"s", (i32, i32, i16)> {
    %0 = llvm.mlir.constant(12 : i64) : i64
    %1 = llvm.mul %arg1, %0  : i64
    %2 = llvm.addrspacecast %arg0 : !llvm.ptr to !llvm.ptr<2>
    %3 = llvm.getelementptr inbounds %2[%1] : (!llvm.ptr<2>, i64) -> !llvm.ptr<2>, i8
    %4 = llvm.addrspacecast %3 : !llvm.ptr<2> to !llvm.ptr<1>
    %5 = llvm.load %4 {alignment = 4 : i64} : !llvm.ptr<1> -> !llvm.struct<"s", (i32, i32, i16)>
    llvm.return %5 : !llvm.struct<"s", (i32, i32, i16)>
  }
  llvm.func @test68_as1(%arg0: !llvm.ptr<1>, %arg1: i32) -> !llvm.struct<"s", (i32, i32, i16)> {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mul %arg1, %0  : i32
    %2 = llvm.getelementptr inbounds %arg0[%1] : (!llvm.ptr<1>, i32) -> !llvm.ptr<1>, i8
    %3 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr<1> -> !llvm.struct<"s", (i32, i32, i16)>
    llvm.return %3 : !llvm.struct<"s", (i32, i32, i16)>
  }
  llvm.func @test69(%arg0: !llvm.ptr, %arg1: i64) -> f64 {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.shl %arg1, %0 overflow<nsw>  : i64
    %2 = llvm.getelementptr inbounds %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.load %2 {alignment = 8 : i64} : !llvm.ptr -> f64
    llvm.return %3 : f64
  }
  llvm.func @test70(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.struct<"s", (i32, i32, i16)> {
    %0 = llvm.mlir.constant(36 : i64) : i64
    %1 = llvm.mul %arg1, %0 overflow<nsw>  : i64
    %2 = llvm.getelementptr inbounds %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr -> !llvm.struct<"s", (i32, i32, i16)>
    llvm.return %3 : !llvm.struct<"s", (i32, i32, i16)>
  }
  llvm.func @test71(%arg0: !llvm.ptr, %arg1: i64) -> f64 {
    %0 = llvm.mlir.constant(5 : i64) : i64
    %1 = llvm.shl %arg1, %0  : i64
    %2 = llvm.getelementptr %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.load %2 {alignment = 8 : i64} : !llvm.ptr -> f64
    llvm.return %3 : f64
  }
  llvm.func @test72(%arg0: !llvm.ptr, %arg1: i32) -> f64 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.shl %arg1, %0 overflow<nsw>  : i32
    %2 = llvm.sext %1 : i32 to i64
    %3 = llvm.getelementptr inbounds %arg0[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %4 = llvm.load %3 {alignment = 8 : i64} : !llvm.ptr -> f64
    llvm.return %4 : f64
  }
  llvm.func @test73(%arg0: !llvm.ptr, %arg1: i128) -> f64 {
    %0 = llvm.mlir.constant(3 : i128) : i128
    %1 = llvm.shl %arg1, %0 overflow<nsw>  : i128
    %2 = llvm.trunc %1 : i128 to i64
    %3 = llvm.getelementptr inbounds %arg0[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %4 = llvm.load %3 {alignment = 8 : i64} : !llvm.ptr -> f64
    llvm.return %4 : f64
  }
  llvm.func @test74(%arg0: !llvm.ptr, %arg1: i64) -> f64 {
    %0 = llvm.getelementptr inbounds %arg0[%arg1] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %1 = llvm.load %0 {alignment = 8 : i64} : !llvm.ptr -> f64
    llvm.return %1 : f64
  }
  llvm.func @test75(%arg0: !llvm.ptr, %arg1: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.shl %arg1, %0  : i32
    %2 = llvm.sext %1 : i32 to i64
    %3 = llvm.getelementptr %arg0[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.return %3 : !llvm.ptr
  }
  llvm.func @test76(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.struct<"s", (i32, i32, i16)> {
    %0 = llvm.mlir.constant(12 : i64) : i64
    %1 = llvm.mul %arg1, %0  : i64
    %2 = llvm.mul %1, %arg2 overflow<nsw>  : i64
    %3 = llvm.getelementptr inbounds %arg0[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %4 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> !llvm.struct<"s", (i32, i32, i16)>
    llvm.return %4 : !llvm.struct<"s", (i32, i32, i16)>
  }
  llvm.func @test77(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.struct<"s", (i32, i32, i16)> {
    %0 = llvm.mlir.constant(36 : i64) : i64
    %1 = llvm.mul %arg1, %0 overflow<nsw>  : i64
    %2 = llvm.mul %1, %arg2 overflow<nsw>  : i64
    %3 = llvm.getelementptr inbounds %arg0[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %4 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> !llvm.struct<"s", (i32, i32, i16)>
    llvm.return %4 : !llvm.struct<"s", (i32, i32, i16)>
  }
  llvm.func @test78(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64, %arg3: i32, %arg4: i32, %arg5: i128, %arg6: i128) -> !llvm.struct<"s", (i32, i32, i16)> {
    %0 = llvm.mlir.constant(36 : i32) : i32
    %1 = llvm.mul %arg3, %0 overflow<nsw>  : i32
    %2 = llvm.mul %1, %arg4 overflow<nsw>  : i32
    %3 = llvm.sext %2 : i32 to i128
    %4 = llvm.mul %3, %arg5 overflow<nsw>  : i128
    %5 = llvm.mul %4, %arg6  : i128
    %6 = llvm.trunc %5 : i128 to i64
    %7 = llvm.mul %6, %arg1 overflow<nsw>  : i64
    %8 = llvm.mul %7, %arg2 overflow<nsw>  : i64
    %9 = llvm.getelementptr inbounds %arg0[%8] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %10 = llvm.load %9 {alignment = 4 : i64} : !llvm.ptr -> !llvm.struct<"s", (i32, i32, i16)>
    llvm.return %10 : !llvm.struct<"s", (i32, i32, i16)>
  }
  llvm.func @test79(%arg0: !llvm.ptr, %arg1: i64, %arg2: i32) -> !llvm.struct<"s", (i32, i32, i16)> {
    %0 = llvm.mlir.constant(36 : i64) : i64
    %1 = llvm.mul %arg1, %0 overflow<nsw>  : i64
    %2 = llvm.trunc %1 : i64 to i32
    %3 = llvm.mul %2, %arg2  : i32
    %4 = llvm.getelementptr inbounds %arg0[%3] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %5 = llvm.load %4 {alignment = 4 : i64} : !llvm.ptr -> !llvm.struct<"s", (i32, i32, i16)>
    llvm.return %5 : !llvm.struct<"s", (i32, i32, i16)>
  }
  llvm.func @test80(%arg0: !llvm.ptr, %arg1: i32) -> f64 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.shl %arg1, %0 overflow<nsw>  : i32
    %2 = llvm.getelementptr %arg0[%1] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %3 = llvm.load %2 {alignment = 8 : i64} : !llvm.ptr -> f64
    llvm.return %3 : f64
  }
  llvm.func @test80_addrspacecast(%arg0: !llvm.ptr<1>, %arg1: i32) -> f64 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.shl %arg1, %0 overflow<nsw>  : i32
    %2 = llvm.addrspacecast %arg0 : !llvm.ptr<1> to !llvm.ptr<2>
    %3 = llvm.getelementptr %2[%1] : (!llvm.ptr<2>, i32) -> !llvm.ptr<2>, i8
    %4 = llvm.addrspacecast %3 : !llvm.ptr<2> to !llvm.ptr<1>
    %5 = llvm.load %4 {alignment = 8 : i64} : !llvm.ptr<1> -> f64
    llvm.return %5 : f64
  }
  llvm.func @test80_addrspacecast_2(%arg0: !llvm.ptr<1>, %arg1: i32) -> f64 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.shl %arg1, %0 overflow<nsw>  : i32
    %2 = llvm.addrspacecast %arg0 : !llvm.ptr<1> to !llvm.ptr<2>
    %3 = llvm.getelementptr %2[%1] : (!llvm.ptr<2>, i32) -> !llvm.ptr<2>, i8
    %4 = llvm.addrspacecast %3 : !llvm.ptr<2> to !llvm.ptr<3>
    %5 = llvm.load %4 {alignment = 8 : i64} : !llvm.ptr<3> -> f64
    llvm.return %5 : f64
  }
  llvm.func @test80_as1(%arg0: !llvm.ptr<1>, %arg1: i16) -> f64 {
    %0 = llvm.mlir.constant(3 : i16) : i16
    %1 = llvm.shl %arg1, %0 overflow<nsw>  : i16
    %2 = llvm.getelementptr %arg0[%1] : (!llvm.ptr<1>, i16) -> !llvm.ptr<1>, i8
    %3 = llvm.load %2 {alignment = 8 : i64} : !llvm.ptr<1> -> f64
    llvm.return %3 : f64
  }
  llvm.func @test81(%arg0: !llvm.ptr, %arg1: f32) -> f64 {
    %0 = llvm.fptosi %arg1 : f32 to i64
    %1 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %2 = llvm.load %1 {alignment = 8 : i64} : !llvm.ptr -> f64
    llvm.return %2 : f64
  }
  llvm.func @test82(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(9 : i32) : i32
    %2 = llvm.trunc %arg0 : i64 to i32
    %3 = llvm.lshr %2, %0  : i32
    %4 = llvm.shl %3, %1  : i32
    %5 = llvm.zext %4 : i32 to i64
    llvm.return %5 : i64
  }
  llvm.func @test83(%arg0: i16, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.sext %arg0 : i16 to i32
    %2 = llvm.add %arg1, %0 overflow<nsw>  : i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.shl %1, %3  : i32
    %5 = llvm.zext %4 : i32 to i64
    llvm.return %5 : i64
  }
  llvm.func @test84(%arg0: i32) -> i8 {
    %0 = llvm.mlir.constant(-16777216 : i32) : i32
    %1 = llvm.mlir.constant(23 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i32
    %3 = llvm.lshr %2, %1  : i32
    %4 = llvm.trunc %3 : i32 to i8
    llvm.return %4 : i8
  }
  llvm.func @test85(%arg0: i32) -> i8 {
    %0 = llvm.mlir.constant(-16777216 : i32) : i32
    %1 = llvm.mlir.constant(23 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.lshr %2, %1  : i32
    %4 = llvm.trunc %3 : i32 to i8
    llvm.return %4 : i8
  }
  llvm.func @test86(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.sext %arg0 : i16 to i32
    %2 = llvm.ashr %1, %0  : i32
    %3 = llvm.trunc %2 : i32 to i16
    llvm.return %3 : i16
  }
  llvm.func @test87(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.sext %arg0 : i16 to i32
    %2 = llvm.mul %1, %0 overflow<nsw>  : i32
    %3 = llvm.ashr %2, %0  : i32
    %4 = llvm.trunc %3 : i32 to i16
    llvm.return %4 : i16
  }
  llvm.func @test88(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(18 : i32) : i32
    %1 = llvm.sext %arg0 : i16 to i32
    %2 = llvm.ashr %1, %0  : i32
    %3 = llvm.trunc %2 : i32 to i16
    llvm.return %3 : i16
  }
  llvm.func @PR21388(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "slt" %arg0, %0 : !llvm.ptr
    %2 = llvm.sext %1 : i1 to i32
    llvm.return %2 : i32
  }
  llvm.func @sitofp_zext(%arg0: i16) -> f32 {
    %0 = llvm.zext %arg0 : i16 to i32
    %1 = llvm.sitofp %0 : i32 to f32
    llvm.return %1 : f32
  }
  llvm.func @PR23309(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-4 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.sub %1, %arg1 overflow<nsw>  : i32
    %3 = llvm.trunc %2 : i32 to i1
    llvm.return %3 : i1
  }
  llvm.func @PR23309v2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-4 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.add %1, %arg1 overflow<nuw>  : i32
    %3 = llvm.trunc %2 : i32 to i1
    llvm.return %3 : i1
  }
  llvm.func @PR24763(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.sext %arg0 : i8 to i32
    %2 = llvm.lshr %1, %0  : i32
    %3 = llvm.trunc %2 : i32 to i16
    llvm.return %3 : i16
  }
  llvm.func @PR28745() -> i64 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<1> : vector<1xi32>) : vector<1xi32>
    %2 = llvm.bitcast %1 : vector<1xi32> to vector<2xi16>
    %3 = llvm.extractelement %2[%0 : i32] : vector<2xi16>
    %4 = llvm.mlir.constant(0 : i16) : i16
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.mlir.undef : !llvm.struct<(i32)>
    %7 = llvm.insertvalue %5, %6[0] : !llvm.struct<(i32)> 
    %8 = llvm.mlir.undef : !llvm.struct<(i32)>
    %9 = llvm.insertvalue %0, %8[0] : !llvm.struct<(i32)> 
    %10 = llvm.icmp "eq" %3, %4 : i16
    %11 = llvm.select %10, %7, %9 : i1, !llvm.struct<(i32)>
    %12 = llvm.extractvalue %11[0] : !llvm.struct<(i32)> 
    %13 = llvm.zext %12 : i32 to i64
    llvm.return %13 : i64
  }
  llvm.func @test89() -> i32 {
    %0 = llvm.mlir.poison : i16
    %1 = llvm.mlir.constant(6 : i16) : i16
    %2 = llvm.mlir.undef : vector<2xi16>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi16>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi16>
    %7 = llvm.bitcast %6 : vector<2xi16> to i32
    llvm.return %7 : i32
  }
  llvm.func @test90() -> vector<2xi32> {
    %0 = llvm.mlir.constant(1.000000e+00 : f16) : f16
    %1 = llvm.mlir.poison : f16
    %2 = llvm.mlir.undef : vector<4xf16>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<4xf16>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<4xf16>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %1, %6[%7 : i32] : vector<4xf16>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<4xf16>
    %11 = llvm.bitcast %10 : vector<4xf16> to vector<2xi32>
    llvm.return %11 : vector<2xi32>
  }
  llvm.func @test91(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(48 : i96) : i96
    %1 = llvm.sext %arg0 : i64 to i96
    %2 = llvm.lshr %1, %0  : i96
    %3 = llvm.trunc %2 : i96 to i64
    llvm.return %3 : i64
  }
  llvm.func @test92(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(32 : i96) : i96
    %1 = llvm.sext %arg0 : i64 to i96
    %2 = llvm.lshr %1, %0  : i96
    %3 = llvm.trunc %2 : i96 to i64
    llvm.return %3 : i64
  }
  llvm.func @test93(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(64 : i96) : i96
    %1 = llvm.sext %arg0 : i32 to i96
    %2 = llvm.lshr %1, %0  : i96
    %3 = llvm.trunc %2 : i96 to i32
    llvm.return %3 : i32
  }
  llvm.func @trunc_lshr_sext(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(6 : i32) : i32
    %1 = llvm.sext %arg0 : i8 to i32
    %2 = llvm.lshr %1, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    llvm.return %3 : i8
  }
  llvm.func @trunc_lshr_sext_exact(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(6 : i32) : i32
    %1 = llvm.sext %arg0 : i8 to i32
    %2 = llvm.lshr %1, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    llvm.return %3 : i8
  }
  llvm.func @trunc_lshr_sext_uniform(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<6> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sext %arg0 : vector<2xi8> to vector<2xi32>
    %2 = llvm.lshr %1, %0  : vector<2xi32>
    %3 = llvm.trunc %2 : vector<2xi32> to vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }
  llvm.func @trunc_lshr_sext_uniform_poison(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(6 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.sext %arg0 : vector<2xi8> to vector<2xi32>
    %8 = llvm.lshr %7, %6  : vector<2xi32>
    %9 = llvm.trunc %8 : vector<2xi32> to vector<2xi8>
    llvm.return %9 : vector<2xi8>
  }
  llvm.func @trunc_lshr_sext_nonuniform(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[6, 2]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sext %arg0 : vector<2xi8> to vector<2xi32>
    %2 = llvm.lshr %1, %0  : vector<2xi32>
    %3 = llvm.trunc %2 : vector<2xi32> to vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }
  llvm.func @trunc_lshr_sext_nonuniform_poison(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(6 : i32) : i32
    %3 = llvm.mlir.undef : vector<3xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<3xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<3xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<3xi32>
    %10 = llvm.sext %arg0 : vector<3xi8> to vector<3xi32>
    %11 = llvm.lshr %10, %9  : vector<3xi32>
    %12 = llvm.trunc %11 : vector<3xi32> to vector<3xi8>
    llvm.return %12 : vector<3xi8>
  }
  llvm.func @trunc_lshr_sext_uses1(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<6> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sext %arg0 : vector<2xi8> to vector<2xi32>
    llvm.call @use_v2i32(%1) : (vector<2xi32>) -> ()
    %2 = llvm.lshr %1, %0  : vector<2xi32>
    %3 = llvm.trunc %2 : vector<2xi32> to vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }
  llvm.func @trunc_lshr_sext_uses2(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(6 : i32) : i32
    %1 = llvm.sext %arg0 : i8 to i32
    %2 = llvm.lshr %1, %0  : i32
    llvm.call @use_i32(%2) : (i32) -> ()
    %3 = llvm.trunc %2 : i32 to i8
    llvm.return %3 : i8
  }
  llvm.func @trunc_lshr_sext_uses3(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<6> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sext %arg0 : vector<2xi8> to vector<2xi32>
    llvm.call @use_v2i32(%1) : (vector<2xi32>) -> ()
    %2 = llvm.lshr %1, %0  : vector<2xi32>
    llvm.call @use_v2i32(%2) : (vector<2xi32>) -> ()
    %3 = llvm.trunc %2 : vector<2xi32> to vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }
  llvm.func @trunc_lshr_overshift_sext(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sext %arg0 : vector<2xi8> to vector<2xi32>
    %2 = llvm.lshr %1, %0  : vector<2xi32>
    %3 = llvm.trunc %2 : vector<2xi32> to vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }
  llvm.func @trunc_lshr_overshift_sext_uses1(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.sext %arg0 : i8 to i32
    llvm.call @use_i32(%1) : (i32) -> ()
    %2 = llvm.lshr %1, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    llvm.return %3 : i8
  }
  llvm.func @trunc_lshr_overshift_sext_uses2(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sext %arg0 : vector<2xi8> to vector<2xi32>
    %2 = llvm.lshr %1, %0  : vector<2xi32>
    llvm.call @use_v2i32(%2) : (vector<2xi32>) -> ()
    %3 = llvm.trunc %2 : vector<2xi32> to vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }
  llvm.func @trunc_lshr_overshift_sext_uses3(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.sext %arg0 : i8 to i32
    llvm.call @use_i32(%1) : (i32) -> ()
    %2 = llvm.lshr %1, %0  : i32
    llvm.call @use_i32(%2) : (i32) -> ()
    %3 = llvm.trunc %2 : i32 to i8
    llvm.return %3 : i8
  }
  llvm.func @trunc_lshr_sext_wide_input(%arg0: i16) -> i8 {
    %0 = llvm.mlir.constant(9 : i32) : i32
    %1 = llvm.sext %arg0 : i16 to i32
    %2 = llvm.lshr %1, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    llvm.return %3 : i8
  }
  llvm.func @trunc_lshr_sext_wide_input_exact(%arg0: i16) -> i8 {
    %0 = llvm.mlir.constant(9 : i32) : i32
    %1 = llvm.sext %arg0 : i16 to i32
    %2 = llvm.lshr %1, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    llvm.return %3 : i8
  }
  llvm.func @trunc_lshr_sext_wide_input_uses1(%arg0: vector<2xi16>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<9> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sext %arg0 : vector<2xi16> to vector<2xi32>
    llvm.call @use_v2i32(%1) : (vector<2xi32>) -> ()
    %2 = llvm.lshr %1, %0  : vector<2xi32>
    %3 = llvm.trunc %2 : vector<2xi32> to vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }
  llvm.func @trunc_lshr_sext_wide_input_uses2(%arg0: i16) -> i8 {
    %0 = llvm.mlir.constant(9 : i32) : i32
    %1 = llvm.sext %arg0 : i16 to i32
    %2 = llvm.lshr %1, %0  : i32
    llvm.call @use_i32(%2) : (i32) -> ()
    %3 = llvm.trunc %2 : i32 to i8
    llvm.return %3 : i8
  }
  llvm.func @trunc_lshr_sext_wide_input_uses3(%arg0: vector<2xi16>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<9> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sext %arg0 : vector<2xi16> to vector<2xi32>
    llvm.call @use_v2i32(%1) : (vector<2xi32>) -> ()
    %2 = llvm.lshr %1, %0  : vector<2xi32>
    llvm.call @use_v2i32(%2) : (vector<2xi32>) -> ()
    %3 = llvm.trunc %2 : vector<2xi32> to vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }
  llvm.func @trunc_lshr_overshift_wide_input_sext(%arg0: vector<2xi16>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sext %arg0 : vector<2xi16> to vector<2xi32>
    %2 = llvm.lshr %1, %0  : vector<2xi32>
    %3 = llvm.trunc %2 : vector<2xi32> to vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }
  llvm.func @trunc_lshr_overshift_sext_wide_input_uses1(%arg0: i16) -> i8 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.sext %arg0 : i16 to i32
    llvm.call @use_i32(%1) : (i32) -> ()
    %2 = llvm.lshr %1, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    llvm.return %3 : i8
  }
  llvm.func @trunc_lshr_overshift_sext_wide_input_uses2(%arg0: vector<2xi16>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sext %arg0 : vector<2xi16> to vector<2xi32>
    %2 = llvm.lshr %1, %0  : vector<2xi32>
    llvm.call @use_v2i32(%2) : (vector<2xi32>) -> ()
    %3 = llvm.trunc %2 : vector<2xi32> to vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }
  llvm.func @trunc_lshr_overshift_sext_wide_input_uses3(%arg0: i16) -> i8 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.sext %arg0 : i16 to i32
    llvm.call @use_i32(%1) : (i32) -> ()
    %2 = llvm.lshr %1, %0  : i32
    llvm.call @use_i32(%2) : (i32) -> ()
    %3 = llvm.trunc %2 : i32 to i8
    llvm.return %3 : i8
  }
  llvm.func @trunc_lshr_sext_narrow_input(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(6 : i32) : i32
    %1 = llvm.sext %arg0 : i8 to i32
    %2 = llvm.lshr %1, %0  : i32
    %3 = llvm.trunc %2 : i32 to i16
    llvm.return %3 : i16
  }
  llvm.func @trunc_lshr_sext_narrow_input_uses1(%arg0: vector<2xi8>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<6> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sext %arg0 : vector<2xi8> to vector<2xi32>
    llvm.call @use_v2i32(%1) : (vector<2xi32>) -> ()
    %2 = llvm.lshr %1, %0  : vector<2xi32>
    %3 = llvm.trunc %2 : vector<2xi32> to vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }
  llvm.func @trunc_lshr_sext_narrow_input_uses2(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(6 : i32) : i32
    %1 = llvm.sext %arg0 : i8 to i32
    %2 = llvm.lshr %1, %0  : i32
    llvm.call @use_i32(%2) : (i32) -> ()
    %3 = llvm.trunc %2 : i32 to i16
    llvm.return %3 : i16
  }
  llvm.func @trunc_lshr_sext_narrow_input_uses3(%arg0: vector<2xi8>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<6> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sext %arg0 : vector<2xi8> to vector<2xi32>
    llvm.call @use_v2i32(%1) : (vector<2xi32>) -> ()
    %2 = llvm.lshr %1, %0  : vector<2xi32>
    llvm.call @use_v2i32(%2) : (vector<2xi32>) -> ()
    %3 = llvm.trunc %2 : vector<2xi32> to vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }
  llvm.func @trunc_lshr_overshift_narrow_input_sext(%arg0: vector<2xi8>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sext %arg0 : vector<2xi8> to vector<2xi32>
    %2 = llvm.lshr %1, %0  : vector<2xi32>
    %3 = llvm.trunc %2 : vector<2xi32> to vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }
  llvm.func @trunc_lshr_overshift_sext_narrow_input_uses1(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.sext %arg0 : i8 to i32
    llvm.call @use_i32(%1) : (i32) -> ()
    %2 = llvm.lshr %1, %0  : i32
    %3 = llvm.trunc %2 : i32 to i16
    llvm.return %3 : i16
  }
  llvm.func @trunc_lshr_overshift_sext_narrow_input_uses2(%arg0: vector<2xi8>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sext %arg0 : vector<2xi8> to vector<2xi32>
    %2 = llvm.lshr %1, %0  : vector<2xi32>
    llvm.call @use_v2i32(%2) : (vector<2xi32>) -> ()
    %3 = llvm.trunc %2 : vector<2xi32> to vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }
  llvm.func @trunc_lshr_overshift_sext_narrow_input_uses3(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.sext %arg0 : i8 to i32
    llvm.call @use_i32(%1) : (i32) -> ()
    %2 = llvm.lshr %1, %0  : i32
    llvm.call @use_i32(%2) : (i32) -> ()
    %3 = llvm.trunc %2 : i32 to i16
    llvm.return %3 : i16
  }
  llvm.func @trunc_lshr_overshift2_sext(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<25> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sext %arg0 : vector<2xi8> to vector<2xi32>
    %2 = llvm.lshr %1, %0  : vector<2xi32>
    %3 = llvm.trunc %2 : vector<2xi32> to vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }
  llvm.func @trunc_lshr_overshift2_sext_uses1(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(25 : i32) : i32
    %1 = llvm.sext %arg0 : i8 to i32
    llvm.call @use_i32(%1) : (i32) -> ()
    %2 = llvm.lshr %1, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    llvm.return %3 : i8
  }
  llvm.func @trunc_lshr_overshift2_sext_uses2(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<25> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sext %arg0 : vector<2xi8> to vector<2xi32>
    %2 = llvm.lshr %1, %0  : vector<2xi32>
    llvm.call @use_v2i32(%2) : (vector<2xi32>) -> ()
    %3 = llvm.trunc %2 : vector<2xi32> to vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }
  llvm.func @trunc_lshr_overshift2_sext_uses3(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(25 : i32) : i32
    %1 = llvm.sext %arg0 : i8 to i32
    llvm.call @use_i32(%1) : (i32) -> ()
    %2 = llvm.lshr %1, %0  : i32
    llvm.call @use_i32(%2) : (i32) -> ()
    %3 = llvm.trunc %2 : i32 to i8
    llvm.return %3 : i8
  }
  llvm.func @trunc_lshr_zext(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(6 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.lshr %1, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    llvm.return %3 : i8
  }
  llvm.func @trunc_lshr_zext_exact(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(6 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.lshr %1, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    llvm.return %3 : i8
  }
  llvm.func @trunc_lshr_zext_uniform(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<6> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.zext %arg0 : vector<2xi8> to vector<2xi32>
    %2 = llvm.lshr %1, %0  : vector<2xi32>
    %3 = llvm.trunc %2 : vector<2xi32> to vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }
  llvm.func @trunc_lshr_zext_uniform_poison(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(6 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.zext %arg0 : vector<2xi8> to vector<2xi32>
    %8 = llvm.lshr %7, %6  : vector<2xi32>
    %9 = llvm.trunc %8 : vector<2xi32> to vector<2xi8>
    llvm.return %9 : vector<2xi8>
  }
  llvm.func @trunc_lshr_zext_nonuniform(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[6, 2]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.zext %arg0 : vector<2xi8> to vector<2xi32>
    %2 = llvm.lshr %1, %0  : vector<2xi32>
    %3 = llvm.trunc %2 : vector<2xi32> to vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }
  llvm.func @trunc_lshr_zext_nonuniform_poison(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(6 : i32) : i32
    %3 = llvm.mlir.undef : vector<3xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<3xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<3xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<3xi32>
    %10 = llvm.zext %arg0 : vector<3xi8> to vector<3xi32>
    %11 = llvm.lshr %10, %9  : vector<3xi32>
    %12 = llvm.trunc %11 : vector<3xi32> to vector<3xi8>
    llvm.return %12 : vector<3xi8>
  }
  llvm.func @trunc_lshr_zext_uses1(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<6> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.zext %arg0 : vector<2xi8> to vector<2xi32>
    llvm.call @use_v2i32(%1) : (vector<2xi32>) -> ()
    %2 = llvm.lshr %1, %0  : vector<2xi32>
    %3 = llvm.trunc %2 : vector<2xi32> to vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }
  llvm.func @pr33078_1(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(8 : i16) : i16
    %1 = llvm.sext %arg0 : i8 to i16
    %2 = llvm.lshr %1, %0  : i16
    %3 = llvm.trunc %2 : i16 to i8
    llvm.return %3 : i8
  }
  llvm.func @pr33078_2(%arg0: i8) -> i12 {
    %0 = llvm.mlir.constant(4 : i16) : i16
    %1 = llvm.sext %arg0 : i8 to i16
    %2 = llvm.lshr %1, %0  : i16
    %3 = llvm.trunc %2 : i16 to i12
    llvm.return %3 : i12
  }
  llvm.func @pr33078_3(%arg0: i8) -> i4 {
    %0 = llvm.mlir.constant(12 : i16) : i16
    %1 = llvm.sext %arg0 : i8 to i16
    %2 = llvm.lshr %1, %0  : i16
    %3 = llvm.trunc %2 : i16 to i4
    llvm.return %3 : i4
  }
  llvm.func @pr33078_4(%arg0: i3) -> i8 {
    %0 = llvm.mlir.constant(13 : i16) : i16
    %1 = llvm.sext %arg0 : i3 to i16
    %2 = llvm.lshr %1, %0  : i16
    %3 = llvm.trunc %2 : i16 to i8
    llvm.return %3 : i8
  }
  llvm.func @test94(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    %3 = llvm.sext %2 : i1 to i8
    %4 = llvm.xor %3, %1  : i8
    %5 = llvm.sext %4 : i8 to i64
    llvm.return %5 : i64
  }
  llvm.func @test95(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.mlir.constant(40 : i8) : i8
    %3 = llvm.trunc %arg0 : i32 to i8
    %4 = llvm.lshr %3, %0  : i8
    %5 = llvm.and %4, %1  : i8
    %6 = llvm.or %5, %2  : i8
    %7 = llvm.zext %6 : i8 to i32
    llvm.return %7 : i32
  }
}
