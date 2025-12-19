{ pkgs, ... }:

{

  imports = [
    ./vibe.nix
  ];

  environment.systemPackages = with pkgs; [
    bat # cat alternative, colorize code outputs
    black # Python code formatter
    cargo
    clang-tools
    cmake
    ctop
    docker-client
    gh # GitHub CLI
    gnumake
    go
    grpcurl # like curl, but for gRPC
    jdk
    just # command runner, like make
    lazygit # TUI for git
    nodejs
    nodePackages.pnpm
    pipx
    # pre-commit # unsupported in darwin due to julia-1.11.5 not being supported in darwin
    protobuf
    protoc-gen-go
    (python3.withPackages (
      pythonPkgs: with pythonPkgs; [
        ipython
        pandas
      ]
    ))
    rustc
    treefmt
    xh # command line HTTP client, easier to use than curl
  ];

}
