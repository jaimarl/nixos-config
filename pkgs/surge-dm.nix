{ pkgs
, version ? "0.8.2"
, sha256 ? "sha256:b6a9fa15b43ce709196648e18b02c49cce6903df59fa93178b762d741446a817"
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
