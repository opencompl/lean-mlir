module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test_fmul(%arg0: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %1 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+05, -3.000000e+00, 4.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %2 = llvm.fmul %arg0, %0  : vector<4xf32>
    %3 = llvm.fmul %2, %1  : vector<4xf32>
    llvm.return %3 : vector<4xf32>
  }
  llvm.func @test_fmul_fast(%arg0: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %1 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+05, -3.000000e+00, 4.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %2 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<fast>} : vector<4xf32>
    %3 = llvm.fmul %2, %1  {fastmathFlags = #llvm.fastmath<fast>} : vector<4xf32>
    llvm.return %3 : vector<4xf32>
  }
  llvm.func @test_fmul_reassoc_nsz(%arg0: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %1 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+05, -3.000000e+00, 4.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %2 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : vector<4xf32>
    %3 = llvm.fmul %2, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : vector<4xf32>
    llvm.return %3 : vector<4xf32>
  }
  llvm.func @test_fmul_reassoc(%arg0: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %1 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+05, -3.000000e+00, 4.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %2 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : vector<4xf32>
    %3 = llvm.fmul %2, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : vector<4xf32>
    llvm.return %3 : vector<4xf32>
  }
  llvm.func @test_fadd(%arg0: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %1 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, -3.000000e+00, 4.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %2 = llvm.fadd %arg0, %0  : vector<4xf32>
    %3 = llvm.fadd %2, %1  : vector<4xf32>
    llvm.return %3 : vector<4xf32>
  }
  llvm.func @test_fadd_fast(%arg0: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %1 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, -3.000000e+00, 4.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %2 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<fast>} : vector<4xf32>
    %3 = llvm.fadd %2, %1  {fastmathFlags = #llvm.fastmath<fast>} : vector<4xf32>
    llvm.return %3 : vector<4xf32>
  }
  llvm.func @test_fadd_reassoc_nsz(%arg0: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %1 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, -3.000000e+00, 4.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %2 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : vector<4xf32>
    %3 = llvm.fadd %2, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : vector<4xf32>
    llvm.return %3 : vector<4xf32>
  }
  llvm.func @test_fadd_reassoc(%arg0: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %1 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, -3.000000e+00, 4.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %2 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : vector<4xf32>
    %3 = llvm.fadd %2, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : vector<4xf32>
    llvm.return %3 : vector<4xf32>
  }
  llvm.func @test_fadds_cancel_(%arg0: vector<4xf32>, %arg1: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %1 = llvm.mlir.constant(dense<[-1.000000e+00, -2.000000e+00, -3.000000e+00, -4.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %2 = llvm.fadd %arg0, %0  : vector<4xf32>
    %3 = llvm.fadd %arg1, %1  : vector<4xf32>
    %4 = llvm.fadd %2, %3  : vector<4xf32>
    llvm.return %4 : vector<4xf32>
  }
  llvm.func @test_fadds_cancel_fast(%arg0: vector<4xf32>, %arg1: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %1 = llvm.mlir.constant(dense<[-1.000000e+00, -2.000000e+00, -3.000000e+00, -4.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %2 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<fast>} : vector<4xf32>
    %3 = llvm.fadd %arg1, %1  {fastmathFlags = #llvm.fastmath<fast>} : vector<4xf32>
    %4 = llvm.fadd %2, %3  {fastmathFlags = #llvm.fastmath<fast>} : vector<4xf32>
    llvm.return %4 : vector<4xf32>
  }
  llvm.func @test_fadds_cancel_reassoc_nsz(%arg0: vector<4xf32>, %arg1: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %1 = llvm.mlir.constant(dense<[-1.000000e+00, -2.000000e+00, -3.000000e+00, -4.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %2 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : vector<4xf32>
    %3 = llvm.fadd %arg1, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : vector<4xf32>
    %4 = llvm.fadd %2, %3  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : vector<4xf32>
    llvm.return %4 : vector<4xf32>
  }
  llvm.func @test_fadds_cancel_reassoc(%arg0: vector<4xf32>, %arg1: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %1 = llvm.mlir.constant(dense<[-1.000000e+00, -2.000000e+00, -3.000000e+00, -4.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %2 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : vector<4xf32>
    %3 = llvm.fadd %arg1, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : vector<4xf32>
    %4 = llvm.fadd %2, %3  {fastmathFlags = #llvm.fastmath<reassoc>} : vector<4xf32>
    llvm.return %4 : vector<4xf32>
  }
}
