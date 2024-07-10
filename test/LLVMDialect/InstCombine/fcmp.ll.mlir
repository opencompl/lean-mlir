module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use(f32)
  llvm.func @fpext_fpext(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.fcmp "ogt" %0, %1 {fastmathFlags = #llvm.fastmath<nnan>} : f64
    llvm.return %2 : i1
  }
  llvm.func @fpext_constant(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.fpext %arg0 : f32 to f64
    %2 = llvm.fcmp "ogt" %1, %0 {fastmathFlags = #llvm.fastmath<ninf>} : f64
    llvm.return %2 : i1
  }
  llvm.func @fpext_constant_vec_splat(%arg0: vector<2xf16>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<4.200000e+01> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.fpext %arg0 : vector<2xf16> to vector<2xf64>
    %2 = llvm.fcmp "ole" %1, %0 {fastmathFlags = #llvm.fastmath<nnan>} : vector<2xf64>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @fpext_constant_lossy(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.0000000000000002 : f64) : f64
    %1 = llvm.fpext %arg0 : f32 to f64
    %2 = llvm.fcmp "ogt" %1, %0 : f64
    llvm.return %2 : i1
  }
  llvm.func @fpext_constant_denorm(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.4012984643248171E-45 : f64) : f64
    %1 = llvm.fpext %arg0 : f32 to f64
    %2 = llvm.fcmp "ogt" %1, %0 : f64
    llvm.return %2 : i1
  }
  llvm.func @fneg_constant_swap_pred(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.fsub %0, %arg0  : f32
    %3 = llvm.fcmp "ogt" %2, %1 : f32
    llvm.return %3 : i1
  }
  llvm.func @unary_fneg_constant_swap_pred(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.fneg %arg0  : f32
    %2 = llvm.fcmp "ogt" %1, %0 : f32
    llvm.return %2 : i1
  }
  llvm.func @fneg_constant_swap_pred_vec(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00]> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.fsub %0, %arg0  : vector<2xf32>
    %3 = llvm.fcmp "ogt" %2, %1 : vector<2xf32>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @unary_fneg_constant_swap_pred_vec(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fneg %arg0  : vector<2xf32>
    %2 = llvm.fcmp "ogt" %1, %0 : vector<2xf32>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @fneg_constant_swap_pred_vec_poison(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.mlir.poison : f32
    %2 = llvm.mlir.undef : vector<2xf32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xf32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xf32>
    %7 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00]> : vector<2xf32>) : vector<2xf32>
    %8 = llvm.fsub %6, %arg0  : vector<2xf32>
    %9 = llvm.fcmp "ogt" %8, %7 : vector<2xf32>
    llvm.return %9 : vector<2xi1>
  }
  llvm.func @fneg_fmf(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %2 = llvm.fsub %0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %3 = llvm.fcmp "oeq" %2, %1 {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %3 : i1
  }
  llvm.func @unary_fneg_fmf(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %1 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %2 = llvm.fcmp "oeq" %1, %0 {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %2 : i1
  }
  llvm.func @fcmp_fneg_fmf_vec(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.mlir.constant(dense<[4.200000e+01, -1.900000e+01]> : vector<2xf32>) : vector<2xf32>
    %3 = llvm.fsub %1, %arg0  {fastmathFlags = #llvm.fastmath<nsz>} : vector<2xf32>
    %4 = llvm.fcmp "uge" %3, %2 {fastmathFlags = #llvm.fastmath<nnan, reassoc>} : vector<2xf32>
    llvm.return %4 : vector<2xi1>
  }
  llvm.func @fneg_fneg_swap_pred(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  : f32
    %2 = llvm.fsub %0, %arg1  : f32
    %3 = llvm.fcmp "olt" %1, %2 {fastmathFlags = #llvm.fastmath<nnan>} : f32
    llvm.return %3 : i1
  }
  llvm.func @unary_fneg_unary_fneg_swap_pred(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    %1 = llvm.fneg %arg1  : f32
    %2 = llvm.fcmp "olt" %0, %1 {fastmathFlags = #llvm.fastmath<nnan>} : f32
    llvm.return %2 : i1
  }
  llvm.func @unary_fneg_fneg_swap_pred(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fneg %arg0  : f32
    %2 = llvm.fsub %0, %arg1  : f32
    %3 = llvm.fcmp "olt" %1, %2 {fastmathFlags = #llvm.fastmath<nnan>} : f32
    llvm.return %3 : i1
  }
  llvm.func @fneg_unary_fneg_swap_pred(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  : f32
    %2 = llvm.fneg %arg1  : f32
    %3 = llvm.fcmp "olt" %1, %2 {fastmathFlags = #llvm.fastmath<nnan>} : f32
    llvm.return %3 : i1
  }
  llvm.func @fneg_fneg_swap_pred_vec(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fsub %0, %arg0  : vector<2xf32>
    %2 = llvm.fsub %0, %arg1  : vector<2xf32>
    %3 = llvm.fcmp "olt" %1, %2 {fastmathFlags = #llvm.fastmath<ninf>} : vector<2xf32>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @unary_fneg_unary_fneg_swap_pred_vec(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.fneg %arg0  : vector<2xf32>
    %1 = llvm.fneg %arg1  : vector<2xf32>
    %2 = llvm.fcmp "olt" %0, %1 {fastmathFlags = #llvm.fastmath<ninf>} : vector<2xf32>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @unary_fneg_fneg_swap_pred_vec(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fneg %arg0  : vector<2xf32>
    %2 = llvm.fsub %0, %arg1  : vector<2xf32>
    %3 = llvm.fcmp "olt" %1, %2 {fastmathFlags = #llvm.fastmath<ninf>} : vector<2xf32>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @fneg_unary_fneg_swap_pred_vec(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fsub %0, %arg0  : vector<2xf32>
    %2 = llvm.fneg %arg1  : vector<2xf32>
    %3 = llvm.fcmp "olt" %1, %2 {fastmathFlags = #llvm.fastmath<ninf>} : vector<2xf32>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @fneg_fneg_swap_pred_vec_poison(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : f32
    %1 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %2 = llvm.mlir.undef : vector<2xf32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xf32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xf32>
    %7 = llvm.mlir.undef : vector<2xf32>
    %8 = llvm.mlir.constant(0 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<2xf32>
    %10 = llvm.mlir.constant(1 : i32) : i32
    %11 = llvm.insertelement %1, %9[%10 : i32] : vector<2xf32>
    %12 = llvm.fsub %6, %arg0  : vector<2xf32>
    %13 = llvm.fsub %11, %arg1  : vector<2xf32>
    %14 = llvm.fcmp "olt" %12, %13 : vector<2xf32>
    llvm.return %14 : vector<2xi1>
  }
  llvm.func @unary_fneg_fneg_swap_pred_vec_poison(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.mlir.poison : f32
    %2 = llvm.mlir.undef : vector<2xf32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xf32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xf32>
    %7 = llvm.fneg %arg0  : vector<2xf32>
    %8 = llvm.fsub %6, %arg1  : vector<2xf32>
    %9 = llvm.fcmp "olt" %7, %8 : vector<2xf32>
    llvm.return %9 : vector<2xi1>
  }
  llvm.func @fneg_unary_fneg_swap_pred_vec_poison(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : f32
    %1 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %2 = llvm.mlir.undef : vector<2xf32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xf32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xf32>
    %7 = llvm.fsub %6, %arg0  : vector<2xf32>
    %8 = llvm.fneg %arg1  : vector<2xf32>
    %9 = llvm.fcmp "olt" %7, %8 : vector<2xf32>
    llvm.return %9 : vector<2xi1>
  }
  llvm.func @test7(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f128) : !llvm.ppc_fp128
    %1 = llvm.fpext %arg0 : f32 to !llvm.ppc_fp128
    %2 = llvm.fcmp "ogt" %1, %0 : !llvm.ppc_fp128
    llvm.return %2 : i1
  }
  llvm.func @test8(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fpext %arg0 : f32 to f64
    %2 = llvm.fcmp "olt" %1, %0 : f64
    %3 = llvm.zext %2 : i1 to i32
    %4 = llvm.sitofp %3 : i32 to f32
    llvm.return %4 : f32
  }
  llvm.func @fabs_uge(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.intr.fabs(%arg0)  : (f64) -> f64
    %2 = llvm.fcmp "uge" %1, %0 : f64
    llvm.return %2 : i1
  }
  llvm.func @fabs_olt(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.intr.fabs(%arg0)  : (f16) -> f16
    %2 = llvm.fcmp "olt" %1, %0 : f16
    llvm.return %2 : i1
  }
  llvm.func @fabs_ole(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.intr.fabs(%arg0)  : (vector<2xf32>) -> vector<2xf32>
    %3 = llvm.fcmp "ole" %2, %1 {fastmathFlags = #llvm.fastmath<ninf>} : vector<2xf32>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @fabs_ule(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.intr.fabs(%arg0)  : (vector<2xf32>) -> vector<2xf32>
    %3 = llvm.fcmp "ule" %2, %1 {fastmathFlags = #llvm.fastmath<ninf, arcp>} : vector<2xf32>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @fabs_ogt(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.intr.fabs(%arg0)  : (f64) -> f64
    %2 = llvm.fcmp "ogt" %1, %0 {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    llvm.return %2 : i1
  }
  llvm.func @fabs_ugt(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.intr.fabs(%arg0)  : (f64) -> f64
    %2 = llvm.fcmp "ugt" %1, %0 {fastmathFlags = #llvm.fastmath<ninf, reassoc>} : f64
    llvm.return %2 : i1
  }
  llvm.func @fabs_oge(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.intr.fabs(%arg0)  : (f64) -> f64
    %2 = llvm.fcmp "oge" %1, %0 {fastmathFlags = #llvm.fastmath<afn>} : f64
    llvm.return %2 : i1
  }
  llvm.func @fabs_ult(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.intr.fabs(%arg0)  : (f64) -> f64
    %2 = llvm.fcmp "ult" %1, %0 {fastmathFlags = #llvm.fastmath<arcp, reassoc>} : f64
    llvm.return %2 : i1
  }
  llvm.func @fabs_ult_nnan(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.intr.fabs(%arg0)  : (vector<2xf32>) -> vector<2xf32>
    %3 = llvm.fcmp "ult" %2, %1 {fastmathFlags = #llvm.fastmath<nnan, arcp, reassoc>} : vector<2xf32>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @fabs_une(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.intr.fabs(%arg0)  : (f16) -> f16
    %2 = llvm.fcmp "une" %1, %0 {fastmathFlags = #llvm.fastmath<ninf>} : f16
    llvm.return %2 : i1
  }
  llvm.func @fabs_oeq(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.intr.fabs(%arg0)  : (f64) -> f64
    %2 = llvm.fcmp "oeq" %1, %0 {fastmathFlags = #llvm.fastmath<ninf, reassoc>} : f64
    llvm.return %2 : i1
  }
  llvm.func @fabs_one(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.intr.fabs(%arg0)  : (f64) -> f64
    %2 = llvm.fcmp "one" %1, %0 {fastmathFlags = #llvm.fastmath<fast>} : f64
    llvm.return %2 : i1
  }
  llvm.func @fabs_ueq(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.intr.fabs(%arg0)  : (vector<2xf32>) -> vector<2xf32>
    %3 = llvm.fcmp "ueq" %2, %1 {fastmathFlags = #llvm.fastmath<arcp>} : vector<2xf32>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @fabs_ord(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.intr.fabs(%arg0)  : (vector<2xf32>) -> vector<2xf32>
    %3 = llvm.fcmp "ord" %2, %1 {fastmathFlags = #llvm.fastmath<arcp>} : vector<2xf32>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @fabs_uno(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.intr.fabs(%arg0)  : (vector<2xf32>) -> vector<2xf32>
    %3 = llvm.fcmp "uno" %2, %1 {fastmathFlags = #llvm.fastmath<arcp>} : vector<2xf32>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @test17(%arg0: f64, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.call %arg1(%arg0) : !llvm.ptr, (f64) -> f64
    %2 = llvm.fcmp "ueq" %1, %0 : f64
    %3 = llvm.zext %2 : i1 to i32
    llvm.return %3 : i32
  }
  llvm.func @test18_undef_unordered(%arg0: f32) -> i32 {
    %0 = llvm.mlir.undef : f32
    %1 = llvm.fcmp "ueq" %arg0, %0 : f32
    %2 = llvm.zext %1 : i1 to i32
    llvm.return %2 : i32
  }
  llvm.func @test18_undef_ordered(%arg0: f32) -> i32 {
    %0 = llvm.mlir.undef : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    %2 = llvm.zext %1 : i1 to i32
    llvm.return %2 : i32
  }
  llvm.func @test19_undef_unordered() -> i1 {
    %0 = llvm.mlir.undef : f32
    %1 = llvm.fcmp "ueq" %0, %0 : f32
    llvm.return %1 : i1
  }
  llvm.func @test19_undef_ordered() -> i1 {
    %0 = llvm.mlir.undef : f32
    %1 = llvm.fcmp "oeq" %0, %0 : f32
    llvm.return %1 : i1
  }
  llvm.func @test20_recipX_olt_0(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.fdiv %0, %arg0  {fastmathFlags = #llvm.fastmath<ninf>} : f32
    %3 = llvm.fcmp "olt" %2, %1 {fastmathFlags = #llvm.fastmath<ninf>} : f32
    llvm.return %3 : i1
  }
  llvm.func @test21_recipX_ole_0(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(-2.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.fdiv %0, %arg0  {fastmathFlags = #llvm.fastmath<ninf>} : f32
    %3 = llvm.fcmp "ole" %2, %1 {fastmathFlags = #llvm.fastmath<ninf>} : f32
    llvm.return %3 : i1
  }
  llvm.func @test22_recipX_ogt_0(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.fdiv %0, %arg0  {fastmathFlags = #llvm.fastmath<ninf>} : f32
    %3 = llvm.fcmp "ogt" %2, %1 {fastmathFlags = #llvm.fastmath<ninf>} : f32
    llvm.return %3 : i1
  }
  llvm.func @test23_recipX_oge_0(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(-1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.fdiv %0, %arg0  {fastmathFlags = #llvm.fastmath<ninf>} : f32
    %3 = llvm.fcmp "oge" %2, %1 {fastmathFlags = #llvm.fastmath<ninf>} : f32
    llvm.return %3 : i1
  }
  llvm.func @test24_recipX_noninf_cmp(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.fdiv %0, %arg0  {fastmathFlags = #llvm.fastmath<ninf>} : f32
    %3 = llvm.fcmp "ogt" %2, %1 : f32
    llvm.return %3 : i1
  }
  llvm.func @test25_recipX_noninf_div(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.fdiv %0, %arg0  : f32
    %3 = llvm.fcmp "ogt" %2, %1 {fastmathFlags = #llvm.fastmath<ninf>} : f32
    llvm.return %3 : i1
  }
  llvm.func @test26_recipX_unorderd(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.fdiv %0, %arg0  {fastmathFlags = #llvm.fastmath<ninf>} : f32
    %3 = llvm.fcmp "ugt" %2, %1 {fastmathFlags = #llvm.fastmath<ninf>} : f32
    llvm.return %3 : i1
  }
  llvm.func @test27_recipX_gt_vecsplat(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-1.000000e+00> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.mlir.constant(dense<-0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.fdiv %0, %arg0  {fastmathFlags = #llvm.fastmath<ninf>} : vector<2xf32>
    %3 = llvm.fcmp "ogt" %2, %1 {fastmathFlags = #llvm.fastmath<ninf>} : vector<2xf32>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @is_signbit_set(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.intr.copysign(%0, %arg0)  : (f64, f64) -> f64
    %3 = llvm.fcmp "olt" %2, %1 : f64
    llvm.return %3 : i1
  }
  llvm.func @is_signbit_set_1(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.intr.copysign(%0, %arg0)  : (f64, f64) -> f64
    %3 = llvm.fcmp "ult" %2, %1 : f64
    llvm.return %3 : i1
  }
  llvm.func @is_signbit_set_2(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.intr.copysign(%0, %arg0)  : (f64, f64) -> f64
    %3 = llvm.fcmp "ole" %2, %1 : f64
    llvm.return %3 : i1
  }
  llvm.func @is_signbit_set_3(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.intr.copysign(%0, %arg0)  : (f64, f64) -> f64
    %3 = llvm.fcmp "ule" %2, %1 : f64
    llvm.return %3 : i1
  }
  llvm.func @is_signbit_set_anyzero(%arg0: vector<2xf64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<4.200000e+01> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.mlir.constant(dense<[-0.000000e+00, 0.000000e+00]> : vector<2xf64>) : vector<2xf64>
    %2 = llvm.intr.copysign(%0, %arg0)  : (vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    %3 = llvm.fcmp "olt" %2, %1 : vector<2xf64>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @is_signbit_clear(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(-4.200000e+01 : f64) : f64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.intr.copysign(%0, %arg0)  : (f64, f64) -> f64
    %3 = llvm.fcmp "ogt" %2, %1 : f64
    llvm.return %3 : i1
  }
  llvm.func @is_signbit_clear_1(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(-4.200000e+01 : f64) : f64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.intr.copysign(%0, %arg0)  : (f64, f64) -> f64
    %3 = llvm.fcmp "ugt" %2, %1 : f64
    llvm.return %3 : i1
  }
  llvm.func @is_signbit_clear_2(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(-4.200000e+01 : f64) : f64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.intr.copysign(%0, %arg0)  : (f64, f64) -> f64
    %3 = llvm.fcmp "oge" %2, %1 : f64
    llvm.return %3 : i1
  }
  llvm.func @is_signbit_clear_3(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(-4.200000e+01 : f64) : f64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.intr.copysign(%0, %arg0)  : (f64, f64) -> f64
    %3 = llvm.fcmp "uge" %2, %1 : f64
    llvm.return %3 : i1
  }
  llvm.func @is_signbit_set_extra_use(%arg0: f64, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.intr.copysign(%0, %arg0)  : (f64, f64) -> f64
    llvm.store %2, %arg1 {alignment = 8 : i64} : f64, !llvm.ptr
    %3 = llvm.fcmp "olt" %2, %1 : f64
    llvm.return %3 : i1
  }
  llvm.func @is_signbit_clear_nonzero(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(-4.200000e+01 : f64) : f64
    %1 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %2 = llvm.intr.copysign(%0, %arg0)  : (f64, f64) -> f64
    %3 = llvm.fcmp "ogt" %2, %1 : f64
    llvm.return %3 : i1
  }
  llvm.func @is_signbit_set_simplify_zero(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.intr.copysign(%0, %arg0)  : (f64, f64) -> f64
    %2 = llvm.fcmp "ogt" %1, %0 : f64
    llvm.return %2 : i1
  }
  llvm.func @is_signbit_set_simplify_nan(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(0xFFFFFFFFFFFFFFFF : f64) : f64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.intr.copysign(%0, %arg0)  : (f64, f64) -> f64
    %3 = llvm.fcmp "ogt" %2, %1 : f64
    llvm.return %3 : i1
  }
  llvm.func @lossy_oeq(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1.000000e-01> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.fpext %arg0 : vector<2xf32> to vector<2xf64>
    %2 = llvm.fcmp "oeq" %1, %0 : vector<2xf64>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @lossy_one(%arg0: f32, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1.000000e-01 : f64) : f64
    %1 = llvm.fpext %arg0 : f32 to f64
    llvm.store %1, %arg1 {alignment = 8 : i64} : f64, !llvm.ptr
    %2 = llvm.fcmp "one" %1, %0 : f64
    llvm.return %2 : i1
  }
  llvm.func @lossy_ueq(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(6.553600e+04 : f64) : f64
    %1 = llvm.fpext %arg0 : f16 to f64
    %2 = llvm.fcmp "ueq" %1, %0 : f64
    llvm.return %2 : i1
  }
  llvm.func @lossy_une(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(2.049000e+03 : f32) : f32
    %1 = llvm.fpext %arg0 : f16 to f32
    %2 = llvm.fcmp "une" %1, %0 : f32
    llvm.return %2 : i1
  }
  llvm.func @lossy_ogt(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1.000000e-01> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.fpext %arg0 : vector<2xf32> to vector<2xf64>
    %2 = llvm.fcmp "ogt" %1, %0 : vector<2xf64>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @lossy_oge(%arg0: f32, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1.000000e-01 : f64) : f64
    %1 = llvm.fpext %arg0 : f32 to f64
    llvm.store %1, %arg1 {alignment = 8 : i64} : f64, !llvm.ptr
    %2 = llvm.fcmp "oge" %1, %0 : f64
    llvm.return %2 : i1
  }
  llvm.func @lossy_olt(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(6.553600e+04 : f64) : f64
    %1 = llvm.fpext %arg0 : f16 to f64
    %2 = llvm.fcmp "olt" %1, %0 : f64
    llvm.return %2 : i1
  }
  llvm.func @lossy_ole(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(2.049000e+03 : f32) : f32
    %1 = llvm.fpext %arg0 : f16 to f32
    %2 = llvm.fcmp "ole" %1, %0 : f32
    llvm.return %2 : i1
  }
  llvm.func @lossy_ugt(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1.000000e-01> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.fpext %arg0 : vector<2xf32> to vector<2xf64>
    %2 = llvm.fcmp "ugt" %1, %0 : vector<2xf64>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @lossy_uge(%arg0: f32, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1.000000e-01 : f64) : f64
    %1 = llvm.fpext %arg0 : f32 to f64
    llvm.store %1, %arg1 {alignment = 8 : i64} : f64, !llvm.ptr
    %2 = llvm.fcmp "uge" %1, %0 : f64
    llvm.return %2 : i1
  }
  llvm.func @lossy_ult(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(6.553600e+04 : f64) : f64
    %1 = llvm.fpext %arg0 : f16 to f64
    %2 = llvm.fcmp "ult" %1, %0 : f64
    llvm.return %2 : i1
  }
  llvm.func @lossy_ule(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(2.049000e+03 : f32) : f32
    %1 = llvm.fpext %arg0 : f16 to f32
    %2 = llvm.fcmp "ule" %1, %0 : f32
    llvm.return %2 : i1
  }
  llvm.func @lossy_ord(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(6.553600e+04 : f64) : f64
    %1 = llvm.fpext %arg0 : f16 to f64
    %2 = llvm.fcmp "ord" %1, %0 : f64
    llvm.return %2 : i1
  }
  llvm.func @lossy_uno(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(2.049000e+03 : f32) : f32
    %1 = llvm.fpext %arg0 : f16 to f32
    %2 = llvm.fcmp "uno" %1, %0 : f32
    llvm.return %2 : i1
  }
  llvm.func @fneg_oeq(%arg0: f32) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    %1 = llvm.fcmp "oeq" %0, %arg0 : f32
    llvm.return %1 : i1
  }
  llvm.func @fneg_ogt(%arg0: f16) -> i1 {
    %0 = llvm.fneg %arg0  : f16
    %1 = llvm.fcmp "ogt" %0, %arg0 {fastmathFlags = #llvm.fastmath<fast>} : f16
    llvm.return %1 : i1
  }
  llvm.func @fneg_oge(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<fast>} : vector<2xf32>
    %1 = llvm.fcmp "oge" %0, %arg0 : vector<2xf32>
    llvm.return %1 : vector<2xi1>
  }
  llvm.func @fneg_olt(%arg0: f32, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    llvm.store %0, %arg1 {alignment = 4 : i64} : f32, !llvm.ptr
    %1 = llvm.fcmp "olt" %0, %arg0 : f32
    llvm.return %1 : i1
  }
  llvm.func @fneg_ole(%arg0: f32) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    %1 = llvm.fcmp "ole" %0, %arg0 {fastmathFlags = #llvm.fastmath<nsz>} : f32
    llvm.return %1 : i1
  }
  llvm.func @fneg_one(%arg0: f32) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    %1 = llvm.fcmp "one" %0, %arg0 {fastmathFlags = #llvm.fastmath<nnan>} : f32
    llvm.return %1 : i1
  }
  llvm.func @fneg_ord(%arg0: f32) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    %1 = llvm.fcmp "ord" %0, %arg0 {fastmathFlags = #llvm.fastmath<ninf>} : f32
    llvm.return %1 : i1
  }
  llvm.func @fneg_uno(%arg0: f32) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    %1 = llvm.fcmp "uno" %0, %arg0 : f32
    llvm.return %1 : i1
  }
  llvm.func @fneg_ueq(%arg0: f16) -> i1 {
    %0 = llvm.fneg %arg0  : f16
    %1 = llvm.fcmp "ueq" %0, %arg0 {fastmathFlags = #llvm.fastmath<fast>} : f16
    llvm.return %1 : i1
  }
  llvm.func @fneg_ugt(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<fast>} : vector<2xf32>
    %1 = llvm.fcmp "ugt" %0, %arg0 : vector<2xf32>
    llvm.return %1 : vector<2xi1>
  }
  llvm.func @fneg_uge(%arg0: f32, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    llvm.store %0, %arg1 {alignment = 4 : i64} : f32, !llvm.ptr
    %1 = llvm.fcmp "uge" %0, %arg0 : f32
    llvm.return %1 : i1
  }
  llvm.func @fneg_ult(%arg0: f32) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    %1 = llvm.fcmp "ult" %0, %arg0 {fastmathFlags = #llvm.fastmath<nsz>} : f32
    llvm.return %1 : i1
  }
  llvm.func @fneg_ule(%arg0: f32) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    %1 = llvm.fcmp "ule" %0, %arg0 {fastmathFlags = #llvm.fastmath<nnan>} : f32
    llvm.return %1 : i1
  }
  llvm.func @fneg_une(%arg0: f32) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    %1 = llvm.fcmp "une" %0, %arg0 {fastmathFlags = #llvm.fastmath<ninf>} : f32
    llvm.return %1 : i1
  }
  llvm.func @fneg_oeq_swap(%arg0: f32) -> i1 {
    %0 = llvm.fadd %arg0, %arg0  : f32
    %1 = llvm.fneg %0  : f32
    %2 = llvm.fcmp "oeq" %0, %1 : f32
    llvm.return %2 : i1
  }
  llvm.func @fneg_ogt_swap(%arg0: f16) -> i1 {
    %0 = llvm.fadd %arg0, %arg0  : f16
    %1 = llvm.fneg %0  : f16
    %2 = llvm.fcmp "ogt" %0, %1 {fastmathFlags = #llvm.fastmath<fast>} : f16
    llvm.return %2 : i1
  }
  llvm.func @fneg_oge_swap(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.fadd %arg0, %arg0  : vector<2xf32>
    %1 = llvm.fneg %0  {fastmathFlags = #llvm.fastmath<fast>} : vector<2xf32>
    %2 = llvm.fcmp "oge" %0, %1 : vector<2xf32>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @fneg_olt_swap(%arg0: f32, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.fadd %arg0, %arg0  : f32
    %1 = llvm.fneg %0  : f32
    llvm.store %1, %arg1 {alignment = 4 : i64} : f32, !llvm.ptr
    %2 = llvm.fcmp "olt" %0, %1 : f32
    llvm.return %2 : i1
  }
  llvm.func @fneg_ole_swap(%arg0: f32) -> i1 {
    %0 = llvm.fadd %arg0, %arg0  : f32
    %1 = llvm.fneg %0  : f32
    %2 = llvm.fcmp "ole" %0, %1 {fastmathFlags = #llvm.fastmath<nsz>} : f32
    llvm.return %2 : i1
  }
  llvm.func @fneg_one_swap(%arg0: f32) -> i1 {
    %0 = llvm.fadd %arg0, %arg0  : f32
    %1 = llvm.fneg %0  : f32
    %2 = llvm.fcmp "one" %0, %1 {fastmathFlags = #llvm.fastmath<nnan>} : f32
    llvm.return %2 : i1
  }
  llvm.func @fneg_ord_swap(%arg0: f32) -> i1 {
    %0 = llvm.fadd %arg0, %arg0  : f32
    %1 = llvm.fneg %0  : f32
    %2 = llvm.fcmp "ord" %0, %1 {fastmathFlags = #llvm.fastmath<ninf>} : f32
    llvm.return %2 : i1
  }
  llvm.func @fneg_uno_swap(%arg0: f32) -> i1 {
    %0 = llvm.fadd %arg0, %arg0  : f32
    %1 = llvm.fneg %0  : f32
    %2 = llvm.fcmp "uno" %0, %1 : f32
    llvm.return %2 : i1
  }
  llvm.func @fneg_ueq_swap(%arg0: f16) -> i1 {
    %0 = llvm.fadd %arg0, %arg0  : f16
    %1 = llvm.fneg %0  : f16
    %2 = llvm.fcmp "ueq" %0, %1 {fastmathFlags = #llvm.fastmath<fast>} : f16
    llvm.return %2 : i1
  }
  llvm.func @fneg_ugt_swap(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.fadd %arg0, %arg0  : vector<2xf32>
    %1 = llvm.fneg %0  {fastmathFlags = #llvm.fastmath<fast>} : vector<2xf32>
    %2 = llvm.fcmp "ugt" %0, %1 : vector<2xf32>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @fneg_uge_swap(%arg0: f32, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.fadd %arg0, %arg0  : f32
    %1 = llvm.fneg %0  : f32
    llvm.store %1, %arg1 {alignment = 4 : i64} : f32, !llvm.ptr
    %2 = llvm.fcmp "uge" %0, %1 : f32
    llvm.return %2 : i1
  }
  llvm.func @fneg_ult_swap(%arg0: f32) -> i1 {
    %0 = llvm.fadd %arg0, %arg0  : f32
    %1 = llvm.fneg %0  : f32
    %2 = llvm.fcmp "ult" %0, %1 {fastmathFlags = #llvm.fastmath<nsz>} : f32
    llvm.return %2 : i1
  }
  llvm.func @fneg_ule_swap(%arg0: f32) -> i1 {
    %0 = llvm.fadd %arg0, %arg0  : f32
    %1 = llvm.fneg %0  : f32
    %2 = llvm.fcmp "ule" %0, %1 {fastmathFlags = #llvm.fastmath<nnan>} : f32
    llvm.return %2 : i1
  }
  llvm.func @fneg_une_swap(%arg0: f32) -> i1 {
    %0 = llvm.fadd %arg0, %arg0  : f32
    %1 = llvm.fneg %0  : f32
    %2 = llvm.fcmp "une" %0, %1 {fastmathFlags = #llvm.fastmath<ninf>} : f32
    llvm.return %2 : i1
  }
  llvm.func @bitcast_eq0(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.bitcast %arg0 : i32 to f32
    %2 = llvm.fcmp "oeq" %1, %0 : f32
    llvm.return %2 : i1
  }
  llvm.func @bitcast_ne0(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.bitcast %arg0 : vector<2xi32> to vector<2xf32>
    %3 = llvm.fcmp "une" %2, %1 : vector<2xf32>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @bitcast_eq0_use(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.bitcast %arg0 : i32 to f32
    llvm.call @use(%1) : (f32) -> ()
    %2 = llvm.fcmp "oeq" %1, %0 : f32
    llvm.return %2 : i1
  }
  llvm.func @bitcast_nonint_eq0(%arg0: vector<2xi16>) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.bitcast %arg0 : vector<2xi16> to f32
    %2 = llvm.fcmp "ogt" %1, %0 : f32
    llvm.return %2 : i1
  }
  llvm.func @bitcast_gt0(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.bitcast %arg0 : i32 to f32
    %2 = llvm.fcmp "ogt" %1, %0 : f32
    llvm.return %2 : i1
  }
  llvm.func @bitcast_1vec_eq0(%arg0: i32) -> vector<1xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<1xf32>) : vector<1xf32>
    %2 = llvm.bitcast %arg0 : i32 to vector<1xf32>
    %3 = llvm.fcmp "oeq" %2, %1 : vector<1xf32>
    llvm.return %3 : vector<1xi1>
  }
  llvm.func @fcmp_fadd_zero_ugt(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  : f32
    %2 = llvm.fcmp "ugt" %1, %arg1 : f32
    llvm.return %2 : i1
  }
  llvm.func @fcmp_fadd_zero_uge(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  : f32
    %2 = llvm.fcmp "uge" %1, %arg1 : f32
    llvm.return %2 : i1
  }
  llvm.func @fcmp_fadd_zero_ogt(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  : f32
    %2 = llvm.fcmp "ogt" %1, %arg1 : f32
    llvm.return %2 : i1
  }
  llvm.func @fcmp_fadd_zero_oge(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  : f32
    %2 = llvm.fcmp "oge" %1, %arg1 : f32
    llvm.return %2 : i1
  }
  llvm.func @fcmp_fadd_zero_ult(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  : f32
    %2 = llvm.fcmp "ult" %1, %arg1 : f32
    llvm.return %2 : i1
  }
  llvm.func @fcmp_fadd_zero_ule(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  : f32
    %2 = llvm.fcmp "ule" %1, %arg1 : f32
    llvm.return %2 : i1
  }
  llvm.func @fcmp_fadd_zero_olt(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  : f32
    %2 = llvm.fcmp "olt" %1, %arg1 : f32
    llvm.return %2 : i1
  }
  llvm.func @fcmp_fadd_zero_ole(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  : f32
    %2 = llvm.fcmp "ole" %1, %arg1 : f32
    llvm.return %2 : i1
  }
  llvm.func @fcmp_fadd_zero_oeq(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  : f32
    %2 = llvm.fcmp "oeq" %1, %arg1 : f32
    llvm.return %2 : i1
  }
  llvm.func @fcmp_fadd_zero_one(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  : f32
    %2 = llvm.fcmp "one" %1, %arg1 : f32
    llvm.return %2 : i1
  }
  llvm.func @fcmp_fadd_zero_ueq(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  : f32
    %2 = llvm.fcmp "ueq" %1, %arg1 : f32
    llvm.return %2 : i1
  }
  llvm.func @fcmp_fadd_zero_une(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  : f32
    %2 = llvm.fcmp "une" %1, %arg1 : f32
    llvm.return %2 : i1
  }
  llvm.func @fcmp_fadd_zero_ord(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  : f32
    %2 = llvm.fcmp "ord" %1, %arg1 : f32
    llvm.return %2 : i1
  }
  llvm.func @fcmp_fadd_zero_uno(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  : f32
    %2 = llvm.fcmp "uno" %1, %arg1 : f32
    llvm.return %2 : i1
  }
  llvm.func @fcmp_fadd_neg_zero(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  : f32
    %2 = llvm.fcmp "ugt" %1, %arg1 : f32
    llvm.return %2 : i1
  }
  llvm.func @fcmp_fadd_zero_switched(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg1, %0  : f32
    %2 = llvm.fcmp "ugt" %arg0, %1 : f32
    llvm.return %2 : i1
  }
  llvm.func @fcmp_fadd_zero_vec(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[0.000000e+00, -0.000000e+00]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fadd %arg0, %0  : vector<2xf32>
    %2 = llvm.fcmp "ugt" %1, %arg1 : vector<2xf32>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @fcmp_fast_fadd_fast_zero(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %2 = llvm.fcmp "ugt" %1, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %2 : i1
  }
  llvm.func @fcmp_fast_fadd_zero(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  : f32
    %2 = llvm.fcmp "ugt" %1, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %2 : i1
  }
  llvm.func @fcmp_fadd_fast_zero(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %2 = llvm.fcmp "ugt" %1, %arg1 : f32
    llvm.return %2 : i1
  }
  llvm.func @fcmp_ueq_sel_x_negx(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "ueq" %arg0, %0 : f32
    %2 = llvm.fneg %arg0  : f32
    %3 = llvm.select %1, %arg0, %2 : i1, f32
    %4 = llvm.fcmp "ueq" %3, %0 : f32
    llvm.return %4 : i1
  }
  llvm.func @fcmp_une_sel_x_negx(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "une" %arg0, %0 : f32
    %2 = llvm.fneg %arg0  : f32
    %3 = llvm.select %1, %arg0, %2 : i1, f32
    %4 = llvm.fcmp "une" %3, %0 : f32
    llvm.return %4 : i1
  }
  llvm.func @fcmp_oeq_sel_x_negx(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    %2 = llvm.fneg %arg0  : f32
    %3 = llvm.select %1, %arg0, %2 : i1, f32
    %4 = llvm.fcmp "oeq" %3, %0 : f32
    llvm.return %4 : i1
  }
  llvm.func @fcmp_one_sel_x_negx(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "one" %arg0, %0 : f32
    %2 = llvm.fneg %arg0  : f32
    %3 = llvm.select %1, %arg0, %2 : i1, f32
    %4 = llvm.fcmp "one" %3, %0 : f32
    llvm.return %4 : i1
  }
  llvm.func @fcmp_ueq_sel_x_negx_nzero(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %2 = llvm.fcmp "ueq" %arg0, %0 : f32
    %3 = llvm.fneg %arg0  : f32
    %4 = llvm.select %2, %arg0, %3 : i1, f32
    %5 = llvm.fcmp "ueq" %4, %1 : f32
    llvm.return %5 : i1
  }
  llvm.func @fcmp_une_sel_x_negx_nzero(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %2 = llvm.fcmp "une" %arg0, %0 : f32
    %3 = llvm.fneg %arg0  : f32
    %4 = llvm.select %2, %arg0, %3 : i1, f32
    %5 = llvm.fcmp "une" %4, %1 : f32
    llvm.return %5 : i1
  }
  llvm.func @fcmp_oeq_sel_x_negx_nzero(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %2 = llvm.fcmp "oeq" %arg0, %0 : f32
    %3 = llvm.fneg %arg0  : f32
    %4 = llvm.select %2, %arg0, %3 : i1, f32
    %5 = llvm.fcmp "oeq" %4, %1 : f32
    llvm.return %5 : i1
  }
  llvm.func @fcmp_one_sel_x_negx_nzero(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %2 = llvm.fcmp "one" %arg0, %0 : f32
    %3 = llvm.fneg %arg0  : f32
    %4 = llvm.select %2, %arg0, %3 : i1, f32
    %5 = llvm.fcmp "one" %4, %1 : f32
    llvm.return %5 : i1
  }
  llvm.func @fcmp_ueq_sel_x_negx_vec(%arg0: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fcmp "ueq" %arg0, %1 : vector<8xf32>
    %3 = llvm.fneg %arg0  : vector<8xf32>
    %4 = llvm.select %2, %arg0, %3 : vector<8xi1>, vector<8xf32>
    %5 = llvm.fcmp "ueq" %4, %1 : vector<8xf32>
    llvm.return %5 : vector<8xi1>
  }
  llvm.func @fcmp_une_sel_x_negx_vec(%arg0: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fcmp "une" %arg0, %1 : vector<8xf32>
    %3 = llvm.fneg %arg0  : vector<8xf32>
    %4 = llvm.select %2, %arg0, %3 : vector<8xi1>, vector<8xf32>
    %5 = llvm.fcmp "une" %4, %1 : vector<8xf32>
    llvm.return %5 : vector<8xi1>
  }
  llvm.func @fcmp_oeq_sel_x_negx_vec(%arg0: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fcmp "oeq" %arg0, %1 : vector<8xf32>
    %3 = llvm.fneg %arg0  : vector<8xf32>
    %4 = llvm.select %2, %arg0, %3 : vector<8xi1>, vector<8xf32>
    %5 = llvm.fcmp "oeq" %4, %1 : vector<8xf32>
    llvm.return %5 : vector<8xi1>
  }
  llvm.func @fcmp_one_sel_x_negx_vec(%arg0: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fcmp "one" %arg0, %1 : vector<8xf32>
    %3 = llvm.fneg %arg0  : vector<8xf32>
    %4 = llvm.select %2, %arg0, %3 : vector<8xi1>, vector<8xf32>
    %5 = llvm.fcmp "one" %4, %1 : vector<8xf32>
    llvm.return %5 : vector<8xi1>
  }
  llvm.func @fcmp_oeq_sel_x_negx_with_any_fpzero_ninf_vec(%arg0: vector<2xi1>, %arg1: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[0.000000e+00, -0.000000e+00]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fneg %arg1  : vector<2xf32>
    %2 = llvm.select %arg0, %arg1, %1 : vector<2xi1>, vector<2xf32>
    %3 = llvm.fcmp "oeq" %2, %0 {fastmathFlags = #llvm.fastmath<ninf>} : vector<2xf32>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @fcmp_one_sel_x_negx_with_any_fpzero_ninf_vec(%arg0: vector<2xi1>, %arg1: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[0.000000e+00, -0.000000e+00]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fneg %arg1  : vector<2xf32>
    %2 = llvm.select %arg0, %arg1, %1 : vector<2xi1>, vector<2xf32>
    %3 = llvm.fcmp "one" %2, %0 {fastmathFlags = #llvm.fastmath<ninf>} : vector<2xf32>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @fcmp_ueq_sel_x_negx_with_any_fpzero_ninf_vec(%arg0: vector<2xi1>, %arg1: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[0.000000e+00, -0.000000e+00]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fneg %arg1  : vector<2xf32>
    %2 = llvm.select %arg0, %arg1, %1 : vector<2xi1>, vector<2xf32>
    %3 = llvm.fcmp "ueq" %2, %0 {fastmathFlags = #llvm.fastmath<ninf>} : vector<2xf32>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @fcmp_une_sel_x_negx_with_any_fpzero_ninf_vec(%arg0: vector<2xi1>, %arg1: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[0.000000e+00, -0.000000e+00]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fneg %arg1  : vector<2xf32>
    %2 = llvm.select %arg0, %arg1, %1 : vector<2xi1>, vector<2xf32>
    %3 = llvm.fcmp "une" %2, %0 {fastmathFlags = #llvm.fastmath<ninf>} : vector<2xf32>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @fcmp_oeq_sel_x_negx_with_any_fpzero_nnan_vec(%arg0: vector<2xi1>, %arg1: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[0.000000e+00, -0.000000e+00]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fneg %arg1  : vector<2xf32>
    %2 = llvm.select %arg0, %arg1, %1 : vector<2xi1>, vector<2xf32>
    %3 = llvm.fcmp "oeq" %2, %0 {fastmathFlags = #llvm.fastmath<nnan>} : vector<2xf32>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @fcmp_one_sel_x_negx_with_any_fpzero_nnan_vec(%arg0: vector<2xi1>, %arg1: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[0.000000e+00, -0.000000e+00]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fneg %arg1  : vector<2xf32>
    %2 = llvm.select %arg0, %arg1, %1 : vector<2xi1>, vector<2xf32>
    %3 = llvm.fcmp "one" %2, %0 {fastmathFlags = #llvm.fastmath<nnan>} : vector<2xf32>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @fcmp_ueq_sel_x_negx_with_any_fpzero_nnan_vec(%arg0: vector<2xi1>, %arg1: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[0.000000e+00, -0.000000e+00]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fneg %arg1  : vector<2xf32>
    %2 = llvm.select %arg0, %arg1, %1 : vector<2xi1>, vector<2xf32>
    %3 = llvm.fcmp "ueq" %2, %0 {fastmathFlags = #llvm.fastmath<nnan>} : vector<2xf32>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @fcmp_une_sel_x_negx_with_any_fpzero_nnan_vec(%arg0: vector<2xi1>, %arg1: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[0.000000e+00, -0.000000e+00]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fneg %arg1  : vector<2xf32>
    %2 = llvm.select %arg0, %arg1, %1 : vector<2xi1>, vector<2xf32>
    %3 = llvm.fcmp "une" %2, %0 {fastmathFlags = #llvm.fastmath<nnan>} : vector<2xf32>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @fcmp_ueq_fsub_nnan_const_extra_use(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nnan>} : f32
    llvm.call @use(%1) : (f32) -> ()
    %2 = llvm.fcmp "ueq" %1, %0 {fastmathFlags = #llvm.fastmath<nnan>} : f32
    llvm.return %2 : i1
  }
  llvm.func @fcmp_oeq_fsub_ninf_const_extra_use(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<ninf>} : f32
    llvm.call @use(%1) : (f32) -> ()
    %2 = llvm.fcmp "oeq" %1, %0 {fastmathFlags = #llvm.fastmath<ninf>} : f32
    llvm.return %2 : i1
  }
  llvm.func @fcmp_oeq_fsub_const(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fsub %arg0, %arg1  : f32
    %2 = llvm.fcmp "oeq" %1, %0 : f32
    llvm.return %2 : i1
  }
  llvm.func @fcmp_oge_fsub_const(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fsub %arg0, %arg1  : f32
    %2 = llvm.fcmp "oge" %1, %0 : f32
    llvm.return %2 : i1
  }
  llvm.func @fcmp_ole_fsub_const(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fsub %arg0, %arg1  : f32
    %2 = llvm.fcmp "ole" %1, %0 : f32
    llvm.return %2 : i1
  }
  llvm.func @fcmp_ueq_fsub_const(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fsub %arg0, %arg1  : f32
    %2 = llvm.fcmp "ueq" %1, %0 : f32
    llvm.return %2 : i1
  }
  llvm.func @fcmp_uge_fsub_const(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fsub %arg0, %arg1  : f32
    %2 = llvm.fcmp "uge" %1, %0 : f32
    llvm.return %2 : i1
  }
  llvm.func @fcmp_ule_fsub_const(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fsub %arg0, %arg1  : f32
    %2 = llvm.fcmp "ule" %1, %0 : f32
    llvm.return %2 : i1
  }
  llvm.func @fcmp_ugt_fsub_const(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fsub %arg0, %arg1  : f32
    %2 = llvm.fcmp "ugt" %1, %0 : f32
    llvm.return %2 : i1
  }
  llvm.func @fcmp_ult_fsub_const(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fsub %arg0, %arg1  : f32
    %2 = llvm.fcmp "ult" %1, %0 : f32
    llvm.return %2 : i1
  }
  llvm.func @fcmp_une_fsub_const(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fsub %arg0, %arg1  : f32
    %2 = llvm.fcmp "une" %1, %0 : f32
    llvm.return %2 : i1
  }
  llvm.func @fcmp_uge_fsub_const_ninf_vec(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<ninf>} : vector<8xf32>
    %3 = llvm.fcmp "uge" %2, %1 {fastmathFlags = #llvm.fastmath<ninf>} : vector<8xf32>
    llvm.return %3 : vector<8xi1>
  }
  llvm.func @fcmp_ule_fsub_const_ninf_vec(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<ninf>} : vector<8xf32>
    %3 = llvm.fcmp "ule" %2, %1 {fastmathFlags = #llvm.fastmath<ninf>} : vector<8xf32>
    llvm.return %3 : vector<8xi1>
  }
  llvm.func @fcmp_ueq_fsub_const_ninf_vec(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<ninf>} : vector<8xf32>
    %3 = llvm.fcmp "ueq" %2, %1 {fastmathFlags = #llvm.fastmath<ninf>} : vector<8xf32>
    llvm.return %3 : vector<8xi1>
  }
  llvm.func @fcmp_oge_fsub_const_ninf_vec(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<ninf>} : vector<8xf32>
    %3 = llvm.fcmp "oge" %2, %1 {fastmathFlags = #llvm.fastmath<ninf>} : vector<8xf32>
    llvm.return %3 : vector<8xi1>
  }
  llvm.func @fcmp_ole_fsub_const_ninf_vec(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<ninf>} : vector<8xf32>
    %3 = llvm.fcmp "ole" %2, %1 {fastmathFlags = #llvm.fastmath<ninf>} : vector<8xf32>
    llvm.return %3 : vector<8xi1>
  }
  llvm.func @fcmp_oeq_fsub_const_ninf_vec(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<ninf>} : vector<8xf32>
    %3 = llvm.fcmp "oeq" %2, %1 {fastmathFlags = #llvm.fastmath<ninf>} : vector<8xf32>
    llvm.return %3 : vector<8xi1>
  }
  llvm.func @fcmp_ogt_fsub_const_ninf_vec(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<ninf>} : vector<8xf32>
    %3 = llvm.fcmp "ogt" %2, %1 {fastmathFlags = #llvm.fastmath<ninf>} : vector<8xf32>
    llvm.return %3 : vector<8xi1>
  }
  llvm.func @fcmp_olt_fsub_const_ninf_vec(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<ninf>} : vector<8xf32>
    %3 = llvm.fcmp "olt" %2, %1 {fastmathFlags = #llvm.fastmath<ninf>} : vector<8xf32>
    llvm.return %3 : vector<8xi1>
  }
  llvm.func @fcmp_one_fsub_const_ninf_vec(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<ninf>} : vector<8xf32>
    %3 = llvm.fcmp "one" %2, %1 {fastmathFlags = #llvm.fastmath<ninf>} : vector<8xf32>
    llvm.return %3 : vector<8xi1>
  }
  llvm.func @fcmp_ugt_fsub_const_ninf_vec(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<ninf>} : vector<8xf32>
    %3 = llvm.fcmp "ugt" %2, %1 {fastmathFlags = #llvm.fastmath<ninf>} : vector<8xf32>
    llvm.return %3 : vector<8xi1>
  }
  llvm.func @fcmp_ult_fsub_const_ninf_vec(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<ninf>} : vector<8xf32>
    %3 = llvm.fcmp "ult" %2, %1 {fastmathFlags = #llvm.fastmath<ninf>} : vector<8xf32>
    llvm.return %3 : vector<8xi1>
  }
  llvm.func @fcmp_une_fsub_const_ninf_vec(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<ninf>} : vector<8xf32>
    %3 = llvm.fcmp "une" %2, %1 {fastmathFlags = #llvm.fastmath<ninf>} : vector<8xf32>
    llvm.return %3 : vector<8xi1>
  }
  llvm.func @fcmp_uge_fsub_const_nnan_vec(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nnan>} : vector<8xf32>
    %3 = llvm.fcmp "uge" %2, %1 {fastmathFlags = #llvm.fastmath<nnan>} : vector<8xf32>
    llvm.return %3 : vector<8xi1>
  }
  llvm.func @fcmp_ule_fsub_const_nnan_vec(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nnan>} : vector<8xf32>
    %3 = llvm.fcmp "ule" %2, %1 {fastmathFlags = #llvm.fastmath<nnan>} : vector<8xf32>
    llvm.return %3 : vector<8xi1>
  }
  llvm.func @fcmp_ueq_fsub_const_nnan_vec(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nnan>} : vector<8xf32>
    %3 = llvm.fcmp "ueq" %2, %1 {fastmathFlags = #llvm.fastmath<nnan>} : vector<8xf32>
    llvm.return %3 : vector<8xi1>
  }
  llvm.func @fcmp_oge_fsub_const_nnan_vec(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nnan>} : vector<8xf32>
    %3 = llvm.fcmp "oge" %2, %1 {fastmathFlags = #llvm.fastmath<nnan>} : vector<8xf32>
    llvm.return %3 : vector<8xi1>
  }
  llvm.func @fcmp_ole_fsub_const_nnan_vec(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nnan>} : vector<8xf32>
    %3 = llvm.fcmp "ole" %2, %1 {fastmathFlags = #llvm.fastmath<nnan>} : vector<8xf32>
    llvm.return %3 : vector<8xi1>
  }
  llvm.func @fcmp_oeq_fsub_const_nnan_vec(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nnan>} : vector<8xf32>
    %3 = llvm.fcmp "oeq" %2, %1 {fastmathFlags = #llvm.fastmath<nnan>} : vector<8xf32>
    llvm.return %3 : vector<8xi1>
  }
  llvm.func @fcmp_ogt_fsub_const_nnan_vec(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nnan>} : vector<8xf32>
    %3 = llvm.fcmp "ogt" %2, %1 {fastmathFlags = #llvm.fastmath<nnan>} : vector<8xf32>
    llvm.return %3 : vector<8xi1>
  }
  llvm.func @fcmp_olt_fsub_const_nnan_vec(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nnan>} : vector<8xf32>
    %3 = llvm.fcmp "olt" %2, %1 {fastmathFlags = #llvm.fastmath<nnan>} : vector<8xf32>
    llvm.return %3 : vector<8xi1>
  }
  llvm.func @fcmp_one_fsub_const_nnan_vec(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nnan>} : vector<8xf32>
    %3 = llvm.fcmp "one" %2, %1 {fastmathFlags = #llvm.fastmath<nnan>} : vector<8xf32>
    llvm.return %3 : vector<8xi1>
  }
  llvm.func @fcmp_ugt_fsub_const_nnan_vec(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nnan>} : vector<8xf32>
    %3 = llvm.fcmp "ugt" %2, %1 {fastmathFlags = #llvm.fastmath<nnan>} : vector<8xf32>
    llvm.return %3 : vector<8xi1>
  }
  llvm.func @fcmp_ult_fsub_const_nnan_vec(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nnan>} : vector<8xf32>
    %3 = llvm.fcmp "ult" %2, %1 {fastmathFlags = #llvm.fastmath<nnan>} : vector<8xf32>
    llvm.return %3 : vector<8xi1>
  }
  llvm.func @fcmp_une_fsub_const_nnan_vec(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nnan>} : vector<8xf32>
    %3 = llvm.fcmp "une" %2, %1 {fastmathFlags = #llvm.fastmath<nnan>} : vector<8xf32>
    llvm.return %3 : vector<8xi1>
  }
  llvm.func @"fcmp_ugt_fsub_const_vec_denormal_positive-zero"(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> attributes {passthrough = [["denormal-fp-math", "positive-zero,positive-zero"]]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  : vector<8xf32>
    %3 = llvm.fcmp "ogt" %2, %1 : vector<8xf32>
    llvm.return %3 : vector<8xi1>
  }
  llvm.func @fcmp_ogt_fsub_const_vec_denormal_dynamic(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> attributes {passthrough = [["denormal-fp-math", "dynamic,dynamic"]]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  : vector<8xf32>
    %3 = llvm.fcmp "ogt" %2, %1 : vector<8xf32>
    llvm.return %3 : vector<8xi1>
  }
  llvm.func @"fcmp_ogt_fsub_const_vec_denormal_preserve-sign"(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> attributes {passthrough = [["denormal-fp-math", "preserve-sign,preserve-sign"]]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  : vector<8xf32>
    %3 = llvm.fcmp "ogt" %2, %1 : vector<8xf32>
    llvm.return %3 : vector<8xi1>
  }
}
