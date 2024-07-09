#di_basic_type = #llvm.di_basic_type<tag = DW_TAG_base_type, name = "unsigned int", sizeInBits = 32, encoding = DW_ATE_unsigned>
#di_file = #llvm.di_file<"b" in "c">
#di_subroutine_type = #llvm.di_subroutine_type<>
#di_compile_unit = #llvm.di_compile_unit<id = distinct[0]<>, sourceLanguage = DW_LANG_C99, file = #di_file, producer = "clang version", isOptimized = true, emissionKind = Full>
#di_composite_type = #llvm.di_composite_type<tag = DW_TAG_array_type, baseType = #di_basic_type>
#di_subprogram = #llvm.di_subprogram<id = distinct[1]<>, compileUnit = #di_compile_unit, scope = #di_file, name = "a", file = #di_file, line = 232, scopeLine = 234, subprogramFlags = "LocalToUnit|Definition|Optimized", type = #di_subroutine_type>
#di_lexical_block = #llvm.di_lexical_block<scope = #di_subprogram, file = #di_file, line = 238, column = 6>
#di_lexical_block1 = #llvm.di_lexical_block<scope = #di_lexical_block, file = #di_file, line = 238, column = 39>
#di_local_variable = #llvm.di_local_variable<scope = #di_lexical_block1, name = "ptr32", file = #di_file, line = 240, type = #di_composite_type>
module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @bar(!llvm.ptr) -> i32
  llvm.func internal @foo() -> i32 attributes {dso_local, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i64) -> !llvm.ptr
    llvm.intr.dbg.declare #di_local_variable = %1 : !llvm.ptr
    %2 = llvm.call @bar(%1) : (!llvm.ptr) -> i32
    llvm.unreachable
  }
}
