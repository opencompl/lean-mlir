module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test(%arg0: i64, %arg1: i64, %arg2: i1, %arg3: i128, %arg4: i128, %arg5: !llvm.ptr, %arg6: !llvm.ptr) -> i128 {
    %0 = llvm.trunc %arg3 : i128 to i64
    %1 = llvm.trunc %arg4 : i128 to i64
    llvm.store %0, %arg5 {alignment = 4 : i64} : i64, !llvm.ptr
    llvm.store %1, %arg6 {alignment = 4 : i64} : i64, !llvm.ptr
    %2 = llvm.sub %0, %1  : i64
    %3 = llvm.sub %0, %1  : i64
    %4 = llvm.zext %arg2 : i1 to i64
    %5 = llvm.sub %3, %4  : i64
    llvm.br ^bb1(%5 : i64)
  ^bb1(%6: i64):  // pred: ^bb0
    %7 = llvm.zext %6 : i64 to i128
    llvm.return %7 : i128
  }
}
