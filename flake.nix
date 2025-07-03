{
  description = "A Nix-based development environment for the lean-mlir project.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    lean.url = "github:leanprover/lean-nix";
  };

  outputs = { self, nixpkgs, flake-utils, lean }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ lean.overlays.default ];
        };

        leanToolchain = pkgs.lean-toolchain.override {
          leanVersion = "nightly-2025-06-27";
        };

        xdsl = pkgs.python3Packages.buildPythonPackage rec {
            pname = "xdsl";
            version = "0.22.0";

            src = pkgs.fetchPypi {
                inherit version;
                pname = "xdsl";
                hash = "sha256-+t8Lic/fm7u7PNEQs9DtSwoVnDjBjdy43f62qtkzPMs=";
            };

            propagatedBuildInputs = with pkgs.python3Packages; [
                immutabledict
                typing-extensions
                ordered-set
            ];

            doCheck = false;

            meta = with pkgs.lib; {
                description = "xDSL: A Python library for building compilers and DSLs";
                homepage = "https://github.com/xdslproject/xdsl";
                license = licenses.asl20;
            };
        };

        pythonPackages = ps: with ps; [
          xdsl
          matplotlib
          pandas
          polars
          num2words
          psutil
          contourpy
          cycler
          fonttools
          importlib-metadata
          kiwisolver
          numpy
          packaging
          pillow
          python-dateutil
          pyparsing
          pytz
          six
          tabulate
          tzdata
          visidata
          zipp
        ];

        pythonEnv = pkgs.python3.withPackages pythonPackages;

      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            leanToolchain
            pythonEnv
            pkgs.unzip
            pkgs.black
            pkgs.llvmPackages_19.mlir
            pkgs.llvmPackages_19.bintools-unwrapped
            pkgs.bitwuzla
            pkgs.ripgrep
            pkgs.git
          ];
        };

        apps.run-experiments = {
          type = "app";
          program = pkgs.writeShellScript "run-experiments-script" ''
            #!${pkgs.bash}/bin/bash
            set -euo pipefail
            export PATH=${pkgs.lib.makeBinPath [ pythonEnv pkgs.coreutils ]}:$PATH
            chmod +x artifacts/oopsla25-width-indep/run_experiments.sh
            ./artifacts/oopsla25-width-indep/run_experiments.sh
          '';
        };
      });
}
