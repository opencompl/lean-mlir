module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use(i8)
  llvm.func @test1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %arg0, %2  : i32
    llvm.return %3 : i32
  }
  llvm.func @test2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %arg1, %2  : i32
    llvm.return %3 : i32
  }
  llvm.func @test3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %arg0, %2  : i32
    llvm.return %3 : i32
  }
  llvm.func @test4(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %arg1, %2  : i32
    llvm.return %3 : i32
  }
  llvm.func @test5(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %arg1  : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.or %1, %2  : i32
    llvm.return %3 : i32
  }
  llvm.func @test5_commuted(%arg0: vector<2xi4>, %arg1: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.xor %arg0, %arg1  : vector<2xi4>
    %3 = llvm.xor %arg0, %1  : vector<2xi4>
    %4 = llvm.or %3, %2  : vector<2xi4>
    llvm.return %4 : vector<2xi4>
  }
  llvm.func @test5_commuted_x_y(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.xor %arg1, %arg0  : i64
    %2 = llvm.xor %arg0, %0  : i64
    %3 = llvm.or %1, %2  : i64
    llvm.return %3 : i64
  }
  llvm.func @test5_extra_use_not(%arg0: i8, %arg1: i8, %arg2: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %arg1  : i8
    %2 = llvm.xor %arg0, %0  : i8
    llvm.store %2, %arg2 {alignment = 1 : i64} : i8, !llvm.ptr
    %3 = llvm.or %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @test5_extra_use_xor(%arg0: i65, %arg1: i65, %arg2: !llvm.ptr) -> i65 {
    %0 = llvm.mlir.constant(-1 : i65) : i65
    %1 = llvm.xor %arg0, %arg1  : i65
    llvm.store %1, %arg2 {alignment = 4 : i64} : i65, !llvm.ptr
    %2 = llvm.xor %arg0, %0  : i65
    %3 = llvm.or %2, %1  : i65
    llvm.return %3 : i65
  }
  llvm.func @test5_extra_use_not_xor(%arg0: i16, %arg1: i16, %arg2: !llvm.ptr, %arg3: !llvm.ptr) -> i16 {
    %0 = llvm.mlir.constant(-1 : i16) : i16
    %1 = llvm.xor %arg0, %arg1  : i16
    llvm.store %1, %arg3 {alignment = 2 : i64} : i16, !llvm.ptr
    %2 = llvm.xor %arg0, %0  : i16
    llvm.store %2, %arg2 {alignment = 2 : i64} : i16, !llvm.ptr
    %3 = llvm.or %2, %1  : i16
    llvm.return %3 : i16
  }
  llvm.func @xor_common_op_commute0(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.xor %arg0, %arg1  : i8
    %1 = llvm.or %0, %arg0  : i8
    llvm.return %1 : i8
  }
  llvm.func @xor_common_op_commute1(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.xor %arg1, %arg0  : i8
    llvm.call @use(%0) : (i8) -> ()
    %1 = llvm.or %0, %arg0  : i8
    llvm.return %1 : i8
  }
  llvm.func @xor_common_op_commute2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %1, %arg1  : i8
    %3 = llvm.or %1, %2  : i8
    llvm.return %3 : i8
  }
  llvm.func @xor_common_op_commute3(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.mul %arg1, %arg1  : i8
    %3 = llvm.xor %2, %1  : i8
    %4 = llvm.or %1, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @test8(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.xor %arg0, %1  : i32
    %3 = llvm.or %arg1, %2  : i32
    llvm.return %3 : i32
  }
  llvm.func @test9(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.xor %1, %arg1  : i32
    %3 = llvm.or %arg0, %2  : i32
    llvm.return %3 : i32
  }
  llvm.func @test10(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %arg0  : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.xor %2, %arg1  : i32
    %4 = llvm.or %1, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @test10_commuted(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %arg0  : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.xor %2, %arg1  : i32
    %4 = llvm.or %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @test10_extrause(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %arg0  : i32
    %2 = llvm.xor %arg0, %0  : i32
    llvm.store %2, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr
    %3 = llvm.xor %2, %arg1  : i32
    %4 = llvm.or %1, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @test10_commuted_extrause(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %arg0  : i32
    %2 = llvm.xor %arg0, %0  : i32
    llvm.store %2, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr
    %3 = llvm.xor %2, %arg1  : i32
    %4 = llvm.or %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @test10_canonical(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %arg0  : i32
    %2 = llvm.xor %arg0, %arg1  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.or %1, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @test11(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.xor %2, %arg1  : i32
    %4 = llvm.and %1, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @test12(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.xor %1, %arg1  : i32
    %3 = llvm.or %arg0, %arg1  : i32
    %4 = llvm.and %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @test12_commuted(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.xor %1, %arg1  : i32
    %3 = llvm.or %arg1, %arg0  : i32
    %4 = llvm.and %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @test13(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.xor %arg1, %arg0  : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.xor %1, %0  : i32
    llvm.return %2 : i32
  }
  llvm.func @test14(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.or %arg0, %1  : i32
    %4 = llvm.or %2, %arg1  : i32
    %5 = llvm.xor %3, %4  : i32
    llvm.return %5 : i32
  }
  llvm.func @test14_commuted(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.or %1, %arg0  : i32
    %4 = llvm.or %2, %arg1  : i32
    %5 = llvm.xor %3, %4  : i32
    llvm.return %5 : i32
  }
  llvm.func @test15(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.and %arg0, %1  : i32
    %4 = llvm.and %2, %arg1  : i32
    %5 = llvm.xor %3, %4  : i32
    llvm.return %5 : i32
  }
  llvm.func @test15_commuted(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.and %1, %arg0  : i32
    %4 = llvm.and %2, %arg1  : i32
    %5 = llvm.xor %3, %4  : i32
    llvm.return %5 : i32
  }
  llvm.func @or_and_xor_not_constant_commute0(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.xor %arg0, %arg1  : i32
    %3 = llvm.and %2, %0  : i32
    %4 = llvm.and %arg1, %1  : i32
    %5 = llvm.or %3, %4  : i32
    llvm.return %5 : i32
  }
  llvm.func @or_and_xor_not_constant_commute1(%arg0: i9, %arg1: i9) -> i9 {
    %0 = llvm.mlir.constant(42 : i9) : i9
    %1 = llvm.mlir.constant(-43 : i9) : i9
    %2 = llvm.xor %arg1, %arg0  : i9
    %3 = llvm.and %2, %0  : i9
    %4 = llvm.and %arg1, %1  : i9
    %5 = llvm.or %3, %4  : i9
    llvm.return %5 : i9
  }
  llvm.func @or_and_xor_not_constant_commute2_splat(%arg0: vector<2xi9>, %arg1: vector<2xi9>) -> vector<2xi9> {
    %0 = llvm.mlir.constant(42 : i9) : i9
    %1 = llvm.mlir.constant(dense<42> : vector<2xi9>) : vector<2xi9>
    %2 = llvm.mlir.constant(-43 : i9) : i9
    %3 = llvm.mlir.constant(dense<-43> : vector<2xi9>) : vector<2xi9>
    %4 = llvm.xor %arg1, %arg0  : vector<2xi9>
    %5 = llvm.and %4, %1  : vector<2xi9>
    %6 = llvm.and %arg1, %3  : vector<2xi9>
    %7 = llvm.or %6, %5  : vector<2xi9>
    llvm.return %7 : vector<2xi9>
  }
  llvm.func @or_and_xor_not_constant_commute3_splat(%arg0: vector<2xi9>, %arg1: vector<2xi9>) -> vector<2xi9> {
    %0 = llvm.mlir.constant(42 : i9) : i9
    %1 = llvm.mlir.constant(dense<42> : vector<2xi9>) : vector<2xi9>
    %2 = llvm.mlir.constant(-43 : i9) : i9
    %3 = llvm.mlir.constant(dense<-43> : vector<2xi9>) : vector<2xi9>
    %4 = llvm.xor %arg0, %arg1  : vector<2xi9>
    %5 = llvm.and %4, %1  : vector<2xi9>
    %6 = llvm.and %arg1, %3  : vector<2xi9>
    %7 = llvm.or %6, %5  : vector<2xi9>
    llvm.return %7 : vector<2xi9>
  }
  llvm.func @not_or(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.or %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @not_or_xor(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.mlir.constant(12 : i8) : i8
    %3 = llvm.xor %arg0, %0  : i8
    %4 = llvm.or %3, %1  : i8
    %5 = llvm.xor %4, %2  : i8
    llvm.return %5 : i8
  }
  llvm.func @xor_or(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(32 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.or %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @xor_or2(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(33 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.or %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @xor_or_xor(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(33 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.mlir.constant(12 : i8) : i8
    %3 = llvm.xor %arg0, %0  : i8
    %4 = llvm.or %3, %1  : i8
    %5 = llvm.xor %4, %2  : i8
    llvm.return %5 : i8
  }
  llvm.func @or_xor_or(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(33 : i8) : i8
    %1 = llvm.mlir.constant(12 : i8) : i8
    %2 = llvm.mlir.constant(7 : i8) : i8
    %3 = llvm.or %arg0, %0  : i8
    %4 = llvm.xor %3, %1  : i8
    %5 = llvm.or %4, %2  : i8
    llvm.return %5 : i8
  }
  llvm.func @test17(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(33 : i8) : i8
    %1 = llvm.xor %arg1, %arg0  : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.xor %2, %arg1  : i8
    %4 = llvm.or %1, %3  : i8
    %5 = llvm.mul %4, %3  : i8
    llvm.return %5 : i8
  }
  llvm.func @test18(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(33 : i8) : i8
    %1 = llvm.xor %arg1, %arg0  : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.xor %2, %arg1  : i8
    %4 = llvm.or %3, %1  : i8
    %5 = llvm.mul %4, %3  : i8
    llvm.return %5 : i8
  }
  llvm.func @test19(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.or %arg0, %arg1  : i32
    %4 = llvm.or %2, %1  : i32
    %5 = llvm.xor %3, %4  : i32
    llvm.return %5 : i32
  }
  llvm.func @test20(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.or %arg0, %arg1  : i32
    %4 = llvm.or %1, %2  : i32
    %5 = llvm.xor %3, %4  : i32
    llvm.return %5 : i32
  }
  llvm.func @test21(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.or %2, %1  : i32
    %4 = llvm.or %arg0, %arg1  : i32
    %5 = llvm.xor %3, %4  : i32
    llvm.return %5 : i32
  }
  llvm.func @test22(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.or %2, %1  : i32
    %4 = llvm.or %arg1, %arg0  : i32
    %5 = llvm.xor %3, %4  : i32
    llvm.return %5 : i32
  }
  llvm.func @test23(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-2 : i8) : i8
    %1 = llvm.mlir.constant(13 : i8) : i8
    %2 = llvm.mlir.constant(1 : i8) : i8
    %3 = llvm.mlir.constant(12 : i8) : i8
    %4 = llvm.or %arg0, %0  : i8
    %5 = llvm.xor %4, %1  : i8
    %6 = llvm.or %5, %2  : i8
    %7 = llvm.xor %6, %3  : i8
    llvm.return %7 : i8
  }
  llvm.func @test23v(%arg0: vector<2xi8>) -> i8 {
    %0 = llvm.mlir.constant(dense<[-2, 0]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<13> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(1 : i8) : i8
    %4 = llvm.mlir.constant(12 : i8) : i8
    %5 = llvm.or %arg0, %0  : vector<2xi8>
    %6 = llvm.xor %5, %1  : vector<2xi8>
    %7 = llvm.extractelement %6[%2 : i32] : vector<2xi8>
    %8 = llvm.or %7, %3  : i8
    %9 = llvm.xor %8, %4  : i8
    llvm.return %9 : i8
  }
  llvm.func @PR45977_f1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.and %1, %arg1  : i32
    %3 = llvm.or %arg0, %arg1  : i32
    %4 = llvm.xor %3, %0  : i32
    %5 = llvm.or %4, %2  : i32
    llvm.return %5 : i32
  }
  llvm.func @PR45977_f2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.xor %arg1, %0  : i32
    %3 = llvm.or %arg0, %2  : i32
    %4 = llvm.xor %1, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @or_xor_common_op_commute0(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.or %arg0, %arg1  : i8
    %1 = llvm.xor %arg0, %arg2  : i8
    %2 = llvm.or %0, %1  : i8
    llvm.return %2 : i8
  }
  llvm.func @or_xor_common_op_commute1(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.or %arg1, %arg0  : i8
    llvm.call @use(%0) : (i8) -> ()
    %1 = llvm.xor %arg0, %arg2  : i8
    %2 = llvm.or %0, %1  : i8
    llvm.return %2 : i8
  }
  llvm.func @or_xor_common_op_commute2(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.or %arg0, %arg1  : i8
    %1 = llvm.xor %arg2, %arg0  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.or %0, %1  : i8
    llvm.return %2 : i8
  }
  llvm.func @or_xor_common_op_commute3(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.or %arg1, %arg0  : i8
    llvm.call @use(%0) : (i8) -> ()
    %1 = llvm.xor %arg2, %arg0  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.or %0, %1  : i8
    llvm.return %2 : i8
  }
  llvm.func @or_xor_common_op_commute4(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.or %arg0, %arg1  : vector<2xi8>
    %1 = llvm.xor %arg0, %arg2  : vector<2xi8>
    %2 = llvm.or %1, %0  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }
  llvm.func @or_xor_common_op_commute5(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.or %arg1, %arg0  : i8
    %1 = llvm.xor %arg0, %arg2  : i8
    %2 = llvm.or %1, %0  : i8
    llvm.return %2 : i8
  }
  llvm.func @or_xor_common_op_commute6(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.or %arg0, %arg1  : i8
    %1 = llvm.xor %arg2, %arg0  : i8
    %2 = llvm.or %1, %0  : i8
    llvm.return %2 : i8
  }
  llvm.func @or_xor_common_op_commute7(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.or %arg1, %arg0  : i8
    %1 = llvm.xor %arg2, %arg0  : i8
    %2 = llvm.or %1, %0  : i8
    llvm.return %2 : i8
  }
  llvm.func @or_xor_notcommon_op(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.or %arg0, %arg1  : i8
    %1 = llvm.xor %arg3, %arg2  : i8
    %2 = llvm.or %0, %1  : i8
    llvm.return %2 : i8
  }
  llvm.func @or_not_xor_common_op_commute0(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.xor %arg0, %0  : i4
    %2 = llvm.xor %arg0, %arg1  : i4
    %3 = llvm.or %1, %arg2  : i4
    %4 = llvm.or %3, %2  : i4
    llvm.return %4 : i4
  }
  llvm.func @or_not_xor_common_op_commute1(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.xor %arg0, %arg1  : i8
    %3 = llvm.or %1, %arg2  : i8
    %4 = llvm.or %2, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @or_not_xor_common_op_commute2(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.sub %0, %arg2  : i8
    %3 = llvm.xor %arg0, %1  : i8
    %4 = llvm.xor %arg0, %arg1  : i8
    %5 = llvm.or %2, %3  : i8
    %6 = llvm.or %4, %5  : i8
    llvm.return %6 : i8
  }
  llvm.func @or_not_xor_common_op_commute3(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.sub %0, %arg2  : i8
    %3 = llvm.xor %arg0, %1  : i8
    %4 = llvm.xor %arg0, %arg1  : i8
    %5 = llvm.or %2, %3  : i8
    %6 = llvm.or %5, %4  : i8
    llvm.return %6 : i8
  }
  llvm.func @or_not_xor_common_op_commute4(%arg0: vector<2xi4>, %arg1: vector<2xi4>, %arg2: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi4>) : vector<2xi4>
    %2 = llvm.xor %arg0, %1  : vector<2xi4>
    %3 = llvm.xor %arg1, %arg0  : vector<2xi4>
    %4 = llvm.or %2, %arg2  : vector<2xi4>
    %5 = llvm.or %4, %3  : vector<2xi4>
    llvm.return %5 : vector<2xi4>
  }
  llvm.func @or_not_xor_common_op_commute5(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %arg0  : i8
    %3 = llvm.or %1, %arg2  : i8
    %4 = llvm.or %2, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @or_not_xor_common_op_commute6(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.sub %0, %arg2  : i8
    %3 = llvm.xor %arg0, %1  : i8
    %4 = llvm.xor %arg1, %arg0  : i8
    %5 = llvm.or %2, %3  : i8
    %6 = llvm.or %4, %5  : i8
    llvm.return %6 : i8
  }
  llvm.func @or_not_xor_common_op_commute7(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.sub %0, %arg2  : i8
    %3 = llvm.xor %arg0, %1  : i8
    %4 = llvm.xor %arg1, %arg0  : i8
    %5 = llvm.or %2, %3  : i8
    %6 = llvm.or %5, %4  : i8
    llvm.return %6 : i8
  }
  llvm.func @or_not_xor_common_op_use1(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg0, %arg1  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.or %1, %arg2  : i8
    %4 = llvm.or %2, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @or_not_xor_common_op_use2(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg0, %arg1  : i8
    %3 = llvm.or %1, %arg2  : i8
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.or %2, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @or_nand_xor_common_op_commute0(%arg0: i4, %arg1: i4, %arg2: i4) -> i4 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.and %arg0, %arg2  : i4
    %2 = llvm.xor %1, %0  : i4
    %3 = llvm.xor %arg0, %arg1  : i4
    %4 = llvm.or %2, %3  : i4
    llvm.return %4 : i4
  }
  llvm.func @or_nand_xor_common_op_commute1(%arg0: vector<2xi4>, %arg1: vector<2xi4>, %arg2: vector<2xi4>) -> vector<2xi4> {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mlir.poison : i4
    %2 = llvm.mlir.undef : vector<2xi4>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi4>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi4>
    %7 = llvm.and %arg2, %arg0  : vector<2xi4>
    %8 = llvm.xor %7, %6  : vector<2xi4>
    %9 = llvm.xor %arg0, %arg1  : vector<2xi4>
    %10 = llvm.or %9, %8  : vector<2xi4>
    llvm.return %10 : vector<2xi4>
  }
  llvm.func @or_nand_xor_common_op_commute2(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.and %arg0, %arg2  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.xor %1, %0  : i8
    %3 = llvm.xor %arg1, %arg0  : i8
    %4 = llvm.or %2, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @or_nand_xor_common_op_commute3(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.and %arg2, %arg0  : i8
    %2 = llvm.xor %1, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.xor %arg1, %arg0  : i8
    %4 = llvm.or %3, %2  : i8
    llvm.return %4 : i8
  }
  llvm.func @or_nand_xor_common_op_commute3_use2(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.and %arg2, %arg0  : i8
    %2 = llvm.xor %1, %0  : i8
    %3 = llvm.xor %arg1, %arg0  : i8
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.or %3, %2  : i8
    llvm.return %4 : i8
  }
  llvm.func @or_nand_xor_common_op_commute3_use3(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.and %arg2, %arg0  : i8
    %2 = llvm.xor %1, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.xor %arg1, %arg0  : i8
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.or %3, %2  : i8
    llvm.return %4 : i8
  }
  llvm.func @PR75692_1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(-5 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.xor %arg0, %1  : i32
    %4 = llvm.or %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @PR75692_2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(-4 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.xor %arg0, %1  : i32
    %4 = llvm.or %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @PR75692_3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(-5 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.xor %arg1, %1  : i32
    %4 = llvm.or %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @or_xor_not(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.xor %arg0, %1  : i32
    %3 = llvm.or %2, %arg1  : i32
    llvm.return %3 : i32
  }
  llvm.func @or_xor_not_uses1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.addressof @use : !llvm.ptr
    %2 = llvm.xor %arg1, %0  : i32
    llvm.call %1(%2) : !llvm.ptr, (i32) -> ()
    %3 = llvm.xor %arg0, %2  : i32
    %4 = llvm.or %3, %arg1  : i32
    llvm.return %4 : i32
  }
  llvm.func @or_xor_not_uses2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.addressof @use : !llvm.ptr
    %2 = llvm.xor %arg1, %0  : i32
    %3 = llvm.xor %arg0, %2  : i32
    llvm.call %1(%3) : !llvm.ptr, (i32) -> ()
    %4 = llvm.or %3, %arg1  : i32
    llvm.return %4 : i32
  }
  llvm.func @or_xor_and_commuted1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mul %arg1, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.xor %2, %arg0  : i32
    %4 = llvm.or %1, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @or_xor_and_commuted2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mul %arg1, %arg1  : i32
    %2 = llvm.mul %arg0, %arg0  : i32
    %3 = llvm.xor %1, %0  : i32
    %4 = llvm.xor %2, %3  : i32
    %5 = llvm.or %4, %1  : i32
    llvm.return %5 : i32
  }
  llvm.func @or_xor_tree_0000(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mul %arg0, %0  : i32
    %2 = llvm.mul %arg1, %0  : i32
    %3 = llvm.mul %arg2, %0  : i32
    %4 = llvm.xor %1, %2  : i32
    %5 = llvm.xor %2, %3  : i32
    %6 = llvm.xor %5, %1  : i32
    %7 = llvm.or %4, %6  : i32
    llvm.return %7 : i32
  }
  llvm.func @or_xor_tree_0001(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mul %arg0, %0  : i32
    %2 = llvm.mul %arg1, %0  : i32
    %3 = llvm.mul %arg2, %0  : i32
    %4 = llvm.xor %2, %1  : i32
    %5 = llvm.xor %2, %3  : i32
    %6 = llvm.xor %5, %1  : i32
    %7 = llvm.or %4, %6  : i32
    llvm.return %7 : i32
  }
  llvm.func @or_xor_tree_0010(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mul %arg0, %0  : i32
    %2 = llvm.mul %arg1, %0  : i32
    %3 = llvm.mul %arg2, %0  : i32
    %4 = llvm.xor %1, %2  : i32
    %5 = llvm.xor %3, %2  : i32
    %6 = llvm.xor %5, %1  : i32
    %7 = llvm.or %4, %6  : i32
    llvm.return %7 : i32
  }
  llvm.func @or_xor_tree_0011(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mul %arg0, %0  : i32
    %2 = llvm.mul %arg1, %0  : i32
    %3 = llvm.mul %arg2, %0  : i32
    %4 = llvm.xor %2, %1  : i32
    %5 = llvm.xor %3, %2  : i32
    %6 = llvm.xor %5, %1  : i32
    %7 = llvm.or %4, %6  : i32
    llvm.return %7 : i32
  }
  llvm.func @or_xor_tree_0100(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mul %arg0, %0  : i32
    %2 = llvm.mul %arg1, %0  : i32
    %3 = llvm.mul %arg2, %0  : i32
    %4 = llvm.xor %1, %2  : i32
    %5 = llvm.xor %2, %3  : i32
    %6 = llvm.xor %1, %5  : i32
    %7 = llvm.or %4, %6  : i32
    llvm.return %7 : i32
  }
  llvm.func @or_xor_tree_0101(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mul %arg0, %0  : i32
    %2 = llvm.mul %arg1, %0  : i32
    %3 = llvm.mul %arg2, %0  : i32
    %4 = llvm.xor %2, %1  : i32
    %5 = llvm.xor %2, %3  : i32
    %6 = llvm.xor %1, %5  : i32
    %7 = llvm.or %4, %6  : i32
    llvm.return %7 : i32
  }
  llvm.func @or_xor_tree_0110(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mul %arg0, %0  : i32
    %2 = llvm.mul %arg1, %0  : i32
    %3 = llvm.mul %arg2, %0  : i32
    %4 = llvm.xor %1, %2  : i32
    %5 = llvm.xor %3, %2  : i32
    %6 = llvm.xor %1, %5  : i32
    %7 = llvm.or %4, %6  : i32
    llvm.return %7 : i32
  }
  llvm.func @or_xor_tree_0111(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mul %arg0, %0  : i32
    %2 = llvm.mul %arg1, %0  : i32
    %3 = llvm.mul %arg2, %0  : i32
    %4 = llvm.xor %2, %1  : i32
    %5 = llvm.xor %3, %2  : i32
    %6 = llvm.xor %1, %5  : i32
    %7 = llvm.or %4, %6  : i32
    llvm.return %7 : i32
  }
  llvm.func @or_xor_tree_1000(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mul %arg0, %0  : i32
    %2 = llvm.mul %arg1, %0  : i32
    %3 = llvm.mul %arg2, %0  : i32
    %4 = llvm.xor %1, %2  : i32
    %5 = llvm.xor %2, %3  : i32
    %6 = llvm.xor %5, %1  : i32
    %7 = llvm.or %6, %4  : i32
    llvm.return %7 : i32
  }
  llvm.func @or_xor_tree_1001(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mul %arg0, %0  : i32
    %2 = llvm.mul %arg1, %0  : i32
    %3 = llvm.mul %arg2, %0  : i32
    %4 = llvm.xor %2, %1  : i32
    %5 = llvm.xor %2, %3  : i32
    %6 = llvm.xor %5, %1  : i32
    %7 = llvm.or %6, %4  : i32
    llvm.return %7 : i32
  }
  llvm.func @or_xor_tree_1010(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mul %arg0, %0  : i32
    %2 = llvm.mul %arg1, %0  : i32
    %3 = llvm.mul %arg2, %0  : i32
    %4 = llvm.xor %1, %2  : i32
    %5 = llvm.xor %3, %2  : i32
    %6 = llvm.xor %5, %1  : i32
    %7 = llvm.or %6, %4  : i32
    llvm.return %7 : i32
  }
  llvm.func @or_xor_tree_1011(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mul %arg0, %0  : i32
    %2 = llvm.mul %arg1, %0  : i32
    %3 = llvm.mul %arg2, %0  : i32
    %4 = llvm.xor %2, %1  : i32
    %5 = llvm.xor %3, %2  : i32
    %6 = llvm.xor %5, %1  : i32
    %7 = llvm.or %6, %4  : i32
    llvm.return %7 : i32
  }
  llvm.func @or_xor_tree_1100(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mul %arg0, %0  : i32
    %2 = llvm.mul %arg1, %0  : i32
    %3 = llvm.mul %arg2, %0  : i32
    %4 = llvm.xor %1, %2  : i32
    %5 = llvm.xor %2, %3  : i32
    %6 = llvm.xor %1, %5  : i32
    %7 = llvm.or %6, %4  : i32
    llvm.return %7 : i32
  }
  llvm.func @or_xor_tree_1101(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mul %arg0, %0  : i32
    %2 = llvm.mul %arg1, %0  : i32
    %3 = llvm.mul %arg2, %0  : i32
    %4 = llvm.xor %2, %1  : i32
    %5 = llvm.xor %2, %3  : i32
    %6 = llvm.xor %1, %5  : i32
    %7 = llvm.or %6, %4  : i32
    llvm.return %7 : i32
  }
  llvm.func @or_xor_tree_1110(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mul %arg0, %0  : i32
    %2 = llvm.mul %arg1, %0  : i32
    %3 = llvm.mul %arg2, %0  : i32
    %4 = llvm.xor %1, %2  : i32
    %5 = llvm.xor %3, %2  : i32
    %6 = llvm.xor %1, %5  : i32
    %7 = llvm.or %6, %4  : i32
    llvm.return %7 : i32
  }
  llvm.func @or_xor_tree_1111(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mul %arg0, %0  : i32
    %2 = llvm.mul %arg1, %0  : i32
    %3 = llvm.mul %arg2, %0  : i32
    %4 = llvm.xor %2, %1  : i32
    %5 = llvm.xor %3, %2  : i32
    %6 = llvm.xor %1, %5  : i32
    %7 = llvm.or %6, %4  : i32
    llvm.return %7 : i32
  }
}
