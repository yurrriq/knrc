let

  fetchTarballFromGitHub =
    { owner, repo, rev, sha256, ... }:
    builtins.fetchTarball {
      url = "https://github.com/${owner}/${repo}/tarball/${rev}";
      inherit sha256;
    };

  fromJSONFile = path: builtins.fromJSON (builtins.readFile path);

in

{ nixpkgs ? fetchTarballFromGitHub (fromJSONFile ./_nix/nixpkgs-src.json)
, nur ? fetchTarballFromGitHub (fromJSONFile ./_nix/nur.json) }:

with import nixpkgs {
  overlays = [
    (import nur {}).repos.yurrriq.overlays.nur
    (self: super: {
      xelatex-noweb = (super.texlive.combine {
        inherit (super) noweb;
        inherit (super.texlive) scheme-small
          datetime
          dirtytalk
          fmtcount
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
    })
  ];
};

stdenv.mkDerivation rec {
  pname = "knrc";
  version = builtins.readFile ./VERSION;
  name = "${pname}-${version}";
  src = ./.;

  # makeFlags = "-B";

  outputs = [ "out" "docs" "dev" ];

  FONTCONFIG_FILE = makeFontsConf {
    fontDirectories = [ iosevka ];
  };

  nativeBuildInputs = with pkgs; [
    doxygen
    gcc
    gdb
    indent
    iosevka
    noweb
    python36Packages.pygments
    which
    xelatex-noweb
  ];

  meta = with stdenv.lib; {
    description = "Working through the K&R C book";
    homepage = https://github.com/yurrriq/knrc;
    license = licenses.wtfpl;
    maintainers = with maintainers; [ yurrriq ];
  };
}
