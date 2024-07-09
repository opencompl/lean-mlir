module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @av_cmp_q_cond_true(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: !llvm.ptr) {
    %0 = llvm.mlir.constant(63 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    llvm.br ^bb2
  ^bb1:  // pred: ^bb2
    llvm.return
  ^bb2:  // pred: ^bb0
    %2 = llvm.load %arg2 {alignment = 4 : i64} : !llvm.ptr -> i64
    %3 = llvm.zext %0 : i32 to i64
    %4 = llvm.ashr %2, %3  : i64
    %5 = llvm.trunc %4 : i64 to i32
    %6 = llvm.or %5, %1  : i32
    llvm.store %6, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr
    %7 = llvm.load %arg1 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.store %7, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.br ^bb1
  }
}
