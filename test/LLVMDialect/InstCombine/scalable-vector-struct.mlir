module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @load(%arg0: !llvm.ptr) -> !llvm.vec<? x 1 x  i32> {
    %0 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> !llvm.struct<"struct.test", (vec<? x 1 x  i32>, vec<? x 1 x  i32>)>
    %1 = llvm.extractvalue %0[1] : !llvm.struct<"struct.test", (vec<? x 1 x  i32>, vec<? x 1 x  i32>)> 
    llvm.return %1 : !llvm.vec<? x 1 x  i32>
  }
  llvm.func @store(%arg0: !llvm.ptr, %arg1: !llvm.vec<? x 1 x  i32>, %arg2: !llvm.vec<? x 1 x  i32>) {
    %0 = llvm.mlir.undef : !llvm.struct<"struct.test", (vec<? x 1 x  i32>, vec<? x 1 x  i32>)>
    %1 = llvm.insertvalue %arg1, %0[0] : !llvm.struct<"struct.test", (vec<? x 1 x  i32>, vec<? x 1 x  i32>)> 
    %2 = llvm.insertvalue %arg2, %1[1] : !llvm.struct<"struct.test", (vec<? x 1 x  i32>, vec<? x 1 x  i32>)> 
    llvm.store %2, %arg0 {alignment = 4 : i64} : !llvm.struct<"struct.test", (vec<? x 1 x  i32>, vec<? x 1 x  i32>)>, !llvm.ptr
    llvm.return
  }
}
