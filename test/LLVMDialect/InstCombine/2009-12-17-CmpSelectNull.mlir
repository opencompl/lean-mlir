module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global internal constant @".str254"(".\00") {addr_space = 0 : i32, dso_local}
  llvm.mlir.global internal constant @".str557"("::\00") {addr_space = 0 : i32, dso_local}
  llvm.func @demangle_qualified(%arg0: i32) -> !llvm.ptr attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(".\00") : !llvm.array<2 x i8>
    %2 = llvm.mlir.addressof @".str254" : !llvm.ptr
    %3 = llvm.mlir.constant("::\00") : !llvm.array<3 x i8>
    %4 = llvm.mlir.addressof @".str557" : !llvm.ptr
    %5 = llvm.mlir.zero : !llvm.ptr
    %6 = llvm.icmp "ne" %arg0, %0 : i32
    %7 = llvm.select %6, %2, %4 : i1, !llvm.ptr
    %8 = llvm.icmp "eq" %7, %5 : !llvm.ptr
    %9 = llvm.getelementptr %7[%8] : (!llvm.ptr, i1) -> !llvm.ptr, i8
    llvm.return %9 : !llvm.ptr
  }
}
