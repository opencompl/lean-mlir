{ pkgs ? import <nixpkgs-unstable> {} }:
with pkgs;let
  xdsl = ps: ps.callPackage ./xdsl.nix {};
  my-python-packages = ps: with ps; [
    (xdsl ps)
    numpy # We install numpy via nix as it has native/C components
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
  export VIRTUAL_ENV=".venv"
  if [[ ! -d "$VIRTUAL_ENV" ]]; then
    python3 -m venv "$VIRTUAL_ENV"
  fi
  source "$VIRTUAL_ENV"/bin/activate
  pip3 install -r requirements.txt
'';
}
