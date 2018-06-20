let
  fetchNixpkgs =
    { owner, repo, rev, sha256, ... }:
    builtins.fetchTarball {
      url = "https://github.com/${owner}/${repo}/archive/${rev}.tar.gz";
      inherit sha256;
    };

  importJSON = path: builtins.fromJSON (builtins.readFile path);
in

{ nixpkgs ? fetchNixpkgs (importJSON ./nixpkgs-src.json) }:

with import nixpkgs {
  config.packageOverrides = super: {
    xelatex-noweb = (super.texlive.combine {
      inherit (super.texlive) scheme-small
        dirtytalk
        framed
        fvextra
        hardwrap
        ifplatform
        latexmk
        minted
        titlesec
        todonotes
        tufte-latex
        xetex
        xstring;
    });
  };
};

stdenv.mkDerivation {
  name = "knrc";
  src = ./.;

  outputs = [ "out" "docs" "dev" ];

  FONTCONFIG_FILE = makeFontsConf {
    fontDirectories = [ iosevka ];
  };

  nativeBuildInputs = with pkgs; ([
    gcc
    indent
    iosevka
    noweb
    python36Packages.pygments
    which
    xelatex-noweb
  ]);

  meta = with stdenv.lib; {
    description = "Working through the K&R C book";
    homepage = https://github.com/yurrriq/knrc;
  };
}
