{ pkgs ? import <nixpkgs> {} }:
with pkgs;let
  my-python-packages = ps: with ps; [
    pygls
  ];
  my-python = pkgs.python3.withPackages my-python-packages;
in
mkShell {
  buildInputs = [
    pkgs.elan
    my-python
    pkgs.vscode
    (vscode-with-extensions.override {
    vscodeExtensions = pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "lean4";
        publisher = "leanprover";
        version = "latest";
        sha256 = "sha256-V2ZjimjLdWjy2ARQY9d5bASOxImVQcSVY/sqMIogiDw=";
      }
    ];
    })
  ];
shellHook = ''
# lake exe cache get!
# lake build
# code
'';
}
