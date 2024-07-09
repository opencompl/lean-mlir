module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @main(%arg0: !llvm.ptr, %arg1: i8, %arg2: i32, %arg3: i8) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(0 : i8) : i8
    %4 = llvm.sext %arg3 : i8 to i32
    %5 = llvm.xor %arg2, %0  : i32
    %6 = llvm.or %4, %arg2  : i32
    %7 = llvm.xor %6, %1  : i32
    %8 = llvm.lshr %7, %0  : i32
    %9 = llvm.sub %5, %8  : i32
    %10 = llvm.trunc %9 : i32 to i8
    llvm.store %10, %arg0 {alignment = 1 : i64} : i8, !llvm.ptr
    %11 = llvm.shl %arg2, %2  : i32
    %12 = llvm.ashr %11, %2  : i32
    %13 = llvm.trunc %arg2 : i32 to i8
    %14 = llvm.or %13, %3  : i8
    %15 = llvm.xor %14, %3  : i8
    %16 = llvm.xor %arg1, %3  : i8
    %17 = llvm.xor %16, %3  : i8
    %18 = llvm.or %15, %17  : i8
    llvm.store %18, %arg0 {alignment = 1 : i64} : i8, !llvm.ptr
    %19 = llvm.icmp "slt" %arg3, %3 : i8
    "llvm.intr.assume"(%19) : (i1) -> ()
    llvm.return %12 : i32
  }
}
