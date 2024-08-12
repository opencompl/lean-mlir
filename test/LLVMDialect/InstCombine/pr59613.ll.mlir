module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @pr59613(%arg0: vector<6xi16>) {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(dense<0> : vector<6xi16>) : vector<6xi16>
    %2 = llvm.mlir.undef : i1
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.mlir.constant(true) : i1
    %5 = llvm.mlir.undef : vector<6xi1>
    %6 = llvm.mlir.constant(0 : i32) : i32
    %7 = llvm.insertelement %4, %5[%6 : i32] : vector<6xi1>
    %8 = llvm.mlir.constant(1 : i32) : i32
    %9 = llvm.insertelement %3, %7[%8 : i32] : vector<6xi1>
    %10 = llvm.mlir.constant(2 : i32) : i32
    %11 = llvm.insertelement %3, %9[%10 : i32] : vector<6xi1>
    %12 = llvm.mlir.constant(3 : i32) : i32
    %13 = llvm.insertelement %3, %11[%12 : i32] : vector<6xi1>
    %14 = llvm.mlir.constant(4 : i32) : i32
    %15 = llvm.insertelement %2, %13[%14 : i32] : vector<6xi1>
    %16 = llvm.mlir.constant(5 : i32) : i32
    %17 = llvm.insertelement %2, %15[%16 : i32] : vector<6xi1>
    %18 = llvm.mlir.constant(dense<-1> : vector<6xi16>) : vector<6xi16>
    %19 = llvm.mlir.zero : !llvm.ptr
    %20 = llvm.icmp "ne" %arg0, %1 : vector<6xi16>
    %21 = llvm.or %17, %20  : vector<6xi1>
    %22 = llvm.sext %21 : vector<6xi1> to vector<6xi16>
    %23 = llvm.xor %22, %18  : vector<6xi16>
    llvm.store %23, %19 {alignment = 16 : i64} : vector<6xi16>, !llvm.ptr
    llvm.return
  }
}
