#access_group = #llvm.access_group<id = distinct[0]<>>
#alias_scope_domain = #llvm.alias_scope_domain<id = distinct[1]<>>
#tbaa_root = #llvm.tbaa_root<id = "root">
#alias_scope = #llvm.alias_scope<id = distinct[2]<>, domain = #alias_scope_domain>
#tbaa_type_desc = #llvm.tbaa_type_desc<id = "scalar type", members = {<#tbaa_root, 0>}>
#tbaa_tag = #llvm.tbaa_tag<base_type = #tbaa_type_desc, access_type = #tbaa_type_desc, offset = 0>
module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">, #dlti.dl_entry<"dlti.stack_alignment", 128 : i64>>} {
  llvm.func @test_load_cast_combine_tbaa(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.load %arg0 {alignment = 4 : i64, tbaa = [#tbaa_tag]} : !llvm.ptr -> f32
    %1 = llvm.bitcast %0 : f32 to i32
    llvm.return %1 : i32
  }
  llvm.func @test_load_cast_combine_noalias(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.load %arg0 {alias_scopes = [#alias_scope], alignment = 4 : i64, noalias_scopes = [#alias_scope]} : !llvm.ptr -> f32
    %1 = llvm.bitcast %0 : f32 to i32
    llvm.return %1 : i32
  }
  llvm.func @test_load_cast_combine_range(%arg0: !llvm.ptr) -> f32 {
    %0 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32
    %1 = llvm.bitcast %0 : i32 to f32
    llvm.return %1 : f32
  }
  llvm.func @test_load_cast_combine_invariant(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.load %arg0 invariant {alignment = 4 : i64} : !llvm.ptr -> f32
    %1 = llvm.bitcast %0 : f32 to i32
    llvm.return %1 : i32
  }
  llvm.func @test_load_cast_combine_nontemporal(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.load %arg0 {alignment = 4 : i64, nontemporal} : !llvm.ptr -> f32
    %1 = llvm.bitcast %0 : f32 to i32
    llvm.return %1 : i32
  }
  llvm.func @test_load_cast_combine_align(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }
  llvm.func @test_load_cast_combine_deref(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }
  llvm.func @test_load_cast_combine_deref_or_null(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }
  llvm.func @test_load_cast_combine_loop(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i32) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    llvm.br ^bb1(%0 : i32)
  ^bb1(%2: i32):  // 2 preds: ^bb0, ^bb1
    %3 = llvm.getelementptr inbounds %arg0[%2] : (!llvm.ptr, i32) -> !llvm.ptr, f32
    %4 = llvm.getelementptr inbounds %arg1[%2] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    %5 = llvm.load %3 {access_groups = [#access_group], alignment = 4 : i64} : !llvm.ptr -> f32
    %6 = llvm.bitcast %5 : f32 to i32
    llvm.store %6, %4 {alignment = 4 : i64} : i32, !llvm.ptr
    %7 = llvm.add %2, %1  : i32
    %8 = llvm.icmp "slt" %7, %arg2 : i32
    llvm.cond_br %8, ^bb1(%7 : i32), ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return
  }
  llvm.func @test_load_cast_combine_nonnull(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %2 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.ptr
    llvm.store %1, %2 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    llvm.return
  }
  llvm.func @test_load_cast_combine_noundef(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> f32
    %1 = llvm.bitcast %0 : f32 to i32
    llvm.return %1 : i32
  }
}
