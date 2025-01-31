{pkgs, ...}: {
  home.sessionVariables = {
    GROQ_API_KEY = "(hidden)";

    # helix-gpt
    HANDLER = "codeium"; # openai/copilot/codeium
  };

  home.packages = with pkgs; [
    lsp-ai
    ollama
    helix-gpt
  ];
}
