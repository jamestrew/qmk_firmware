{
  description = "QMK devshell";

  inputs = { };

  outputs =
    { ... }:
    let
      system = "x86_64-linux";
      sources = import ./util/nix/sources.nix { };
      pkgs = import sources.nixpkgs { inherit system; };
      poetry2nix = pkgs.callPackage (import sources.poetry2nix) { };
      baseShell = import ./shell.nix { inherit pkgs poetry2nix; };
    in
    {
      devShells.${system}.default = baseShell.overrideAttrs (old: {
        buildInputs = old.buildInputs ++ [ pkgs.xfce.thunar ];
      });
    };
}
