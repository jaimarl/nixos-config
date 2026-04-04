{ pkgs
, version ? "0.7.7"
, sha256 ? "sha256:6afcd69b24e80c094099a67b8e4bf31e853663c148cc99127d7345e49536ad17"
}:

pkgs.stdenv.mkDerivation rec {
    pname = "surge-dm";
    inherit version;

    src = pkgs.fetchurl {
        url = "https://github.com/SurgeDM/Surge/releases/download/v${version}/Surge_${version}_linux_amd64.tar.gz";
        inherit sha256;
    };

    sourceRoot = ".";
    nativeBuildInputs = [ pkgs.autoPatchelfHook ];

    installPhase = ''
        mkdir -p $out/bin
        cp surge $out/bin
    '';
}
