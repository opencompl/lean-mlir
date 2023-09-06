module  {
  llvm.func @fmul_fadd(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fmul %arg0, %arg2  : f32
    %1 = llvm.fmul %arg1, %arg2  : f32
    %2 = llvm.fadd %0, %1  : f32
    llvm.return %2 : f32
  }
  llvm.func @fmul_fadd_commute1_vec(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fmul %arg2, %arg0  : vector<2xf32>
    %1 = llvm.fmul %arg2, %arg1  : vector<2xf32>
    %2 = llvm.fadd %0, %1  : vector<2xf32>
    llvm.return %2 : vector<2xf32>
  }
  llvm.func @fmul_fadd_commute2_vec(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fmul %arg0, %arg2  : vector<2xf32>
    %1 = llvm.fmul %arg2, %arg1  : vector<2xf32>
    %2 = llvm.fadd %0, %1  : vector<2xf32>
    llvm.return %2 : vector<2xf32>
  }
  llvm.func @fmul_fadd_commute3(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.fmul %arg2, %arg0  : f64
    %1 = llvm.fmul %arg1, %arg2  : f64
    %2 = llvm.fadd %0, %1  : f64
    llvm.return %2 : f64
  }
  llvm.func @fmul_fadd_not_enough_FMF(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fmul %arg0, %arg2  : f32
    %1 = llvm.fmul %arg1, %arg2  : f32
    %2 = llvm.fadd %0, %1  : f32
    llvm.return %2 : f32
  }
  llvm.func @use(f32)
  llvm.func @fmul_fadd_uses1(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fmul %arg2, %arg0  : f32
    %1 = llvm.fmul %arg1, %arg2  : f32
    %2 = llvm.fadd %0, %1  : f32
    llvm.call @use(%0) : (f32) -> ()
    llvm.return %2 : f32
  }
  llvm.func @fmul_fadd_uses2(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fmul %arg2, %arg0  : f32
    %1 = llvm.fmul %arg2, %arg1  : f32
    %2 = llvm.fadd %0, %1  : f32
    llvm.call @use(%1) : (f32) -> ()
    llvm.return %2 : f32
  }
  llvm.func @fmul_fadd_uses3(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fmul %arg0, %arg2  : f32
    %1 = llvm.fmul %arg2, %arg1  : f32
    %2 = llvm.fadd %0, %1  : f32
    llvm.call @use(%0) : (f32) -> ()
    llvm.call @use(%1) : (f32) -> ()
    llvm.return %2 : f32
  }
  llvm.func @fmul_fsub(%arg0: f16, %arg1: f16, %arg2: f16) -> f16 {
    %0 = llvm.fmul %arg0, %arg2  : f16
    %1 = llvm.fmul %arg1, %arg2  : f16
    %2 = llvm.fsub %0, %1  : f16
    llvm.return %2 : f16
  }
  llvm.func @fmul_fsub_commute1_vec(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fmul %arg2, %arg0  : vector<2xf32>
    %1 = llvm.fmul %arg1, %arg2  : vector<2xf32>
    %2 = llvm.fsub %0, %1  : vector<2xf32>
    llvm.return %2 : vector<2xf32>
  }
  llvm.func @fmul_fsub_commute2_vec(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fmul %arg0, %arg2  : vector<2xf32>
    %1 = llvm.fmul %arg2, %arg1  : vector<2xf32>
    %2 = llvm.fsub %0, %1  : vector<2xf32>
    llvm.return %2 : vector<2xf32>
  }
  llvm.func @fmul_fsub_commute3(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.fmul %arg2, %arg0  : f64
    %1 = llvm.fmul %arg2, %arg1  : f64
    %2 = llvm.fsub %0, %1  : f64
    llvm.return %2 : f64
  }
  llvm.func @fmul_fsub_not_enough_FMF(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fmul %arg2, %arg0  : f32
    %1 = llvm.fmul %arg1, %arg2  : f32
    %2 = llvm.fsub %0, %1  : f32
    llvm.return %2 : f32
  }
  llvm.func @fmul_fsub_uses1(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fmul %arg0, %arg2  : f32
    %1 = llvm.fmul %arg1, %arg2  : f32
    %2 = llvm.fsub %0, %1  : f32
    llvm.call @use(%0) : (f32) -> ()
    llvm.return %2 : f32
  }
  llvm.func @fmul_fsub_uses2(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fmul %arg2, %arg0  : f32
    %1 = llvm.fmul %arg2, %arg1  : f32
    %2 = llvm.fsub %0, %1  : f32
    llvm.call @use(%1) : (f32) -> ()
    llvm.return %2 : f32
  }
  llvm.func @fmul_fsub_uses3(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fmul %arg0, %arg2  : f32
    %1 = llvm.fmul %arg1, %arg2  : f32
    %2 = llvm.fsub %0, %1  : f32
    llvm.call @use(%0) : (f32) -> ()
    llvm.call @use(%1) : (f32) -> ()
    llvm.return %2 : f32
  }
  llvm.func @fdiv_fadd(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.fdiv %arg0, %arg2  : f64
    %1 = llvm.fdiv %arg1, %arg2  : f64
    %2 = llvm.fadd %0, %1  : f64
    llvm.return %2 : f64
  }
  llvm.func @fdiv_fsub(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fdiv %arg0, %arg2  : f32
    %1 = llvm.fdiv %arg1, %arg2  : f32
    %2 = llvm.fsub %0, %1  : f32
    llvm.return %2 : f32
  }
  llvm.func @fdiv_fadd_vec(%arg0: vector<2xf64>, %arg1: vector<2xf64>, %arg2: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.fdiv %arg0, %arg2  : vector<2xf64>
    %1 = llvm.fdiv %arg1, %arg2  : vector<2xf64>
    %2 = llvm.fadd %0, %1  : vector<2xf64>
    llvm.return %2 : vector<2xf64>
  }
  llvm.func @fdiv_fsub_vec(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fdiv %arg0, %arg2  : vector<2xf32>
    %1 = llvm.fdiv %arg1, %arg2  : vector<2xf32>
    %2 = llvm.fsub %0, %1  : vector<2xf32>
    llvm.return %2 : vector<2xf32>
  }
  llvm.func @fdiv_fadd_commute1(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fdiv %arg2, %arg1  : f32
    %1 = llvm.fdiv %arg2, %arg0  : f32
    %2 = llvm.fadd %0, %1  : f32
    llvm.return %2 : f32
  }
  llvm.func @fdiv_fsub_commute2(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fdiv %arg2, %arg1  : f32
    %1 = llvm.fdiv %arg0, %arg2  : f32
    %2 = llvm.fsub %0, %1  : f32
    llvm.return %2 : f32
  }
  llvm.func @fdiv_fadd_not_enough_FMF(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fdiv %arg1, %arg0  : f32
    %1 = llvm.fdiv %arg2, %arg0  : f32
    %2 = llvm.fadd %0, %1  : f32
    llvm.return %2 : f32
  }
  llvm.func @fdiv_fsub_not_enough_FMF(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fdiv %arg1, %arg0  : f32
    %1 = llvm.fdiv %arg2, %arg0  : f32
    %2 = llvm.fsub %0, %1  : f32
    llvm.return %2 : f32
  }
  llvm.func @fdiv_fadd_uses1(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fdiv %arg0, %arg2  : f32
    %1 = llvm.fdiv %arg1, %arg2  : f32
    %2 = llvm.fadd %0, %1  : f32
    llvm.call @use(%0) : (f32) -> ()
    llvm.return %2 : f32
  }
  llvm.func @fdiv_fsub_uses2(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fdiv %arg0, %arg2  : f32
    %1 = llvm.fdiv %arg1, %arg2  : f32
    %2 = llvm.fsub %0, %1  : f32
    llvm.call @use(%1) : (f32) -> ()
    llvm.return %2 : f32
  }
  llvm.func @fdiv_fsub_uses3(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fdiv %arg0, %arg2  : f32
    %1 = llvm.fdiv %arg1, %arg2  : f32
    %2 = llvm.fsub %0, %1  : f32
    llvm.call @use(%0) : (f32) -> ()
    llvm.call @use(%1) : (f32) -> ()
    llvm.return %2 : f32
  }
  llvm.func @fdiv_fadd_not_denorm(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(5.87747175E-39 : f32) : f32
    %1 = llvm.mlir.constant(1.17549435E-38 : f32) : f32
    %2 = llvm.fdiv %1, %arg0  : f32
    %3 = llvm.fdiv %0, %arg0  : f32
    %4 = llvm.fadd %2, %3  : f32
    llvm.return %4 : f32
  }
  llvm.func @fdiv_fadd_denorm(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(5.87747175E-39 : f32) : f32
    %1 = llvm.mlir.constant(-1.17549435E-38 : f32) : f32
    %2 = llvm.fdiv %1, %arg0  : f32
    %3 = llvm.fdiv %0, %arg0  : f32
    %4 = llvm.fadd %2, %3  : f32
    llvm.return %4 : f32
  }
  llvm.func @fdiv_fsub_denorm(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(5.87747175E-39 : f32) : f32
    %1 = llvm.mlir.constant(1.17549435E-38 : f32) : f32
    %2 = llvm.fdiv %1, %arg0  : f32
    %3 = llvm.fdiv %0, %arg0  : f32
    %4 = llvm.fsub %2, %3  : f32
    llvm.return %4 : f32
  }
  llvm.func @lerp_commute0(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg2  : f32
    %2 = llvm.fmul %1, %arg0  : f32
    %3 = llvm.fmul %arg2, %arg1  : f32
    %4 = llvm.fadd %2, %3  : f32
    llvm.return %4 : f32
  }
  llvm.func @lerp_commute1(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<1.000000e+00> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fsub %0, %arg2  : vector<2xf32>
    %2 = llvm.fmul %1, %arg0  : vector<2xf32>
    %3 = llvm.fmul %arg2, %arg1  : vector<2xf32>
    %4 = llvm.fadd %3, %2  : vector<2xf32>
    llvm.return %4 : vector<2xf32>
  }
  llvm.func @lerp_commute2(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg2  : f32
    %2 = llvm.fmul %1, %arg0  : f32
    %3 = llvm.fmul %arg1, %arg2  : f32
    %4 = llvm.fadd %2, %3  : f32
    llvm.return %4 : f32
  }
  llvm.func @lerp_commute3(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg2  : f32
    %2 = llvm.fmul %1, %arg0  : f32
    %3 = llvm.fmul %arg1, %arg2  : f32
    %4 = llvm.fadd %3, %2  : f32
    llvm.return %4 : f32
  }
  llvm.func @lerp_commute4(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.fsub %0, %arg2  : f64
    %2 = llvm.fmul %arg0, %1  : f64
    %3 = llvm.fmul %arg2, %arg1  : f64
    %4 = llvm.fadd %2, %3  : f64
    llvm.return %4 : f64
  }
  llvm.func @lerp_commute5(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.fsub %0, %arg2  : f64
    %2 = llvm.fmul %arg0, %1  : f64
    %3 = llvm.fmul %arg2, %arg1  : f64
    %4 = llvm.fadd %3, %2  : f64
    llvm.return %4 : f64
  }
  llvm.func @lerp_commute6(%arg0: f16, %arg1: f16, %arg2: f16) -> f16 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f16
    %1 = llvm.fsub %0, %arg2  : f16
    %2 = llvm.fmul %arg0, %1  : f16
    %3 = llvm.fmul %arg1, %arg2  : f16
    %4 = llvm.fadd %2, %3  : f16
    llvm.return %4 : f16
  }
  llvm.func @lerp_commute7(%arg0: f16, %arg1: f16, %arg2: f16) -> f16 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f16
    %1 = llvm.fsub %0, %arg2  : f16
    %2 = llvm.fmul %arg0, %1  : f16
    %3 = llvm.fmul %arg1, %arg2  : f16
    %4 = llvm.fadd %3, %2  : f16
    llvm.return %4 : f16
  }
  llvm.func @lerp_extra_use1(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg2  : f32
    %2 = llvm.fmul %arg0, %1  : f32
    %3 = llvm.fmul %arg1, %arg2  : f32
    llvm.call @use(%3) : (f32) -> ()
    %4 = llvm.fadd %3, %2  : f32
    llvm.return %4 : f32
  }
  llvm.func @lerp_extra_use2(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg2  : f32
    %2 = llvm.fmul %arg0, %1  : f32
    llvm.call @use(%2) : (f32) -> ()
    %3 = llvm.fmul %arg1, %arg2  : f32
    %4 = llvm.fadd %3, %2  : f32
    llvm.return %4 : f32
  }
  llvm.func @lerp_extra_use3(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg2  : f32
    llvm.call @use(%1) : (f32) -> ()
    %2 = llvm.fmul %arg0, %1  : f32
    %3 = llvm.fmul %arg1, %arg2  : f32
    %4 = llvm.fadd %3, %2  : f32
    llvm.return %4 : f32
  }
}
