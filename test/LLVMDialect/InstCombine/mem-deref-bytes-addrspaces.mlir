module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @memcmp(!llvm.ptr<1> {llvm.nocapture}, !llvm.ptr<1> {llvm.nocapture}, i64) -> i32
  llvm.func @memcmp_const_size_update_deref(%arg0: !llvm.ptr<1> {llvm.nocapture, llvm.readonly}, %arg1: !llvm.ptr<1> {llvm.nocapture, llvm.readonly}) -> i32 {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.call @memcmp(%arg0, %arg1, %0) : (!llvm.ptr<1>, !llvm.ptr<1>, i64) -> i32
    llvm.return %1 : i32
  }
  llvm.func @memcmp_nonconst_size_nonnnull(%arg0: !llvm.ptr<1> {llvm.nocapture, llvm.readonly}, %arg1: !llvm.ptr<1> {llvm.nocapture, llvm.readonly}, %arg2: i64) -> i32 {
    %0 = llvm.call @memcmp(%arg0, %arg1, %arg2) : (!llvm.ptr<1>, !llvm.ptr<1>, i64) -> i32
    llvm.return %0 : i32
  }
}
