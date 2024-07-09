module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr<270>, dense<32> : vector<4xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr<272>, dense<64> : vector<4xi64>>, #dlti.dl_entry<!llvm.ptr<271>, dense<32> : vector<4xi64>>, #dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.stack_alignment", 128 : i64>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func local_unnamed_addr @annotated(%arg0: !llvm.ptr) -> i32 attributes {passthrough = ["mustprogress", "nofree", "nounwind", "willreturn", ["uwtable", "2"]]} {
    %0 = llvm.mlir.undef : !llvm.ptr
    %1 = llvm.mlir.undef : i32
    %2 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32
    %3 = "llvm.intr.annotation"(%2, %0, %0, %1) : (i32, !llvm.ptr, !llvm.ptr, i32) -> i32
    %4 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32
    %5 = llvm.add %3, %4 overflow<nsw>  : i32
    llvm.return %5 : i32
  }
}
