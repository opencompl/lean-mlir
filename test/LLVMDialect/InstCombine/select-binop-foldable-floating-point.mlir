module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @select_maybe_nan_fadd(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fadd %arg1, %arg2  : f32
    %1 = llvm.select %arg0, %0, %arg1 : i1, f32
    llvm.return %1 : f32
  }
  llvm.func @select_fpclass_fadd(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fadd %arg1, %arg2  : f32
    %1 = llvm.select %arg0, %0, %arg1 : i1, f32
    llvm.return %1 : f32
  }
  llvm.func @select_nnan_fadd(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fadd %arg1, %arg2  : f32
    %1 = llvm.select %arg0, %0, %arg1 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f32
    llvm.return %1 : f32
  }
  llvm.func @select_nnan_fadd_swapped(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fadd %arg1, %arg2  : f32
    %1 = llvm.select %arg0, %arg1, %0 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f32
    llvm.return %1 : f32
  }
  llvm.func @select_nnan_fadd_fast_math(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fadd %arg1, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %1 = llvm.select %arg0, %0, %arg1 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f32
    llvm.return %1 : f32
  }
  llvm.func @select_nnan_fadd_swapped_fast_math(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fadd %arg1, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %1 = llvm.select %arg0, %arg1, %0 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f32
    llvm.return %1 : f32
  }
  llvm.func @select_nnan_nsz_fadd_v4f32(%arg0: vector<4xi1>, %arg1: vector<4xf32>, %arg2: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.fadd %arg1, %arg2  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : vector<4xf32>
    %1 = llvm.select %arg0, %0, %arg1 {fastmathFlags = #llvm.fastmath<nnan, nsz>} : vector<4xi1>, vector<4xf32>
    llvm.return %1 : vector<4xf32>
  }
  llvm.func @select_nnan_nsz_fadd_nxv4f32(%arg0: !llvm.vec<? x 4 x  i1>, %arg1: !llvm.vec<? x 4 x  f32>, %arg2: !llvm.vec<? x 4 x  f32>) -> !llvm.vec<? x 4 x  f32> {
    %0 = llvm.fadd %arg1, %arg2  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : !llvm.vec<? x 4 x  f32>
    %1 = llvm.select %arg0, %0, %arg1 {fastmathFlags = #llvm.fastmath<nnan, nsz>} : !llvm.vec<? x 4 x  i1>, !llvm.vec<? x 4 x  f32>
    llvm.return %1 : !llvm.vec<? x 4 x  f32>
  }
  llvm.func @select_nnan_nsz_fadd_nxv4f32_swapops(%arg0: !llvm.vec<? x 4 x  i1>, %arg1: !llvm.vec<? x 4 x  f32>, %arg2: !llvm.vec<? x 4 x  f32>) -> !llvm.vec<? x 4 x  f32> {
    %0 = llvm.fadd %arg1, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : !llvm.vec<? x 4 x  f32>
    %1 = llvm.select %arg0, %arg1, %0 {fastmathFlags = #llvm.fastmath<fast>} : !llvm.vec<? x 4 x  i1>, !llvm.vec<? x 4 x  f32>
    llvm.return %1 : !llvm.vec<? x 4 x  f32>
  }
  llvm.func @select_nnan_fmul(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fmul %arg1, %arg2  : f32
    %1 = llvm.select %arg0, %0, %arg1 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f32
    llvm.return %1 : f32
  }
  llvm.func @select_nnan_fmul_swapped(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fmul %arg1, %arg2  : f32
    %1 = llvm.select %arg0, %arg1, %0 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f32
    llvm.return %1 : f32
  }
  llvm.func @select_nnan_fmul_fast_math(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fmul %arg1, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %1 = llvm.select %arg0, %0, %arg1 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f32
    llvm.return %1 : f32
  }
  llvm.func @select_nnan_fmul_swapped_fast_math(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fmul %arg1, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %1 = llvm.select %arg0, %arg1, %0 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f32
    llvm.return %1 : f32
  }
  llvm.func @select_nnan_fsub(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fsub %arg1, %arg2  : f32
    %1 = llvm.select %arg0, %0, %arg1 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f32
    llvm.return %1 : f32
  }
  llvm.func @select_nnan_fsub_swapped(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fsub %arg1, %arg2  : f32
    %1 = llvm.select %arg0, %arg1, %0 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f32
    llvm.return %1 : f32
  }
  llvm.func @select_nnan_fsub_fast_math(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fsub %arg1, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %1 = llvm.select %arg0, %0, %arg1 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f32
    llvm.return %1 : f32
  }
  llvm.func @select_nnan_fsub_swapped_fast_math(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fsub %arg1, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %1 = llvm.select %arg0, %arg1, %0 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f32
    llvm.return %1 : f32
  }
  llvm.func @select_nnan_nsz_fsub_v4f32(%arg0: vector<4xi1>, %arg1: vector<4xf32>, %arg2: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.fsub %arg1, %arg2  : vector<4xf32>
    %1 = llvm.select %arg0, %0, %arg1 {fastmathFlags = #llvm.fastmath<nnan, nsz>} : vector<4xi1>, vector<4xf32>
    llvm.return %1 : vector<4xf32>
  }
  llvm.func @select_nnan_nsz_fsub_nxv4f32(%arg0: !llvm.vec<? x 4 x  i1>, %arg1: !llvm.vec<? x 4 x  f32>, %arg2: !llvm.vec<? x 4 x  f32>) -> !llvm.vec<? x 4 x  f32> {
    %0 = llvm.fsub %arg1, %arg2  : !llvm.vec<? x 4 x  f32>
    %1 = llvm.select %arg0, %0, %arg1 {fastmathFlags = #llvm.fastmath<nnan, nsz>} : !llvm.vec<? x 4 x  i1>, !llvm.vec<? x 4 x  f32>
    llvm.return %1 : !llvm.vec<? x 4 x  f32>
  }
  llvm.func @select_nnan_fsub_invalid(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fsub %arg2, %arg1  : f32
    %1 = llvm.select %arg0, %0, %arg1 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f32
    llvm.return %1 : f32
  }
  llvm.func @select_nnan_fdiv(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fdiv %arg1, %arg2  : f32
    %1 = llvm.select %arg0, %0, %arg1 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f32
    llvm.return %1 : f32
  }
  llvm.func @select_nnan_fdiv_swapped(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fdiv %arg1, %arg2  : f32
    %1 = llvm.select %arg0, %arg1, %0 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f32
    llvm.return %1 : f32
  }
  llvm.func @select_nnan_fdiv_fast_math(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fdiv %arg1, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %1 = llvm.select %arg0, %0, %arg1 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f32
    llvm.return %1 : f32
  }
  llvm.func @select_nnan_fdiv_swapped_fast_math(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fdiv %arg1, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %1 = llvm.select %arg0, %arg1, %0 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f32
    llvm.return %1 : f32
  }
  llvm.func @select_nnan_fdiv_invalid(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fdiv %arg2, %arg1  : f32
    %1 = llvm.select %arg0, %0, %arg1 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f32
    llvm.return %1 : f32
  }
}
