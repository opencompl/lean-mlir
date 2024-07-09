module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global internal unnamed_addr @Q(1.000000e+00 : f64) {addr_space = 0 : i32, alignment = 8 : i64, dso_local} : f64
  llvm.func @test(%arg0: i1, %arg1: !llvm.ptr) -> f64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %2 = llvm.mlir.addressof @Q : !llvm.ptr
    llvm.cond_br %arg0, ^bb1, ^bb2(%0 : i64)
  ^bb1:  // pred: ^bb0
    %3 = llvm.load %2 {alignment = 8 : i64} : !llvm.ptr -> i64
    llvm.br ^bb2(%3 : i64)
  ^bb2(%4: i64):  // 2 preds: ^bb0, ^bb1
    llvm.store %4, %arg1 {alignment = 8 : i64} : i64, !llvm.ptr
    %5 = llvm.bitcast %4 : i64 to f64
    llvm.return %5 : f64
  }
}
