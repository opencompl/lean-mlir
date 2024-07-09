module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @func(%arg0: !llvm.ptr {llvm.nocapture, llvm.readnone}, ...) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.alloca %0 x !llvm.struct<"struct.__va_list", (ptr, ptr, ptr, i32, i32)> {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %3 = llvm.alloca %0 x !llvm.struct<"struct.__va_list", (ptr, ptr, ptr, i32, i32)> {alignment = 8 : i64} : (i32) -> !llvm.ptr
    llvm.intr.lifetime.start 32, %2 : !llvm.ptr
    llvm.intr.vastart %2 : !llvm.ptr
    llvm.intr.lifetime.start 32, %3 : !llvm.ptr
    llvm.intr.vacopy %2 to %3 : !llvm.ptr, !llvm.ptr
    llvm.intr.vaend %3 : !llvm.ptr
    llvm.intr.lifetime.end 32, %3 : !llvm.ptr
    llvm.intr.vaend %2 : !llvm.ptr
    llvm.intr.lifetime.end 32, %2 : !llvm.ptr
    llvm.return %1 : i32
  }
}
