#alias_scope_domain = #llvm.alias_scope_domain<id = distinct[0]<>>
#tbaa_root = #llvm.tbaa_root<id = "tbaa root">
#alias_scope = #llvm.alias_scope<id = distinct[1]<>, domain = #alias_scope_domain>
#alias_scope1 = #llvm.alias_scope<id = distinct[2]<>, domain = #alias_scope_domain>
#tbaa_type_desc = #llvm.tbaa_type_desc<id = "scalar type", members = {<#tbaa_root, 0>}>
#tbaa_tag = #llvm.tbaa_tag<base_type = #tbaa_type_desc, access_type = #tbaa_type_desc, offset = 0>
module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">, #dlti.dl_entry<"dlti.stack_alignment", 128 : i64>>} {
  llvm.func @test_load_load_combine_metadata(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: !llvm.ptr) {
    %0 = llvm.load %arg0 {alias_scopes = [#alias_scope], alignment = 4 : i64, noalias_scopes = [#alias_scope1], tbaa = [#tbaa_tag]} : !llvm.ptr -> i32
    %1 = llvm.load %arg0 {alignment = 4 : i64, tbaa = [#tbaa_tag]} : !llvm.ptr -> i32
    llvm.store %0, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %1, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
}
