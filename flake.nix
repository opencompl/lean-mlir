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

        installPackages = with pkgs; [
          ##########################################################
          ##
          ## Installed packages
          ##
          ##########################################################
          #
          # To add a new package to be installed in both the Dockerfile
          # and local development environments, search for the name of the 
          # relevant nix package on https://search.nixos.org/packages, 
          # and add it at the end of the list below.
          #
          elan
          curl # Needed for `lake exe cache ...`
          unzip
          black
          llvmPackages_19.mlir
          llvmPackages_19.bintools-unwrapped
          ripgrep

          uv # Extremely fast Python package installer and resolver,
          python312Packages.numpy

          #
          # Packages with specific version overrides
          #
          # To update, replace `version` with the new commit hash or tag
          # you wish to update to, replace hash with an empty string (`""`),
          # and run `nix develop` (or attempt to build the Docker image).
          # This will fail, with a hash mismatch error, for example;
          # ```
          # error: hash mismatch in fixed-output derivation '/nix/store/ni1ps8il94y5lbvzlxwvaqsxwrwqkxqd-source.drv':
          #   specified: sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
          #      got:    sha256-cEzN/nktAe5wbNDCn6P9orNuZS6KbnjuRpG4XgnzevA=
          # ```
          # Then, replace the now-empty hash with the hash you see in the `got` 
          # of the error you just got.
          (bitwuzla.overrideAttrs (final: prev: rec {
            version = "0dca38d0f62fa9002ad6278ca6374838a69ade19";
            src = fetchFromGitHub {
              inherit (prev.src) owner repo;
              rev = version;
              hash = "sha256-cEzN/nktAe5wbNDCn6P9orNuZS6KbnjuRpG4XgnzevA=";
            };
          }))
        ];


        pythonPackages = ps: with ps; [
          ##########################################################
          ##
          ## Python dependencies
          ##
          ##########################################################
          #
          # To add a new python package to be installed in both the Dockerfile
          # and local development environments, search for the name of the 
          # relevant nix package on https://search.nixos.org/packages, 
          # and add it at the end of the list below. 
          # For example, for matplotlib, the search will return 
          # `python313Packages.matplotlib` as the relevant nix package.
          # To install this, omit the python313Packages prefix from the 
          # package name, and list only the bit after the dot below.
          # 
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
          zipp
          # (ps.callPackage ./xdsl.nix {})
          # ^^ FIXME: this is temporarily disabled, as the version of 
          #    typing-extensions packaged by nixpkgs did not fit in the constraints
          #    set by xdsl, breaking the entire devshell. We do need xDSL, though!
       ];

        pythonEnv = pkgs.python3.withPackages pythonPackages;

        customShellHook = pkgs.writeShellScriptBin "lean-mlir-init-env" ''
          # Ensure the right Lean toolchain gets installed
          # And that dependencies are checked out to the right versions,
          # although we do not check any cached build outputs
          #
          # NOTE: surprisingly, there seems to be no dedicated command which just
          # fetches the depencies, without updating the manifest to newer version
          # as `lake update` does, or fetching build outputs from cache. Thus, 
          # we use `lake env ...` which as a side-effect does ensure all dependency 
          # sources are available.

          lake env echo
        '';

        shellPkgs = installPackages ++ [
          pythonEnv
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
        };
        
        # nix run .#test-experiments
        apps.test-experiments = 
        let
          programDir = pkgs.writeShellApplication {
            name = "run-experiments-script";
            runtimeInputs = shellPkgs;
            text = ''
              set -euo pipefail
              export PATH=${pkgs.lib.makeBinPath [ pythonEnv pkgs.coreutils ]}:$PATH
              ./artifacts/oopsla25-width-indep/test_experiments.sh
            '';
          };
          program = "${programDir}/bin/run-experiments-script";
        in
        {
          inherit program;
          type = "app";
        };
      });
}
