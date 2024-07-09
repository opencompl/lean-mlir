module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">, #dlti.dl_entry<"dlti.stack_alignment", 128 : i64>>} {
  llvm.func @testa(%arg0: !llvm.vec<2 x ptr>) -> !llvm.vec<2 x ptr> {
    %0 = llvm.mlir.constant(dense<[0, 1]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.getelementptr %arg0[%0] : (!llvm.vec<2 x ptr>, vector<2xi32>) -> !llvm.vec<2 x ptr>, i8
    llvm.return %1 : !llvm.vec<2 x ptr>
  }
  llvm.func @vgep_s_v8i64(%arg0: !llvm.ptr, %arg1: vector<8xi64>) -> !llvm.vec<8 x ptr> {
    %0 = llvm.getelementptr %arg0[%arg1] : (!llvm.ptr, vector<8xi64>) -> !llvm.vec<8 x ptr>, f64
    llvm.return %0 : !llvm.vec<8 x ptr>
  }
  llvm.func @vgep_s_v8i32(%arg0: !llvm.ptr, %arg1: vector<8xi32>) -> !llvm.vec<8 x ptr> {
    %0 = llvm.getelementptr %arg0[%arg1] : (!llvm.ptr, vector<8xi32>) -> !llvm.vec<8 x ptr>, f64
    llvm.return %0 : !llvm.vec<8 x ptr>
  }
  llvm.func @vgep_v8iPtr_i32(%arg0: !llvm.vec<8 x ptr>, %arg1: i32) -> !llvm.vec<8 x ptr> {
    %0 = llvm.getelementptr %arg0[%arg1] : (!llvm.vec<8 x ptr>, i32) -> !llvm.vec<8 x ptr>, i8
    llvm.return %0 : !llvm.vec<8 x ptr>
  }
}
