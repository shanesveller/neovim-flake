# This file was generated by nvfetcher, please do not modify it manually.
{
  fetchgit,
  fetchurl,
  fetchFromGitHub,
}: {
  elixir-nvim = {
    pname = "elixir-nvim";
    version = "2cb7c410346cb4f5b42b505b0e5cb036153973eb";
    src = fetchFromGitHub {
      owner = "mhanberg";
      repo = "elixir.nvim";
      rev = "2cb7c410346cb4f5b42b505b0e5cb036153973eb";
      fetchSubmodules = false;
      sha256 = "sha256-+sSoIKSSUD+ypDjPOn3dN5kG/IBACMOicF23nlBsO5I=";
    };
  };
  neorg = {
    pname = "neorg";
    version = "ad2f5735c837046a40efef9aad70d01af5acd076";
    src = fetchFromGitHub {
      owner = "nvim-neorg";
      repo = "neorg";
      rev = "ad2f5735c837046a40efef9aad70d01af5acd076";
      fetchSubmodules = false;
      sha256 = "sha256-N2Do/W0Cm2H1fqX1Oe+GKhM+TC+66WWZKwoON4MjT/Y=";
    };
  };
  neorg-telescope = {
    pname = "neorg-telescope";
    version = "8d15129818c5dc224be97c9c6350d3386addeac8";
    src = fetchFromGitHub {
      owner = "nvim-neorg";
      repo = "neorg-telescope";
      rev = "8d15129818c5dc224be97c9c6350d3386addeac8";
      fetchSubmodules = false;
      sha256 = "sha256-KDEziW99VyW2RjGV0+JaLSXXZ66WSNVPBNaw6N7Fri0=";
    };
  };
  other-nvim = {
    pname = "other-nvim";
    version = "9afecea37c9b5ffed65a21de9e585d548de7778a";
    src = fetchFromGitHub {
      owner = "rgroli";
      repo = "other.nvim";
      rev = "9afecea37c9b5ffed65a21de9e585d548de7778a";
      fetchSubmodules = false;
      sha256 = "sha256-df/L8ZOdjkviE6WRRe7uon82hlUb+yYDdtiN3pJ5OBs=";
    };
  };
  pretty-fold-nvim = {
    pname = "pretty-fold-nvim";
    version = "a7d8b424abe0eedf50116c460fbe6dfd5783b1d5";
    src = fetchFromGitHub {
      owner = "anuvyklack";
      repo = "pretty-fold.nvim";
      rev = "a7d8b424abe0eedf50116c460fbe6dfd5783b1d5";
      fetchSubmodules = false;
      sha256 = "sha256-PQPZw0qXwMtpVE4uSxR3xUvkHE9iG4T+ZwgV6H9pUjo=";
    };
  };
  vim-just = {
    pname = "vim-just";
    version = "838c9096d4c5d64d1000a6442a358746324c2123";
    src = fetchFromGitHub {
      owner = "NoahTheDuke";
      repo = "vim-just";
      rev = "838c9096d4c5d64d1000a6442a358746324c2123";
      fetchSubmodules = false;
      sha256 = "sha256-DSC47z2wOEXvo2kGO5JtmR3hyHPiYXrkX7MgtagV5h4=";
    };
  };
}
