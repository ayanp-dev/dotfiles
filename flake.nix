# ~/.dotfiles/flake.nix
{
  description = "Portable USB NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    herdr.url = "github:herdrdev/herdr";
    claude-code.url = "github:ryoppippi/nix-claude-code";
    
    # Add Numtide's LLM agents flake for Antigravity CLI
    llm-agents.url = "github:numtide/llm-agents.nix";
  };

  outputs = { self, nixpkgs, home-manager, herdr, claude-code, llm-agents, ... }@inputs: {
    nixosConfigurations."portable" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      
      modules = [
        ./configuration.nix
        
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = {
            dotfilesPath = "/home/ayan/.dotfiles";
          };
          
          home-manager.users.ayan = {
            imports = [ ./home.nix ];
            home.packages = [ 
              herdr.packages."x86_64-linux".default 
              claude-code.packages."x86_64-linux".default
              llm-agents.packages."x86_64-linux".antigravity-cli
            ];
          };
        }
      ];
    };
  };
}