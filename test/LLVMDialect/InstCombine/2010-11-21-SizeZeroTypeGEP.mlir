module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @foo(%arg0: !llvm.ptr, %arg1: i32) -> !llvm.ptr {
    %0 = llvm.getelementptr %arg0[%arg1] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<()>
    llvm.return %0 : !llvm.ptr
  }
  llvm.func @bar(%arg0: i64, %arg1: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.getelementptr %arg1[%arg0, 1, %arg0, 0, %arg0] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.struct<(struct<()>, array<0 x struct<(array<0 x i8>)>>)>
    llvm.return %2 : !llvm.ptr
  }
}
