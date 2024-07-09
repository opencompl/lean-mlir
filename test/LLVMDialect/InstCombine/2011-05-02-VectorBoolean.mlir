module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @entry(%arg0: vector<2xi16>) -> vector<2xi16> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i16) : i16
    %2 = llvm.mlir.constant(dense<0> : vector<2xi16>) : vector<2xi16>
    %3 = llvm.alloca %0 x vector<2xi16> {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %4 = llvm.alloca %0 x vector<2xi16> {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.store %arg0, %3 {alignment = 4 : i64} : vector<2xi16>, !llvm.ptr
    %5 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> vector<2xi16>
    llvm.store %2, %4 {alignment = 4 : i64} : vector<2xi16>, !llvm.ptr
    %6 = llvm.load %4 {alignment = 4 : i64} : !llvm.ptr -> vector<2xi16>
    %7 = llvm.icmp "uge" %5, %6 : vector<2xi16>
    %8 = llvm.sext %7 : vector<2xi1> to vector<2xi16>
    llvm.return %8 : vector<2xi16>
  }
}
