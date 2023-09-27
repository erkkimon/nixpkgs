{ pkgs ? import <nixpkgs> {} }:

let
  src = pkgs.fetchFromGitHub {
    owner = "huggingface";
    repo = "llm-ls";
    rev = "v0.2.1";
    sha256 = "1ja641l1sqzv3dczsf9ra99f3kz3cs07ha3m6vs9pj66x1lpbbvj";
  };
in
pkgs.rustPlatform.buildRustPackage rec {
  pname = "llm-ls";
  version = "0.2.1";
  inherit src;

  buildPhase = "cargo build --release";

  installPhase = ''
    mkdir -p $out/bin
    cp target/release/llm-ls $out/bin/llm-ls
  '';

  meta = {
    description = "llm-ls is a LSP server leveraging LLMs for code completion";
    homepage = "https://github.com/huggingface/llm-ls";
    license = pkgs.lib.licenses.asl20;
    maintainers = with pkgs.lib.maintainers; [ erkkimon ];
  };

  cargoSha256 = "JGCD8CXxbWwygVfpohM9yyFP/KGN604I4bSayg/gQzM=";
}
