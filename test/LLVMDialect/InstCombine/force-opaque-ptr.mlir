module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @g(dense<0> : tensor<16xi16>) {addr_space = 0 : i32} : !llvm.array<16 x i16>
  llvm.func @gep_constexpr_gv_1() -> !llvm.ptr {
    %0 = llvm.mlir.constant(10 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(0 : i16) : i16
    %3 = llvm.mlir.constant(dense<0> : tensor<16xi16>) : !llvm.array<16 x i16>
    %4 = llvm.mlir.addressof @g : !llvm.ptr
    %5 = llvm.getelementptr inbounds %4[%1, %0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<16 x i16>
    llvm.return %5 : !llvm.ptr
  }
  llvm.func @gep_constexpr_gv_2() -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(10 : i64) : i64
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(0 : i16) : i16
    %4 = llvm.mlir.constant(dense<0> : tensor<16xi16>) : !llvm.array<16 x i16>
    %5 = llvm.mlir.addressof @g : !llvm.ptr
    %6 = llvm.getelementptr inbounds %5[%2, %1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<16 x i16>
    %7 = llvm.getelementptr %6[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %7 : !llvm.ptr
  }
  llvm.func @gep_constexpr_inttoptr() -> !llvm.ptr {
    %0 = llvm.mlir.constant(10 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.mlir.constant(0 : i16) : i16
    %4 = llvm.mlir.constant(dense<0> : tensor<16xi16>) : !llvm.array<16 x i16>
    %5 = llvm.mlir.addressof @g : !llvm.ptr
    %6 = llvm.ptrtoint %5 : !llvm.ptr to i64
    %7 = llvm.mul %6, %2  : i64
    %8 = llvm.inttoptr %7 : i64 to !llvm.ptr
    %9 = llvm.getelementptr %8[%1, %0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<16 x i16>
    llvm.return %9 : !llvm.ptr
  }
}
