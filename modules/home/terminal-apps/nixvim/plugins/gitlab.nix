{
  programs.nixvim = {
    plugins.gitlab = {
      enable = true;
      settings = {
        gitlab_url = "https://cm.infra.he2pi.com";
        code_suggestions.enabled = false;
      };
    };
  };
}
