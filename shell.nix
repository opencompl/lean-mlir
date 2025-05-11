{ pkgs ? import <nixpkgs-unstable> {} }:
with pkgs;let
  xdsl = ps: ps.callPackage ./xdsl.nix {};
  my-python-packages = ps: with ps; [
    (xdsl ps)
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
    pkgs.vscode
    (vscode-with-extensions.override {
      vscodeExtensions = pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "lean4";
          publisher = "leanprover";
          version = "latest";
          sha256 = "sha256-EA/m4l4TRnq002e6DZerXJhnOnyF628mqBjm+kiiElA=";
        }
    ];})
  ];
shellHook = ''
# lake exe cache get!
# lake build
# code
'';
}
