module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @f1(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.array<6 x i32>
    %3 = llvm.getelementptr %2[%1, %arg1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<6 x i32>
    llvm.return %3 : !llvm.ptr
  }
  llvm.func @f2(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.array<6 x i32>
    %2 = llvm.getelementptr %1[%arg1, %arg1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<6 x i32>
    llvm.return %2 : !llvm.ptr
  }
}
