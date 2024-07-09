module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @do_something(!llvm.vec<? x 4 x  i32>)
  llvm.func @can_replace_gep_idx_with_zero_typesize(%arg0: i64, %arg1: !llvm.ptr, %arg2: i64) {
    %0 = llvm.getelementptr %arg1[%arg2] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.vec<? x 4 x  i32>
    %1 = llvm.load %0 {alignment = 16 : i64} : !llvm.ptr -> !llvm.vec<? x 4 x  i32>
    llvm.call @do_something(%1) : (!llvm.vec<? x 4 x  i32>) -> ()
    llvm.return
  }
  llvm.func @can_replace_gep_idx_with_zero_typesize_2(%arg0: i64, %arg1: !llvm.ptr, %arg2: i64) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.getelementptr %arg1[%arg2, %0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<2 x vec<? x 4 x  i32>>
    %2 = llvm.load %1 {alignment = 16 : i64} : !llvm.ptr -> !llvm.vec<? x 4 x  i32>
    llvm.call @do_something(%2) : (!llvm.vec<? x 4 x  i32>) -> ()
    llvm.return
  }
}
