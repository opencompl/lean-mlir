#di_basic_type = #llvm.di_basic_type<tag = DW_TAG_base_type, name = "int", sizeInBits = 32, encoding = DW_ATE_signed>
#di_file = #llvm.di_file<"t.c" in "C:\\src\\llvm-project\\build">
#di_null_type = #llvm.di_null_type
#tbaa_root = #llvm.tbaa_root<id = "Simple C/C++ TBAA">
#di_compile_unit = #llvm.di_compile_unit<id = distinct[0]<>, sourceLanguage = DW_LANG_C99, file = #di_file, producer = "clang version 6.0.0 ", isOptimized = true, emissionKind = Full>
#di_derived_type = #llvm.di_derived_type<tag = DW_TAG_member, name = "x", baseType = #di_basic_type, sizeInBits = 32>
#di_derived_type1 = #llvm.di_derived_type<tag = DW_TAG_member, name = "y", baseType = #di_basic_type, sizeInBits = 32, offsetInBits = 32>
#di_composite_type = #llvm.di_composite_type<tag = DW_TAG_structure_type, name = "Foo", file = #di_file, line = 1, sizeInBits = 64, elements = #di_derived_type, #di_derived_type1>
#tbaa_type_desc = #llvm.tbaa_type_desc<id = "omnipotent char", members = {<#tbaa_root, 0>}>
#di_derived_type2 = #llvm.di_derived_type<tag = DW_TAG_pointer_type, baseType = #di_composite_type, sizeInBits = 64>
#di_subroutine_type = #llvm.di_subroutine_type<types = #di_null_type, #di_derived_type2>
#tbaa_type_desc1 = #llvm.tbaa_type_desc<id = "long long", members = {<#tbaa_type_desc, 0>}>
#di_subprogram = #llvm.di_subprogram<id = distinct[1]<>, compileUnit = #di_compile_unit, scope = #di_file, name = "f", file = #di_file, line = 5, scopeLine = 5, subprogramFlags = "Definition|Optimized", type = #di_subroutine_type>
#tbaa_tag = #llvm.tbaa_tag<base_type = #tbaa_type_desc1, access_type = #tbaa_type_desc1, offset = 0>
#di_local_variable = #llvm.di_local_variable<scope = #di_subprogram, name = "local", file = #di_file, line = 6, type = #di_composite_type>
module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">, #dlti.dl_entry<"dlti.stack_alignment", 128 : i64>>} {
  llvm.func @f(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x !llvm.struct<"struct.Foo", (i32, i32)> {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.intr.dbg.declare #di_local_variable = %1 : !llvm.ptr
    %2 = llvm.load %arg0 {alignment = 8 : i64, tbaa = [#tbaa_tag]} : !llvm.ptr -> i64
    llvm.store %2, %1 {alignment = 4 : i64, tbaa = [#tbaa_tag]} : i64, !llvm.ptr
    llvm.call @escape(%1) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @escape(!llvm.ptr)
}
