{ pkgs, ... }:

{
  # Install Standard Notes with Wayland support
  environment.systemPackages = with pkgs; [
    (pkgs.symlinkJoin {
      name = "standardnotes";
      paths = [ pkgs.standardnotes ];
      buildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/standardnotes \
          --add-flags "--enable-features=UseOzonePlatform --ozone-platform=wayland"
      '';
    })
  ];
}