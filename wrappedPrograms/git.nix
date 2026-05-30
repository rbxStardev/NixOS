{inputs, ...}: {
  perSystem = {pkgs, ...}: {
    packages.git = inputs.wrappers.lib.wrapPackage {
      inherit pkgs;
      package = pkgs.git;
      env = rec {
        GIT_AUTHOR_NAME = "rbxStardev";
        GIT_AUTHOR_EMAIL = "miguelscb0310@gmail.com";
        GIT_COMMITTER_NAME = GIT_AUTHOR_NAME;
        GIT_COMMITTER_EMAIL = GIT_AUTHOR_EMAIL;
      };
    };
  };
}
