return {
    cmd = { "bash-language-server", "start" },
    filetypes = { "sh", "bash" },
    root_markers = { ".git/", ".bashrc", ".bash_profile", ".profile" },
    single_file_support = true,
    log_level = vim.lsp.protocol.MessageType.Warning,
}
