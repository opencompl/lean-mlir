import Lake
open System Lake DSL

package sqlite where
  srcDir := "Sqlite"

@[default_target]
lean_lib Sqlite

@[default_target]
lean_exe test where
  root := `Test

target ffi.o pkg : FilePath := do
  let oFile := pkg.buildDir / "c" / "ffi.o"
  let srcJob ← inputTextFile <| pkg.dir / "c" / "ffi.c"
  let weakArgs := #["-I", (← getLeanIncludeDir).toString]
  buildO oFile srcJob weakArgs #["-fPIC"] "cc" getLeanTrace

target sqlite.o pkg : FilePath := do
  let oFile := pkg.buildDir / "c" / "ffi.o"
  let srcJob ← inputTextFile <| pkg.dir / "c" / "sqlite3.c"
  let weakArgs := #["-I", (← getLeanIncludeDir).toString]
  buildO oFile srcJob weakArgs #["-fPIC"] "cc" getLeanTrace

extern_lib libleansqlite pkg := do
  let ffiO ← ffi.o.fetch
  let sqliteO ← sqlite.o.fetch
  let name := nameToStaticLib "leansqlite"
  buildStaticLib (pkg.nativeLibDir / name) #[ffiO, sqliteO]

