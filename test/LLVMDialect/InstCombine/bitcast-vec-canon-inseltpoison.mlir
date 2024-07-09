module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @a(%arg0: vector<1xi64>) -> f64 {
    %0 = llvm.bitcast %arg0 : vector<1xi64> to f64
    llvm.return %0 : f64
  }
  llvm.func @b(%arg0: vector<1xi64>) -> i64 {
    %0 = llvm.bitcast %arg0 : vector<1xi64> to i64
    llvm.return %0 : i64
  }
  llvm.func @c(%arg0: f64) -> vector<1xi64> {
    %0 = llvm.bitcast %arg0 : f64 to vector<1xi64>
    llvm.return %0 : vector<1xi64>
  }
  llvm.func @d(%arg0: i64) -> vector<1xi64> {
    %0 = llvm.bitcast %arg0 : i64 to vector<1xi64>
    llvm.return %0 : vector<1xi64>
  }
  llvm.func @e(%arg0: vector<1xi64>) -> !llvm.x86_mmx {
    %0 = llvm.bitcast %arg0 : vector<1xi64> to !llvm.x86_mmx
    llvm.return %0 : !llvm.x86_mmx
  }
  llvm.func @f(%arg0: !llvm.x86_mmx) -> vector<1xi64> {
    %0 = llvm.bitcast %arg0 : !llvm.x86_mmx to vector<1xi64>
    llvm.return %0 : vector<1xi64>
  }
  llvm.func @g(%arg0: !llvm.x86_mmx) -> f64 {
    %0 = llvm.bitcast %arg0 : !llvm.x86_mmx to vector<1xi64>
    %1 = llvm.bitcast %0 : vector<1xi64> to f64
    llvm.return %1 : f64
  }
  llvm.func @bitcast_inselt_undef(%arg0: f64, %arg1: i32) -> vector<3xi64> {
    %0 = llvm.mlir.poison : vector<3xi64>
    %1 = llvm.bitcast %arg0 : f64 to i64
    %2 = llvm.insertelement %1, %0[%arg1 : i32] : vector<3xi64>
    llvm.return %2 : vector<3xi64>
  }
  llvm.func @bitcast_inselt_undef_fp(%arg0: i32, %arg1: i567) -> vector<3xf32> {
    %0 = llvm.mlir.poison : vector<3xf32>
    %1 = llvm.bitcast %arg0 : i32 to f32
    %2 = llvm.insertelement %1, %0[%arg1 : i567] : vector<3xf32>
    llvm.return %2 : vector<3xf32>
  }
  llvm.func @bitcast_inselt_undef_vscale(%arg0: i32, %arg1: i567) -> !llvm.vec<? x 3 x  f32> {
    %0 = llvm.mlir.poison : !llvm.vec<? x 3 x  f32>
    %1 = llvm.bitcast %arg0 : i32 to f32
    %2 = llvm.insertelement %1, %0[%arg1 : i567] : !llvm.vec<? x 3 x  f32>
    llvm.return %2 : !llvm.vec<? x 3 x  f32>
  }
  llvm.func @use(i64)
  llvm.func @bitcast_inselt_undef_extra_use(%arg0: f64, %arg1: i32) -> vector<3xi64> {
    %0 = llvm.mlir.poison : vector<3xi64>
    %1 = llvm.bitcast %arg0 : f64 to i64
    llvm.call @use(%1) : (i64) -> ()
    %2 = llvm.insertelement %1, %0[%arg1 : i32] : vector<3xi64>
    llvm.return %2 : vector<3xi64>
  }
  llvm.func @bitcast_inselt_undef_vec_src(%arg0: vector<2xi32>, %arg1: i32) -> vector<3xi64> {
    %0 = llvm.mlir.poison : vector<3xi64>
    %1 = llvm.bitcast %arg0 : vector<2xi32> to i64
    %2 = llvm.insertelement %1, %0[%arg1 : i32] : vector<3xi64>
    llvm.return %2 : vector<3xi64>
  }
  llvm.func @bitcast_inselt_undef_from_mmx(%arg0: !llvm.x86_mmx, %arg1: i32) -> vector<3xi64> {
    %0 = llvm.mlir.poison : vector<3xi64>
    %1 = llvm.bitcast %arg0 : !llvm.x86_mmx to i64
    %2 = llvm.insertelement %1, %0[%arg1 : i32] : vector<3xi64>
    llvm.return %2 : vector<3xi64>
  }
  llvm.func @PR45748(%arg0: f64, %arg1: f64) -> vector<2xi64> {
    %0 = llvm.mlir.poison : vector<2xi64>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.bitcast %arg0 : f64 to i64
    %4 = llvm.insertelement %3, %0[%1 : i32] : vector<2xi64>
    %5 = llvm.bitcast %arg1 : f64 to i64
    %6 = llvm.insertelement %5, %4[%2 : i32] : vector<2xi64>
    llvm.return %6 : vector<2xi64>
  }
}
