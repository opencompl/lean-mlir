module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @exp2_f32_sitofp_i8(%arg0: i8) -> f32 {
    %0 = llvm.sitofp %arg0 : i8 to f32
    %1 = llvm.intr.exp2(%0)  : (f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @exp2_f32_sitofp_i8_flags(%arg0: i8) -> f32 {
    %0 = llvm.sitofp %arg0 : i8 to f32
    %1 = llvm.intr.exp2(%0)  {fastmathFlags = #llvm.fastmath<nnan, ninf>} : (f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @exp2_v2f32_sitofp_v2i8(%arg0: vector<2xi8>) -> vector<2xf32> {
    %0 = llvm.sitofp %arg0 : vector<2xi8> to vector<2xf32>
    %1 = llvm.intr.exp2(%0)  : (vector<2xf32>) -> vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }
  llvm.func @exp2_f32_uitofp_i8(%arg0: i8) -> f32 {
    %0 = llvm.uitofp %arg0 : i8 to f32
    %1 = llvm.intr.exp2(%0)  : (f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @exp2_f16_sitofp_i8(%arg0: i8) -> f16 {
    %0 = llvm.sitofp %arg0 : i8 to f16
    %1 = llvm.intr.exp2(%0)  : (f16) -> f16
    llvm.return %1 : f16
  }
  llvm.func @exp2_f64_sitofp_i8(%arg0: i8) -> f64 {
    %0 = llvm.sitofp %arg0 : i8 to f64
    %1 = llvm.intr.exp2(%0)  : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @exp2_fp128_sitofp_i8(%arg0: i8) -> f128 {
    %0 = llvm.sitofp %arg0 : i8 to f128
    %1 = llvm.intr.exp2(%0)  : (f128) -> f128
    llvm.return %1 : f128
  }
  llvm.func @exp2_nxv4f32_sitofp_i8(%arg0: !llvm.vec<? x 4 x  i8>) -> !llvm.vec<? x 4 x  f32> {
    %0 = llvm.sitofp %arg0 : !llvm.vec<? x 4 x  i8> to !llvm.vec<? x 4 x  f32>
    %1 = llvm.intr.exp2(%0)  : (!llvm.vec<? x 4 x  f32>) -> !llvm.vec<? x 4 x  f32>
    llvm.return %1 : !llvm.vec<? x 4 x  f32>
  }
}
