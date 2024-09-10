module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @"\01??2@YAPEAX_K@Z"(i64) -> (!llvm.ptr {llvm.noalias}) attributes {passthrough = ["nobuiltin"]}
  llvm.func @"\01??3@YAXPEAX@Z"(!llvm.ptr) attributes {passthrough = ["nobuiltin"]}
  llvm.func @test9() {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.call @"\01??2@YAPEAX_K@Z"(%0) : (i64) -> !llvm.ptr
    llvm.call @"\01??3@YAXPEAX@Z"(%1) : (!llvm.ptr) -> ()
    llvm.return
  }
}
