{ pkgs
, version ? "0.7.8"
, sha256 ? "sha256:9c6bad3ae307239012ef421058ff5c8dc565c35ad51629cac363ae72568a769a"
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
