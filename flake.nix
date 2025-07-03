{
  description = "A Nix-based development environment for the lean-mlir project.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
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

        customShellHook = pkgs.writeShellScriptBin "lean-mlir-init-env" ''
          # Ensure the right Lean toolchain gets installed
          # And that dependencies are checked out to the right versions,
          # although we do not check any cached build outputs
          MATHLIB_NO_CACHE_ON_UPDATE=1 lake update --no-cache
        '';

        shellPkgs = with pkgs; [
          pythonEnv
          elan
          customShellHook
        ];

      in
      {
        devShell = pkgs.mkShell {
          buildInputs = shellPkgs;
          shellHook = ''
            lean-mlir-init-env
          '';
        };

        packages.default = pkgs.buildEnv {
          name = "LeanMLIR build environment";
          paths = shellPkgs;
          pathsToLink = [
            "/bin"
            "/share"
          ];
        };

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
