module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @fadd_fpext_op0(%arg0: f32, %arg1: f64) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fadd %0, %arg1  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }
  llvm.func @fsub_fpext_op1(%arg0: f16, %arg1: f64) -> f16 {
    %0 = llvm.fpext %arg0 : f16 to f64
    %1 = llvm.fsub %arg1, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    %2 = llvm.fptrunc %1 : f64 to f16
    llvm.return %2 : f16
  }
  llvm.func @fdiv_constant_op0(%arg0: vector<2xf64>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<[4.210000e+01, -1.000000e-01]> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.fdiv %0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : vector<2xf64>
    %2 = llvm.fptrunc %1 : vector<2xf64> to vector<2xf32>
    llvm.return %2 : vector<2xf32>
  }
  llvm.func @fmul_constant_op1(%arg0: vector<2xf32>) -> vector<2xf16> {
    %0 = llvm.mlir.constant(dense<[3.40282347E+38, 5.000000e-01]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : vector<2xf32>
    %2 = llvm.fptrunc %1 : vector<2xf32> to vector<2xf16>
    llvm.return %2 : vector<2xf16>
  }
  llvm.func @fptrunc_select_true_val(%arg0: f32, %arg1: f64, %arg2: i1) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.select %arg2, %arg1, %0 {fastmathFlags = #llvm.fastmath<fast>} : i1, f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }
  llvm.func @fptrunc_select_false_val(%arg0: vector<2xf32>, %arg1: vector<2xf64>, %arg2: vector<2xi1>) -> vector<2xf32> {
    %0 = llvm.fpext %arg0 : vector<2xf32> to vector<2xf64>
    %1 = llvm.select %arg2, %0, %arg1 {fastmathFlags = #llvm.fastmath<nnan>} : vector<2xi1>, vector<2xf64>
    %2 = llvm.fptrunc %1 : vector<2xf64> to vector<2xf32>
    llvm.return %2 : vector<2xf32>
  }
  llvm.func @use(f32)
  llvm.func @fptrunc_select_true_val_extra_use(%arg0: f16, %arg1: f32, %arg2: i1) -> f16 {
    %0 = llvm.fpext %arg0 : f16 to f32
    llvm.call @use(%0) : (f32) -> ()
    %1 = llvm.select %arg2, %arg1, %0 {fastmathFlags = #llvm.fastmath<ninf>} : i1, f32
    %2 = llvm.fptrunc %1 : f32 to f16
    llvm.return %2 : f16
  }
  llvm.func @fptrunc_select_true_val_extra_use_2(%arg0: f16, %arg1: f32, %arg2: i1) -> f16 {
    %0 = llvm.fpext %arg0 : f16 to f32
    %1 = llvm.select %arg2, %arg1, %0 {fastmathFlags = #llvm.fastmath<ninf>} : i1, f32
    llvm.call @use(%1) : (f32) -> ()
    %2 = llvm.fptrunc %1 : f32 to f16
    llvm.return %2 : f16
  }
  llvm.func @fptrunc_select_true_val_type_mismatch(%arg0: f16, %arg1: f64, %arg2: i1) -> f32 {
    %0 = llvm.fpext %arg0 : f16 to f64
    %1 = llvm.select %arg2, %arg1, %0 : i1, f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }
  llvm.func @fptrunc_select_true_val_type_mismatch_fast(%arg0: f16, %arg1: f64, %arg2: i1) -> f32 {
    %0 = llvm.fpext %arg0 : f16 to f64
    %1 = llvm.select %arg2, %arg1, %0 {fastmathFlags = #llvm.fastmath<fast>} : i1, f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }
  llvm.func @ItoFtoF_s54_f64_f32(%arg0: vector<2xi54>) -> vector<2xf32> {
    %0 = llvm.sitofp %arg0 : vector<2xi54> to vector<2xf64>
    %1 = llvm.fptrunc %0 : vector<2xf64> to vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }
  llvm.func @ItoFtoF_u24_f32_f16(%arg0: i24) -> f16 {
    %0 = llvm.uitofp %arg0 : i24 to f32
    llvm.call @use(%0) : (f32) -> ()
    %1 = llvm.fptrunc %0 : f32 to f16
    llvm.return %1 : f16
  }
  llvm.func @ItoFtoF_s55_f64_f32(%arg0: i55) -> f32 {
    %0 = llvm.sitofp %arg0 : i55 to f64
    %1 = llvm.fptrunc %0 : f64 to f32
    llvm.return %1 : f32
  }
  llvm.func @ItoFtoF_u25_f32_f16(%arg0: i25) -> f16 {
    %0 = llvm.uitofp %arg0 : i25 to f32
    %1 = llvm.fptrunc %0 : f32 to f16
    llvm.return %1 : f16
  }
  llvm.func @fptrunc_to_bfloat_bitcast_to_half(%arg0: f32) -> f16 {
    %0 = llvm.fptrunc %arg0 : f32 to bf16
    %1 = llvm.bitcast %0 : bf16 to f16
    llvm.return %1 : f16
  }
}
