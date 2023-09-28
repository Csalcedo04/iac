{
  description = "Integración Terraform-Ansible para curso IpTI";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }@inputs:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
    my-python-packages = ps: with ps; [
      docker
    ];
  in
  {
    devShells.${system}.default = pkgs.mkShell {
      nativeBuildInputs = with pkgs; [
        # qemu
        ansible
        ansible-language-server
        ansible-lint
        # terraform
        # terraform-providers.azurerm
        # terraform-ls
        # azure-cli
      ];

      shellHook = ''
        PS1='\[\e[32m\]\u@\H:\[\e[0m\] \[\e[91m\]\w\[\e[36m\]  $(git branch 2>/dev/null | grep '"'"'*'"'"' | colrm 1 2)\n\[\e[32m\]\\$\[\e[0m\] '
        alias ap='ANSIBLE_CONFIG=ansible.cfg ansible-playbook run.yml'
      '';
    };
  };
}

