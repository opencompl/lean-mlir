module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func local_unnamed_addr @foo(%arg0: !llvm.ptr) -> (i32 {llvm.signext}) attributes {passthrough = ["noinline", "nounwind"]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %4 = llvm.load %3 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    llvm.store %4, %arg0 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    %5 = llvm.getelementptr inbounds %arg0[%0, 1] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"struct.C", (ptr, i32)>
    %6 = llvm.load %5 {alignment = 8 : i64} : !llvm.ptr -> i32
    %7 = llvm.add %6, %2 overflow<nsw>  : i32
    llvm.store %7, %5 {alignment = 8 : i64} : i32, !llvm.ptr
    "llvm.intr.prefetch"(%4) <{cache = 1 : i32, hint = 0 : i32, rw = 0 : i32}> : (!llvm.ptr) -> ()
    %8 = llvm.load %5 {alignment = 8 : i64} : !llvm.ptr -> i32
    llvm.return %8 : i32
  }
}
