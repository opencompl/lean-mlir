module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">, #dlti.dl_entry<"dlti.stack_alignment", 128 : i64>>} {
  llvm.func @PR40940(%arg0: vector<4xi8>) -> i32 {
    %0 = llvm.mlir.poison : vector<4xi8>
    %1 = llvm.mlir.constant(65536 : i32) : i32
    %2 = llvm.shufflevector %arg0, %0 [1, 1, 2, 3] : vector<4xi8> 
    %3 = llvm.bitcast %2 : vector<4xi8> to i32
    %4 = llvm.icmp "ult" %3, %1 : i32
    "llvm.intr.assume"(%4) : (i1) -> ()
    llvm.return %3 : i32
  }
}
