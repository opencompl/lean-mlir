module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @pr80941(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 144 : i32}> : (f32) -> i1
    llvm.cond_br %1, ^bb1, ^bb2(%arg0 : f32)
  ^bb1:  // pred: ^bb0
    %2 = llvm.fpext %arg0 : f32 to f64
    %3 = llvm.intr.copysign(%0, %2)  : (f64, f64) -> f64
    %4 = llvm.fptrunc %3 : f64 to f32
    llvm.br ^bb2(%4 : f32)
  ^bb2(%5: f32):  // 2 preds: ^bb0, ^bb1
    llvm.return %5 : f32
  }
}
