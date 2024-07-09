module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @g(!llvm.ptr)
  llvm.func @g_addr1(!llvm.ptr<1>)
  llvm.func @f() -> i8 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr
    llvm.store %1, %2 {alignment = 1 : i64} : i8, !llvm.ptr
    %3 = llvm.intr.invariant.start 1, %2 : !llvm.ptr
    llvm.call @g(%2) : (!llvm.ptr) -> ()
    %4 = llvm.load %2 {alignment = 1 : i64} : !llvm.ptr -> i8
    llvm.return %4 : i8
  }
  llvm.func @f_addrspace1(%arg0: !llvm.ptr<1>) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    llvm.store %0, %arg0 {alignment = 1 : i64} : i8, !llvm.ptr<1>
    %1 = llvm.intr.invariant.start 1, %arg0 : !llvm.ptr<1>
    llvm.call @g_addr1(%arg0) : (!llvm.ptr<1>) -> ()
    %2 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr<1> -> i8
    llvm.return %2 : i8
  }
}
