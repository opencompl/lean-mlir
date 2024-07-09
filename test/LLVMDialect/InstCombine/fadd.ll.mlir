module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use(f32)
  llvm.func @use_vec(vector<2xf32>)
  llvm.func @fneg_op0(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  : f32
    %2 = llvm.fadd %1, %arg1  : f32
    llvm.return %2 : f32
  }
  llvm.func @fneg_op1(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg1  : f32
    %2 = llvm.fadd %arg0, %1  : f32
    llvm.return %2 : f32
  }
  llvm.func @fdiv_fneg1(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.mlir.constant(4.200000e+01 : f64) : f64
    %1 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %2 = llvm.frem %0, %arg2  : f64
    %3 = llvm.fsub %1, %arg0  : f64
    %4 = llvm.fdiv %3, %arg1  : f64
    %5 = llvm.fadd %2, %4  : f64
    llvm.return %5 : f64
  }
  llvm.func @fdiv_fneg2(%arg0: vector<2xf64>, %arg1: vector<2xf64>, %arg2: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<[4.200000e+01, 8.000000e+00]> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.mlir.constant(dense<-0.000000e+00> : vector<2xf64>) : vector<2xf64>
    %2 = llvm.frem %0, %arg2  : vector<2xf64>
    %3 = llvm.fsub %1, %arg0  : vector<2xf64>
    %4 = llvm.fdiv %arg1, %3  : vector<2xf64>
    %5 = llvm.fadd %2, %4  : vector<2xf64>
    llvm.return %5 : vector<2xf64>
  }
  llvm.func @fmul_fneg1(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.mlir.constant(4.200000e+01 : f64) : f64
    %1 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %2 = llvm.frem %0, %arg2  : f64
    %3 = llvm.fsub %1, %arg0  : f64
    %4 = llvm.fmul %3, %arg1  : f64
    %5 = llvm.fadd %2, %4  : f64
    llvm.return %5 : f64
  }
  llvm.func @fmul_fneg2(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.mlir.constant(-4.200000e+01 : f64) : f64
    %1 = llvm.mlir.constant(4.200000e+01 : f64) : f64
    %2 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %3 = llvm.frem %0, %arg1  : f64
    %4 = llvm.frem %1, %arg2  : f64
    %5 = llvm.fsub %2, %arg0  : f64
    %6 = llvm.fmul %3, %5  : f64
    %7 = llvm.fadd %4, %6  : f64
    llvm.return %7 : f64
  }
  llvm.func @fdiv_fneg1_commute(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.mlir.constant(4.200000e+01 : f64) : f64
    %1 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %2 = llvm.frem %0, %arg2  : f64
    %3 = llvm.fsub %1, %arg0  : f64
    %4 = llvm.fdiv %3, %arg1  : f64
    %5 = llvm.fadd %4, %2  : f64
    llvm.return %5 : f64
  }
  llvm.func @fdiv_fneg2_commute(%arg0: vector<2xf64>, %arg1: vector<2xf64>, %arg2: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<[4.200000e+01, 8.000000e+00]> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.mlir.constant(dense<-0.000000e+00> : vector<2xf64>) : vector<2xf64>
    %2 = llvm.frem %0, %arg2  : vector<2xf64>
    %3 = llvm.fsub %1, %arg0  : vector<2xf64>
    %4 = llvm.fdiv %arg1, %3  : vector<2xf64>
    %5 = llvm.fadd %4, %2  : vector<2xf64>
    llvm.return %5 : vector<2xf64>
  }
  llvm.func @fmul_fneg1_commute(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.mlir.constant(4.200000e+01 : f64) : f64
    %1 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %2 = llvm.frem %0, %arg2  : f64
    %3 = llvm.fsub %1, %arg0  : f64
    %4 = llvm.fmul %3, %arg1  : f64
    %5 = llvm.fadd %4, %2  : f64
    llvm.return %5 : f64
  }
  llvm.func @fmul_fneg2_commute(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.mlir.constant(4.100000e+01 : f64) : f64
    %1 = llvm.mlir.constant(4.200000e+01 : f64) : f64
    %2 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %3 = llvm.frem %0, %arg1  : f64
    %4 = llvm.frem %1, %arg2  : f64
    %5 = llvm.fsub %2, %arg0  : f64
    %6 = llvm.fmul %3, %5  : f64
    %7 = llvm.fadd %6, %4  : f64
    llvm.return %7 : f64
  }
  llvm.func @fdiv_fneg1_extra_use(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %1 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %2 = llvm.frem %0, %arg2  : f32
    %3 = llvm.fsub %1, %arg0  : f32
    %4 = llvm.fdiv %3, %arg1  : f32
    llvm.call @use(%4) : (f32) -> ()
    %5 = llvm.fadd %2, %4  : f32
    llvm.return %5 : f32
  }
  llvm.func @fdiv_fneg2_extra_use(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-4.200000e+01 : f32) : f32
    %1 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %2 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %3 = llvm.frem %0, %arg1  : f32
    %4 = llvm.frem %1, %arg2  : f32
    %5 = llvm.fsub %2, %arg0  : f32
    %6 = llvm.fdiv %3, %5  : f32
    llvm.call @use(%6) : (f32) -> ()
    %7 = llvm.fadd %4, %6  : f32
    llvm.return %7 : f32
  }
  llvm.func @fmul_fneg1_extra_use(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<[4.200000e+01, -1.000000e+00]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.mlir.constant(dense<-0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.frem %0, %arg2  : vector<2xf32>
    %3 = llvm.fsub %1, %arg0  : vector<2xf32>
    %4 = llvm.fmul %3, %arg1  : vector<2xf32>
    llvm.call @use_vec(%4) : (vector<2xf32>) -> ()
    %5 = llvm.fadd %2, %4  : vector<2xf32>
    llvm.return %5 : vector<2xf32>
  }
  llvm.func @fmul_fneg2_extra_use(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-4.200000e+01 : f32) : f32
    %1 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %2 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %3 = llvm.frem %0, %arg1  : f32
    %4 = llvm.frem %1, %arg2  : f32
    %5 = llvm.fsub %2, %arg0  : f32
    %6 = llvm.fmul %3, %5  : f32
    llvm.call @use(%6) : (f32) -> ()
    %7 = llvm.fadd %4, %6  : f32
    llvm.return %7 : f32
  }
  llvm.func @fdiv_fneg1_extra_use2(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  : f32
    llvm.call @use(%1) : (f32) -> ()
    %2 = llvm.fdiv %1, %arg1  : f32
    %3 = llvm.fadd %2, %arg2  : f32
    llvm.return %3 : f32
  }
  llvm.func @fdiv_fneg2_extra_use2(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  : f32
    llvm.call @use(%1) : (f32) -> ()
    %2 = llvm.fdiv %arg1, %1  : f32
    %3 = llvm.fadd %2, %arg2  : f32
    llvm.return %3 : f32
  }
  llvm.func @fmul_fneg1_extra_use2(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<-0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fsub %0, %arg0  : vector<2xf32>
    llvm.call @use_vec(%1) : (vector<2xf32>) -> ()
    %2 = llvm.fmul %1, %arg1  : vector<2xf32>
    %3 = llvm.fadd %2, %arg2  : vector<2xf32>
    llvm.return %3 : vector<2xf32>
  }
  llvm.func @fmul_fneg2_extra_use2(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-4.200000e+01 : f32) : f32
    %1 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %2 = llvm.frem %0, %arg1  : f32
    %3 = llvm.fsub %1, %arg0  : f32
    llvm.call @use(%3) : (f32) -> ()
    %4 = llvm.fmul %2, %3  : f32
    %5 = llvm.fadd %4, %arg2  : f32
    llvm.return %5 : f32
  }
  llvm.func @fdiv_fneg1_extra_use3(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  : f32
    llvm.call @use(%1) : (f32) -> ()
    %2 = llvm.fdiv %1, %arg1  : f32
    llvm.call @use(%2) : (f32) -> ()
    %3 = llvm.fadd %2, %arg2  : f32
    llvm.return %3 : f32
  }
  llvm.func @fdiv_fneg2_extra_use3(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  : f32
    llvm.call @use(%1) : (f32) -> ()
    %2 = llvm.fdiv %arg1, %1  : f32
    llvm.call @use(%2) : (f32) -> ()
    %3 = llvm.fadd %2, %arg2  : f32
    llvm.return %3 : f32
  }
  llvm.func @fmul_fneg1_extra_use3(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<-0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fsub %0, %arg0  : vector<2xf32>
    llvm.call @use_vec(%1) : (vector<2xf32>) -> ()
    %2 = llvm.fmul %1, %arg1  : vector<2xf32>
    llvm.call @use_vec(%2) : (vector<2xf32>) -> ()
    %3 = llvm.fadd %2, %arg2  : vector<2xf32>
    llvm.return %3 : vector<2xf32>
  }
  llvm.func @fmul_fneg2_extra_use3(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-4.200000e+01 : f32) : f32
    %1 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %2 = llvm.frem %0, %arg1  : f32
    %3 = llvm.fsub %1, %arg0  : f32
    llvm.call @use(%3) : (f32) -> ()
    %4 = llvm.fmul %2, %3  : f32
    llvm.call @use(%4) : (f32) -> ()
    %5 = llvm.fadd %4, %arg2  : f32
    llvm.return %5 : f32
  }
  llvm.func @fadd_rdx(%arg0: f32, %arg1: vector<4xf32>) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = "llvm.intr.vector.reduce.fadd"(%0, %arg1) <{fastmathFlags = #llvm.fastmath<fast>}> : (f32, vector<4xf32>) -> f32
    %2 = llvm.fadd %1, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %2 : f32
  }
  llvm.func @fadd_rdx_commute(%arg0: f32, %arg1: vector<4xf32>) -> f32 {
    %0 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %1 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %2 = llvm.fdiv %0, %arg0  : f32
    %3 = "llvm.intr.vector.reduce.fadd"(%1, %arg1) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, vector<4xf32>) -> f32
    %4 = llvm.fadd %2, %3  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %4 : f32
  }
  llvm.func @fadd_rdx_fmf(%arg0: f32, %arg1: vector<4xf32>) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = "llvm.intr.vector.reduce.fadd"(%0, %arg1) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, vector<4xf32>) -> f32
    %2 = llvm.fadd %1, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    llvm.return %2 : f32
  }
  llvm.func @fadd_rdx_extra_use(%arg0: f32, %arg1: vector<4xf32>) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = "llvm.intr.vector.reduce.fadd"(%0, %arg1) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, vector<4xf32>) -> f32
    llvm.call @use(%1) : (f32) -> ()
    %2 = llvm.fadd %1, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %2 : f32
  }
  llvm.func @fadd_rdx_nonzero_start_const_op(%arg0: vector<4xf32>) -> f32 {
    %0 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %1 = llvm.mlir.constant(-9.000000e+00 : f32) : f32
    %2 = "llvm.intr.vector.reduce.fadd"(%0, %arg0) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, vector<4xf32>) -> f32
    %3 = llvm.fadd %2, %1  {fastmathFlags = #llvm.fastmath<ninf, nsz, reassoc>} : f32
    llvm.return %3 : f32
  }
  llvm.func @fadd_rdx_nonzero_start_variable_op(%arg0: f32, %arg1: vector<4xf32>) -> f32 {
    %0 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %1 = "llvm.intr.vector.reduce.fadd"(%0, %arg1) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, vector<4xf32>) -> f32
    %2 = llvm.fadd %1, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %2 : f32
  }
  llvm.func @fadd_fmul_common_op(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    %2 = llvm.fadd %1, %arg0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %2 : f32
  }
  llvm.func @fadd_fmul_common_op_vec(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<4.200000e+01> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : vector<2xf32>
    %2 = llvm.fadd %1, %arg0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : vector<2xf32>
    llvm.return %2 : vector<2xf32>
  }
  llvm.func @fadd_fmul_common_op_commute_vec(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<[4.200000e+01, -4.300000e+01]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fmul %arg0, %arg0  : vector<2xf32>
    %2 = llvm.fmul %1, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : vector<2xf32>
    %3 = llvm.fadd %1, %2  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : vector<2xf32>
    llvm.return %3 : vector<2xf32>
  }
  llvm.func @fadd_fmul_common_op_use(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.call @use(%1) : (f32) -> ()
    %2 = llvm.fadd %1, %arg0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %2 : f32
  }
  llvm.func @fadd_fmul_common_op_wrong_fmf(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<ninf, nsz>} : f32
    %2 = llvm.fadd %1, %arg0  {fastmathFlags = #llvm.fastmath<ninf, nsz>} : f32
    llvm.return %2 : f32
  }
  llvm.func @fadd_fneg_reass_commute0(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.call @use(%0) : (f32) -> ()
    %1 = llvm.fsub %0, %arg1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    %2 = llvm.fadd %arg0, %arg2  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    %3 = llvm.fadd %1, %2  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %3 : f32
  }
  llvm.func @fadd_fneg_reass_commute1(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f32
    llvm.call @use(%0) : (f32) -> ()
    %1 = llvm.fsub %0, %arg1  : f32
    llvm.call @use(%1) : (f32) -> ()
    %2 = llvm.fadd %arg0, %arg2  : f32
    %3 = llvm.fadd %2, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %3 : f32
  }
  llvm.func @fadd_fneg_reass_commute2(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f32
    llvm.call @use(%0) : (f32) -> ()
    %1 = llvm.fsub %0, %arg1  : f32
    llvm.call @use(%1) : (f32) -> ()
    %2 = llvm.fadd %arg2, %arg0  : f32
    llvm.call @use(%2) : (f32) -> ()
    %3 = llvm.fadd %1, %2  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %3 : f32
  }
  llvm.func @fadd_fneg_reass_commute3(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : vector<2xf32>
    llvm.call @use_vec(%0) : (vector<2xf32>) -> ()
    %1 = llvm.fsub %0, %arg1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : vector<2xf32>
    %2 = llvm.fadd %arg2, %arg0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : vector<2xf32>
    %3 = llvm.fadd %2, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : vector<2xf32>
    llvm.return %3 : vector<2xf32>
  }
  llvm.func @fadd_fneg_commute0(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f32
    llvm.call @use(%0) : (f32) -> ()
    %1 = llvm.fsub %0, %arg1  : f32
    %2 = llvm.fadd %arg0, %arg2  : f32
    %3 = llvm.fadd %1, %2  {fastmathFlags = #llvm.fastmath<nsz>} : f32
    llvm.return %3 : f32
  }
  llvm.func @fadd_reduce_sqr_sum_varA(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %arg0  : f32
    %2 = llvm.fmul %arg0, %0  : f32
    %3 = llvm.fadd %2, %arg1  : f32
    %4 = llvm.fmul %3, %arg1  : f32
    %5 = llvm.fadd %4, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %5 : f32
  }
  llvm.func @fadd_reduce_sqr_sum_varA_order2(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %arg0  : f32
    %2 = llvm.fmul %arg0, %0  : f32
    %3 = llvm.fadd %2, %arg1  : f32
    %4 = llvm.fmul %3, %arg1  : f32
    %5 = llvm.fadd %1, %4  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %5 : f32
  }
  llvm.func @fadd_reduce_sqr_sum_varA_order3(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %arg0  : f32
    %2 = llvm.fmul %arg0, %0  : f32
    %3 = llvm.fadd %2, %arg1  : f32
    %4 = llvm.fmul %arg1, %3  : f32
    %5 = llvm.fadd %4, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %5 : f32
  }
  llvm.func @fadd_reduce_sqr_sum_varA_order4(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %arg0  : f32
    %2 = llvm.fmul %arg0, %0  : f32
    %3 = llvm.fadd %arg1, %2  : f32
    %4 = llvm.fmul %3, %arg1  : f32
    %5 = llvm.fadd %4, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %5 : f32
  }
  llvm.func @fadd_reduce_sqr_sum_varA_order5(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %arg0  : f32
    %2 = llvm.fmul %0, %arg0  : f32
    %3 = llvm.fadd %2, %arg1  : f32
    %4 = llvm.fmul %3, %arg1  : f32
    %5 = llvm.fadd %4, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %5 : f32
  }
  llvm.func @fadd_reduce_sqr_sum_varB(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %arg1  : f32
    %2 = llvm.fmul %1, %0  : f32
    %3 = llvm.fmul %arg0, %arg0  : f32
    %4 = llvm.fmul %arg1, %arg1  : f32
    %5 = llvm.fadd %3, %4  : f32
    %6 = llvm.fadd %2, %5  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %6 : f32
  }
  llvm.func @fadd_reduce_sqr_sum_varB_order1(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %arg1  : f32
    %2 = llvm.fmul %1, %0  : f32
    %3 = llvm.fmul %arg0, %arg0  : f32
    %4 = llvm.fmul %arg1, %arg1  : f32
    %5 = llvm.fadd %3, %4  : f32
    %6 = llvm.fadd %5, %2  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %6 : f32
  }
  llvm.func @fadd_reduce_sqr_sum_varB_order2(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %arg1  : f32
    %2 = llvm.fmul %1, %0  : f32
    %3 = llvm.fmul %arg0, %arg0  : f32
    %4 = llvm.fmul %arg1, %arg1  : f32
    %5 = llvm.fadd %4, %3  : f32
    %6 = llvm.fadd %2, %5  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %6 : f32
  }
  llvm.func @fadd_reduce_sqr_sum_varB_order3(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg1, %arg0  : f32
    %2 = llvm.fmul %0, %1  : f32
    %3 = llvm.fmul %arg0, %arg0  : f32
    %4 = llvm.fmul %arg1, %arg1  : f32
    %5 = llvm.fadd %3, %4  : f32
    %6 = llvm.fadd %2, %5  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %6 : f32
  }
  llvm.func @fadd_reduce_sqr_sum_varB2(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %0  : f32
    %2 = llvm.fmul %1, %arg1  : f32
    %3 = llvm.fmul %arg0, %arg0  : f32
    %4 = llvm.fmul %arg1, %arg1  : f32
    %5 = llvm.fadd %3, %4  : f32
    %6 = llvm.fadd %2, %5  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %6 : f32
  }
  llvm.func @fadd_reduce_sqr_sum_varB2_order1(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %0  : f32
    %2 = llvm.fmul %1, %arg1  : f32
    %3 = llvm.fmul %arg0, %arg0  : f32
    %4 = llvm.fmul %arg1, %arg1  : f32
    %5 = llvm.fadd %3, %4  : f32
    %6 = llvm.fadd %5, %2  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %6 : f32
  }
  llvm.func @fadd_reduce_sqr_sum_varB2_order2(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %0  : f32
    %2 = llvm.fmul %arg1, %1  : f32
    %3 = llvm.fmul %arg0, %arg0  : f32
    %4 = llvm.fmul %arg1, %arg1  : f32
    %5 = llvm.fadd %3, %4  : f32
    %6 = llvm.fadd %2, %5  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %6 : f32
  }
  llvm.func @fadd_reduce_sqr_sum_varB2_order3(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.fmul %0, %arg0  : f32
    %2 = llvm.fmul %1, %arg1  : f32
    %3 = llvm.fmul %arg0, %arg0  : f32
    %4 = llvm.fmul %arg1, %arg1  : f32
    %5 = llvm.fadd %3, %4  : f32
    %6 = llvm.fadd %2, %5  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %6 : f32
  }
  llvm.func @fadd_reduce_sqr_sum_varA_not_one_use1(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %arg0  : f32
    %2 = llvm.fmul %arg0, %0  : f32
    %3 = llvm.fadd %2, %arg1  : f32
    %4 = llvm.fmul %3, %arg1  : f32
    %5 = llvm.fadd %4, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.call @fake_func(%4) : (f32) -> ()
    llvm.return %5 : f32
  }
  llvm.func @fadd_reduce_sqr_sum_varA_not_one_use2(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %arg0  : f32
    %2 = llvm.fmul %arg0, %0  : f32
    %3 = llvm.fadd %2, %arg1  : f32
    %4 = llvm.fmul %3, %arg1  : f32
    %5 = llvm.fadd %4, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.call @fake_func(%1) : (f32) -> ()
    llvm.return %5 : f32
  }
  llvm.func @fadd_reduce_sqr_sum_varB_not_one_use1(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %arg1  : f32
    %2 = llvm.fmul %1, %0  : f32
    %3 = llvm.fmul %arg0, %arg0  : f32
    %4 = llvm.fmul %arg1, %arg1  : f32
    %5 = llvm.fadd %3, %4  : f32
    %6 = llvm.fadd %2, %5  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.call @fake_func(%2) : (f32) -> ()
    llvm.return %6 : f32
  }
  llvm.func @fadd_reduce_sqr_sum_varB_not_one_use2(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %arg1  : f32
    %2 = llvm.fmul %1, %0  : f32
    %3 = llvm.fmul %arg0, %arg0  : f32
    %4 = llvm.fmul %arg1, %arg1  : f32
    %5 = llvm.fadd %3, %4  : f32
    %6 = llvm.fadd %2, %5  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.call @fake_func(%5) : (f32) -> ()
    llvm.return %6 : f32
  }
  llvm.func @fadd_reduce_sqr_sum_varB2_not_one_use(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %0  : f32
    %2 = llvm.fmul %1, %arg1  : f32
    %3 = llvm.fmul %arg0, %arg0  : f32
    %4 = llvm.fmul %arg1, %arg1  : f32
    %5 = llvm.fadd %3, %4  : f32
    %6 = llvm.fadd %2, %5  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.call @fake_func(%2) : (f32) -> ()
    llvm.return %6 : f32
  }
  llvm.func @fadd_reduce_sqr_sum_varA_invalid1(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %arg0  : f32
    %2 = llvm.fmul %arg0, %0  : f32
    %3 = llvm.fadd %2, %arg1  : f32
    %4 = llvm.fmul %3, %arg0  : f32
    %5 = llvm.fadd %4, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %5 : f32
  }
  llvm.func @fadd_reduce_sqr_sum_varA_invalid2(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %arg0  : f32
    %2 = llvm.fmul %arg0, %0  : f32
    %3 = llvm.fadd %2, %arg0  : f32
    %4 = llvm.fmul %3, %arg1  : f32
    %5 = llvm.fadd %4, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %5 : f32
  }
  llvm.func @fadd_reduce_sqr_sum_varA_invalid3(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.100000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %arg0  : f32
    %2 = llvm.fmul %arg0, %0  : f32
    %3 = llvm.fadd %2, %arg1  : f32
    %4 = llvm.fmul %3, %arg1  : f32
    %5 = llvm.fadd %4, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %5 : f32
  }
  llvm.func @fadd_reduce_sqr_sum_varA_invalid4(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %arg0  : f32
    %2 = llvm.fmul %arg1, %0  : f32
    %3 = llvm.fadd %2, %arg1  : f32
    %4 = llvm.fmul %3, %arg1  : f32
    %5 = llvm.fadd %4, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %5 : f32
  }
  llvm.func @fadd_reduce_sqr_sum_varA_invalid5(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %arg1  : f32
    %2 = llvm.fmul %arg0, %0  : f32
    %3 = llvm.fadd %2, %arg1  : f32
    %4 = llvm.fmul %3, %arg1  : f32
    %5 = llvm.fadd %4, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %5 : f32
  }
  llvm.func @fadd_reduce_sqr_sum_varB_invalid1(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %arg1  : f32
    %2 = llvm.fmul %1, %0  : f32
    %3 = llvm.fmul %arg0, %arg0  : f32
    %4 = llvm.fmul %arg1, %arg0  : f32
    %5 = llvm.fadd %3, %4  : f32
    %6 = llvm.fadd %2, %5  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %6 : f32
  }
  llvm.func @fadd_reduce_sqr_sum_varB_invalid2(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %arg1  : f32
    %2 = llvm.fmul %1, %0  : f32
    %3 = llvm.fmul %arg0, %arg1  : f32
    %4 = llvm.fmul %arg1, %arg1  : f32
    %5 = llvm.fadd %3, %4  : f32
    %6 = llvm.fadd %2, %5  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %6 : f32
  }
  llvm.func @fadd_reduce_sqr_sum_varB_invalid3(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.100000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %arg1  : f32
    %2 = llvm.fmul %1, %0  : f32
    %3 = llvm.fmul %arg0, %arg0  : f32
    %4 = llvm.fmul %arg1, %arg1  : f32
    %5 = llvm.fadd %3, %4  : f32
    %6 = llvm.fadd %2, %5  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %6 : f32
  }
  llvm.func @fadd_reduce_sqr_sum_varB_invalid4(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %arg0  : f32
    %2 = llvm.fmul %1, %0  : f32
    %3 = llvm.fmul %arg0, %arg0  : f32
    %4 = llvm.fmul %arg1, %arg1  : f32
    %5 = llvm.fadd %3, %4  : f32
    %6 = llvm.fadd %2, %5  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %6 : f32
  }
  llvm.func @fadd_reduce_sqr_sum_varB_invalid5(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg1, %arg1  : f32
    %2 = llvm.fmul %1, %0  : f32
    %3 = llvm.fmul %arg0, %arg0  : f32
    %4 = llvm.fmul %arg1, %arg1  : f32
    %5 = llvm.fadd %3, %4  : f32
    %6 = llvm.fadd %2, %5  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %6 : f32
  }
  llvm.func @fadd_reduce_sqr_sum_varB2_invalid1(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %0  : f32
    %2 = llvm.fmul %1, %arg0  : f32
    %3 = llvm.fmul %arg0, %arg0  : f32
    %4 = llvm.fmul %arg1, %arg1  : f32
    %5 = llvm.fadd %3, %4  : f32
    %6 = llvm.fadd %2, %5  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %6 : f32
  }
  llvm.func @fadd_reduce_sqr_sum_varB2_invalid2(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.100000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %0  : f32
    %2 = llvm.fmul %1, %arg1  : f32
    %3 = llvm.fmul %arg0, %arg0  : f32
    %4 = llvm.fmul %arg1, %arg1  : f32
    %5 = llvm.fadd %3, %4  : f32
    %6 = llvm.fadd %2, %5  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %6 : f32
  }
  llvm.func @fadd_reduce_sqr_sum_varB2_invalid3(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg1, %0  : f32
    %2 = llvm.fmul %1, %arg1  : f32
    %3 = llvm.fmul %arg0, %arg0  : f32
    %4 = llvm.fmul %arg1, %arg1  : f32
    %5 = llvm.fadd %3, %4  : f32
    %6 = llvm.fadd %2, %5  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %6 : f32
  }
  llvm.func @fake_func(f32)
}
