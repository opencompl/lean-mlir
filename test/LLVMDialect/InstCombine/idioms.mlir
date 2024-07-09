module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test_asr(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    llvm.cond_br %2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %3 = llvm.sub %0, %arg0  : i32
    %4 = llvm.sub %3, %1  : i32
    %5 = llvm.ashr %4, %arg1  : i32
    %6 = llvm.sub %0, %5  : i32
    %7 = llvm.sub %6, %1  : i32
    llvm.br ^bb3(%7 : i32)
  ^bb2:  // pred: ^bb0
    %8 = llvm.ashr %arg0, %arg1  : i32
    llvm.br ^bb3(%8 : i32)
  ^bb3(%9: i32):  // 2 preds: ^bb1, ^bb2
    llvm.return %9 : i32
  }
}
