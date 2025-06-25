{ pkgs ? import <nixpkgs-unstable> {} }:
with pkgs;let
  xdsl = ps: ps.callPackage ./xdsl.nix {};
  my-python-packages = ps: with ps; [
    (xdsl ps)
    matplotlib
    pandas
    polars
  ];
  my-python = pkgs.python3.withPackages my-python-packages;
in
mkShell {
  buildInputs = [
    my-python
    pkgs.unzip
    pkgs.black
    pkgs.llvmPackages_19.mlir
    pkgs.llvmPackages_19.bintools-unwrapped
    pkgs.bitwuzla
    pkgs.ripgrep
  ];
shellHook = ''
# lake exe cache get!
# lake build
# code
'';
}
