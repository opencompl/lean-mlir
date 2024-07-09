module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @buffer() {addr_space = 0 : i32} : !llvm.array<64 x f32>
  llvm.func @use(!llvm.ptr)
  llvm.func @f() {
    %0 = llvm.mlir.constant(127 : i64) : i64
    %1 = llvm.mlir.addressof @buffer : !llvm.ptr
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i64
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.sub %3, %2  : i64
    %5 = llvm.add %4, %0  : i64
    %6 = llvm.getelementptr %1[%5] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.call @use(%6) : (!llvm.ptr) -> ()
    llvm.return
  }
}
