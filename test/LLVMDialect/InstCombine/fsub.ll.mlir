module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @b() {addr_space = 0 : i32, alignment = 1 : i64} : i16
  llvm.func @test1(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %arg0, %arg1  : f32
    %2 = llvm.fsub %0, %1  : f32
    llvm.return %2 : f32
  }
  llvm.func @test1_unary(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fsub %arg0, %arg1  : f32
    %1 = llvm.fneg %0  : f32
    llvm.return %1 : f32
  }
  llvm.func @neg_sub_nsz(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %arg0, %arg1  : f32
    %2 = llvm.fsub %0, %1  {fastmathFlags = #llvm.fastmath<nsz>} : f32
    llvm.return %2 : f32
  }
  llvm.func @unary_neg_sub_nsz(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fsub %arg0, %arg1  : f32
    %1 = llvm.fneg %0  {fastmathFlags = #llvm.fastmath<nsz>} : f32
    llvm.return %1 : f32
  }
  llvm.func @use(f32)
  llvm.func @use2(f32, f64)
  llvm.func @neg_sub_nsz_extra_use(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %arg0, %arg1  : f32
    %2 = llvm.fsub %0, %1  {fastmathFlags = #llvm.fastmath<nsz>} : f32
    llvm.call @use(%1) : (f32) -> ()
    llvm.return %2 : f32
  }
  llvm.func @unary_neg_sub_nsz_extra_use(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fsub %arg0, %arg1  : f32
    %1 = llvm.fneg %0  {fastmathFlags = #llvm.fastmath<nsz>} : f32
    llvm.call @use(%0) : (f32) -> ()
    llvm.return %1 : f32
  }
  llvm.func @sub_sub_nsz(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fsub %arg0, %arg1  : f32
    %1 = llvm.fsub %arg2, %0  {fastmathFlags = #llvm.fastmath<nsz>} : f32
    llvm.return %1 : f32
  }
  llvm.func @sub_add_neg_x(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(5.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %0  : f32
    %2 = llvm.fadd %1, %arg1  : f32
    %3 = llvm.fsub %arg1, %2  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %3 : f32
  }
  llvm.func @sub_sub_known_not_negzero(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %1 = llvm.fsub %arg0, %arg1  : f32
    %2 = llvm.fsub %0, %1  : f32
    llvm.return %2 : f32
  }
  llvm.func @test2(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.fadd %arg0, %arg1  : f64
    %1 = llvm.fsub %arg0, %0  : f64
    llvm.return %1 : f64
  }
  llvm.func @constant_op1(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %1 = llvm.fsub %arg0, %0  : f32
    llvm.return %1 : f32
  }
  llvm.func @constant_op1_vec(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<[4.200000e+01, -4.200000e+01]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fsub %arg0, %0  : vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }
  llvm.func @constant_op1_vec_poison(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(-4.200000e+01 : f32) : f32
    %1 = llvm.mlir.poison : f32
    %2 = llvm.mlir.undef : vector<2xf32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xf32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xf32>
    %7 = llvm.fsub %arg0, %6  : vector<2xf32>
    llvm.return %7 : vector<2xf32>
  }
  llvm.func @neg_op1(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg1  : f32
    %2 = llvm.fsub %arg0, %1  : f32
    llvm.return %2 : f32
  }
  llvm.func @unary_neg_op1(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fneg %arg1  : f32
    %1 = llvm.fsub %arg0, %0  : f32
    llvm.return %1 : f32
  }
  llvm.func @neg_op1_vec(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<-0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fsub %0, %arg1  : vector<2xf32>
    %2 = llvm.fsub %arg0, %1  : vector<2xf32>
    llvm.return %2 : vector<2xf32>
  }
  llvm.func @unary_neg_op1_vec(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fneg %arg1  : vector<2xf32>
    %1 = llvm.fsub %arg0, %0  : vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }
  llvm.func @neg_op1_vec_poison(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.poison : f32
    %1 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %2 = llvm.mlir.undef : vector<2xf32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xf32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xf32>
    %7 = llvm.fsub %6, %arg1  : vector<2xf32>
    %8 = llvm.fsub %arg0, %7  : vector<2xf32>
    llvm.return %8 : vector<2xf32>
  }
  llvm.func @neg_ext_op1(%arg0: f32, %arg1: f64) -> f64 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  : f32
    %2 = llvm.fpext %1 : f32 to f64
    %3 = llvm.fsub %arg1, %2  : f64
    llvm.return %3 : f64
  }
  llvm.func @unary_neg_ext_op1(%arg0: f32, %arg1: f64) -> f64 {
    %0 = llvm.fneg %arg0  : f32
    %1 = llvm.fpext %0 : f32 to f64
    %2 = llvm.fsub %arg1, %1  : f64
    llvm.return %2 : f64
  }
  llvm.func @neg_trunc_op1(%arg0: vector<2xf64>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<-0.000000e+00> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.fsub %0, %arg0  : vector<2xf64>
    %2 = llvm.fptrunc %1 : vector<2xf64> to vector<2xf32>
    %3 = llvm.fsub %arg1, %2  : vector<2xf32>
    llvm.return %3 : vector<2xf32>
  }
  llvm.func @unary_neg_trunc_op1(%arg0: vector<2xf64>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fneg %arg0  : vector<2xf64>
    %1 = llvm.fptrunc %0 : vector<2xf64> to vector<2xf32>
    %2 = llvm.fsub %arg1, %1  : vector<2xf32>
    llvm.return %2 : vector<2xf32>
  }
  llvm.func @neg_ext_op1_fast(%arg0: f32, %arg1: f64) -> f64 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  : f32
    %2 = llvm.fpext %1 : f32 to f64
    %3 = llvm.fsub %arg1, %2  {fastmathFlags = #llvm.fastmath<fast>} : f64
    llvm.return %3 : f64
  }
  llvm.func @unary_neg_ext_op1_fast(%arg0: f32, %arg1: f64) -> f64 {
    %0 = llvm.fneg %arg0  : f32
    %1 = llvm.fpext %0 : f32 to f64
    %2 = llvm.fsub %arg1, %1  {fastmathFlags = #llvm.fastmath<fast>} : f64
    llvm.return %2 : f64
  }
  llvm.func @neg_ext_op1_extra_use(%arg0: f16, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f16) : f16
    %1 = llvm.fsub %0, %arg0  : f16
    %2 = llvm.fpext %1 : f16 to f32
    %3 = llvm.fsub %arg1, %2  : f32
    llvm.call @use(%2) : (f32) -> ()
    llvm.return %3 : f32
  }
  llvm.func @unary_neg_ext_op1_extra_use(%arg0: f16, %arg1: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f16
    %1 = llvm.fpext %0 : f16 to f32
    %2 = llvm.fsub %arg1, %1  : f32
    llvm.call @use(%1) : (f32) -> ()
    llvm.return %2 : f32
  }
  llvm.func @neg_trunc_op1_extra_use(%arg0: f64, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %1 = llvm.fsub %0, %arg0  : f64
    %2 = llvm.fptrunc %1 : f64 to f32
    %3 = llvm.fsub %arg1, %2  : f32
    llvm.call @use(%2) : (f32) -> ()
    llvm.return %3 : f32
  }
  llvm.func @unary_neg_trunc_op1_extra_use(%arg0: f64, %arg1: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f64
    %1 = llvm.fptrunc %0 : f64 to f32
    %2 = llvm.fsub %arg1, %1  : f32
    llvm.call @use(%1) : (f32) -> ()
    llvm.return %2 : f32
  }
  llvm.func @neg_trunc_op1_extra_uses(%arg0: f64, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %1 = llvm.fsub %0, %arg0  : f64
    %2 = llvm.fptrunc %1 : f64 to f32
    %3 = llvm.fsub %arg1, %2  : f32
    llvm.call @use2(%2, %1) : (f32, f64) -> ()
    llvm.return %3 : f32
  }
  llvm.func @unary_neg_trunc_op1_extra_uses(%arg0: f64, %arg1: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f64
    %1 = llvm.fptrunc %0 : f64 to f32
    %2 = llvm.fsub %arg1, %1  : f32
    llvm.call @use2(%1, %0) : (f32, f64) -> ()
    llvm.return %2 : f32
  }
  llvm.func @PR37605(%arg0: f32) -> f32 {
    %0 = llvm.mlir.addressof @b : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i32
    %2 = llvm.bitcast %1 : i32 to f32
    %3 = llvm.fsub %arg0, %2  : f32
    llvm.return %3 : f32
  }
  llvm.func @fsub_fdiv_fneg1(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %1 = llvm.fsub %0, %arg0  : f64
    %2 = llvm.fdiv %1, %arg1  : f64
    %3 = llvm.fsub %arg2, %2  : f64
    llvm.return %3 : f64
  }
  llvm.func @fsub_fdiv_fneg2(%arg0: vector<2xf64>, %arg1: vector<2xf64>, %arg2: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<-0.000000e+00> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.fsub %0, %arg0  : vector<2xf64>
    %2 = llvm.fdiv %arg1, %1  : vector<2xf64>
    %3 = llvm.fsub %arg2, %2  : vector<2xf64>
    llvm.return %3 : vector<2xf64>
  }
  llvm.func @fsub_fmul_fneg1(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %1 = llvm.fsub %0, %arg0  : f64
    %2 = llvm.fmul %1, %arg1  : f64
    %3 = llvm.fsub %arg2, %2  : f64
    llvm.return %3 : f64
  }
  llvm.func @fsub_fmul_fneg2(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %1 = llvm.fsub %0, %arg0  : f64
    %2 = llvm.fmul %arg1, %1  : f64
    %3 = llvm.fsub %arg2, %2  : f64
    llvm.return %3 : f64
  }
  llvm.func @fsub_fdiv_fneg1_extra_use(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  : f32
    %2 = llvm.fdiv %1, %arg1  : f32
    llvm.call @use(%2) : (f32) -> ()
    %3 = llvm.fsub %arg2, %2  : f32
    llvm.return %3 : f32
  }
  llvm.func @fsub_fdiv_fneg2_extra_use(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  : f32
    %2 = llvm.fdiv %arg1, %1  : f32
    llvm.call @use(%2) : (f32) -> ()
    %3 = llvm.fsub %arg2, %2  : f32
    llvm.return %3 : f32
  }
  llvm.func @use_vec(vector<2xf32>)
  llvm.func @fsub_fmul_fneg1_extra_use(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<-0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fsub %0, %arg0  : vector<2xf32>
    %2 = llvm.fmul %1, %arg1  : vector<2xf32>
    llvm.call @use_vec(%2) : (vector<2xf32>) -> ()
    %3 = llvm.fsub %arg2, %2  : vector<2xf32>
    llvm.return %3 : vector<2xf32>
  }
  llvm.func @fsub_fmul_fneg2_extra_use(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  : f32
    %2 = llvm.fmul %arg1, %1  : f32
    llvm.call @use(%2) : (f32) -> ()
    %3 = llvm.fsub %arg2, %2  : f32
    llvm.return %3 : f32
  }
  llvm.func @fsub_fdiv_fneg1_extra_use2(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  : f32
    llvm.call @use(%1) : (f32) -> ()
    %2 = llvm.fdiv %1, %arg1  : f32
    %3 = llvm.fsub %arg2, %2  : f32
    llvm.return %3 : f32
  }
  llvm.func @fsub_fdiv_fneg2_extra_use2(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  : f32
    llvm.call @use(%1) : (f32) -> ()
    %2 = llvm.fdiv %arg1, %1  : f32
    %3 = llvm.fsub %arg2, %2  : f32
    llvm.return %3 : f32
  }
  llvm.func @fsub_fmul_fneg1_extra_use2(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<-0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fsub %0, %arg0  : vector<2xf32>
    llvm.call @use_vec(%1) : (vector<2xf32>) -> ()
    %2 = llvm.fmul %1, %arg1  : vector<2xf32>
    %3 = llvm.fsub %arg2, %2  : vector<2xf32>
    llvm.return %3 : vector<2xf32>
  }
  llvm.func @fsub_fmul_fneg2_extra_use2(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  : f32
    llvm.call @use(%1) : (f32) -> ()
    %2 = llvm.fmul %arg1, %1  : f32
    %3 = llvm.fsub %arg2, %2  : f32
    llvm.return %3 : f32
  }
  llvm.func @fsub_fdiv_fneg1_extra_use3(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  : f32
    llvm.call @use(%1) : (f32) -> ()
    %2 = llvm.fdiv %1, %arg1  : f32
    llvm.call @use(%2) : (f32) -> ()
    %3 = llvm.fsub %arg2, %2  : f32
    llvm.return %3 : f32
  }
  llvm.func @fsub_fdiv_fneg2_extra_use3(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  : f32
    llvm.call @use(%1) : (f32) -> ()
    %2 = llvm.fdiv %arg1, %1  : f32
    llvm.call @use(%2) : (f32) -> ()
    %3 = llvm.fsub %arg2, %2  : f32
    llvm.return %3 : f32
  }
  llvm.func @fsub_fmul_fneg1_extra_use3(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<-0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fsub %0, %arg0  : vector<2xf32>
    llvm.call @use_vec(%1) : (vector<2xf32>) -> ()
    %2 = llvm.fmul %1, %arg1  : vector<2xf32>
    llvm.call @use_vec(%2) : (vector<2xf32>) -> ()
    %3 = llvm.fsub %arg2, %2  : vector<2xf32>
    llvm.return %3 : vector<2xf32>
  }
  llvm.func @fsub_fmul_fneg2_extra_use3(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  : f32
    llvm.call @use(%1) : (f32) -> ()
    %2 = llvm.fmul %arg1, %1  : f32
    llvm.call @use(%2) : (f32) -> ()
    %3 = llvm.fsub %arg2, %2  : f32
    llvm.return %3 : f32
  }
  llvm.func @fsub_fsub(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fsub %arg0, %arg1  : f32
    %1 = llvm.fsub %0, %arg2  : f32
    llvm.return %1 : f32
  }
  llvm.func @fsub_fsub_nsz(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fsub %arg0, %arg1  : f32
    %1 = llvm.fsub %0, %arg2  {fastmathFlags = #llvm.fastmath<nsz>} : f32
    llvm.return %1 : f32
  }
  llvm.func @fsub_fsub_reassoc(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fsub %arg0, %arg1  : f32
    %1 = llvm.fsub %0, %arg2  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    llvm.return %1 : f32
  }
  llvm.func @fsub_fsub_nsz_reassoc(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fsub %arg0, %arg1  : f32
    %1 = llvm.fsub %0, %arg2  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %1 : f32
  }
  llvm.func @fsub_fsub_fast_vec(%arg0: vector<2xf64>, %arg1: vector<2xf64>, %arg2: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : vector<2xf64>
    %1 = llvm.fsub %0, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : vector<2xf64>
    llvm.return %1 : vector<2xf64>
  }
  llvm.func @fsub_fsub_nsz_reassoc_extra_use(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fsub %arg0, %arg1  : f32
    llvm.call @use(%0) : (f32) -> ()
    %1 = llvm.fsub %0, %arg2  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %1 : f32
  }
  llvm.func @fneg_fsub(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f32
    %1 = llvm.fsub %0, %arg1  : f32
    llvm.return %1 : f32
  }
  llvm.func @fneg_fsub_nsz(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f32
    %1 = llvm.fsub %0, %arg1  {fastmathFlags = #llvm.fastmath<nsz>} : f32
    llvm.return %1 : f32
  }
  llvm.func @fake_fneg_fsub_fast(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  : f32
    %2 = llvm.fsub %1, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %2 : f32
  }
  llvm.func @fake_fneg_fsub_fast_extra_use(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  : f32
    llvm.call @use(%1) : (f32) -> ()
    %2 = llvm.fsub %1, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %2 : f32
  }
  llvm.func @fake_fneg_fsub_vec(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<-0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fsub %0, %arg0  : vector<2xf32>
    %2 = llvm.fsub %1, %arg1  {fastmathFlags = #llvm.fastmath<nsz>} : vector<2xf32>
    llvm.return %2 : vector<2xf32>
  }
  llvm.func @fneg_fsub_constant(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %1 = llvm.fneg %arg0  : f32
    %2 = llvm.fsub %1, %0  {fastmathFlags = #llvm.fastmath<nsz>} : f32
    llvm.return %2 : f32
  }
  llvm.func @fsub_fadd_fsub_reassoc(%arg0: f32, %arg1: f32, %arg2: f32, %arg3: f32) -> f32 {
    %0 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    %1 = llvm.fadd %0, %arg2  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    %2 = llvm.fsub %1, %arg3  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %2 : f32
  }
  llvm.func @fsub_fadd_fsub_reassoc_commute(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>, %arg3: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<[4.200000e+01, -4.200000e+01]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fdiv %arg2, %0  : vector<2xf32>
    %2 = llvm.fsub %arg0, %arg1  : vector<2xf32>
    %3 = llvm.fadd %1, %2  : vector<2xf32>
    %4 = llvm.fsub %3, %arg3  {fastmathFlags = #llvm.fastmath<fast>} : vector<2xf32>
    llvm.return %4 : vector<2xf32>
  }
  llvm.func @fsub_fadd_fsub_reassoc_twice(%arg0: f32, %arg1: f32, %arg2: f32, %arg3: f32, %arg4: f32) -> f32 {
    %0 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    %1 = llvm.fsub %arg2, %arg3  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    %2 = llvm.fadd %0, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    %3 = llvm.fsub %2, %arg4  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %3 : f32
  }
  llvm.func @fsub_fadd_fsub_not_reassoc(%arg0: f32, %arg1: f32, %arg2: f32, %arg3: f32) -> f32 {
    %0 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %1 = llvm.fadd %0, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %2 = llvm.fsub %1, %arg3  {fastmathFlags = #llvm.fastmath<nsz>} : f32
    llvm.return %2 : f32
  }
  llvm.func @fsub_fadd_fsub_reassoc_use1(%arg0: f32, %arg1: f32, %arg2: f32, %arg3: f32) -> f32 {
    %0 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.call @use(%0) : (f32) -> ()
    %1 = llvm.fadd %0, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %2 = llvm.fsub %1, %arg3  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %2 : f32
  }
  llvm.func @fsub_fadd_fsub_reassoc_use2(%arg0: f32, %arg1: f32, %arg2: f32, %arg3: f32) -> f32 {
    %0 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %1 = llvm.fadd %0, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.call @use(%1) : (f32) -> ()
    %2 = llvm.fsub %1, %arg3  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %2 : f32
  }
  llvm.func @fmul_c1(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %1 = llvm.fmul %arg0, %0  : f32
    %2 = llvm.fsub %arg1, %1  : f32
    llvm.return %2 : f32
  }
  llvm.func @fmul_c1_fmf(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<[4.200000e+01, 5.000000e-01]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<ninf, nsz>} : vector<2xf32>
    %2 = llvm.fsub %arg1, %1  : vector<2xf32>
    llvm.return %2 : vector<2xf32>
  }
  llvm.func @fmul_c1_use(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %1 = llvm.fmul %arg0, %0  : f32
    llvm.call @use(%1) : (f32) -> ()
    %2 = llvm.fsub %arg1, %1  : f32
    llvm.return %2 : f32
  }
  llvm.func @fdiv_c0(%arg0: f16, %arg1: f16) -> f16 {
    %0 = llvm.mlir.constant(7.000000e+00 : f16) : f16
    %1 = llvm.fdiv %0, %arg0  : f16
    %2 = llvm.fsub %arg1, %1  : f16
    llvm.return %2 : f16
  }
  llvm.func @fdiv_c0_fmf(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.mlir.constant(7.000000e+00 : f64) : f64
    %1 = llvm.fdiv %0, %arg0  : f64
    %2 = llvm.fsub %arg1, %1  {fastmathFlags = #llvm.fastmath<nnan, reassoc>} : f64
    llvm.return %2 : f64
  }
  llvm.func @fdiv_c1(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<[4.270000e+02, -0.000000e+00]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fdiv %arg0, %0  : vector<2xf32>
    %2 = llvm.fsub %arg1, %1  : vector<2xf32>
    llvm.return %2 : vector<2xf32>
  }
  llvm.func @fdiv_c1_fmf(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(4.270000e+02 : f32) : f32
    %1 = llvm.fdiv %arg0, %0  {fastmathFlags = #llvm.fastmath<nnan>} : f32
    %2 = llvm.fsub %arg1, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    llvm.return %2 : f32
  }
  llvm.func @fdiv_c1_use(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<[4.270000e+02, -0.000000e+00]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fdiv %arg0, %0  : vector<2xf32>
    llvm.call @use_vec(%1) : (vector<2xf32>) -> ()
    %2 = llvm.fsub %arg1, %1  : vector<2xf32>
    llvm.return %2 : vector<2xf32>
  }
}
