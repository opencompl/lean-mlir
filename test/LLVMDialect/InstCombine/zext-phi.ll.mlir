module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @sink_i1_casts(%arg0: i1, %arg1: i1) -> i64 {
    %0 = llvm.zext %arg0 : i1 to i64
    llvm.cond_br %arg0, ^bb1, ^bb2(%0 : i64)
  ^bb1:  // pred: ^bb0
    %1 = llvm.zext %arg1 : i1 to i64
    llvm.br ^bb2(%1 : i64)
  ^bb2(%2: i64):  // 2 preds: ^bb0, ^bb1
    llvm.return %2 : i64
  }
}
