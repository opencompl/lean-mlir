module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<32> : vector<4xi64>>, #dlti.dl_entry<i1, dense<[8, 32]> : vector<2xi64>>, #dlti.dl_entry<i16, dense<[16, 32]> : vector<2xi64>>, #dlti.dl_entry<i8, dense<[8, 32]> : vector<2xi64>>, #dlti.dl_entry<i64, dense<32> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<32> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external constant @a(dense<[3, 6]> : tensor<2xi32>) {addr_space = 0 : i32} : !llvm.array<2 x i32>
  llvm.func @b(%arg0: i32) -> i32 attributes {memory = #llvm.memory_effects<other = read, argMem = read, inaccessibleMem = read>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(dense<[3, 6]> : tensor<2xi32>) : !llvm.array<2 x i32>
    %3 = llvm.mlir.addressof @a : !llvm.ptr
    %4 = llvm.getelementptr inbounds %3[%0, %1] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<2 x i32>
    %5 = llvm.icmp "eq" %arg0, %0 : i32
    %6 = llvm.select %5, %4, %3 : i1, !llvm.ptr
    %7 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %7 : i32
  }
}
