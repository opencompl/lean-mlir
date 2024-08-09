#alias_scope_domain = #llvm.alias_scope_domain<id = distinct[0]<>, description = "some domain">
#tbaa_root = #llvm.tbaa_root<id = "Simple C/C++ TBAA">
#alias_scope = #llvm.alias_scope<id = distinct[1]<>, domain = #alias_scope_domain, description = "scope0">
#alias_scope1 = #llvm.alias_scope<id = distinct[2]<>, domain = #alias_scope_domain, description = "scope1">
#alias_scope2 = #llvm.alias_scope<id = distinct[3]<>, domain = #alias_scope_domain, description = "scope2">
#alias_scope3 = #llvm.alias_scope<id = distinct[4]<>, domain = #alias_scope_domain, description = "scope3">
#tbaa_type_desc = #llvm.tbaa_type_desc<id = "omnipotent char", members = {<#tbaa_root, 0>}>
#tbaa_type_desc1 = #llvm.tbaa_type_desc<id = "float", members = {<#tbaa_type_desc, 0>}>
#tbaa_type_desc2 = #llvm.tbaa_type_desc<id = "int", members = {<#tbaa_type_desc, 0>}>
#tbaa_type_desc3 = #llvm.tbaa_type_desc<id = "", members = {<#tbaa_type_desc1, 0>, <#tbaa_type_desc2, 4>}>
#tbaa_type_desc4 = #llvm.tbaa_type_desc<id = "", members = {<#tbaa_type_desc2, 0>, <#tbaa_type_desc1, 4>}>
#tbaa_tag = #llvm.tbaa_tag<base_type = #tbaa_type_desc3, access_type = #tbaa_type_desc2, offset = 4>
#tbaa_tag1 = #llvm.tbaa_tag<base_type = #tbaa_type_desc4, access_type = #tbaa_type_desc2, offset = 0>
module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global common @g1() {addr_space = 0 : i32, alignment = 8 : i64} : !llvm.ptr {
    %0 = llvm.mlir.zero : !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }
  llvm.func @phi_load_metadata(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i32, %arg3: !llvm.ptr, %arg4: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.zero : !llvm.ptr
    %4 = llvm.mlir.addressof @g1 : !llvm.ptr
    %5 = llvm.icmp "eq" %arg2, %0 : i32
    llvm.cond_br %5, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    %6 = llvm.getelementptr inbounds %arg1[%1, 1] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<"struct.S2", (f32, i32)>
    %7 = llvm.load %6 invariant {alias_scopes = [#alias_scope, #alias_scope1], alignment = 4 : i64, noalias_scopes = [#alias_scope2, #alias_scope3], tbaa = [#tbaa_tag]} : !llvm.ptr -> i32
    %8 = llvm.load %arg3 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    llvm.br ^bb3(%7, %8 : i32, !llvm.ptr)
  ^bb2:  // pred: ^bb0
    %9 = llvm.load %arg0 invariant {alias_scopes = [#alias_scope, #alias_scope2], alignment = 4 : i64, noalias_scopes = [#alias_scope1, #alias_scope3], tbaa = [#tbaa_tag1]} : !llvm.ptr -> i32
    %10 = llvm.load %arg4 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    llvm.br ^bb3(%9, %10 : i32, !llvm.ptr)
  ^bb3(%11: i32, %12: !llvm.ptr):  // 2 preds: ^bb1, ^bb2
    llvm.store %12, %4 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    llvm.return %11 : i32
  }
}
