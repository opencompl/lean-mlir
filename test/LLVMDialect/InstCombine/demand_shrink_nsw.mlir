module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @foo(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(223 : i32) : i32
    %1 = llvm.mlir.constant(29 : i32) : i32
    %2 = llvm.mlir.constant(-784568073 : i32) : i32
    %3 = llvm.mlir.constant(1874836915 : i32) : i32
    %4 = llvm.mlir.constant(221 : i32) : i32
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.mlir.constant(1533579450 : i32) : i32
    %7 = llvm.mlir.constant(-2147483648 : i32) : i32
    %8 = llvm.mlir.constant(749011377 : i32) : i32
    %9 = llvm.and %arg0, %0  : i32
    %10 = llvm.xor %9, %1  : i32
    %11 = llvm.add %10, %2 overflow<nuw>  : i32
    %12 = llvm.or %10, %3  : i32
    %13 = llvm.and %10, %4  : i32
    %14 = llvm.xor %13, %3  : i32
    %15 = llvm.xor %12, %14  : i32
    %16 = llvm.shl %15, %5 overflow<nsw, nuw>  : i32
    %17 = llvm.sub %11, %16  : i32
    %18 = llvm.add %17, %6 overflow<nsw>  : i32
    %19 = llvm.or %18, %7  : i32
    %20 = llvm.xor %19, %8  : i32
    llvm.return %20 : i32
  }
}
