#tbaa_root = #llvm.tbaa_root<id = "tbaa_root">
#tbaa_type_desc = #llvm.tbaa_type_desc<id = "Complex", members = {<#tbaa_root, 0>}>
#tbaa_tag = #llvm.tbaa_tag<base_type = #tbaa_type_desc, access_type = #tbaa_type_desc, offset = 0>
module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @teststructextract(%arg0: !llvm.ptr) -> f64 {
    %0 = llvm.load %arg0 {alignment = 8 : i64, tbaa = [#tbaa_tag]} : !llvm.ptr -> !llvm.struct<"Complex", (f64, f64)>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<"Complex", (f64, f64)> 
    llvm.return %1 : f64
  }
  llvm.func @testarrayextract(%arg0: !llvm.ptr) -> f64 {
    %0 = llvm.load %arg0 {alignment = 8 : i64, tbaa = [#tbaa_tag]} : !llvm.ptr -> !llvm.array<2 x f64>
    %1 = llvm.extractvalue %0[0] : !llvm.array<2 x f64> 
    llvm.return %1 : f64
  }
  llvm.func @teststructinsert(%arg0: !llvm.ptr, %arg1: f64, %arg2: f64) {
    %0 = llvm.mlir.undef : !llvm.struct<"Complex", (f64, f64)>
    %1 = llvm.insertvalue %arg1, %0[0] : !llvm.struct<"Complex", (f64, f64)> 
    %2 = llvm.insertvalue %arg2, %1[1] : !llvm.struct<"Complex", (f64, f64)> 
    llvm.store %2, %arg0 {alignment = 8 : i64, tbaa = [#tbaa_tag]} : !llvm.struct<"Complex", (f64, f64)>, !llvm.ptr
    llvm.return
  }
  llvm.func @testarrayinsert(%arg0: !llvm.ptr, %arg1: f64, %arg2: f64) {
    %0 = llvm.mlir.undef : !llvm.array<2 x f64>
    %1 = llvm.insertvalue %arg1, %0[0] : !llvm.array<2 x f64> 
    %2 = llvm.insertvalue %arg2, %1[1] : !llvm.array<2 x f64> 
    llvm.store %2, %arg0 {alignment = 8 : i64, tbaa = [#tbaa_tag]} : !llvm.array<2 x f64>, !llvm.ptr
    llvm.return
  }
}
