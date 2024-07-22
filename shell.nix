{ pkgs ? import <nixpkgs> {} }:
with pkgs;
mkShell {
  buildInputs = [
    pkgs.elan
    pkgs.python3
    pkgs.vscode
    (vscode-with-extensions.override {
    vscodeExtensions = pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "lean4";
        publisher = "leanprover";
        version = "latest";
        sha256 = "sha256-z6J1mUMmjdI6lK2JPKzoz99JIyEA9LgUprypd3b5Fi4=";
      }
    ];
    })
  ];
shellHook = ''
lake exe cache get!
lake build
code
'';
}
