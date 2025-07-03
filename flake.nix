{
  description = "A Nix-based development environment for the lean-mlir project.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs";
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
        # nix run .#test-experiments
        apps.test-experiments = {
          type = "app";
          program = "${pkgs.writeShellScriptBin "run-experiments-script" ''
            set -euo pipefail
            export PATH=${pkgs.lib.makeBinPath [ pythonEnv pkgs.coreutils ]}:$PATH
            ./artifacts/oopsla25-width-indep/test_experiments.sh
          ''}/bin/run-experiments-script";
        };

      });
}
