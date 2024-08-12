module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @shrink_splat_scalable_extend(%arg0: !llvm.vec<? x 2 x  f32>) -> !llvm.vec<? x 2 x  f32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1.000000e+00 : f32) : f32
    %2 = llvm.mlir.undef : !llvm.vec<? x 2 x  f32>
    %3 = llvm.insertelement %1, %2[%0 : i32] : !llvm.vec<? x 2 x  f32>
    %4 = llvm.shufflevector %3, %2 [0, 0] : !llvm.vec<? x 2 x  f32> 
    %5 = llvm.fpext %arg0 : !llvm.vec<? x 2 x  f32> to !llvm.vec<? x 2 x  f64>
    %6 = llvm.fpext %4 : vector<[2]xf32> to !llvm.vec<? x 2 x  f64>
    %7 = llvm.fadd %5, %6  : !llvm.vec<? x 2 x  f64>
    %8 = llvm.fptrunc %7 : !llvm.vec<? x 2 x  f64> to !llvm.vec<? x 2 x  f32>
    llvm.return %8 : !llvm.vec<? x 2 x  f32>
  }
}
