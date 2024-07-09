module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @and_add_shl(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(-1 : i8) : i8
    %3 = llvm.mlir.constant(32 : i8) : i8
    %4 = llvm.icmp "ule" %arg0, %0 : i8
    "llvm.intr.assume"(%4) : (i1) -> ()
    %5 = llvm.shl %1, %arg0  : i8
    %6 = llvm.add %5, %2  : i8
    %7 = llvm.and %6, %3  : i8
    llvm.return %7 : i8
  }
  llvm.func @and_not_shl(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(32 : i8) : i8
    %3 = llvm.icmp "ule" %arg0, %0 : i8
    "llvm.intr.assume"(%3) : (i1) -> ()
    %4 = llvm.shl %1, %arg0  : i8
    %5 = llvm.xor %4, %1  : i8
    %6 = llvm.and %5, %2  : i8
    llvm.return %6 : i8
  }
  llvm.func @and_add_shl_overlap(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(-1 : i8) : i8
    %3 = llvm.mlir.constant(32 : i8) : i8
    %4 = llvm.icmp "ule" %arg0, %0 : i8
    "llvm.intr.assume"(%4) : (i1) -> ()
    %5 = llvm.shl %1, %arg0  : i8
    %6 = llvm.add %5, %2  : i8
    %7 = llvm.and %6, %3  : i8
    llvm.return %7 : i8
  }
}
