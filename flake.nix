{
  description = "A Nix-based development environment for the lean-mlir project.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    lean.url = "github:lenianiva/lean4-nix";
  };

  outputs = { self, nixpkgs, flake-utils, lean }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };

        pythonPackages = ps: with ps; [
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
          # visidata
          zipp
        ];

        pythonEnv = pkgs.python3.withPackages pythonPackages;

      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = [
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

      apps.test-experiments = {
        type = "app";
        program = "${pkgs.writeShellScriptBin "run-experiments-script" ''
          set -euo pipefail
          export PATH=${pkgs.lib.makeBinPath [ pythonEnv pkgs.coreutils ]}:$PATH
          chmod +x artifacts/oopsla25-width-indep/test_experiments.sh
          ./artifacts/oopsla25-width-indep/test_experiments.sh
        ''}/bin/run-experiments-script";
      };

      apps.run-experiments = {
        type = "app";
        program = "${pkgs.writeShellScriptBin "run-experiments-script" ''
          set -euo pipefail
          export PATH=${pkgs.lib.makeBinPath [ pythonEnv pkgs.coreutils ]}:$PATH
          chmod +x artifacts/oopsla25-width-indep/run_experiments.sh
          ./artifacts/oopsla25-width-indep/run_experiments.sh
        ''}/bin/run-experiments-script";
      };

      });
}
