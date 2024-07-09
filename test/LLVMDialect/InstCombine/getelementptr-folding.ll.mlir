module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">, #dlti.dl_entry<"dlti.stack_alignment", 128 : i64>>} {
  llvm.mlir.global external @matrix_identity_float3x3() {addr_space = 0 : i32, alignment = 16 : i64} : !llvm.struct<"struct.matrix_float3x3", (array<3 x vector<3xf32>>)>
  llvm.mlir.global external @bbb() {addr_space = 0 : i32} : !llvm.ptr {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.mlir.addressof @matrix_identity_float3x3 : !llvm.ptr
    %5 = llvm.getelementptr inbounds %4[%3, 0, %1, %0] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.struct<"struct.matrix_float3x3", (array<3 x vector<3xf32>>)>
    llvm.return %5 : !llvm.ptr
  }
}
