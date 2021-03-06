{ pkgs, ...}:

{
    l = "${pkgs.exa}/bin/exa";
    ls = "${pkgs.exa}/bin/exa";
    ll = "${pkgs.exa}/bin/exa -l";
    g = "git";
    t = "tig status";
    e = "nvim";
    ee = "fzf --print0 | xargs -0 nvim";
    download = "${pkgs.aria}/bin/aria2c --file-allocation=none --seed-time=0";
    # gotty-sridca = "gotty -a 0.0.0.0 -p 9999 -r"; # To be run from the thebeast wireguard peer only.
    youtube-dl-audio = "${pkgs.youtube-dl}/bin/youtube-dl --ignore-errors --output \"%(title)s.%(ext)s\" --extract-audio --audio-format mp3";
    cast-video = "${pkgs.catt}/bin/catt -d SridScreen cast";
    cast-audio = "${pkgs.catt}/bin/catt -d SridMini cast";
}
