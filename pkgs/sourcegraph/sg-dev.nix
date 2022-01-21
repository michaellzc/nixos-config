{ autoPatchelfHook
, lib
, stdenv
, fetchurl
, name ? "sg-dev"
}:

stdenv.mkDerivation rec {
  pname = "sg-dev";
  version = "2022-01-20-08-24-2a7285c2";

  src = fetchurl {
    url = {
      "x86_64-linux" = "https://github.com/sourcegraph/sg/releases/download/${version}/sg_linux_amd64";
      "x86_64-darwin" = "https://github.com/sourcegraph/sg/releases/download/${version}/sg_darwin_amd64";
      "aarch64-darwin" = "https://github.com/sourcegraph/sg/releases/download/${version}/sg_darwin_arm64";
    }.${stdenv.hostPlatform.system};
    sha256 = {
      "x86_64-linux" = "84caa9d1d6047bcea714e62624af7c80cdfe0327a270a50817c9d974982f8eb7";
      "x86_64-darwin" = "90cd295645806c4bf38ff8887eca51edc60eef32a239101675078597d0178b06";
      "aarch64-darwin" = "426e608e2a5b3692dbeb61ca36e3dfee1b68d878490768bdf451f87ced9ff29c";
    }.${stdenv.hostPlatform.system};
  };

  dontStrip = stdenv.isDarwin;

  nativeBuildInputs = lib.optionals stdenv.isLinux [ autoPatchelfHook ];

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/${name}
    chmod +x $out/bin/${name}
  '';

  doInstallCheck = true;

  installCheckPhase = ''
    $out/bin/sg-dev version
  '';

  meta = with lib; {
    description = "Sourcegraph developer tool";
    homepage = "https://github.com/sourcegraph/sg";
    downloadPage = "https://github.com/sourcegraph/sg/releases";
    maintainers = with maintainers; [ michaellzc ];
    license = licenses.free;
    platforms = [ "x86_64-linux" "x86_64-darwin" "aarch64-darwin" ];
  };
}