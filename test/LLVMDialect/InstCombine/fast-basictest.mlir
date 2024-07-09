module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test1(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-1.200000e+01 : f32) : f32
    %1 = llvm.mlir.constant(1.200000e+01 : f32) : f32
    %2 = llvm.fsub %0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %3 = llvm.fadd %2, %1  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %3 : f32
  }
  llvm.func @test1_minimal(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-1.200000e+01 : f32) : f32
    %1 = llvm.mlir.constant(1.200000e+01 : f32) : f32
    %2 = llvm.fsub %0, %arg0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    %3 = llvm.fadd %2, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %3 : f32
  }
  llvm.func @test1_reassoc(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-1.200000e+01 : f32) : f32
    %1 = llvm.mlir.constant(1.200000e+01 : f32) : f32
    %2 = llvm.fsub %0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    %3 = llvm.fadd %2, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    llvm.return %3 : f32
  }
  llvm.func @test2(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(-3.000000e+01 : f32) : f32
    %1 = llvm.mlir.constant(3.000000e+01 : f32) : f32
    %2 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %3 = llvm.fadd %2, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %4 = llvm.fadd %3, %1  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %4 : f32
  }
  llvm.func @test2_no_FMF(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(-3.000000e+01 : f32) : f32
    %1 = llvm.mlir.constant(3.000000e+01 : f32) : f32
    %2 = llvm.fadd %arg0, %0  : f32
    %3 = llvm.fadd %2, %arg1  : f32
    %4 = llvm.fadd %3, %1  : f32
    llvm.return %4 : f32
  }
  llvm.func @test2_reassoc(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(-3.000000e+01 : f32) : f32
    %1 = llvm.mlir.constant(3.000000e+01 : f32) : f32
    %2 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    %3 = llvm.fadd %2, %arg1  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    %4 = llvm.fadd %3, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    llvm.return %4 : f32
  }
  llvm.func @test7(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %2 = llvm.fmul %1, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %3 = llvm.fadd %2, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %3 : f32
  }
  llvm.func @test7_unary_fneg(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %1 = llvm.fmul %0, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %2 = llvm.fadd %1, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %2 : f32
  }
  llvm.func @test7_reassoc_nsz(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    %2 = llvm.fmul %1, %arg1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    %3 = llvm.fadd %2, %arg2  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %3 : f32
  }
  llvm.func @test7_reassoc(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    %2 = llvm.fmul %1, %arg1  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    %3 = llvm.fadd %2, %arg2  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    llvm.return %3 : f32
  }
  llvm.func @test8(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(4.700000e+01 : f32) : f32
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %2 = llvm.fadd %1, %1  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %2 : f32
  }
  llvm.func @test8_reassoc_nsz(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(4.700000e+01 : f32) : f32
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    %2 = llvm.fadd %1, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %2 : f32
  }
  llvm.func @test8_reassoc(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(4.700000e+01 : f32) : f32
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    %2 = llvm.fadd %1, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    llvm.return %2 : f32
  }
  llvm.func @test9(%arg0: f32) -> f32 {
    %0 = llvm.fadd %arg0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %1 = llvm.fadd %0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %2 = llvm.fadd %1, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %2 : f32
  }
  llvm.func @test9_reassoc_nsz(%arg0: f32) -> f32 {
    %0 = llvm.fadd %arg0, %arg0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    %1 = llvm.fadd %0, %arg0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    %2 = llvm.fadd %1, %arg0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %2 : f32
  }
  llvm.func @test9_reassoc(%arg0: f32) -> f32 {
    %0 = llvm.fadd %arg0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    %1 = llvm.fadd %0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    %2 = llvm.fadd %1, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    llvm.return %2 : f32
  }
  llvm.func @test10(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.270000e+02 : f32) : f32
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %2 = llvm.fadd %1, %1  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %3 = llvm.fadd %2, %1  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %3 : f32
  }
  llvm.func @test10_reassoc_nsz(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.270000e+02 : f32) : f32
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    %2 = llvm.fadd %1, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    %3 = llvm.fadd %2, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %3 : f32
  }
  llvm.func @test10_reassoc(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.270000e+02 : f32) : f32
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    %2 = llvm.fadd %1, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    %3 = llvm.fadd %2, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    llvm.return %3 : f32
  }
  llvm.func @test11(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %2 = llvm.mlir.constant(3.000000e+00 : f32) : f32
    %3 = llvm.fsub %0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %4 = llvm.fsub %1, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %5 = llvm.fsub %2, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %6 = llvm.fadd %3, %4  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %7 = llvm.fadd %6, %5  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %7 : f32
  }
  llvm.func @test11_reassoc_nsz(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %2 = llvm.mlir.constant(3.000000e+00 : f32) : f32
    %3 = llvm.fsub %0, %arg0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    %4 = llvm.fsub %1, %arg0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    %5 = llvm.fsub %2, %arg0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    %6 = llvm.fadd %3, %4  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    %7 = llvm.fadd %6, %5  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %7 : f32
  }
  llvm.func @test11_reassoc(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %2 = llvm.mlir.constant(3.000000e+00 : f32) : f32
    %3 = llvm.fsub %0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    %4 = llvm.fsub %1, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    %5 = llvm.fsub %2, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    %6 = llvm.fadd %3, %4  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    %7 = llvm.fadd %6, %5  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    llvm.return %7 : f32
  }
  llvm.func @test12(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %2 = llvm.fmul %1, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %3 = llvm.fmul %arg0, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %4 = llvm.fadd %2, %3  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %4 : f32
  }
  llvm.func @test12_unary_fneg(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %1 = llvm.fmul %0, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %2 = llvm.fmul %arg0, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %3 = llvm.fadd %1, %2  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %3 : f32
  }
  llvm.func @test12_reassoc_nsz(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    %2 = llvm.fmul %1, %arg1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    %3 = llvm.fmul %arg0, %arg2  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    %4 = llvm.fadd %2, %3  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %4 : f32
  }
  llvm.func @test12_reassoc(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    %2 = llvm.fmul %1, %arg1  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    %3 = llvm.fmul %arg0, %arg2  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    %4 = llvm.fadd %2, %3  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    llvm.return %4 : f32
  }
  llvm.func @test13(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(4.700000e+01 : f32) : f32
    %1 = llvm.mlir.constant(-4.700000e+01 : f32) : f32
    %2 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %3 = llvm.fmul %arg1, %1  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %4 = llvm.fadd %2, %3  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %4 : f32
  }
  llvm.func @test13_reassoc_nsz(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(4.700000e+01 : f32) : f32
    %1 = llvm.mlir.constant(-4.700000e+01 : f32) : f32
    %2 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    %3 = llvm.fmul %arg1, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    %4 = llvm.fadd %2, %3  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %4 : f32
  }
  llvm.func @test13_reassoc(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(4.700000e+01 : f32) : f32
    %1 = llvm.mlir.constant(-4.700000e+01 : f32) : f32
    %2 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    %3 = llvm.fmul %arg1, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    %4 = llvm.fadd %2, %3  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    llvm.return %4 : f32
  }
  llvm.func @test14(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.200000e+01 : f32) : f32
    %1 = llvm.fmul %0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %2 = llvm.fmul %1, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %2 : f32
  }
  llvm.func @test14_reassoc(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.200000e+01 : f32) : f32
    %1 = llvm.fmul %0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    %2 = llvm.fmul %1, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    llvm.return %2 : f32
  }
  llvm.func @test15(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(1.234000e+03 : f32) : f32
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.fadd %arg1, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %3 = llvm.fadd %arg0, %2  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %4 = llvm.fsub %1, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %5 = llvm.fadd %3, %4  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %5 : f32
  }
  llvm.func @test15_unary_fneg(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(1.234000e+03 : f32) : f32
    %1 = llvm.fadd %arg1, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %2 = llvm.fadd %arg0, %1  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %3 = llvm.fneg %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %4 = llvm.fadd %2, %3  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %4 : f32
  }
  llvm.func @test15_reassoc_nsz(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(1.234000e+03 : f32) : f32
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.fadd %arg1, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    %3 = llvm.fadd %arg0, %2  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    %4 = llvm.fsub %1, %arg1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    %5 = llvm.fadd %3, %4  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %5 : f32
  }
  llvm.func @test15_reassoc(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(1.234000e+03 : f32) : f32
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.fadd %arg1, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    %3 = llvm.fadd %arg0, %2  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    %4 = llvm.fsub %1, %arg1  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    %5 = llvm.fadd %3, %4  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    llvm.return %5 : f32
  }
  llvm.func @test16(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(1.234500e+04 : f32) : f32
    %2 = llvm.fsub %0, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %3 = llvm.fmul %arg0, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %4 = llvm.fmul %2, %3  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %5 = llvm.fmul %4, %1  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %6 = llvm.fsub %0, %5  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %6 : f32
  }
  llvm.func @test16_unary_fneg(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(1.234500e+04 : f32) : f32
    %1 = llvm.fneg %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %2 = llvm.fmul %arg0, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %3 = llvm.fmul %1, %2  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %4 = llvm.fmul %3, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %5 = llvm.fneg %4  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %5 : f32
  }
  llvm.func @test16_reassoc_nsz(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(1.234500e+04 : f32) : f32
    %2 = llvm.fsub %0, %arg2  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    %3 = llvm.fmul %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    %4 = llvm.fmul %2, %3  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    %5 = llvm.fmul %4, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    %6 = llvm.fsub %0, %5  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %6 : f32
  }
  llvm.func @test16_reassoc(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(1.234500e+04 : f32) : f32
    %2 = llvm.fsub %0, %arg2  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    %3 = llvm.fmul %arg0, %arg1  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    %4 = llvm.fmul %2, %3  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    %5 = llvm.fmul %4, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    %6 = llvm.fsub %0, %5  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    llvm.return %6 : f32
  }
  llvm.func @test17(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(4.000000e+01 : f32) : f32
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.fmul %arg2, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %3 = llvm.fsub %1, %2  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %4 = llvm.fmul %arg0, %3  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %5 = llvm.fsub %1, %4  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %5 : f32
  }
  llvm.func @test17_unary_fneg(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(4.000000e+01 : f32) : f32
    %1 = llvm.fmul %arg2, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %2 = llvm.fneg %1  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %3 = llvm.fmul %arg0, %2  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %4 = llvm.fneg %3  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %4 : f32
  }
  llvm.func @test17_reassoc_nsz(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(4.000000e+01 : f32) : f32
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.fmul %arg2, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    %3 = llvm.fsub %1, %2  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    %4 = llvm.fmul %arg0, %3  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    %5 = llvm.fsub %1, %4  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %5 : f32
  }
  llvm.func @test17_reassoc(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(4.000000e+01 : f32) : f32
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.fmul %arg2, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    %3 = llvm.fsub %1, %2  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    %4 = llvm.fmul %arg0, %3  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    %5 = llvm.fsub %1, %4  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    llvm.return %5 : f32
  }
  llvm.func @test17_unary_fneg_no_FMF(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(4.000000e+01 : f32) : f32
    %1 = llvm.fmul %arg2, %0  : f32
    %2 = llvm.fneg %1  : f32
    %3 = llvm.fmul %arg0, %2  : f32
    %4 = llvm.fneg %3  : f32
    llvm.return %4 : f32
  }
  llvm.func @test17_reassoc_unary_fneg(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(4.000000e+01 : f32) : f32
    %1 = llvm.fmul %arg2, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    %2 = llvm.fneg %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    %3 = llvm.fmul %arg0, %2  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    %4 = llvm.fneg %3  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    llvm.return %4 : f32
  }
  llvm.func @test18(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(-1.200000e+01 : f32) : f32
    %1 = llvm.mlir.constant(1.200000e+01 : f32) : f32
    %2 = llvm.fadd %0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %3 = llvm.fsub %2, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %4 = llvm.fadd %3, %1  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %4 : f32
  }
  llvm.func @test18_reassoc(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(-1.200000e+01 : f32) : f32
    %1 = llvm.mlir.constant(1.200000e+01 : f32) : f32
    %2 = llvm.fadd %0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    %3 = llvm.fsub %2, %arg1  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    %4 = llvm.fadd %3, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    llvm.return %4 : f32
  }
  llvm.func @test19(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %1 = llvm.fsub %0, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %2 = llvm.fsub %1, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %2 : f32
  }
  llvm.func @test19_reassoc_nsz(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    %1 = llvm.fsub %0, %arg2  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    %2 = llvm.fsub %1, %arg0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %2 : f32
  }
  llvm.func @test19_reassoc(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    %1 = llvm.fsub %0, %arg2  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    %2 = llvm.fsub %1, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    llvm.return %2 : f32
  }
}
