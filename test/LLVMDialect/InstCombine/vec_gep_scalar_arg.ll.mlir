module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @PR41270(%arg0: !llvm.ptr) -> !llvm.vec<4 x ptr> {
    %0 = llvm.mlir.undef : !llvm.vec<4 x ptr>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : !llvm.vec<4 x ptr>
    %4 = llvm.shufflevector %3, %0 [0, 0, 0, 0] : !llvm.vec<4 x ptr> 
    %5 = llvm.getelementptr inbounds %4[%1, %2] : (!llvm.vec<4 x ptr>, i32, i32) -> !llvm.vec<4 x ptr>, !llvm.array<4 x i16>
    %6 = llvm.extractelement %5[%2 : i32] : !llvm.vec<4 x ptr>
    %7 = llvm.insertelement %6, %0[%1 : i32] : !llvm.vec<4 x ptr>
    llvm.return %7 : !llvm.vec<4 x ptr>
  }
}
