#di_basic_type = #llvm.di_basic_type<tag = DW_TAG_base_type, name = "int", sizeInBits = 32, encoding = DW_ATE_signed>
#di_derived_type = #llvm.di_derived_type<tag = DW_TAG_pointer_type, sizeInBits = 64>
#di_file = #llvm.di_file<"t.c" in "C:\\src\\llvm-project\\build">
#di_null_type = #llvm.di_null_type
#di_compile_unit = #llvm.di_compile_unit<id = distinct[0]<>, sourceLanguage = DW_LANG_C99, file = #di_file, producer = "clang version 6.0.0 ", isOptimized = true, emissionKind = Full>
#di_derived_type1 = #llvm.di_derived_type<tag = DW_TAG_pointer_type, baseType = #di_basic_type, sizeInBits = 64>
#di_subroutine_type = #llvm.di_subroutine_type<types = #di_null_type, #di_derived_type>
#di_subprogram = #llvm.di_subprogram<id = distinct[1]<>, compileUnit = #di_compile_unit, scope = #di_file, name = "f", file = #di_file, line = 2, scopeLine = 2, subprogramFlags = "Definition|Optimized", type = #di_subroutine_type>
#di_local_variable = #llvm.di_local_variable<scope = #di_subprogram, name = "q", file = #di_file, line = 3, type = #di_derived_type1>
#di_local_variable1 = #llvm.di_local_variable<scope = #di_subprogram, name = "p", file = #di_file, line = 2, arg = 1, type = #di_derived_type>
module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">, #dlti.dl_entry<"dlti.stack_alignment", 128 : i64>>} {
  llvm.func @f(%arg0: !llvm.ptr) {
    llvm.intr.dbg.value #di_local_variable = %arg0 : !llvm.ptr
    llvm.intr.dbg.value #di_local_variable1 = %arg0 : !llvm.ptr
    llvm.call @use_as_void(%arg0) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @use_as_void(!llvm.ptr)
}
