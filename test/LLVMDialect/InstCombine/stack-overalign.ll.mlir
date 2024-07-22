module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @dst(dense<0> : tensor<1024xi8>) {addr_space = 0 : i32, alignment = 32 : i64} : !llvm.array<1024 x i8>
  llvm.func @foo() attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : tensor<1024xi8>) : !llvm.array<1024 x i8>
    %3 = llvm.mlir.addressof @dst : !llvm.ptr
    %4 = llvm.mlir.constant(1024 : i32) : i32
    %5 = llvm.alloca %0 x !llvm.array<1024 x i8> {alignment = 64 : i64} : (i32) -> !llvm.ptr
    "llvm.intr.memcpy"(%3, %5, %4) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()
    llvm.call @frob(%5) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @frob(!llvm.ptr)
}
