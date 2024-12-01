{
  description = "A Nix-flake-based C/C++ development environment";

  inputs.nixpkgs.url = "nixpkgs/nixos-24.11";

  outputs = { self, nixpkgs }:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forEachSupportedSystem = f: nixpkgs.lib.genAttrs supportedSystems (system: f {
        pkgs = import nixpkgs { inherit system; };
      });
    in
    {
      devShells = forEachSupportedSystem ({ pkgs }: {
        default = pkgs.mkShell.override
          {
            # Override stdenv in order to change compiler:
            stdenv = pkgs.clangStdenv;
          }
          {
            nativeBuildInputs = with pkgs; [
              cmake
              pkg-config
              ninja
            ];
            
            buildInputs = with pkgs; [
              clang-tools
              gtest
              # llvmPackages_12.openmp
            ];
            packages = with pkgs; [
              miniaudio
            ] ++ (if system == "aarch64-darwin" then [ ] else [ gdb ]);
            shellhook = '' '';
          };
      });
    };
}


# export CPATH=${pipewire.dev}/include/pipewire-0.3/:${pipewire.dev}/include/spa-0.2/
