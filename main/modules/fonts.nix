{ config, lib, pkgs, inputs, ... }:

{
  fonts.packages =
    with pkgs;
    [        
      nerd-fonts.iosevka
      nerd-fonts.iosevka-term-slab
      iosevka-comfy.comfy-motion-fixed
      sarasa-gothic
      nerd-fonts.space-mono
      nerd-fonts.caskaydia-cove
      nerd-fonts.lekton
      nerd-fonts.mononoki
      nerd-fonts.profont
      nerd-fonts.meslo-lg
      nerd-fonts.martian-mono
      maple-mono.NF
      maple-mono.NF-CN
      monaspace
      inriafonts
      hubot-sans
      encode-sans
      fira
      nerd-fonts.fira-code

      jetbrains-mono
      rounded-mgenplus
    ];
}
