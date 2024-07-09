module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1.280000e+02 : f64) : f64
    %1 = llvm.sitofp %arg0 : i8 to f64
    %2 = llvm.fcmp "ult" %1, %0 : f64
    llvm.return %2 : i1
  }
  llvm.func @test2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1.281000e+02 : f64) : f64
    %1 = llvm.sitofp %arg0 : i8 to f64
    %2 = llvm.fcmp "ugt" %1, %0 : f64
    llvm.return %2 : i1
  }
  llvm.func @test3(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1.270000e+02 : f64) : f64
    %1 = llvm.sitofp %arg0 : i8 to f64
    %2 = llvm.fcmp "ule" %1, %0 : f64
    llvm.return %2 : i1
  }
  llvm.func @test4(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1.270000e+02 : f64) : f64
    %1 = llvm.sitofp %arg0 : i8 to f64
    %2 = llvm.fcmp "ult" %1, %0 : f64
    llvm.return %2 : i1
  }
  llvm.func @test5(%arg0: i32) -> i32 {
    %0 = llvm.sitofp %arg0 : i32 to f64
    %1 = llvm.fptosi %0 : f64 to i32
    %2 = llvm.uitofp %1 : i32 to f64
    %3 = llvm.fptoui %2 : f64 to i32
    llvm.return %3 : i32
  }
  llvm.func @test6(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.and %arg0, %1  : i32
    %4 = llvm.sitofp %2 : i32 to f64
    %5 = llvm.sitofp %3 : i32 to f64
    %6 = llvm.fadd %4, %5  : f64
    %7 = llvm.fptosi %6 : f64 to i32
    llvm.return %7 : i32
  }
  llvm.func @test7(%arg0: i32) -> i32 {
    %0 = llvm.sitofp %arg0 : i32 to f64
    %1 = llvm.fptoui %0 : f64 to i32
    llvm.return %1 : i32
  }
  llvm.func @test8(%arg0: i32) -> i32 {
    %0 = llvm.uitofp %arg0 : i32 to f64
    %1 = llvm.fptosi %0 : f64 to i32
    llvm.return %1 : i32
  }
  llvm.func @test9(%arg0: i8) -> i32 {
    %0 = llvm.sitofp %arg0 : i8 to f32
    %1 = llvm.fptoui %0 : f32 to i32
    llvm.return %1 : i32
  }
  llvm.func @test10(%arg0: i8) -> i32 {
    %0 = llvm.sitofp %arg0 : i8 to f32
    %1 = llvm.fptosi %0 : f32 to i32
    llvm.return %1 : i32
  }
  llvm.func @test11(%arg0: i32) -> i8 {
    %0 = llvm.sitofp %arg0 : i32 to f32
    %1 = llvm.fptosi %0 : f32 to i8
    llvm.return %1 : i8
  }
  llvm.func @test12(%arg0: i8) -> i32 {
    %0 = llvm.sitofp %arg0 : i8 to f32
    %1 = llvm.fptoui %0 : f32 to i32
    llvm.return %1 : i32
  }
  llvm.func @test13(%arg0: i25) -> i32 {
    %0 = llvm.uitofp %arg0 : i25 to f32
    %1 = llvm.fptoui %0 : f32 to i32
    llvm.return %1 : i32
  }
  llvm.func @test14(%arg0: i24) -> i32 {
    %0 = llvm.uitofp %arg0 : i24 to f32
    %1 = llvm.fptoui %0 : f32 to i32
    llvm.return %1 : i32
  }
  llvm.func @test15(%arg0: i32) -> i24 {
    %0 = llvm.uitofp %arg0 : i32 to f32
    %1 = llvm.fptoui %0 : f32 to i24
    llvm.return %1 : i24
  }
  llvm.func @test16(%arg0: i25) -> i32 {
    %0 = llvm.sitofp %arg0 : i25 to f32
    %1 = llvm.fptoui %0 : f32 to i32
    llvm.return %1 : i32
  }
  llvm.func @test17(%arg0: i26) -> i32 {
    %0 = llvm.sitofp %arg0 : i26 to f32
    %1 = llvm.fptoui %0 : f32 to i32
    llvm.return %1 : i32
  }
  llvm.func @test18(%arg0: i64) -> i54 {
    %0 = llvm.sitofp %arg0 : i64 to f64
    %1 = llvm.fptosi %0 : f64 to i54
    llvm.return %1 : i54
  }
  llvm.func @test19(%arg0: i64) -> i55 {
    %0 = llvm.sitofp %arg0 : i64 to f64
    %1 = llvm.fptosi %0 : f64 to i55
    llvm.return %1 : i55
  }
  llvm.func @masked_input(%arg0: i25) -> i25 {
    %0 = llvm.mlir.constant(65535 : i25) : i25
    %1 = llvm.and %arg0, %0  : i25
    %2 = llvm.uitofp %1 : i25 to f32
    %3 = llvm.fptoui %2 : f32 to i25
    llvm.return %3 : i25
  }
  llvm.func @max_masked_input(%arg0: i25) -> i25 {
    %0 = llvm.mlir.constant(16777215 : i25) : i25
    %1 = llvm.and %arg0, %0  : i25
    %2 = llvm.uitofp %1 : i25 to f32
    %3 = llvm.fptoui %2 : f32 to i25
    llvm.return %3 : i25
  }
  llvm.func @consider_lowbits_masked_input(%arg0: i25) -> i25 {
    %0 = llvm.mlir.constant(-16777214 : i25) : i25
    %1 = llvm.and %arg0, %0  : i25
    %2 = llvm.uitofp %1 : i25 to f32
    %3 = llvm.fptoui %2 : f32 to i25
    llvm.return %3 : i25
  }
  llvm.func @overflow_masked_input(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(16777217 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.uitofp %1 : i32 to f32
    %3 = llvm.fptoui %2 : f32 to i32
    llvm.return %3 : i32
  }
  llvm.func @low_masked_input(%arg0: i25) -> i25 {
    %0 = llvm.mlir.constant(-2 : i25) : i25
    %1 = llvm.and %arg0, %0  : i25
    %2 = llvm.uitofp %1 : i25 to f32
    %3 = llvm.fptoui %2 : f32 to i25
    llvm.return %3 : i25
  }
  llvm.func @s32_half_s11(%arg0: i32) -> i11 {
    %0 = llvm.sitofp %arg0 : i32 to f16
    %1 = llvm.fptosi %0 : f16 to i11
    llvm.return %1 : i11
  }
  llvm.func @s32_half_u11(%arg0: i32) -> i11 {
    %0 = llvm.sitofp %arg0 : i32 to f16
    %1 = llvm.fptoui %0 : f16 to i11
    llvm.return %1 : i11
  }
  llvm.func @u32_half_s11(%arg0: i32) -> i11 {
    %0 = llvm.uitofp %arg0 : i32 to f16
    %1 = llvm.fptosi %0 : f16 to i11
    llvm.return %1 : i11
  }
  llvm.func @u32_half_u11(%arg0: i32) -> i11 {
    %0 = llvm.uitofp %arg0 : i32 to f16
    %1 = llvm.fptoui %0 : f16 to i11
    llvm.return %1 : i11
  }
  llvm.func @s32_half_s12(%arg0: i32) -> i12 {
    %0 = llvm.sitofp %arg0 : i32 to f16
    %1 = llvm.fptosi %0 : f16 to i12
    llvm.return %1 : i12
  }
  llvm.func @s32_half_u12(%arg0: i32) -> i12 {
    %0 = llvm.sitofp %arg0 : i32 to f16
    %1 = llvm.fptoui %0 : f16 to i12
    llvm.return %1 : i12
  }
  llvm.func @u32_half_s12(%arg0: i32) -> i12 {
    %0 = llvm.uitofp %arg0 : i32 to f16
    %1 = llvm.fptosi %0 : f16 to i12
    llvm.return %1 : i12
  }
  llvm.func @u32_half_u12(%arg0: i32) -> i12 {
    %0 = llvm.uitofp %arg0 : i32 to f16
    %1 = llvm.fptoui %0 : f16 to i12
    llvm.return %1 : i12
  }
  llvm.func @i8_vec_sitofp_test1(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1.280000e+02> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.sitofp %arg0 : vector<2xi8> to vector<2xf64>
    %2 = llvm.fcmp "ult" %1, %0 : vector<2xf64>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @i8_vec_sitofp_test2(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-1.281000e+02> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.sitofp %arg0 : vector<2xi8> to vector<2xf64>
    %2 = llvm.fcmp "ugt" %1, %0 : vector<2xf64>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @i8_vec_sitofp_test3(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1.270000e+02> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.sitofp %arg0 : vector<2xi8> to vector<2xf64>
    %2 = llvm.fcmp "ule" %1, %0 : vector<2xf64>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @i8_vec_sitofp_test4(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1.270000e+02> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.sitofp %arg0 : vector<2xi8> to vector<2xf64>
    %2 = llvm.fcmp "ult" %1, %0 : vector<2xf64>
    llvm.return %2 : vector<2xi1>
  }
}
