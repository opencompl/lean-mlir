module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<32> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @takes_i32(i32)
  llvm.func @takes_i32_inalloca(!llvm.ptr {llvm.inalloca = i32})
  llvm.func @f() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.addressof @takes_i32 : !llvm.ptr
    %2 = llvm.alloca inalloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.call %1(%2) : !llvm.ptr, (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @g() {
    %0 = llvm.mlir.addressof @takes_i32_inalloca : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i32) : i32
    llvm.call %0(%1) : !llvm.ptr, (i32) -> ()
    llvm.return
  }
}
