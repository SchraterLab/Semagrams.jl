{
  inputs = { utils.url = "github:numtide/flake-utils"; };

  outputs = { self, nixpkgs, utils }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config = { allowUnfree = true; };
        };
      in rec {
        # `nix develop`
        devShell = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [
            nodejs
            sbt
            openjdk
            metals
            bloop
          ];
          shellHook = "export PATH=$PWD/node_modules/.bin:$PATH";
        };
      });
}
