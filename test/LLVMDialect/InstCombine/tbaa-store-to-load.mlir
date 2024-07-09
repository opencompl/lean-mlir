#tbaa_root = #llvm.tbaa_root<id = "load_tbaa">
#tbaa_type_desc = #llvm.tbaa_type_desc<id = "scalar type", members = {<#tbaa_root, 0>}>
#tbaa_tag = #llvm.tbaa_tag<base_type = #tbaa_type_desc, access_type = #tbaa_type_desc, offset = 0>
module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @f(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i64 {
    %0 = llvm.load %arg0 {alignment = 8 : i64, tbaa = [#tbaa_tag]} : !llvm.ptr -> i64
    llvm.store %0, %arg1 {alignment = 8 : i64} : i64, !llvm.ptr
    %1 = llvm.load %arg1 {alignment = 8 : i64} : !llvm.ptr -> i64
    llvm.return %1 : i64
  }
}
