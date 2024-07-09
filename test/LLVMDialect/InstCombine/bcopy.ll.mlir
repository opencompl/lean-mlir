module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @bcopy(!llvm.ptr {llvm.nocapture, llvm.readonly}, !llvm.ptr {llvm.nocapture}, i32)
  llvm.func @bcopy_memmove(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg1: !llvm.ptr {llvm.nocapture}) {
    %0 = llvm.mlir.constant(8 : i32) : i32
    llvm.call @bcopy(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i32) -> ()
    llvm.return
  }
  llvm.func @bcopy_memmove2(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg1: !llvm.ptr {llvm.nocapture}, %arg2: i32) {
    llvm.call @bcopy(%arg0, %arg1, %arg2) : (!llvm.ptr, !llvm.ptr, i32) -> ()
    llvm.return
  }
}
