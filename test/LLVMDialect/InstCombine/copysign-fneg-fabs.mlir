module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @copysign_fneg_x(%arg0: f16, %arg1: f16) -> f16 {
    %0 = llvm.fneg %arg0  : f16
    %1 = llvm.intr.copysign(%0, %arg1)  : (f16, f16) -> f16
    llvm.return %1 : f16
  }
  llvm.func @copysign_fabs_x(%arg0: f16, %arg1: f16) -> f16 {
    %0 = llvm.intr.fabs(%arg0)  : (f16) -> f16
    %1 = llvm.intr.copysign(%0, %arg1)  : (f16, f16) -> f16
    llvm.return %1 : f16
  }
  llvm.func @copysign_fneg_fabs_x(%arg0: f16, %arg1: f16) -> f16 {
    %0 = llvm.intr.fabs(%arg0)  : (f16) -> f16
    %1 = llvm.fneg %0  : f16
    %2 = llvm.intr.copysign(%1, %arg1)  : (f16, f16) -> f16
    llvm.return %2 : f16
  }
  llvm.func @copysign_fneg_y(%arg0: f16, %arg1: f16) -> f16 {
    %0 = llvm.fneg %arg1  : f16
    %1 = llvm.intr.copysign(%arg0, %0)  : (f16, f16) -> f16
    llvm.return %1 : f16
  }
  llvm.func @copysign_fabs_y(%arg0: f16, %arg1: f16) -> f16 {
    %0 = llvm.intr.fabs(%arg1)  : (f16) -> f16
    %1 = llvm.intr.copysign(%arg0, %0)  : (f16, f16) -> f16
    llvm.return %1 : f16
  }
  llvm.func @copysign_fneg_fabs_y(%arg0: f16, %arg1: f16) -> f16 {
    %0 = llvm.intr.fabs(%arg1)  : (f16) -> f16
    %1 = llvm.fneg %0  : f16
    %2 = llvm.intr.copysign(%arg0, %1)  : (f16, f16) -> f16
    llvm.return %2 : f16
  }
  llvm.func @fneg_copysign(%arg0: f16, %arg1: f16) -> f16 {
    %0 = llvm.intr.copysign(%arg0, %arg1)  : (f16, f16) -> f16
    %1 = llvm.fneg %0  : f16
    llvm.return %1 : f16
  }
  llvm.func @fneg_fabs_copysign(%arg0: f16, %arg1: f16) -> f16 {
    %0 = llvm.intr.copysign(%arg0, %arg1)  : (f16, f16) -> f16
    %1 = llvm.intr.fabs(%0)  : (f16) -> f16
    %2 = llvm.fneg %1  : f16
    llvm.return %2 : f16
  }
  llvm.func @fabs_copysign(%arg0: f16, %arg1: f16) -> f16 {
    %0 = llvm.intr.copysign(%arg0, %arg1)  : (f16, f16) -> f16
    %1 = llvm.intr.fabs(%0)  : (f16) -> f16
    llvm.return %1 : f16
  }
  llvm.func @fneg_copysign_vector(%arg0: vector<2xf16>, %arg1: vector<2xf16>) -> vector<2xf16> {
    %0 = llvm.intr.copysign(%arg0, %arg1)  : (vector<2xf16>, vector<2xf16>) -> vector<2xf16>
    %1 = llvm.fneg %0  : vector<2xf16>
    llvm.return %1 : vector<2xf16>
  }
  llvm.func @fneg_fabs_copysign_vector(%arg0: vector<2xf16>, %arg1: vector<2xf16>) -> vector<2xf16> {
    %0 = llvm.intr.copysign(%arg0, %arg1)  : (vector<2xf16>, vector<2xf16>) -> vector<2xf16>
    %1 = llvm.intr.fabs(%0)  : (vector<2xf16>) -> vector<2xf16>
    %2 = llvm.fneg %1  : vector<2xf16>
    llvm.return %2 : vector<2xf16>
  }
  llvm.func @fabs_copysign_vector(%arg0: vector<2xf16>, %arg1: vector<2xf16>) -> vector<2xf16> {
    %0 = llvm.intr.copysign(%arg0, %arg1)  : (vector<2xf16>, vector<2xf16>) -> vector<2xf16>
    %1 = llvm.intr.fabs(%0)  : (vector<2xf16>) -> vector<2xf16>
    llvm.return %1 : vector<2xf16>
  }
  llvm.func @fneg_copysign_flags(%arg0: f16, %arg1: f16) -> f16 {
    %0 = llvm.intr.copysign(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (f16, f16) -> f16
    %1 = llvm.fneg %0  {fastmathFlags = #llvm.fastmath<ninf, nsz>} : f16
    llvm.return %1 : f16
  }
  llvm.func @fneg_fabs_copysign_flags(%arg0: f16, %arg1: f16) -> f16 {
    %0 = llvm.intr.copysign(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<nnan, ninf, nsz>} : (f16, f16) -> f16
    %1 = llvm.intr.fabs(%0)  {fastmathFlags = #llvm.fastmath<nnan, ninf, afn>} : (f16) -> f16
    %2 = llvm.fneg %1  {fastmathFlags = #llvm.fastmath<ninf, reassoc>} : f16
    llvm.return %2 : f16
  }
  llvm.func @fneg_nsz_copysign(%arg0: f16, %arg1: f16) -> f16 {
    %0 = llvm.intr.copysign(%arg0, %arg1)  : (f16, f16) -> f16
    %1 = llvm.fneg %0  {fastmathFlags = #llvm.fastmath<nsz>} : f16
    llvm.return %1 : f16
  }
  llvm.func @fneg_fabs_copysign_flags_none_fabs(%arg0: f16, %arg1: f16) -> f16 {
    %0 = llvm.intr.copysign(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<nnan, ninf, nsz>} : (f16, f16) -> f16
    %1 = llvm.intr.fabs(%0)  : (f16) -> f16
    %2 = llvm.fneg %1  {fastmathFlags = #llvm.fastmath<fast>} : f16
    llvm.return %2 : f16
  }
  llvm.func @fabs_copysign_flags(%arg0: f16, %arg1: f16) -> f16 {
    %0 = llvm.intr.copysign(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<nnan>} : (f16, f16) -> f16
    %1 = llvm.intr.fabs(%0)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (f16) -> f16
    llvm.return %1 : f16
  }
  llvm.func @fabs_copysign_all_flags(%arg0: f16, %arg1: f16) -> f16 {
    %0 = llvm.intr.copysign(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<fast>} : (f16, f16) -> f16
    %1 = llvm.intr.fabs(%0)  {fastmathFlags = #llvm.fastmath<fast>} : (f16) -> f16
    llvm.return %1 : f16
  }
  llvm.func @fabs_copysign_no_flags_copysign_user(%arg0: f16, %arg1: f16, %arg2: !llvm.ptr) -> f16 {
    %0 = llvm.intr.copysign(%arg0, %arg1)  : (f16, f16) -> f16
    llvm.store %0, %arg2 {alignment = 2 : i64} : f16, !llvm.ptr
    %1 = llvm.intr.fabs(%0)  {fastmathFlags = #llvm.fastmath<fast>} : (f16) -> f16
    llvm.return %1 : f16
  }
  llvm.func @fneg_fabs_copysign_drop_flags(%arg0: f16, %arg1: f16) -> f16 {
    %0 = llvm.intr.copysign(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<nnan>} : (f16, f16) -> f16
    %1 = llvm.intr.fabs(%0)  {fastmathFlags = #llvm.fastmath<ninf>} : (f16) -> f16
    %2 = llvm.fneg %1  {fastmathFlags = #llvm.fastmath<nsz>} : f16
    llvm.return %2 : f16
  }
  llvm.func @fneg_copysign_multi_use(%arg0: f16, %arg1: f16, %arg2: !llvm.ptr) -> f16 {
    %0 = llvm.intr.copysign(%arg0, %arg1)  : (f16, f16) -> f16
    llvm.store %0, %arg2 {alignment = 2 : i64} : f16, !llvm.ptr
    %1 = llvm.fneg %0  : f16
    llvm.return %1 : f16
  }
  llvm.func @fabs_copysign_multi_use(%arg0: f16, %arg1: f16, %arg2: !llvm.ptr) -> f16 {
    %0 = llvm.intr.copysign(%arg0, %arg1)  : (f16, f16) -> f16
    llvm.store %0, %arg2 {alignment = 2 : i64} : f16, !llvm.ptr
    %1 = llvm.intr.fabs(%0)  : (f16) -> f16
    llvm.return %1 : f16
  }
  llvm.func @fabs_flags_copysign_multi_use(%arg0: f16, %arg1: f16, %arg2: !llvm.ptr) -> f16 {
    %0 = llvm.intr.copysign(%arg0, %arg1)  : (f16, f16) -> f16
    llvm.store %0, %arg2 {alignment = 2 : i64} : f16, !llvm.ptr
    %1 = llvm.intr.fabs(%0)  {fastmathFlags = #llvm.fastmath<nnan, ninf>} : (f16) -> f16
    llvm.return %1 : f16
  }
  llvm.func @fneg_fabs_copysign_multi_use_fabs(%arg0: f16, %arg1: f16, %arg2: !llvm.ptr) -> f16 {
    %0 = llvm.intr.copysign(%arg0, %arg1)  : (f16, f16) -> f16
    %1 = llvm.intr.fabs(%0)  : (f16) -> f16
    llvm.store %1, %arg2 {alignment = 2 : i64} : f16, !llvm.ptr
    llvm.return %1 : f16
  }
  llvm.func @copysign_pos(%arg0: f16) -> f16 {
    %0 = llvm.mlir.constant(1.000000e+00 : f16) : f16
    %1 = llvm.intr.copysign(%0, %arg0)  : (f16, f16) -> f16
    llvm.return %1 : f16
  }
  llvm.func @copysign_neg(%arg0: f16) -> f16 {
    %0 = llvm.mlir.constant(-1.000000e+00 : f16) : f16
    %1 = llvm.intr.copysign(%0, %arg0)  : (f16, f16) -> f16
    llvm.return %1 : f16
  }
  llvm.func @copysign_negzero(%arg0: f16) -> f16 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f16) : f16
    %1 = llvm.intr.copysign(%0, %arg0)  : (f16, f16) -> f16
    llvm.return %1 : f16
  }
  llvm.func @copysign_negnan(%arg0: f16) -> f16 {
    %0 = llvm.mlir.constant(0xFE00 : f16) : f16
    %1 = llvm.intr.copysign(%0, %arg0)  : (f16, f16) -> f16
    llvm.return %1 : f16
  }
  llvm.func @copysign_neginf(%arg0: f16) -> f16 {
    %0 = llvm.mlir.constant(0xFC00 : f16) : f16
    %1 = llvm.intr.copysign(%0, %arg0)  : (f16, f16) -> f16
    llvm.return %1 : f16
  }
  llvm.func @copysign_splat(%arg0: vector<4xf16>) -> vector<4xf16> {
    %0 = llvm.mlir.constant(dense<-1.000000e+00> : vector<4xf16>) : vector<4xf16>
    %1 = llvm.intr.copysign(%0, %arg0)  : (vector<4xf16>, vector<4xf16>) -> vector<4xf16>
    llvm.return %1 : vector<4xf16>
  }
  llvm.func @copysign_vec4(%arg0: vector<4xf16>) -> vector<4xf16> {
    %0 = llvm.mlir.poison : f16
    %1 = llvm.mlir.undef : f16
    %2 = llvm.mlir.constant(-1.000000e+00 : f16) : f16
    %3 = llvm.mlir.constant(1.000000e+00 : f16) : f16
    %4 = llvm.mlir.undef : vector<4xf16>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<4xf16>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<4xf16>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %1, %8[%9 : i32] : vector<4xf16>
    %11 = llvm.mlir.constant(3 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<4xf16>
    %13 = llvm.intr.copysign(%12, %arg0)  : (vector<4xf16>, vector<4xf16>) -> vector<4xf16>
    llvm.return %13 : vector<4xf16>
  }
}
