module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<32> : vector<4xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f80, dense<32> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @g() {addr_space = 0 : i32} : !llvm.struct<"opaque_t", opaque>
  llvm.mlir.global external @h() {addr_space = 0 : i32} : !llvm.struct<"op_ts", (struct<"opaque2", opaque>, i32)>
  llvm.func @foo() -> i32 {
    %0 = llvm.mlir.addressof @g : !llvm.ptr
    %1 = llvm.mlir.addressof @h : !llvm.ptr
    %2 = llvm.load %0 {alignment = 1 : i64} : !llvm.ptr -> i8
    %3 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> i32
    %4 = llvm.zext %2 : i8 to i32
    %5 = llvm.add %3, %4  : i32
    llvm.return %5 : i32
  }
}
