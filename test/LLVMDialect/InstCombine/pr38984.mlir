module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<16> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @a() {addr_space = 0 : i32, alignment = 1 : i64} : !llvm.array<21 x i16>
  llvm.mlir.global external @offsets() {addr_space = 0 : i32, alignment = 1 : i64} : !llvm.array<4 x i16>
  llvm.func @PR38984_1() -> vector<4xi1> {
    %0 = llvm.mlir.addressof @offsets : !llvm.ptr
    %1 = llvm.mlir.undef : vector<4xi16>
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.zero : !llvm.ptr
    %4 = llvm.load %0 {alignment = 1 : i64} : !llvm.ptr -> i16
    %5 = llvm.insertelement %4, %1[%2 : i32] : vector<4xi16>
    %6 = llvm.getelementptr %3[%5] : (!llvm.ptr, vector<4xi16>) -> !llvm.vec<4 x ptr>, i32
    %7 = llvm.getelementptr %3[%5] : (!llvm.ptr, vector<4xi16>) -> !llvm.vec<4 x ptr>, i32
    %8 = llvm.icmp "eq" %6, %7 : !llvm.vec<4 x ptr>
    llvm.return %8 : vector<4xi1>
  }
  llvm.func @PR38984_2() -> vector<4xi1> {
    %0 = llvm.mlir.addressof @offsets : !llvm.ptr
    %1 = llvm.mlir.undef : vector<4xi16>
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(1 : i64) : i64
    %5 = llvm.mlir.addressof @a : !llvm.ptr
    %6 = llvm.getelementptr inbounds %5[%4, %3] : (!llvm.ptr, i64, i32) -> !llvm.ptr, !llvm.array<21 x i16>
    %7 = llvm.mlir.zero : !llvm.ptr
    %8 = llvm.load %0 {alignment = 2 : i64} : !llvm.ptr -> i16
    %9 = llvm.insertelement %8, %1[%2 : i32] : vector<4xi16>
    %10 = llvm.getelementptr %6[%9] : (!llvm.ptr, vector<4xi16>) -> !llvm.vec<4 x ptr>, i16
    %11 = llvm.getelementptr %7[%9] : (!llvm.ptr, vector<4xi16>) -> !llvm.vec<4 x ptr>, i16
    %12 = llvm.icmp "eq" %10, %11 : !llvm.vec<4 x ptr>
    llvm.return %12 : vector<4xi1>
  }
}
