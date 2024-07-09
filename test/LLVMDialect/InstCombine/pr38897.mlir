module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @sharpening(%arg0: i32, %arg1: i1, %arg2: i1, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32) -> i32 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.select %arg1, %arg3, %arg4 : i1, i32
    %4 = llvm.select %arg2, %arg5, %arg6 : i1, i32
    %5 = llvm.sub %0, %4  : i32
    %6 = llvm.icmp "sgt" %5, %1 : i32
    %7 = llvm.select %6, %5, %1 : i1, i32
    %8 = llvm.xor %7, %2  : i32
    %9 = llvm.icmp "sgt" %3, %8 : i32
    %10 = llvm.select %9, %3, %8 : i1, i32
    %11 = llvm.xor %10, %2  : i32
    llvm.return %11 : i32
  }
}
