(with-eval-after-load 'evil-maps
  (define-key evil-normal-state-map (kbd "L") 'evil-end-of-line)
  (define-key evil-normal-state-map (kbd "z z") 'evil-write)
  (define-key evil-normal-state-map (kbd "j") 'evil-next-line)
  (define-key evil-normal-state-map (kbd "H") 'evil-beginning-of-visual-line))

  ;;;(define-key evil-normal-state-map (kbd "H") 'evil-beginning-of-line))
(global-set-key (kbd "C-c s") 'swiper)

(evil-leader/set-leader "<SPC>")

(evil-leader/set-key
  "a" 'org-agenda
  "v" 'switch-to-buffer
  "b" 'buffer-menu
  "f" 'counsel-find-file
  "g" 'counsel-git
  "k" 'kill-buffer
  "s" 'swiper
  "m" 'bm-toggle
  "n" 'bm-next
  "l" 'bm-show-all
  "w" 'evil-window-next
  "/" 'zss-rg-dwim-project-dir
  ">" 'zssr-rg-dwim-project-dir
  "<" 'zss-rg-dwim-project-dir1
  "*" 'zs-rg-dwim-project-dir
  "&" 'zsr-rg-dwim-project-dir
  ;;"r" 'xref-find-references
  "r" 'lsp-ui-peek-find-references
  "o" 'lsp-treemacs-symbols
  "c" 'lsp-ui-imenu
  )
(provide 'init-keybindings)
