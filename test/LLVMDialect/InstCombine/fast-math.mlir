module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @fold(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.200000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.300000e+00 : f32) : f32
    %2 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %3 = llvm.fmul %2, %1  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %3 : f32
  }
  llvm.func @notfold(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.200000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.300000e+00 : f32) : f32
    %2 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %3 = llvm.fmul %2, %1  : f32
    llvm.return %3 : f32
  }
  llvm.func @fold2(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.200000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.300000e+00 : f32) : f32
    %2 = llvm.fmul %arg0, %0  : f32
    %3 = llvm.fmul %2, %1  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %3 : f32
  }
  llvm.func @fold3(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(5.000000e+00 : f64) : f64
    %1 = llvm.fmul %0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.fadd %arg0, %1  {fastmathFlags = #llvm.fastmath<fast>} : f64
    llvm.return %2 : f64
  }
  llvm.func @fold3_reassoc_nsz(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(5.000000e+00 : f64) : f64
    %1 = llvm.fmul %0, %arg0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f64
    %2 = llvm.fadd %arg0, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f64
    llvm.return %2 : f64
  }
  llvm.func @fold3_reassoc(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(5.000000e+00 : f64) : f64
    %1 = llvm.fmul %0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    %2 = llvm.fadd %arg0, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    llvm.return %2 : f64
  }
  llvm.func @fold4(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(4.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(5.000000e+00 : f32) : f32
    %2 = llvm.fsub %0, %arg0  : f32
    %3 = llvm.fsub %1, %arg1  : f32
    %4 = llvm.fadd %2, %3  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %4 : f32
  }
  llvm.func @fold4_reassoc_nsz(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(4.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(5.000000e+00 : f32) : f32
    %2 = llvm.fsub %0, %arg0  : f32
    %3 = llvm.fsub %1, %arg1  : f32
    %4 = llvm.fadd %2, %3  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %4 : f32
  }
  llvm.func @fold4_reassoc(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(4.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(5.000000e+00 : f32) : f32
    %2 = llvm.fsub %0, %arg0  : f32
    %3 = llvm.fsub %1, %arg1  : f32
    %4 = llvm.fadd %2, %3  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    llvm.return %4 : f32
  }
  llvm.func @fold5(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(4.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(5.000000e+00 : f32) : f32
    %2 = llvm.fadd %arg0, %0  : f32
    %3 = llvm.fadd %2, %1  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %3 : f32
  }
  llvm.func @fold5_reassoc_nsz(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(4.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(5.000000e+00 : f32) : f32
    %2 = llvm.fadd %arg0, %0  : f32
    %3 = llvm.fadd %2, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %3 : f32
  }
  llvm.func @fold5_reassoc(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(4.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(5.000000e+00 : f32) : f32
    %2 = llvm.fadd %arg0, %0  : f32
    %3 = llvm.fadd %2, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    llvm.return %3 : f32
  }
  llvm.func @fold6(%arg0: f32) -> f32 {
    %0 = llvm.fadd %arg0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %1 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %2 = llvm.fadd %1, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %2 : f32
  }
  llvm.func @fold6_reassoc_nsz(%arg0: f32) -> f32 {
    %0 = llvm.fadd %arg0, %arg0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    %1 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    %2 = llvm.fadd %1, %arg0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %2 : f32
  }
  llvm.func @fold6_reassoc(%arg0: f32) -> f32 {
    %0 = llvm.fadd %arg0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    %1 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    %2 = llvm.fadd %1, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    llvm.return %2 : f32
  }
  llvm.func @fold7(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(5.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %2 = llvm.fadd %arg0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %3 = llvm.fadd %1, %2  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %3 : f32
  }
  llvm.func @fold7_reassoc_nsz(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(5.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    %2 = llvm.fadd %arg0, %arg0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    %3 = llvm.fadd %1, %2  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %3 : f32
  }
  llvm.func @fold7_reassoc(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(5.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    %2 = llvm.fadd %arg0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    %3 = llvm.fadd %1, %2  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    llvm.return %3 : f32
  }
  llvm.func @fold8(%arg0: f32) -> f32 {
    %0 = llvm.fadd %arg0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %1 = llvm.fadd %arg0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %2 = llvm.fadd %0, %1  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %3 = llvm.fadd %2, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %3 : f32
  }
  llvm.func @fold8_reassoc_nsz(%arg0: f32) -> f32 {
    %0 = llvm.fadd %arg0, %arg0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    %1 = llvm.fadd %arg0, %arg0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    %2 = llvm.fadd %0, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    %3 = llvm.fadd %2, %arg0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %3 : f32
  }
  llvm.func @fold8_reassoc(%arg0: f32) -> f32 {
    %0 = llvm.fadd %arg0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    %1 = llvm.fadd %arg0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    %2 = llvm.fadd %0, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    %3 = llvm.fadd %2, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    llvm.return %3 : f32
  }
  llvm.func @fsub_fadd_common_op_fneg(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fadd %arg0, %arg1  : f32
    %1 = llvm.fsub %arg1, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %1 : f32
  }
  llvm.func @fsub_fadd_common_op_fneg_reassoc_nsz(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fadd %arg0, %arg1  : f32
    %1 = llvm.fsub %arg1, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %1 : f32
  }
  llvm.func @fsub_fadd_common_op_fneg_vec(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fadd %arg0, %arg1  : vector<2xf32>
    %1 = llvm.fsub %arg1, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }
  llvm.func @fsub_fadd_common_op_fneg_commute(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fadd %arg1, %arg0  : f32
    %1 = llvm.fsub %arg1, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %1 : f32
  }
  llvm.func @fsub_fadd_common_op_fneg_commute_vec(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fadd %arg1, %arg0  : vector<2xf32>
    %1 = llvm.fsub %arg1, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }
  llvm.func @fsub_fsub_common_op_fneg(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fsub %arg1, %arg0  : f32
    %1 = llvm.fsub %0, %arg1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %1 : f32
  }
  llvm.func @fsub_fsub_common_op_fneg_vec(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fsub %arg1, %arg0  : vector<2xf32>
    %1 = llvm.fsub %0, %arg1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }
  llvm.func @fold9_reassoc(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fadd %arg0, %arg1  : f32
    %1 = llvm.fsub %arg0, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    llvm.return %1 : f32
  }
  llvm.func @fold10(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(3.000000e+00 : f32) : f32
    %2 = llvm.fadd %0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %3 = llvm.fsub %arg1, %1  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %4 = llvm.fadd %2, %3  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %4 : f32
  }
  llvm.func @fold10_reassoc_nsz(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(3.000000e+00 : f32) : f32
    %2 = llvm.fadd %0, %arg0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    %3 = llvm.fsub %arg1, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    %4 = llvm.fadd %2, %3  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %4 : f32
  }
  llvm.func @fold10_reassoc(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(3.000000e+00 : f32) : f32
    %2 = llvm.fadd %0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    %3 = llvm.fsub %arg1, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    %4 = llvm.fadd %2, %3  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    llvm.return %4 : f32
  }
  llvm.func @fail1(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(-1.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %2 = llvm.fadd %1, %1  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %3 = llvm.fadd %2, %1  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %3 : f32
  }
  llvm.func @fail2(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f64
    %1 = llvm.fadd %arg0, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.fsub %0, %1  {fastmathFlags = #llvm.fastmath<fast>} : f64
    llvm.return %2 : f64
  }
  llvm.func @fsub_op0_fmul_const(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(7.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %0  : f32
    %2 = llvm.fsub %1, %arg0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %2 : f32
  }
  llvm.func @fsub_op0_fmul_const_vec(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<[7.000000e+00, -4.200000e+01]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fmul %arg0, %0  : vector<2xf32>
    %2 = llvm.fsub %1, %arg0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : vector<2xf32>
    llvm.return %2 : vector<2xf32>
  }
  llvm.func @fsub_op1_fmul_const(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(7.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %0  : f32
    %2 = llvm.fsub %arg0, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %2 : f32
  }
  llvm.func @fsub_op1_fmul_const_vec(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<[7.000000e+00, 0.000000e+00]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fmul %arg0, %0  : vector<2xf32>
    %2 = llvm.fsub %arg0, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : vector<2xf32>
    llvm.return %2 : vector<2xf32>
  }
  llvm.func @fsub_op0_fmul_const_wrong_FMF(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(7.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    %2 = llvm.fsub %1, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    llvm.return %2 : f32
  }
  llvm.func @fold16(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fcmp "ogt" %arg0, %arg1 : f32
    %1 = llvm.fadd %arg0, %arg1  : f32
    %2 = llvm.fsub %arg0, %arg1  : f32
    %3 = llvm.select %0, %1, %2 : i1, f32
    llvm.return %3 : f32
  }
  llvm.func @fneg1(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.fsub %0, %arg0  : f32
    %3 = llvm.fsub %1, %arg1  {fastmathFlags = #llvm.fastmath<nsz>} : f32
    %4 = llvm.fmul %2, %3  : f32
    llvm.return %4 : f32
  }
  llvm.func @fneg2(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  {fastmathFlags = #llvm.fastmath<nsz>} : f32
    llvm.return %1 : f32
  }
  llvm.func @fneg2_vec_poison(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.poison : f32
    %2 = llvm.mlir.undef : vector<2xf32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xf32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xf32>
    %7 = llvm.fsub %6, %arg0  {fastmathFlags = #llvm.fastmath<nsz>} : vector<2xf32>
    llvm.return %7 : vector<2xf32>
  }
  llvm.func @fdiv1(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.200000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.300000e+00 : f32) : f32
    %2 = llvm.fdiv %arg0, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %3 = llvm.fdiv %2, %1  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %3 : f32
  }
  llvm.func @fdiv2(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.200000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.300000e+00 : f32) : f32
    %2 = llvm.fmul %arg0, %0  : f32
    %3 = llvm.fdiv %2, %1  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %3 : f32
  }
  llvm.func @fdiv2_vec(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<[6.000000e+00, 9.000000e+00]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.mlir.constant(dense<[2.000000e+00, 3.000000e+00]> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.fmul %arg0, %0  : vector<2xf32>
    %3 = llvm.fdiv %2, %1  {fastmathFlags = #llvm.fastmath<fast>} : vector<2xf32>
    llvm.return %3 : vector<2xf32>
  }
  llvm.func @fdiv3(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(3.40282347E+38 : f32) : f32
    %1 = llvm.mlir.constant(2.300000e+00 : f32) : f32
    %2 = llvm.fdiv %arg0, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %3 = llvm.fdiv %2, %1  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %3 : f32
  }
  llvm.func @fdiv4(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(3.40282347E+38 : f32) : f32
    %1 = llvm.mlir.constant(2.000000e-01 : f32) : f32
    %2 = llvm.fmul %arg0, %0  : f32
    %3 = llvm.fdiv %2, %1  : f32
    llvm.return %3 : f32
  }
  llvm.func @sqrt_intrinsic_arg_squared(%arg0: f64) -> f64 {
    %0 = llvm.fmul %arg0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f64
    %1 = llvm.intr.sqrt(%0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @sqrt_intrinsic_three_args1(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.fmul %arg1, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f64
    %1 = llvm.fmul %0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.intr.sqrt(%1)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    llvm.return %2 : f64
  }
  llvm.func @sqrt_intrinsic_three_args2(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.fmul %arg0, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f64
    %1 = llvm.fmul %0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.intr.sqrt(%1)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    llvm.return %2 : f64
  }
  llvm.func @sqrt_intrinsic_three_args3(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.fmul %arg0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f64
    %1 = llvm.fmul %0, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.intr.sqrt(%1)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    llvm.return %2 : f64
  }
  llvm.func @sqrt_intrinsic_three_args4(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.fmul %arg1, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f64
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.intr.sqrt(%1)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    llvm.return %2 : f64
  }
  llvm.func @sqrt_intrinsic_three_args5(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.fmul %arg0, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f64
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.intr.sqrt(%1)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    llvm.return %2 : f64
  }
  llvm.func @sqrt_intrinsic_three_args6(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.fmul %arg0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f64
    %1 = llvm.fmul %arg1, %0  {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.intr.sqrt(%1)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    llvm.return %2 : f64
  }
  llvm.func @sqrt_intrinsic_not_so_fast(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.fmul %arg0, %arg0  : f64
    %1 = llvm.fmul %0, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.intr.sqrt(%1)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    llvm.return %2 : f64
  }
  llvm.func @sqrt_intrinsic_arg_4th(%arg0: f64) -> f64 {
    %0 = llvm.fmul %arg0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f64
    %1 = llvm.fmul %0, %0  {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.intr.sqrt(%1)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    llvm.return %2 : f64
  }
  llvm.func @sqrt_intrinsic_arg_5th(%arg0: f64) -> f64 {
    %0 = llvm.fmul %arg0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f64
    %1 = llvm.fmul %0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.fmul %1, %0  {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.intr.sqrt(%2)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    llvm.return %3 : f64
  }
  llvm.func @sqrtf(f32) -> f32
  llvm.func @sqrt(f64) -> f64
  llvm.func @sqrtl(f128) -> f128
  llvm.func @sqrt_call_squared_f32(%arg0: f32) -> f32 {
    %0 = llvm.fmul %arg0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %1 = llvm.call @sqrtf(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @sqrt_call_squared_f64(%arg0: f64) -> f64 {
    %0 = llvm.fmul %arg0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f64
    %1 = llvm.call @sqrt(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @sqrt_call_squared_f128(%arg0: f128) -> f128 {
    %0 = llvm.fmul %arg0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f128
    %1 = llvm.call @sqrtl(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f128) -> f128
    llvm.return %1 : f128
  }
  llvm.func @fmax(f64, f64) -> f64
  llvm.func @fmin(f64, f64) -> f64
  llvm.func @fmaxf(f32, f32) -> f32
  llvm.func @fminf(f32, f32) -> f32
  llvm.func @fmaxl(f128, f128) -> f128
  llvm.func @fminl(f128, f128) -> f128
  llvm.func @max1(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.call @fmax(%0, %1) {fastmathFlags = #llvm.fastmath<fast>} : (f64, f64) -> f64
    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }
  llvm.func @fmax_no_fmf(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.call @fmaxf(%arg0, %arg1) : (f32, f32) -> f32
    llvm.return %0 : f32
  }
  llvm.func @max2(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.call @fmaxf(%arg0, %arg1) {fastmathFlags = #llvm.fastmath<nnan>} : (f32, f32) -> f32
    llvm.return %0 : f32
  }
  llvm.func @max3(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.call @fmax(%arg0, %arg1) {fastmathFlags = #llvm.fastmath<fast>} : (f64, f64) -> f64
    llvm.return %0 : f64
  }
  llvm.func @max4(%arg0: f128, %arg1: f128) -> f128 {
    %0 = llvm.call @fmaxl(%arg0, %arg1) {fastmathFlags = #llvm.fastmath<nnan>} : (f128, f128) -> f128
    llvm.return %0 : f128
  }
  llvm.func @min1(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.call @fmin(%0, %1) {fastmathFlags = #llvm.fastmath<nnan>} : (f64, f64) -> f64
    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }
  llvm.func @fmin_no_fmf(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.call @fminf(%arg0, %arg1) : (f32, f32) -> f32
    llvm.return %0 : f32
  }
  llvm.func @min2(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.call @fminf(%arg0, %arg1) {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32) -> f32
    llvm.return %0 : f32
  }
  llvm.func @min3(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.call @fmin(%arg0, %arg1) {fastmathFlags = #llvm.fastmath<nnan>} : (f64, f64) -> f64
    llvm.return %0 : f64
  }
  llvm.func @min4(%arg0: f128, %arg1: f128) -> f128 {
    %0 = llvm.call @fminl(%arg0, %arg1) {fastmathFlags = #llvm.fastmath<fast>} : (f128, f128) -> f128
    llvm.return %0 : f128
  }
  llvm.func @test55(%arg0: i1, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    llvm.cond_br %arg0, ^bb2(%0 : f32), ^bb1
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%arg1 : f32)
  ^bb2(%2: f32):  // 2 preds: ^bb0, ^bb1
    %3 = llvm.fadd %2, %1  : f32
    llvm.return %3 : f32
  }
}
