module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">, #dlti.dl_entry<"dlti.stack_alignment", 128 : i64>>} {
  llvm.mlir.global external @x() {addr_space = 0 : i32, alignment = 8 : i64} : !llvm.ptr {
    %0 = llvm.mlir.zero : !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }
  llvm.mlir.global external @y() {addr_space = 0 : i32, alignment = 8 : i64} : !llvm.ptr {
    %0 = llvm.mlir.zero : !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }
  llvm.func @f() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.mlir.addressof @x : !llvm.ptr
    %3 = llvm.mlir.addressof @y : !llvm.ptr
    %4 = llvm.alloca %0 x !llvm.array<0 x i8> {alignment = 1 : i64} : (i32) -> !llvm.ptr
    %5 = llvm.alloca %0 x !llvm.array<0 x i8> {alignment = 1024 : i64} : (i32) -> !llvm.ptr
    llvm.store %4, %2 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    llvm.store %5, %3 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    llvm.return
  }
}
