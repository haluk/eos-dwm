;;; keybindings.el -*- lexical-binding: t; -*-

(map! :nv "C-c t" 'treemacs-select-window)
(map! :i "M-<backspace>" 'sp-backward-delete-word)
(map! :leader
      :desc "Yank visible text only"
      "oy" #'evil-yank-visible)
