module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @external() {addr_space = 0 : i32} : i32
  llvm.func @use_vec(vector<2xf32>)
  llvm.func @use_vec3(vector<3xf32>)
  llvm.func @fma_fneg_x_fneg_y(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  : f32
    %2 = llvm.fsub %0, %arg1  : f32
    %3 = llvm.intr.fma(%1, %2, %arg2)  : (f32, f32, f32) -> f32
    llvm.return %3 : f32
  }
  llvm.func @fma_unary_fneg_x_unary_fneg_y(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f32
    %1 = llvm.fneg %arg1  : f32
    %2 = llvm.intr.fma(%0, %1, %arg2)  : (f32, f32, f32) -> f32
    llvm.return %2 : f32
  }
  llvm.func @fma_fneg_x_fneg_y_vec(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<-0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fsub %0, %arg0  : vector<2xf32>
    %2 = llvm.fsub %0, %arg1  : vector<2xf32>
    %3 = llvm.intr.fma(%1, %2, %arg2)  : (vector<2xf32>, vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    llvm.return %3 : vector<2xf32>
  }
  llvm.func @fma_unary_fneg_x_unary_fneg_y_vec(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fneg %arg0  : vector<2xf32>
    %1 = llvm.fneg %arg1  : vector<2xf32>
    %2 = llvm.intr.fma(%0, %1, %arg2)  : (vector<2xf32>, vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    llvm.return %2 : vector<2xf32>
  }
  llvm.func @fma_fneg_x_fneg_y_vec_poison(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<2xf32> {
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
    %14 = llvm.intr.fma(%12, %13, %arg2)  : (vector<2xf32>, vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    llvm.return %14 : vector<2xf32>
  }
  llvm.func @fma_fneg_x_fneg_y_fast(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  : f32
    %2 = llvm.fsub %0, %arg1  : f32
    %3 = llvm.intr.fma(%1, %2, %arg2)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32, f32) -> f32
    llvm.return %3 : f32
  }
  llvm.func @fma_unary_fneg_x_unary_fneg_y_fast(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f32
    %1 = llvm.fneg %arg1  : f32
    %2 = llvm.intr.fma(%0, %1, %arg2)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32, f32) -> f32
    llvm.return %2 : f32
  }
  llvm.func @fma_fneg_const_fneg_y(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.mlir.addressof @external : !llvm.ptr
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i32
    %3 = llvm.bitcast %2 : i32 to f32
    %4 = llvm.fsub %0, %arg0  : f32
    %5 = llvm.fsub %0, %3  : f32
    %6 = llvm.intr.fma(%5, %4, %arg1)  : (f32, f32, f32) -> f32
    llvm.return %6 : f32
  }
  llvm.func @fma_unary_fneg_const_unary_fneg_y(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.addressof @external : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i32
    %2 = llvm.bitcast %1 : i32 to f32
    %3 = llvm.fneg %arg0  : f32
    %4 = llvm.fneg %2  : f32
    %5 = llvm.intr.fma(%4, %3, %arg1)  : (f32, f32, f32) -> f32
    llvm.return %5 : f32
  }
  llvm.func @fma_fneg_x_fneg_const(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.mlir.addressof @external : !llvm.ptr
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i32
    %3 = llvm.bitcast %2 : i32 to f32
    %4 = llvm.fsub %0, %arg0  : f32
    %5 = llvm.fsub %0, %3  : f32
    %6 = llvm.intr.fma(%4, %5, %arg1)  : (f32, f32, f32) -> f32
    llvm.return %6 : f32
  }
  llvm.func @fma_unary_fneg_x_unary_fneg_const(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.addressof @external : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i32
    %2 = llvm.bitcast %1 : i32 to f32
    %3 = llvm.fneg %arg0  : f32
    %4 = llvm.fneg %2  : f32
    %5 = llvm.intr.fma(%3, %4, %arg1)  : (f32, f32, f32) -> f32
    llvm.return %5 : f32
  }
  llvm.func @fma_fabs_x_fabs_y(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.intr.fabs(%arg1)  : (f32) -> f32
    %2 = llvm.intr.fma(%0, %1, %arg2)  : (f32, f32, f32) -> f32
    llvm.return %2 : f32
  }
  llvm.func @fma_fabs_x_fabs_x(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.intr.fma(%0, %0, %arg1)  : (f32, f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @fma_fabs_x_fabs_x_fast(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.intr.fma(%0, %0, %arg1)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @fmuladd_fneg_x_fneg_y(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  : f32
    %2 = llvm.fsub %0, %arg1  : f32
    %3 = llvm.intr.fmuladd(%1, %2, %arg2)  : (f32, f32, f32) -> f32
    llvm.return %3 : f32
  }
  llvm.func @fmuladd_unary_fneg_x_unary_fneg_y(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f32
    %1 = llvm.fneg %arg1  : f32
    %2 = llvm.intr.fmuladd(%0, %1, %arg2)  : (f32, f32, f32) -> f32
    llvm.return %2 : f32
  }
  llvm.func @fmuladd_fneg_x_fneg_y_fast(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  : f32
    %2 = llvm.fsub %0, %arg1  : f32
    %3 = llvm.intr.fmuladd(%1, %2, %arg2)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32, f32) -> f32
    llvm.return %3 : f32
  }
  llvm.func @fmuladd_unfold(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.intr.fmuladd(%arg0, %arg1, %arg2)  {fastmathFlags = #llvm.fastmath<contract, reassoc>} : (f32, f32, f32) -> f32
    llvm.return %0 : f32
  }
  llvm.func @fmuladd_unfold_vec(%arg0: vector<8xf16>, %arg1: vector<8xf16>, %arg2: vector<8xf16>) -> vector<8xf16> {
    %0 = llvm.intr.fmuladd(%arg0, %arg1, %arg2)  {fastmathFlags = #llvm.fastmath<contract, reassoc>} : (vector<8xf16>, vector<8xf16>, vector<8xf16>) -> vector<8xf16>
    llvm.return %0 : vector<8xf16>
  }
  llvm.func @fmuladd_unary_fneg_x_unary_fneg_y_fast(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f32
    %1 = llvm.fneg %arg1  : f32
    %2 = llvm.intr.fmuladd(%0, %1, %arg2)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32, f32) -> f32
    llvm.return %2 : f32
  }
  llvm.func @fmuladd_fneg_const_fneg_y(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.mlir.addressof @external : !llvm.ptr
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i32
    %3 = llvm.bitcast %2 : i32 to f32
    %4 = llvm.fsub %0, %arg0  : f32
    %5 = llvm.fsub %0, %3  : f32
    %6 = llvm.intr.fmuladd(%5, %4, %arg1)  : (f32, f32, f32) -> f32
    llvm.return %6 : f32
  }
  llvm.func @fmuladd_unary_fneg_const_unary_fneg_y(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.addressof @external : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i32
    %2 = llvm.bitcast %1 : i32 to f32
    %3 = llvm.fneg %arg0  : f32
    %4 = llvm.fneg %2  : f32
    %5 = llvm.intr.fmuladd(%4, %3, %arg1)  : (f32, f32, f32) -> f32
    llvm.return %5 : f32
  }
  llvm.func @fmuladd_fneg_x_fneg_const(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.mlir.addressof @external : !llvm.ptr
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i32
    %3 = llvm.bitcast %2 : i32 to f32
    %4 = llvm.fsub %0, %arg0  : f32
    %5 = llvm.fsub %0, %3  : f32
    %6 = llvm.intr.fmuladd(%4, %5, %arg1)  : (f32, f32, f32) -> f32
    llvm.return %6 : f32
  }
  llvm.func @fmuladd_unary_fneg_x_unary_fneg_const(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.addressof @external : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i32
    %2 = llvm.bitcast %1 : i32 to f32
    %3 = llvm.fneg %arg0  : f32
    %4 = llvm.fneg %2  : f32
    %5 = llvm.intr.fmuladd(%3, %4, %arg1)  : (f32, f32, f32) -> f32
    llvm.return %5 : f32
  }
  llvm.func @fmuladd_fabs_x_fabs_y(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.intr.fabs(%arg1)  : (f32) -> f32
    %2 = llvm.intr.fmuladd(%0, %1, %arg2)  : (f32, f32, f32) -> f32
    llvm.return %2 : f32
  }
  llvm.func @fmuladd_fabs_x_fabs_x(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.intr.fmuladd(%0, %0, %arg1)  : (f32, f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @fmuladd_fabs_x_fabs_x_fast(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.intr.fmuladd(%0, %0, %arg1)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @fma_k_y_z(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(4.000000e+00 : f32) : f32
    %1 = llvm.intr.fma(%0, %arg0, %arg1)  : (f32, f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @fma_k_y_z_fast(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(4.000000e+00 : f32) : f32
    %1 = llvm.intr.fma(%0, %arg0, %arg1)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @fmuladd_k_y_z_fast(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(4.000000e+00 : f32) : f32
    %1 = llvm.intr.fmuladd(%0, %arg0, %arg1)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @fma_1_y_z(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.intr.fma(%0, %arg0, %arg1)  : (f32, f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @fma_x_1_z(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.intr.fma(%arg0, %0, %arg1)  : (f32, f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @fma_x_1_z_v2f32(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<1.000000e+00> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.intr.fma(%arg0, %0, %arg1)  : (vector<2xf32>, vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }
  llvm.func @fma_x_1_2_z_v2f32(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.intr.fma(%arg0, %0, %arg1)  : (vector<2xf32>, vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }
  llvm.func @fma_x_1_z_fast(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.intr.fma(%arg0, %0, %arg1)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @fma_1_1_z(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.intr.fma(%0, %0, %arg0)  : (f32, f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @fma_x_y_0(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.intr.fma(%arg0, %arg1, %0)  : (f32, f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @fma_x_y_0_nsz(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.intr.fma(%arg0, %arg1, %0)  {fastmathFlags = #llvm.fastmath<nsz>} : (f32, f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @fma_x_y_0_v(%arg0: vector<8xf16>, %arg1: vector<8xf16>) -> vector<8xf16> {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf16>) : vector<8xf16>
    %2 = llvm.intr.fma(%arg0, %arg1, %1)  : (vector<8xf16>, vector<8xf16>, vector<8xf16>) -> vector<8xf16>
    llvm.return %2 : vector<8xf16>
  }
  llvm.func @fma_x_y_0_nsz_v(%arg0: vector<8xf16>, %arg1: vector<8xf16>) -> vector<8xf16> {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf16>) : vector<8xf16>
    %2 = llvm.intr.fma(%arg0, %arg1, %1)  {fastmathFlags = #llvm.fastmath<nsz>} : (vector<8xf16>, vector<8xf16>, vector<8xf16>) -> vector<8xf16>
    llvm.return %2 : vector<8xf16>
  }
  llvm.func @fmuladd_x_y_0(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.intr.fmuladd(%arg0, %arg1, %0)  : (f32, f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @fmuladd_x_y_0_nsz(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.intr.fmuladd(%arg0, %arg1, %0)  {fastmathFlags = #llvm.fastmath<nsz>} : (f32, f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @fma_x_y_m0(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.intr.fma(%arg0, %arg1, %0)  : (f32, f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @fma_x_y_m0_v(%arg0: vector<8xf16>, %arg1: vector<8xf16>) -> vector<8xf16> {
    %0 = llvm.mlir.constant(dense<-0.000000e+00> : vector<8xf16>) : vector<8xf16>
    %1 = llvm.intr.fma(%arg0, %arg1, %0)  : (vector<8xf16>, vector<8xf16>, vector<8xf16>) -> vector<8xf16>
    llvm.return %1 : vector<8xf16>
  }
  llvm.func @fmuladd_x_y_m0(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.intr.fmuladd(%arg0, %arg1, %0)  : (f32, f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @fmuladd_x_1_z_fast(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.intr.fmuladd(%arg0, %0, %arg1)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @fmuladd_a_0_b(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf64>) : vector<2xf64>
    %2 = llvm.intr.fmuladd(%arg0, %1, %arg1)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (vector<2xf64>, vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    llvm.return %2 : vector<2xf64>
  }
  llvm.func @fmuladd_0_a_b(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf64>) : vector<2xf64>
    %2 = llvm.intr.fmuladd(%1, %arg0, %arg1)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (vector<2xf64>, vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    llvm.return %2 : vector<2xf64>
  }
  llvm.func @fmuladd_a_0_b_missing_flags(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf64>) : vector<2xf64>
    %2 = llvm.intr.fmuladd(%arg0, %1, %arg1)  {fastmathFlags = #llvm.fastmath<nnan>} : (vector<2xf64>, vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    llvm.return %2 : vector<2xf64>
  }
  llvm.func @fma_a_0_b(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf64>) : vector<2xf64>
    %2 = llvm.intr.fma(%arg0, %1, %arg1)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (vector<2xf64>, vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    llvm.return %2 : vector<2xf64>
  }
  llvm.func @fma_0_a_b(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf64>) : vector<2xf64>
    %2 = llvm.intr.fma(%1, %arg0, %arg1)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (vector<2xf64>, vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    llvm.return %2 : vector<2xf64>
  }
  llvm.func @fma_0_a_b_missing_flags(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf64>) : vector<2xf64>
    %2 = llvm.intr.fma(%1, %arg0, %arg1)  {fastmathFlags = #llvm.fastmath<nsz>} : (vector<2xf64>, vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    llvm.return %2 : vector<2xf64>
  }
  llvm.func @fma_sqrt(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.intr.sqrt(%arg0)  {fastmathFlags = #llvm.fastmath<fast>} : (vector<2xf64>) -> vector<2xf64>
    %1 = llvm.intr.fma(%0, %0, %arg1)  {fastmathFlags = #llvm.fastmath<fast>} : (vector<2xf64>, vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    llvm.return %1 : vector<2xf64>
  }
  llvm.func @fma_const_fmul(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<[1123123.0099110012, 9999.0000001000008]> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.mlir.constant(dense<[1.291820e-08, 9.123000e-06]> : vector<2xf64>) : vector<2xf64>
    %2 = llvm.intr.fma(%0, %1, %arg0)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (vector<2xf64>, vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    llvm.return %2 : vector<2xf64>
  }
  llvm.func @fma_const_fmul_zero(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf64>) : vector<2xf64>
    %2 = llvm.mlir.constant(dense<[1123123.0099110012, 9999.0000001000008]> : vector<2xf64>) : vector<2xf64>
    %3 = llvm.intr.fma(%1, %2, %arg0)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (vector<2xf64>, vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    llvm.return %3 : vector<2xf64>
  }
  llvm.func @fma_const_fmul_zero2(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<[1123123.0099110012, 9999.0000001000008]> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf64>) : vector<2xf64>
    %3 = llvm.intr.fma(%0, %2, %arg0)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (vector<2xf64>, vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    llvm.return %3 : vector<2xf64>
  }
  llvm.func @fma_const_fmul_one(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<1.000000e+00> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.mlir.constant(dense<[1123123.0099110012, 9999.0000001000008]> : vector<2xf64>) : vector<2xf64>
    %2 = llvm.intr.fma(%0, %1, %arg0)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (vector<2xf64>, vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    llvm.return %2 : vector<2xf64>
  }
  llvm.func @fma_const_fmul_one2(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<[1123123.0099110012, 9999.0000001000008]> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.mlir.constant(dense<1.000000e+00> : vector<2xf64>) : vector<2xf64>
    %2 = llvm.intr.fma(%0, %1, %arg0)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (vector<2xf64>, vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    llvm.return %2 : vector<2xf64>
  }
  llvm.func @fma_nan_and_const_0(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<0x7FF8000000000000> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.mlir.constant(dense<[1.291820e-08, 9.123000e-06]> : vector<2xf64>) : vector<2xf64>
    %2 = llvm.intr.fma(%0, %1, %arg0)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (vector<2xf64>, vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    llvm.return %2 : vector<2xf64>
  }
  llvm.func @fma_nan_and_const_1(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<[1.291820e-08, 9.123000e-06]> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.mlir.constant(dense<0x7FF8000000000000> : vector<2xf64>) : vector<2xf64>
    %2 = llvm.intr.fma(%0, %1, %arg0)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (vector<2xf64>, vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    llvm.return %2 : vector<2xf64>
  }
  llvm.func @fma_nan_and_const_2(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<[1.291820e-08, 9.123000e-06]> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.mlir.constant(dense<0x7FF8000000000000> : vector<2xf64>) : vector<2xf64>
    %2 = llvm.intr.fma(%0, %arg0, %1)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (vector<2xf64>, vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    llvm.return %2 : vector<2xf64>
  }
  llvm.func @fma_undef_0(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.undef : vector<2xf64>
    %1 = llvm.intr.fma(%0, %arg0, %arg1)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (vector<2xf64>, vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    llvm.return %1 : vector<2xf64>
  }
  llvm.func @fma_undef_1(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.undef : vector<2xf64>
    %1 = llvm.intr.fma(%arg0, %0, %arg1)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (vector<2xf64>, vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    llvm.return %1 : vector<2xf64>
  }
  llvm.func @fma_undef_2(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.undef : vector<2xf64>
    %1 = llvm.intr.fma(%arg0, %arg1, %0)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (vector<2xf64>, vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    llvm.return %1 : vector<2xf64>
  }
  llvm.func @fma_partial_undef_0(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(199.00122999999999 : f64) : f64
    %1 = llvm.mlir.undef : f64
    %2 = llvm.mlir.undef : vector<2xf64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xf64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xf64>
    %7 = llvm.intr.fma(%6, %arg0, %arg1)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (vector<2xf64>, vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    llvm.return %7 : vector<2xf64>
  }
  llvm.func @fma_partial_undef_1(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.undef : f64
    %1 = llvm.mlir.constant(199.00122999999999 : f64) : f64
    %2 = llvm.mlir.undef : vector<2xf64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xf64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xf64>
    %7 = llvm.intr.fma(%arg0, %6, %arg1)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (vector<2xf64>, vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    llvm.return %7 : vector<2xf64>
  }
  llvm.func @fma_partial_undef_2(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.undef : f64
    %1 = llvm.mlir.constant(199.00122999999999 : f64) : f64
    %2 = llvm.mlir.undef : vector<2xf64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xf64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xf64>
    %7 = llvm.intr.fma(%arg0, %arg1, %6)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (vector<2xf64>, vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    llvm.return %7 : vector<2xf64>
  }
  llvm.func @fma_nan_0(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<0x7FF8000000000000> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.intr.fma(%0, %arg0, %arg1)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (vector<2xf64>, vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    llvm.return %1 : vector<2xf64>
  }
  llvm.func @fma_nan_1(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<0x7FF8000000000000> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.intr.fma(%arg0, %0, %arg1)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (vector<2xf64>, vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    llvm.return %1 : vector<2xf64>
  }
  llvm.func @fma_nan_2(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<0x7FF8000000000000> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.intr.fma(%arg0, %arg1, %0)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (vector<2xf64>, vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    llvm.return %1 : vector<2xf64>
  }
  llvm.func @fmuladd_const_fmul(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<[1123123.0099110012, 9999.0000001000008]> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.mlir.constant(dense<[1.291820e-08, 9.123000e-06]> : vector<2xf64>) : vector<2xf64>
    %2 = llvm.intr.fmuladd(%0, %1, %arg0)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (vector<2xf64>, vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    llvm.return %2 : vector<2xf64>
  }
  llvm.func @fmuladd_nan_and_const_0(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<0x7FF8000000000000> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.mlir.constant(dense<[1.291820e-08, 9.123000e-06]> : vector<2xf64>) : vector<2xf64>
    %2 = llvm.intr.fmuladd(%0, %1, %arg0)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (vector<2xf64>, vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    llvm.return %2 : vector<2xf64>
  }
  llvm.func @fmuladd_nan_and_const_1(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<[1.291820e-08, 9.123000e-06]> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.mlir.constant(dense<0x7FF8000000000000> : vector<2xf64>) : vector<2xf64>
    %2 = llvm.intr.fmuladd(%0, %1, %arg0)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (vector<2xf64>, vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    llvm.return %2 : vector<2xf64>
  }
  llvm.func @fmuladd_nan_and_const_2(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<[1.291820e-08, 9.123000e-06]> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.mlir.constant(dense<0x7FF8000000000000> : vector<2xf64>) : vector<2xf64>
    %2 = llvm.intr.fmuladd(%0, %arg0, %1)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (vector<2xf64>, vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    llvm.return %2 : vector<2xf64>
  }
  llvm.func @fmuladd_nan_0(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<0x7FF8000000000000> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.intr.fmuladd(%0, %arg0, %arg1)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (vector<2xf64>, vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    llvm.return %1 : vector<2xf64>
  }
  llvm.func @fmuladd_nan_1(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<0x7FF8000000000000> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.intr.fmuladd(%arg0, %0, %arg1)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (vector<2xf64>, vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    llvm.return %1 : vector<2xf64>
  }
  llvm.func @fmuladd_undef_0(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.undef : vector<2xf64>
    %1 = llvm.intr.fmuladd(%0, %arg0, %arg1)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (vector<2xf64>, vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    llvm.return %1 : vector<2xf64>
  }
  llvm.func @fmuladd_undef_1(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.undef : vector<2xf64>
    %1 = llvm.intr.fmuladd(%arg0, %0, %arg1)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (vector<2xf64>, vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    llvm.return %1 : vector<2xf64>
  }
  llvm.func @fmuladd_undef_2(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<0x7FF8000000000000> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.intr.fmuladd(%arg0, %arg1, %0)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (vector<2xf64>, vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    llvm.return %1 : vector<2xf64>
  }
  llvm.func @fma_unary_shuffle_ops(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.shufflevector %arg0, %0 [1, 0] : vector<2xf32> 
    %2 = llvm.shufflevector %arg1, %0 [1, 0] : vector<2xf32> 
    %3 = llvm.shufflevector %arg2, %0 [1, 0] : vector<2xf32> 
    %4 = llvm.intr.fma(%1, %2, %3)  : (vector<2xf32>, vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    llvm.return %4 : vector<2xf32>
  }
  llvm.func @fma_unary_shuffle_ops_widening(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<3xf32> {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.shufflevector %arg0, %0 [1, 0, 1] : vector<2xf32> 
    llvm.call @use_vec3(%1) : (vector<3xf32>) -> ()
    %2 = llvm.shufflevector %arg1, %0 [1, 0, 1] : vector<2xf32> 
    %3 = llvm.shufflevector %arg2, %0 [1, 0, 1] : vector<2xf32> 
    %4 = llvm.intr.fma(%1, %2, %3)  {fastmathFlags = #llvm.fastmath<fast>} : (vector<3xf32>, vector<3xf32>, vector<3xf32>) -> vector<3xf32>
    llvm.return %4 : vector<3xf32>
  }
  llvm.func @fma_unary_shuffle_ops_narrowing(%arg0: vector<3xf32>, %arg1: vector<3xf32>, %arg2: vector<3xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.poison : vector<3xf32>
    %1 = llvm.shufflevector %arg0, %0 [1, 0] : vector<3xf32> 
    %2 = llvm.shufflevector %arg1, %0 [1, 0] : vector<3xf32> 
    llvm.call @use_vec(%2) : (vector<2xf32>) -> ()
    %3 = llvm.shufflevector %arg2, %0 [1, 0] : vector<3xf32> 
    %4 = llvm.intr.fma(%1, %2, %3)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (vector<2xf32>, vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    llvm.return %4 : vector<2xf32>
  }
  llvm.func @fma_unary_shuffle_ops_unshuffled(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.shufflevector %arg0, %0 [1, 0] : vector<2xf32> 
    %2 = llvm.shufflevector %arg1, %0 [1, 0] : vector<2xf32> 
    %3 = llvm.intr.fma(%1, %2, %arg2)  : (vector<2xf32>, vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    llvm.return %3 : vector<2xf32>
  }
  llvm.func @fma_unary_shuffle_ops_wrong_mask(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.shufflevector %arg0, %0 [1, 0] : vector<2xf32> 
    %2 = llvm.shufflevector %arg1, %0 [0, 0] : vector<2xf32> 
    %3 = llvm.shufflevector %arg2, %0 [1, 0] : vector<2xf32> 
    %4 = llvm.intr.fma(%1, %2, %3)  : (vector<2xf32>, vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    llvm.return %4 : vector<2xf32>
  }
  llvm.func @fma_unary_shuffle_ops_uses(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.shufflevector %arg0, %0 [1, 0] : vector<2xf32> 
    llvm.call @use_vec(%1) : (vector<2xf32>) -> ()
    %2 = llvm.shufflevector %arg1, %0 [1, 0] : vector<2xf32> 
    llvm.call @use_vec(%2) : (vector<2xf32>) -> ()
    %3 = llvm.shufflevector %arg2, %0 [1, 0] : vector<2xf32> 
    llvm.call @use_vec(%3) : (vector<2xf32>) -> ()
    %4 = llvm.intr.fma(%1, %2, %3)  : (vector<2xf32>, vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    llvm.return %4 : vector<2xf32>
  }
}
