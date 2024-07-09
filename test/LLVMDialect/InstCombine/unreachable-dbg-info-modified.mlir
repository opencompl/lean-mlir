#di_basic_type = #llvm.di_basic_type<tag = DW_TAG_base_type, name = "int", sizeInBits = 32, encoding = DW_ATE_signed>
#di_file = #llvm.di_file<"foo.c" in "/">
#di_compile_unit = #llvm.di_compile_unit<id = distinct[0]<>, sourceLanguage = DW_LANG_C99, file = #di_file, producer = "clang version 12.0.0", isOptimized = true, emissionKind = Full>
#di_subroutine_type = #llvm.di_subroutine_type<types = #di_basic_type>
#di_subprogram = #llvm.di_subprogram<id = distinct[1]<>, compileUnit = #di_compile_unit, scope = #di_file, name = "foo", file = #di_file, line = 1, scopeLine = 1, subprogramFlags = "Definition|Optimized", type = #di_subroutine_type>
#di_local_variable = #llvm.di_local_variable<scope = #di_subprogram, name = "bar", file = #di_file, line = 1, type = #di_basic_type>
module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @foo() -> i32 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.undef : i32
    llvm.intr.dbg.value #di_local_variable = %1 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %1 : i32
  }
}
